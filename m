Return-Path: <linux-kernel-owner+w=401wt.eu-S1030353AbXAEG5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbXAEG5w (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 01:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbXAEG5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 01:57:52 -0500
Received: from mga03.intel.com ([143.182.124.21]:7853 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030353AbXAEG5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 01:57:52 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,240,1165219200"; 
   d="scan'208"; a="165476854:sNHT37816394"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Hugh Dickins'" <hugh@veritas.com>, "Hua Zhong" <hzhong@gmail.com>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "Christoph Hellwig" <hch@infradead.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'Linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: open(O_DIRECT) on a tmpfs?
Date: Thu, 4 Jan 2007 22:57:49 -0800
Message-ID: <000001c73096$d0e7d370$ab80030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccwNM9cHxJq19o3Qiygnsvs07VjhgAYJdIw
In-Reply-To: <Pine.LNX.4.64.0701041911470.27405@blonde.wat.veritas.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote on Thursday, January 04, 2007 11:14 AM
> On Thu, 4 Jan 2007, Hua Zhong wrote:
> > So I'd argue that it makes more sense to support O_DIRECT
> > on tmpfs as the memory IS the backing store.
> 
> A few more voices in favour and I'll be persuaded.  Perhaps I'm
> out of date: when O_DIRECT came in, just a few filesystems supported
> it, and it was perfectly normal for open O_DIRECT to be failed; but
> I wouldn't want tmpfs to stand out now as a lone obstacle.

Maybe a bit hackish, all we need is to have an empty .direct_IO method
in shmem_aops to make __dentry_open() to pass the O_DIRECT check.  The
following patch adds 40 bytes to kernel text on x86-64.  An even more
hackish but zero cost route is to make .direct_IO variable non-zero via
a cast of -1 or some sort (that is probably ugly as hell).


diff -Nurp linus-2.6.git/mm/shmem.c linus-2.6.git.ken/mm/shmem.c
--- linus-2.6.git/mm/shmem.c	2006-12-27 19:06:11.000000000 -0800
+++ linus-2.6.git.ken/mm/shmem.c	2007-01-04 21:03:14.000000000 -0800
@@ -2314,10 +2314,18 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(shmem_inode_cachep);
 }
 
+ssize_t shmem_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
+			loff_t offset, unsigned long nr_segs)
+{
+	/* dummy direct_IO function.  Not to be executed */
+	BUG();
+}
+
 static const struct address_space_operations shmem_aops = {
 	.writepage	= shmem_writepage,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
 #ifdef CONFIG_TMPFS
+	.direct_IO	= shmem_direct_IO,
 	.prepare_write	= shmem_prepare_write,
 	.commit_write	= simple_commit_write,
 #endif
