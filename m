Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWCBHgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWCBHgE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 02:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWCBHgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 02:36:03 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45442 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750950AbWCBHgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 02:36:02 -0500
Date: Wed, 1 Mar 2006 23:25:40 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Dave Jones <davej@redhat.com>, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Mike OConnor <mjo@dojo.mi.org>,
       trond.myklebust@netapp.com, Greg Banks <gnb@melbourne.sgi.com>
Subject: Re: [stable] Re: [patch 38/39] Normal user can panic NFS client with direct I/O (CVE-2006-0555)
Message-ID: <20060302072540.GY3883@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org> <20060227223407.671256000@sorel.sous-sol.org> <20060302043323.GC31863@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302043323.GC31863@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones (davej@redhat.com) wrote:
> Also broken in 2.6.15.5 it seems :-/

Indeed, the diff below effectively replaces what's in 2.6.15.5 with
what Trond had sent me.  Should fix the compile error and keep in sync
with what's going upstream.
--

Compile fix:

fs/nfs/direct.c: In function 'nfs_get_user_pages':
fs/nfs/direct.c:110: warning: implicit declaration of function 'nfs_free_user_pages'
fs/nfs/direct.c: At top level:
fs/nfs/direct.c:127: warning: conflicting types for 'nfs_free_user_pages'
fs/nfs/direct.c:127: error: static declaration of 'nfs_free_user_pages' follows non-static declaration
fs/nfs/direct.c:110: error: previous implicit declaration of 'nfs_free_user_pages' was here

This should now be the same as fix that's going upstream.

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
---

 fs/nfs/direct.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6.15.5.orig/fs/nfs/direct.c
+++ linux-2.6.15.5/fs/nfs/direct.c
@@ -57,6 +57,7 @@
 #define NFSDBG_FACILITY		NFSDBG_VFS
 #define MAX_DIRECTIO_SIZE	(4096UL << PAGE_SHIFT)
 
+static void nfs_free_user_pages(struct page **pages, int npages, int do_dirty);
 static kmem_cache_t *nfs_direct_cachep;
 
 /*
@@ -106,12 +107,16 @@ nfs_get_user_pages(int rw, unsigned long
 		result = get_user_pages(current, current->mm, user_addr,
 					page_count, (rw == READ), 0,
 					*pages, NULL);
+		up_read(&current->mm->mmap_sem);
+		/*
+		 * If we got fewer pages than expected from get_user_pages(),
+		 * the user buffer runs off the end of a mapping; return EFAULT.
+		 */
 		if (result >= 0 && result < page_count) {
 			nfs_free_user_pages(*pages, result, 0);
 			*pages = NULL;
 			result = -EFAULT;
 		}
-		up_read(&current->mm->mmap_sem);
 	}
 	return result;
 }
