Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751672AbWCCH5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWCCH5h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 02:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbWCCH5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 02:57:25 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:19586 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751672AbWCCH5N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 02:57:13 -0500
Message-Id: <20060303075735.613512000@sorel.sous-sol.org>
References: <20060303075542.659414000@sorel.sous-sol.org>
Date: Thu, 02 Mar 2006 23:55:45 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [PATCH 3/4] [PATCH] fs/nfs/direct.c compile fix
Content-Disposition: inline; filename=normal-user-can-panic-nfs-client-with-direct-i-o-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

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

--
