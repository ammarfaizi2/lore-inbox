Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUDFEWc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 00:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263613AbUDFEWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 00:22:32 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28059
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263584AbUDFEW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 00:22:26 -0400
Date: Tue, 6 Apr 2004 06:22:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040406042222.GP2234@dualathlon.random>
References: <20040402195927.A6659@infradead.org> <20040402192941.GP21341@dualathlon.random> <20040402205410.A7194@infradead.org> <20040402203514.GR21341@dualathlon.random> <20040403094058.A13091@infradead.org> <20040403152026.GE2307@dualathlon.random> <20040403155958.GF2307@dualathlon.random> <20040403170258.GH2307@dualathlon.random> <20040405105912.A3896@infradead.org> <20040405131113.A5094@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405131113.A5094@infradead.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 01:11:13PM +0100, Christoph Hellwig wrote:
> Disabling compound pages unconditionally gets it working again.

you know what, I'm looking hard everywhere (this is the only pending
still unresolved VM related bug I have) and at the end I happened to
quickly look at xfs too, and I see nothing else in the kernel as suspect
as such piece of xfs code that I touched below, unfortunately the
moltitude of xfs paths that can reach that place prevents me to
quickly identify an exact stacktrace where that bugcheck will trigger at
runtime, but it's the only remaining thing I didn't ruled out yet from
source code audit, plus the kind of corruption on page->private that
your previous debugging data showed matches _exactly_ with the kind of
bitflag corruption that those set_bits would generate. Plus disabling
compound fixes it. Plus this only triggers on xfs. Plus you never used
hugetlbfs=y before. Then there's the pagebuf_associate_memory that rings
an extremely *loud* bell, pagebuf_get_no_daddr and XBUF_SET_PTR sounds
even more, then I go on with xlog_get_bp and tons of other things doing
pagebuf I/O with kmalloced memory with variable size of the kmalloc. Too
many concidences for this not being an xfs bug.

What really happens is that you get errors with my tree because xfs in
some unlikely case is messing with set_bit on the page->private of slab
pages of order > 0.  This effectively means xfs has always been silenty
corrupting memory in 2.6 with hugetlbfs turned on, and I'm just exposing
this bug for the first time to you with my robustness gfp-no-compound
fix.

Maybe next time you'll think twice before insulting a patch that helped
you fix a nasty mm corruption bug by enhnacing the VM robustness, and
for the record there's not a single database specific change in my tree
(yet ;).

Can you give this thing a spin now on top of 2.6.5-aa3 and verify it
really triggers?

Index: fs/xfs/linux/xfs_buf.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/fs/xfs/linux/xfs_buf.c,v
retrieving revision 1.4
diff -u -p -r1.4 xfs_buf.c
--- fs/xfs/linux/xfs_buf.c	3 Mar 2004 06:53:03 -0000	1.4
+++ fs/xfs/linux/xfs_buf.c	6 Apr 2004 02:59:27 -0000
@@ -1285,6 +1285,7 @@ bio_end_io_pagebuf(
 	for (i = 0; i < bio->bi_vcnt; i++, bvec++) {
 		struct page	*page = bvec->bv_page;
 
+		BUG_ON(PageCompound(page));
 		if (pb->pb_error) {
 			SetPageError(page);
 		} else if (blocksize == PAGE_CACHE_SIZE) {


And now I give you a blazing fast 100% reliable fix so you can still
mess with page->private on the slab pages inside xfs as much as you want ;),
but without destabilizing 2.6 mainline with hugelbtfs=y (or 2.6-aa).
Note this fix wouldn't be possible w/o my new gfp-no-compound logic, so
you may have to apply the gfp-no-compound to the xfs tree too to fix the
hugetlbfs=y instability, this patch itself is incremental with
2.6.5-aa3.

I cannot reverse the logic to __GFP_COMP (that would microoptimize the
order > 0 allocations) or even more simply add a one liner in slab in
the __get_free_pages call because that would invalidate all the hard
driver testing done in the last few months: just like xfs breaks with
compound turned on, everything else may break with compound turned off
and the majority of the recent testing happened with compound on.

Please test it so I can checkin into CVS and release a 2.6-aa update.
Many thanks for all the help!

--- x/fs/xfs/linux/xfs_buf.c.~1~	2004-03-11 08:27:42.000000000 +0100
+++ x/fs/xfs/linux/xfs_buf.c	2004-04-06 06:02:58.095233216 +0200
@@ -189,7 +189,7 @@ free_address(
 {
 	a_list_t	*aentry;
 
-	aentry = kmalloc(sizeof(a_list_t), GFP_ATOMIC);
+	aentry = kmalloc(sizeof(a_list_t), GFP_ATOMIC | __GFP_NO_COMP);
 	if (aentry) {
 		spin_lock(&as_lock);
 		aentry->next = as_free_head;
@@ -870,7 +870,7 @@ pagebuf_get_no_daddr(
 			kfree(rmem); /* free the mem from the previous try */
 			tlen <<= 1; /* double the size and try again */
 		}
-		if ((rmem = kmalloc(tlen, GFP_KERNEL)) == 0) {
+		if ((rmem = kmalloc(tlen, GFP_KERNEL | __GFP_NO_COMP)) == 0) {
 			pagebuf_free(pb);
 			return NULL;
 		}
@@ -1285,6 +1285,7 @@ bio_end_io_pagebuf(
 	for (i = 0; i < bio->bi_vcnt; i++, bvec++) {
 		struct page	*page = bvec->bv_page;
 
+		BUG_ON(PageCompound(page));
 		if (pb->pb_error) {
 			SetPageError(page);
 		} else if (blocksize == PAGE_CACHE_SIZE) {
--- x/fs/xfs/linux/xfs_file.c.~1~	2004-04-04 08:09:26.000000000 +0200
+++ x/fs/xfs/linux/xfs_file.c	2004-04-06 06:01:42.165776248 +0200
@@ -348,7 +348,7 @@ linvfs_readdir(
 
 	/* Try fairly hard to get memory */
 	do {
-		if ((read_buf = (caddr_t)kmalloc(rlen, GFP_KERNEL)))
+		if ((read_buf = (caddr_t)kmalloc(rlen, GFP_KERNEL | __GFP_NO_COMP)))
 			break;
 		rlen >>= 1;
 	} while (rlen >= 1024);
--- x/fs/xfs/linux/xfs_iops.c.~1~	2004-04-06 05:57:39.817618768 +0200
+++ x/fs/xfs/linux/xfs_iops.c	2004-04-06 06:02:24.030411856 +0200
@@ -418,11 +418,11 @@ linvfs_follow_link(
 	ASSERT(dentry);
 	ASSERT(nd);
 
-	link = (char *)kmalloc(MAXNAMELEN+1, GFP_KERNEL);
+	link = (char *)kmalloc(MAXNAMELEN+1, GFP_KERNEL | __GFP_NO_COMP);
 	if (!link)
 		return -ENOMEM;
 
-	uio = (uio_t *)kmalloc(sizeof(uio_t), GFP_KERNEL);
+	uio = (uio_t *)kmalloc(sizeof(uio_t), GFP_KERNEL | __GFP_NO_COMP);
 	if (!uio) {
 		kfree(link);
 		return -ENOMEM;
--- x/fs/xfs/linux/xfs_ioctl.c.~1~	2004-04-04 08:09:26.000000000 +0200
+++ x/fs/xfs/linux/xfs_ioctl.c	2004-04-06 06:01:56.278630768 +0200
@@ -517,7 +517,7 @@ xfs_attrmulti_by_handle(
 		return -error;
 
 	size = am_hreq.opcount * sizeof(attr_multiop_t);
-	ops = (xfs_attr_multiop_t *)kmalloc(size, GFP_KERNEL);
+	ops = (xfs_attr_multiop_t *)kmalloc(size, GFP_KERNEL | __GFP_NO_COMP);
 	if (!ops) {
 		VN_RELE(vp);
 		return -XFS_ERROR(ENOMEM);
--- x/fs/xfs/linux/kmem.h.~1~	2004-04-04 08:09:26.000000000 +0200
+++ x/fs/xfs/linux/kmem.h	2004-04-06 06:08:14.173182064 +0200
@@ -101,7 +101,7 @@ kmem_flags_convert(int flags)
 	if (PFLAGS_TEST_FSTRANS() || (flags & KM_NOFS))
 		lflags &= ~__GFP_FS;
 
-	return lflags;
+	return lflags | __GFP_NO_COMP;
 }
 
 static __inline void *
