Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261806AbSJDWRD>; Fri, 4 Oct 2002 18:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261788AbSJDWRD>; Fri, 4 Oct 2002 18:17:03 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:14976 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S261739AbSJDWQy>; Fri, 4 Oct 2002 18:16:54 -0400
Date: Fri, 4 Oct 2002 18:22:26 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] NFS O_DIRECT support for 2.5
Message-ID: <Pine.LNX.4.44.0210041814410.8094-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Linus-

this patch is a first pass at implementing direct I/O in the 2.5 NFS
client.  there are many who would like NFS direct I/O support to be 
included in 2.5/6.

support for NFS direct I/O is enabled via a new kernel build option.  
when enabled, NFS direct I/O support does not compile because it is not
finished yet, but i'd like to get it into 2.5 before the October 20th
deadline, and submit patches later that make it work.  making this support 
available in the kernel now also allows a wider review audience and easier 
testing.

when the build option is disabled, the kernel compiles and functions as
normal.  the new config option is only available in the File Systems menu
when CONFIG_EXPERIMENTAL is set.


diff -drN -U2 07-odirect2/fs/Config.help 08-odirect3/fs/Config.help
--- 07-odirect2/fs/Config.help	Tue Oct  1 03:07:34 2002
+++ 08-odirect3/fs/Config.help	Fri Oct  4 15:30:34 2002
@@ -515,4 +515,25 @@
   If unsure, say N.
 
+CONFIG_NFS_DIRECTIO
+  This option enables applications to perform uncached I/O on files
+  in NFS file systems using the O_DIRECT open() flag.  When O_DIRECT
+  is set for files, their data is not cached in the system's page
+  cache.  Data is moved to and from user-level application buffers
+  directly.  Unlike local disk-based file systems, NFS O_DIRECT has
+  no alignment restrictions.
+
+  Unless your program is designed to use O_DIRECT properly, you are
+  much better off allowing the NFS client to manage caching for you.
+  Misusing O_DIRECT can cause poor server performance or network
+  storms.  This kernel build option defaults OFF to avoid exposing
+  system administrators unwittingly to a potentially hazardous
+  feature.
+
+  For more details on NFS O_DIRECT, see fs/nfs/direct.c.
+
+  If unsure, say N.  This reduces the size of the NFS client, and
+  causes open() to return EINVAL if a file residing in NFS is
+  opened with the O_DIRECT flag.
+
 CONFIG_ROOT_NFS
   If you want your Linux box to mount its whole root file system (the
diff -drN -U2 07-odirect2/fs/Config.in 08-odirect3/fs/Config.in
--- 07-odirect2/fs/Config.in	Tue Oct  1 03:07:10 2002
+++ 08-odirect3/fs/Config.in	Fri Oct  4 15:30:34 2002
@@ -119,4 +119,5 @@
    dep_mbool '  Provide NFSv3 client support' CONFIG_NFS_V3 $CONFIG_NFS_FS
    dep_bool '  Root file system on NFS' CONFIG_ROOT_NFS $CONFIG_NFS_FS $CONFIG_IP_PNP
+   dep_mbool '  Allow direct I/O on NFS files (EXPERIMENTAL)' CONFIG_NFS_DIRECTIO $CONFIG_NFS_FS $CONFIG_EXPERIMENTAL
 
    dep_tristate 'NFS server support' CONFIG_NFSD $CONFIG_INET
diff -drN -U2 07-odirect2/fs/nfs/Makefile 08-odirect3/fs/nfs/Makefile
--- 07-odirect2/fs/nfs/Makefile	Tue Oct  1 03:06:22 2002
+++ 08-odirect3/fs/nfs/Makefile	Fri Oct  4 15:30:34 2002
@@ -9,4 +9,5 @@
 nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o mount_clnt.o      
 nfs-$(CONFIG_NFS_V3)	+= nfs3proc.o nfs3xdr.o
+nfs-$(CONFIG_NFS_DIRECTIO) += direct.o
 nfs-objs		:= $(nfs-y)
 
diff -drN -U2 07-odirect2/fs/nfs/direct.c 08-odirect3/fs/nfs/direct.c
--- 07-odirect2/fs/nfs/direct.c	Wed Dec 31 19:00:00 1969
+++ 08-odirect3/fs/nfs/direct.c	Fri Oct  4 15:30:34 2002
@@ -0,0 +1,270 @@
+/*
+ * linux/fs/nfs/direct.c
+ *
+ * Copyright (C) 2001 by Chuck Lever <cel@netapp.com>
+ *
+ * High-performance uncached I/O for the Linux NFS client
+ *
+ * There are important applications whose performance or correctness
+ * depends on uncached access to file data.  Database clusters
+ * (multiple copies of the same instance running on separate hosts) 
+ * implement their own cache coherency protocol that subsumes file
+ * system cache protocols.  Applications that process datasets 
+ * considerably larger than the client's memory do not always benefit 
+ * from a local cache.  A streaming video server, for instance, has no 
+ * need to cache the contents of a file.
+ *
+ * When an application requests uncached I/O, all read and write requests
+ * are made directly to the server; data stored or fetched via these
+ * requests is not cached in the Linux page cache.  The client does not
+ * correct unaligned requests from applications.  All requested bytes are
+ * held on permanent storage before a direct write system call returns to
+ * an application.
+ *
+ * Solaris implements an uncached I/O facility called directio() that
+ * is used for backups and sequential I/O to very large files.  Solaris
+ * also supports uncaching whole NFS partitions with "-o forcedirectio,"
+ * an undocumented mount option.
+ *
+ * Designed by Jeff Kimmel, Chuck Lever, and Trond Myklebust.
+ *
+ * 18 Dec 2001	Initial implementation for 2.4  --cel
+ * 08 Jul 2002	Version for 2.4.19, with bug fixes --trondmy
+ * 24 Sep 2002	Rewrite to use asynchronous RPCs, port to 2.5  --cel
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/file.h>
+#include <linux/errno.h>
+#include <linux/nfs_fs.h>
+#include <linux/nfs_page.h>
+#include <linux/sunrpc/clnt.h>
+
+#include <asm/system.h>
+#include <asm/uaccess.h>
+
+#define NFSDBG_FACILITY		(NFSDBG_PAGECACHE | NFSDBG_VFS)
+#define VERF_SIZE		(2 * sizeof(__u32))
+
+
+/**
+ * nfs_get_user_pages - find and set up page representing user buffer
+ * addr: user-space address of target buffer
+ * size: total size in bytes of target buffer
+ * @pages: returned array of page struct pointers underlying target buffer
+ * write: whether or not buffer is target of a write operation
+ */
+static inline int
+nfs_get_user_pages(unsigned long addr, size_t size,
+		struct page ***pages, int rw)
+{
+	int result = -ENOMEM;
+	unsigned page_count = (unsigned) size >> PAGE_SHIFT;
+	unsigned array_size = (page_count * sizeof(struct page *)) + 2U;
+
+	*pages = (struct page **) kmalloc(array_size, GFP_KERNEL);
+	if (*pages) {
+		down_read(&current->mm->mmap_sem);
+		result = get_user_pages(current, current->mm, addr,
+					page_count, (rw == WRITE), 0,
+					*pages, NULL);
+		up_read(&current->mm->mmap_sem);
+		if (result < 0)
+			printk(KERN_ERR "%s: get_user_pages result %d\n",
+					__FUNCTION__, result);
+	}
+	return result;
+}
+
+/**
+ * nfs_free_user_pages - tear down page struct array
+ * @pages: array of page struct pointers underlying target buffer
+ */
+static inline void
+nfs_free_user_pages(struct page **pages, unsigned count)
+{
+	unsigned page = 0;
+
+	while (count--)
+		page_cache_release(pages[page++]);
+
+	kfree(pages);
+}
+
+/**
+ * nfs_iov2pagelist - convert an array of iovecs to a list of page requests
+ * @inode: inode of target file
+ * @cred: credentials of user who requested I/O
+ * @iov: array of vectors that define I/O buffer
+ * offset: where in file to begin the read
+ * nr_segs: size of iovec array
+ * @requests: append new page requests to this list head
+ */
+/*
+ * XXX: still some confusion about how to use nfs_create_request --
+ *      how do you pass it both a file byte offset, and a page byte
+ *      offset ???
+ *      the page struct contains the file index of that page.  this
+ *      assumes the page is mapped to a file, which is not true in
+ *      our case.
+ *      note that NFS depends on page->index to be valid when filling
+ *      in the args structs for the RPC request.
+ */
+static int
+nfs_iov2pagelist(int rw, const struct inode *inode,
+		const struct rpc_cred *cred,
+		const struct iovec *iov, loff_t offset,
+		unsigned long nr_segs, struct list_head *requests)
+{
+	unsigned seg;
+	int tot_bytes = 0;
+	struct page **pages;
+
+	/* for each iovec in the array... */
+	for (seg = 0; seg < nr_segs; seg++) {
+		const unsigned long user_addr =
+					(unsigned long) iov[seg].iov_base;
+		size_t bytes = iov[seg].iov_len;
+		unsigned int pg_offset = (user_addr & ~PAGE_MASK);
+		int page_count, page = 0;
+
+		page_count = nfs_get_user_pages(user_addr, bytes, &pages, rw);
+		if (page_count < 0) {
+			nfs_release_list(requests);
+			return page_count;
+		}
+
+		/* ...build as many page requests as required */
+		while (bytes > 0) {
+			struct nfs_page *new;
+			const unsigned int pg_bytes = (bytes > PAGE_SIZE) ?
+							PAGE_SIZE : bytes;
+
+			new = nfs_create_request((struct rpc_cred *) cred,
+						 (struct inode *) inode,
+						 pages[page],
+						 pg_offset, pg_bytes);
+			if (IS_ERR(new)) {
+				nfs_free_user_pages(pages, page_count);
+				nfs_release_list(requests);
+				return PTR_ERR(new);
+			}
+			new->wb_index = offset;
+			nfs_list_add_request(new, requests);
+
+			/* after the first page */
+			pg_offset = 0;
+			offset += PAGE_SIZE;
+			tot_bytes += pg_bytes;
+			bytes -= pg_bytes;
+			page++;
+		}
+
+		/* don't release pages here -- I/O completion will do that */
+		nfs_free_user_pages(pages, 0);
+	}
+
+	return tot_bytes;
+}
+
+/**
+ * do_nfs_direct_IO - Read or write data without caching
+ * @inode: inode of target file
+ * @cred: credentials of user who requested I/O
+ * @iov: array of vectors that define I/O buffer
+ * offset: where in file to begin the read
+ * nr_segs: size of iovec array
+ *
+ * Break the passed-in iovec into a series of page-sized or smaller
+ * requests, where each page is mapped for direct user-land I/O.
+ *
+ * For each of these pages, create an NFS page request and
+ * append it to an automatic list of page requests.
+ *
+ * When all page requests have been queued, start the I/O on the
+ * whole list.  The underlying routines coalesce the pages on the
+ * list into a bunch of asynchronous "r/wsize" network requests.
+ *
+ * I/O completion automatically unmaps and releases the pages.
+ */
+static int
+do_nfs_direct_IO(int rw, const struct inode *inode,
+		const struct rpc_cred *cred, const struct iovec *iov,
+		loff_t offset, unsigned long nr_segs)
+{
+	LIST_HEAD(requests);
+	int result, tot_bytes;
+
+	result = nfs_iov2pagelist(rw, inode, cred, iov, offset, nr_segs,
+								&requests);
+	if (result < 0)
+		return result;
+	tot_bytes = result;
+
+	switch (rw) {
+	case READ:
+		if (IS_SYNC(inode) || (NFS_SERVER(inode)->rsize < PAGE_SIZE)) {
+			result = nfs_direct_read_sync(inode, cred, iov, offset, nr_segs);
+			break;
+		}
+		result = nfs_pagein_list(&requests, NFS_SERVER(inode)->rpages);
+		nfs_wait_for_reads(&requests);
+		break;
+	case WRITE:
+		if (IS_SYNC(inode) || (NFS_SERVER(inode)->wsize < PAGE_SIZE))
+			result = nfs_direct_write_sync(inode, cred, iov, offset, nr_segs);
+		else
+			result = nfs_flush_list(&requests,
+					NFS_SERVER(inode)->wpages, FLUSH_WAIT);
+
+		/* invalidate cache so normal readers will pick up changes */
+		invalidate_inode_pages((struct inode *) inode);
+		break;
+	default:
+		result = -EINVAL;
+		break;
+	}
+
+	if (result < 0)
+		return result;
+	return tot_bytes;
+}
+
+/**
+ * nfs_direct_IO - NFS address space operation for direct I/O
+ * rw: direction (read or write)
+ * @file: file struct of target file
+ * @iov: array of vectors that define I/O buffer
+ * offset: offset in file to begin the operation
+ * nr_segs: size of iovec array
+ *
+ * This is the NFS client entry point that the Linux VFS layer uses
+ * to handle direct I/O requests to NFS files.  The inode's i_sem is
+ * held by the VFS layer before it calls this function to do a write.
+ */
+int
+nfs_direct_IO(int rw, struct file *file, struct inode *inode,
+		const struct iovec *iov, loff_t offset,
+		unsigned long nr_segs)
+{
+	/* This stuff doesn't work yet, so prevent it from compiling. */
+#if 0
+	int result;
+	struct dentry *dentry = file->f_dentry;
+	const struct rpc_cred *cred = nfs_file_cred(file);
+#endif
+
+	dfprintk(VFS, "NFS: direct_IO(%s) (%s/%s) off/no(%Lu/%lu)\n",
+				((rw == READ) ? "READ" : "WRITE"),
+				dentry->d_parent->d_name.name,
+				dentry->d_name.name, offset, nr_segs);
+
+	result = do_nfs_direct_IO(rw, inode, cred, iov, offset, nr_segs);
+
+	dfprintk(VFS, "NFS: direct_IO result = %d\n", result);
+
+	return result;
+}
diff -drN -U2 07-odirect2/fs/nfs/file.c 08-odirect3/fs/nfs/file.c
--- 07-odirect2/fs/nfs/file.c	Fri Oct  4 15:28:35 2002
+++ 08-odirect3/fs/nfs/file.c	Fri Oct  4 15:30:34 2002
@@ -200,5 +200,8 @@
 	.writepage = nfs_writepage,
 	.prepare_write = nfs_prepare_write,
-	.commit_write = nfs_commit_write
+	.commit_write = nfs_commit_write,
+#ifdef CONFIG_NFS_DIRECTIO
+	.direct_IO = nfs_direct_IO,
+#endif
 };
 
diff -drN -U2 07-odirect2/fs/nfs/pagelist.c 08-odirect3/fs/nfs/pagelist.c
--- 07-odirect2/fs/nfs/pagelist.c	Fri Oct  4 15:28:35 2002
+++ 08-odirect3/fs/nfs/pagelist.c	Fri Oct  4 15:30:34 2002
@@ -177,4 +177,24 @@
 
 /**
+ * nfs_release_list - cleanly dispose of an unattached list of page requests
+ * @list: list of doomed page requests
+ */
+void
+nfs_release_list(struct list_head *list)
+{
+	while (!list_empty(list)) {
+		struct nfs_page *req = nfs_list_entry(list);
+
+		nfs_list_remove_request(req);
+
+		page_cache_release(req->wb_page);
+
+		/* Release struct file or cached credential */
+		nfs_clear_request(req);
+		nfs_page_free(req);
+	}
+}
+
+/**
  * nfs_list_add_request - Insert a request into a sorted list
  * @req: request
@@ -224,4 +244,35 @@
 }
 
+/**
+ * nfs_wait_for_reads - wait for outstanding requests to complete
+ * @head: list of page requests to wait for
+ */
+int
+nfs_wait_for_reads(struct list_head *head)
+{
+	struct list_head *p = head->next;
+	unsigned int res = 0;
+
+	while (p != head) {
+		struct nfs_page *req = nfs_list_entry(p);
+		int error;
+
+		if (!NFS_WBACK_BUSY(req))
+			continue;
+
+		req->wb_count++;
+		error = nfs_wait_on_request(req);
+		if (error < 0)
+			return error;
+		nfs_list_remove_request(req);
+		nfs_clear_request(req);
+		nfs_page_free(req);
+
+		p = head->next;
+		res++;
+	}
+	return res;
+}
+
 /**
  * nfs_coalesce_requests - Split coalesced requests out from a list.
diff -drN -U2 07-odirect2/include/linux/nfs_page.h 08-odirect3/include/linux/nfs_page.h
--- 07-odirect2/include/linux/nfs_page.h	Fri Oct  4 15:28:35 2002
+++ 08-odirect3/include/linux/nfs_page.h	Fri Oct  4 15:30:34 2002
@@ -49,4 +49,5 @@
 extern	void nfs_clear_request(struct nfs_page *req);
 extern	void nfs_release_request(struct nfs_page *req);
+extern	void nfs_release_list(struct list_head *list);
 
 
@@ -60,4 +61,5 @@
 				  unsigned int);
 extern  int nfs_wait_on_request(struct nfs_page *);
+extern	int nfs_wait_for_reads(struct list_head *);
 
 extern	spinlock_t nfs_wreq_lock;
diff -drN -U2 07-odirect2/include/linux/nfs_xdr.h 08-odirect3/include/linux/nfs_xdr.h
--- 07-odirect2/include/linux/nfs_xdr.h	Tue Oct  1 03:07:35 2002
+++ 08-odirect3/include/linux/nfs_xdr.h	Fri Oct  4 15:30:34 2002
@@ -2,4 +2,6 @@
 #define _LINUX_NFS_XDR_H
 
+#include <linux/sunrpc/xprt.h>
+
 struct nfs_fattr {
 	unsigned short		valid;		/* which fields are valid */
@@ -58,8 +60,12 @@
 };
 
-/* Arguments to the read call.
- * Note that NFS_READ_MAXIOV must be <= (MAX_IOVEC-2) from sunrpc/xprt.h
+/*
+ * Arguments to the read call.
  */
-#define NFS_READ_MAXIOV 8
+
+#define NFS_READ_MAXIOV		(9U)
+#if (NFS_READ_MAXIOV > (MAX_IOVEC -2))
+#error "NFS_READ_MAXIOV is too large"
+#endif
 
 struct nfs_readargs {
@@ -77,8 +83,12 @@
 };
 
-/* Arguments to the write call.
- * Note that NFS_WRITE_MAXIOV must be <= (MAX_IOVEC-2) from sunrpc/xprt.h
+/*
+ * Arguments to the write call.
  */
-#define NFS_WRITE_MAXIOV        8
+#define NFS_WRITE_MAXIOV	(9U)
+#if (NFS_WRITE_MAXIOV > (MAX_IOVEC -2))
+#error "NFS_WRITE_MAXIOV is too large"
+#endif
+
 struct nfs_writeargs {
 	struct nfs_fh *		fh;

-- 

corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

