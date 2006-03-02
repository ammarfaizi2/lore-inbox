Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWCBEia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWCBEia (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 23:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWCBEia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 23:38:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39130 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750784AbWCBEi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 23:38:29 -0500
Date: Wed, 1 Mar 2006 23:33:23 -0500
From: Dave Jones <davej@redhat.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Mike OConnor <mjo@dojo.mi.org>,
       trond.myklebust@netapp.com, Greg Banks <gnb@melbourne.sgi.com>
Subject: Re: [patch 38/39] Normal user can panic NFS client with direct I/O (CVE-2006-0555)
Message-ID: <20060302043323.GC31863@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
	stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
	Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
	Mike OConnor <mjo@dojo.mi.org>, trond.myklebust@netapp.com,
	Greg Banks <gnb@melbourne.sgi.com>
References: <20060227223200.865548000@sorel.sous-sol.org> <20060227223407.671256000@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227223407.671256000@sorel.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 02:32:38PM -0800, Chris Wright wrote:
 > -stable review patch.  If anyone has any objections, please let us know.
 > ------------------
 > 
 > This is CVE-2006-0555 and SGI bug 946529.  A normal user can panic an
 > NFS client and cause a local DoS with 'judicious'(?) use of O_DIRECT.
 > 
 > Signed-off-by: Chris Wright <chrisw@sous-sol.org>
 > ---
 > 
 >  fs/nfs/direct.c |    5 +++++
 >  1 files changed, 5 insertions(+)
 > 
 > --- linux-2.6.15.4.orig/fs/nfs/direct.c
 > +++ linux-2.6.15.4/fs/nfs/direct.c
 > @@ -106,6 +106,11 @@ nfs_get_user_pages(int rw, unsigned long
 >  		result = get_user_pages(current, current->mm, user_addr,
 >  					page_count, (rw == READ), 0,
 >  					*pages, NULL);
 > +		if (result >= 0 && result < page_count) {
 > +			nfs_free_user_pages(*pages, result, 0);
 > +			*pages = NULL;
 > +			result = -EFAULT;
 > +		}
 >  		up_read(&current->mm->mmap_sem);
 >  	}
 >  	return result;

Also broken in 2.6.15.5 it seems :-/

fs/nfs/direct.c: In function 'nfs_get_user_pages':
fs/nfs/direct.c:110: warning: implicit declaration of function 'nfs_free_user_pages'
fs/nfs/direct.c: At top level:
fs/nfs/direct.c:127: warning: conflicting types for 'nfs_free_user_pages'
fs/nfs/direct.c:127: error: static declaration of 'nfs_free_user_pages' follows non-static declaration
fs/nfs/direct.c:110: error: previous implicit declaration of 'nfs_free_user_pages' was here

Some function juggling should do the trick.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15/fs/nfs/direct.c~	2006-03-01 23:31:37.000000000 -0500
+++ linux-2.6.15/fs/nfs/direct.c	2006-03-01 23:32:01.000000000 -0500
@@ -73,6 +73,23 @@ struct nfs_direct_req {
 				error;		/* any reported error */
 };
 
+/**
+ * nfs_free_user_pages - tear down page struct array
+ * @pages: array of page struct pointers underlying target buffer
+ * @npages: number of pages in the array
+ * @do_dirty: dirty the pages as we release them
+ */
+static void
+nfs_free_user_pages(struct page **pages, int npages, int do_dirty)
+{
+	int i;
+	for (i = 0; i < npages; i++) {
+		if (do_dirty)
+			set_page_dirty_lock(pages[i]);
+		page_cache_release(pages[i]);
+	}
+	kfree(pages);
+}
 
 /**
  * nfs_get_user_pages - find and set up pages underlying user's buffer
@@ -117,24 +134,6 @@ nfs_get_user_pages(int rw, unsigned long
 }
 
 /**
- * nfs_free_user_pages - tear down page struct array
- * @pages: array of page struct pointers underlying target buffer
- * @npages: number of pages in the array
- * @do_dirty: dirty the pages as we release them
- */
-static void
-nfs_free_user_pages(struct page **pages, int npages, int do_dirty)
-{
-	int i;
-	for (i = 0; i < npages; i++) {
-		if (do_dirty)
-			set_page_dirty_lock(pages[i]);
-		page_cache_release(pages[i]);
-	}
-	kfree(pages);
-}
-
-/**
  * nfs_direct_req_release - release  nfs_direct_req structure for direct read
  * @kref: kref object embedded in an nfs_direct_req structure
  *
