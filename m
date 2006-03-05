Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWCEVG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWCEVG0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 16:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbWCEVGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 16:06:25 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:34432 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751201AbWCEVGZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 16:06:25 -0500
Date: Sun, 5 Mar 2006 13:10:21 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.15.6
Message-ID: <20060305211021.GU3883@sorel.sous-sol.org>
References: <20060305210904.GT3883@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060305210904.GT3883@sorel.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 9b04e35..3a85dd1 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 15
-EXTRAVERSION = .5
+EXTRAVERSION = .6
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/arch/ia64/kernel/unaligned.c b/arch/ia64/kernel/unaligned.c
index 43b45b6..f2bc971 100644
--- a/arch/ia64/kernel/unaligned.c
+++ b/arch/ia64/kernel/unaligned.c
@@ -24,7 +24,7 @@
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
 
-extern void die_if_kernel(char *str, struct pt_regs *regs, long err) __attribute__ ((noreturn));
+extern void die_if_kernel(char *str, struct pt_regs *regs, long err);
 
 #undef DEBUG_UNALIGNED_TRAP
 
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 3ebb06e..96c104b 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
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
diff --git a/include/linux/types.h b/include/linux/types.h
index 21b9ce8..f5a4572 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -8,6 +8,7 @@
 	(((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
+#define BITS_PER_BYTE 8
 #endif
 
 #include <linux/posix_types.h>
diff --git a/net/core/request_sock.c b/net/core/request_sock.c
index b8203de..98f0fc9 100644
--- a/net/core/request_sock.c
+++ b/net/core/request_sock.c
@@ -52,7 +52,6 @@ int reqsk_queue_alloc(struct request_soc
 	get_random_bytes(&lopt->hash_rnd, sizeof(lopt->hash_rnd));
 	rwlock_init(&queue->syn_wait_lock);
 	queue->rskq_accept_head = queue->rskq_accept_head = NULL;
-	queue->rskq_defer_accept = 0;
 	lopt->nr_table_entries = nr_table_entries;
 
 	write_lock_bh(&queue->syn_wait_lock);
