Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267008AbTBTVph>; Thu, 20 Feb 2003 16:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267022AbTBTVph>; Thu, 20 Feb 2003 16:45:37 -0500
Received: from [195.223.140.107] ([195.223.140.107]:13442 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267008AbTBTVpY>;
	Thu, 20 Feb 2003 16:45:24 -0500
Date: Thu, 20 Feb 2003 22:54:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>, t.baetzler@bringe.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: xdr nfs highmem deadlock fix [Re: filesystem access slowing system to a crawl]
Message-ID: <20030220215457.GV31480@x30.school.suse.de>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR> <200302191742.02275.m.c.p@wolk-project.de> <20030219174940.GJ14633@x30.suse.de> <200302201629.51374.m.c.p@wolk-project.de> <20030220103543.7c2d250c.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220103543.7c2d250c.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 10:35:43AM -0800, Andrew Morton wrote:
> Marc-Christian Petersen <m.c.p@wolk-project.de> wrote:
> >
> > On Wednesday 19 February 2003 18:49, Andrea Arcangeli wrote:
> > 
> > Hi Andrea,
> > 
> > > Marcelo please include this:
> > > 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.2
> > >1pre4aa3/10_inode-highmem-2
> > great. Thanks. Now let's hope Marcelo use this :)
> > 
> > > other fixes should be included too but they don't apply cleanly yet
> > > unfortunately, I (or somebody else) should rediff them against mainline.
> > Can you tell me what in special you mean? I'd do this.
> > 
> 
> Andrea's VM patches, against 2.4.21-pre4 are at
> 
> 	http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.21-pre4/
> 
> The applying order is in the series file.

Cool!

> 
> These have been rediffed, and apply cleanly.  They have not been
> tested much though.

If they didn't reject in non obvious way they should work fine too ;)
If Marcelo merges them I'll verify everything when I update to his tree
like I do regularly with everything else that rejects.

btw, I finished today fixing a deadlock condition in the xdr layer
triggered by nfs on highmem machines, here's the fix against 2.4.21pre4,
please apply it now to pre4 or will have to live in my tree with the
other hundred of patches like it happened to some of the patches we're
discussing in this thread.

Explanation is very simple: you _can't_ kmap two times in the context of
a single task (especially if more than one task can run the same code at
the same time). I don't yet have the confirmation that this fixes the
deadlock though (it takes days to reproduce so it will take weeks to
confirm), but I can't see anything else wrong at the moment, and this
remains a genuine highmem deadlock that has to be fixed.  The fix is
optimal, no change unless you run out of kmaps and in turn you can
deadlock, i.e. all the light workloads won't be affected at all.

Note, this was developed on top of 2.4.21pre4aa3, so I had to rework it
to make it apply cleanly to mainline, the version I tested and included
in -aa is different, so this one is untested but if it compiles it will
work like a charm ;).

2.5.62 has the very same deadlock condition in xdr triggered by nfs too.
Andrew, if you're forward porting it yourself like with the filebacked
vma merging feature just let me know so we make sure not to duplicate
effort.

diff -urNp nfs-ref/include/asm-i386/highmem.h nfs/include/asm-i386/highmem.h
--- nfs-ref/include/asm-i386/highmem.h	2003-02-14 07:01:58.000000000 +0100
+++ nfs/include/asm-i386/highmem.h	2003-02-20 21:42:17.000000000 +0100
@@ -56,16 +56,19 @@ extern void kmap_init(void) __init;
 #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
-extern void * FASTCALL(kmap_high(struct page *page));
+extern void * FASTCALL(kmap_high(struct page *page, int nonblocking));
 extern void FASTCALL(kunmap_high(struct page *page));
 
-static inline void *kmap(struct page *page)
+#define kmap(page) __kmap(page, 0)
+#define kmap_nonblock(page) __kmap(page, 1)
+
+static inline void *__kmap(struct page *page, int nonblocking)
 {
 	if (in_interrupt())
 		out_of_line_bug();
 	if (page < highmem_start_page)
 		return page_address(page);
-	return kmap_high(page);
+	return kmap_high(page, nonblocking);
 }
 
 static inline void kunmap(struct page *page)
diff -urNp nfs-ref/include/linux/sunrpc/xdr.h nfs/include/linux/sunrpc/xdr.h
--- nfs-ref/include/linux/sunrpc/xdr.h	2003-02-19 01:12:41.000000000 +0100
+++ nfs/include/linux/sunrpc/xdr.h	2003-02-20 21:39:51.000000000 +0100
@@ -137,7 +137,7 @@ void xdr_zero_iovec(struct iovec *, int,
  * XDR buffer helper functions
  */
 extern int xdr_kmap(struct iovec *, struct xdr_buf *, unsigned int);
-extern void xdr_kunmap(struct xdr_buf *, unsigned int);
+extern void xdr_kunmap(struct xdr_buf *, unsigned int, int);
 extern void xdr_shift_buf(struct xdr_buf *, size_t);
 
 /*
diff -urNp nfs-ref/mm/highmem.c nfs/mm/highmem.c
--- nfs-ref/mm/highmem.c	2002-11-29 02:23:18.000000000 +0100
+++ nfs/mm/highmem.c	2003-02-20 21:45:27.000000000 +0100
@@ -77,7 +77,7 @@ static void flush_all_zero_pkmaps(void)
 	flush_tlb_all();
 }
 
-static inline unsigned long map_new_virtual(struct page *page)
+static inline unsigned long map_new_virtual(struct page *page, int nonblocking)
 {
 	unsigned long vaddr;
 	int count;
@@ -96,6 +96,9 @@ start:
 		if (--count)
 			continue;
 
+		if (nonblocking)
+			return 0;
+
 		/*
 		 * Sleep for somebody else to unmap their entries
 		 */
@@ -126,7 +129,7 @@ start:
 	return vaddr;
 }
 
-void *kmap_high(struct page *page)
+void *kmap_high(struct page *page, int nonblocking)
 {
 	unsigned long vaddr;
 
@@ -138,11 +141,15 @@ void *kmap_high(struct page *page)
 	 */
 	spin_lock(&kmap_lock);
 	vaddr = (unsigned long) page->virtual;
-	if (!vaddr)
-		vaddr = map_new_virtual(page);
+	if (!vaddr) {
+		vaddr = map_new_virtual(page, nonblocking);
+		if (!vaddr)
+			goto out;
+	}
 	pkmap_count[PKMAP_NR(vaddr)]++;
 	if (pkmap_count[PKMAP_NR(vaddr)] < 2)
 		BUG();
+ out:
 	spin_unlock(&kmap_lock);
 	return (void*) vaddr;
 }
diff -urNp nfs-ref/net/sunrpc/xdr.c nfs/net/sunrpc/xdr.c
--- nfs-ref/net/sunrpc/xdr.c	2002-11-29 02:23:23.000000000 +0100
+++ nfs/net/sunrpc/xdr.c	2003-02-20 21:39:51.000000000 +0100
@@ -180,7 +180,7 @@ int xdr_kmap(struct iovec *iov_base, str
 {
 	struct iovec	*iov = iov_base;
 	struct page	**ppage = xdr->pages;
-	unsigned int	len, pglen = xdr->page_len;
+	unsigned int	len, pglen = xdr->page_len, first_kmap;
 
 	len = xdr->head[0].iov_len;
 	if (base < len) {
@@ -203,9 +203,17 @@ int xdr_kmap(struct iovec *iov_base, str
 		ppage += base >> PAGE_CACHE_SHIFT;
 		base &= ~PAGE_CACHE_MASK;
 	}
+	first_kmap = 1;
 	do {
 		len = PAGE_CACHE_SIZE;
-		iov->iov_base = kmap(*ppage);
+		if (first_kmap) {
+			first_kmap = 0;
+			iov->iov_base = kmap(*ppage);
+		} else {
+			iov->iov_base = kmap_nonblock(*ppage);
+			if (!iov->iov_base)
+				goto out;
+		}
 		if (base) {
 			iov->iov_base += base;
 			len -= base;
@@ -223,20 +231,23 @@ map_tail:
 		iov->iov_base = (char *)xdr->tail[0].iov_base + base;
 		iov++;
 	}
+ out:
 	return (iov - iov_base);
 }
 
-void xdr_kunmap(struct xdr_buf *xdr, unsigned int base)
+void xdr_kunmap(struct xdr_buf *xdr, unsigned int base, int niov)
 {
 	struct page	**ppage = xdr->pages;
 	unsigned int	pglen = xdr->page_len;
 
 	if (!pglen)
 		return;
-	if (base > xdr->head[0].iov_len)
+	if (base >= xdr->head[0].iov_len)
 		base -= xdr->head[0].iov_len;
-	else
+	else {
+		niov--;
 		base = 0;
+	}
 
 	if (base >= pglen)
 		return;
@@ -250,7 +261,11 @@ void xdr_kunmap(struct xdr_buf *xdr, uns
 		 * we bump pglen here, and just subtract PAGE_CACHE_SIZE... */
 		pglen += base & ~PAGE_CACHE_MASK;
 	}
-	for (;;) {
+	/*
+	 * In case we could only do a partial xdr_kmap, all remaining iovecs
+	 * refer to pages. Otherwise we detect the end through pglen.
+	 */
+	for (; niov; niov--) {
 		flush_dcache_page(*ppage);
 		kunmap(*ppage);
 		if (pglen <= PAGE_CACHE_SIZE)
@@ -322,9 +337,22 @@ void
 xdr_shift_buf(struct xdr_buf *xdr, size_t len)
 {
 	struct iovec iov[MAX_IOVEC];
-	unsigned int nr;
+	unsigned int nr, len_part, n, skip;
+
+	skip = 0;
+	do {
+
+		nr = xdr_kmap(iov, xdr, skip);
+
+		len_part = 0;
+		for (n = 0; n < nr; n++)
+			len_part += iov[n].iov_len;
+
+		xdr_shift_iovec(iov, nr, len_part);
+
+		xdr_kunmap(xdr, skip, nr);
 
-	nr = xdr_kmap(iov, xdr, 0);
-	xdr_shift_iovec(iov, nr, len);
-	xdr_kunmap(xdr, 0);
+		skip += len_part;
+		len -= len_part;
+	} while (len);
 }
diff -urNp nfs-ref/net/sunrpc/xprt.c nfs/net/sunrpc/xprt.c
--- nfs-ref/net/sunrpc/xprt.c	2003-01-29 06:14:32.000000000 +0100
+++ nfs/net/sunrpc/xprt.c	2003-02-20 21:39:51.000000000 +0100
@@ -226,23 +226,34 @@ xprt_sendmsg(struct rpc_xprt *xprt, stru
 	/* Dont repeat bytes */
 	skip = req->rq_bytes_sent;
 	slen = xdr->len - skip;
-	niov = xdr_kmap(niv, xdr, skip);
+	oldfs = get_fs(); set_fs(get_ds());
+	do {
+		unsigned int slen_part, n;
 
-	msg.msg_flags   = MSG_DONTWAIT|MSG_NOSIGNAL;
-	msg.msg_iov	= niv;
-	msg.msg_iovlen	= niov;
-	msg.msg_name	= (struct sockaddr *) &xprt->addr;
-	msg.msg_namelen = sizeof(xprt->addr);
-	msg.msg_control = NULL;
-	msg.msg_controllen = 0;
+		niov = xdr_kmap(niv, xdr, skip);
 
-	oldfs = get_fs(); set_fs(get_ds());
-	clear_bit(SOCK_ASYNC_NOSPACE, &sock->flags);
-	result = sock_sendmsg(sock, &msg, slen);
+		msg.msg_flags   = MSG_DONTWAIT|MSG_NOSIGNAL;
+		msg.msg_iov	= niv;
+		msg.msg_iovlen	= niov;
+		msg.msg_name	= (struct sockaddr *) &xprt->addr;
+		msg.msg_namelen = sizeof(xprt->addr);
+		msg.msg_control = NULL;
+		msg.msg_controllen = 0;
+
+		slen_part = 0;
+		for (n = 0; n < niov; n++)
+			slen_part += niv[n].iov_len;
+
+		clear_bit(SOCK_ASYNC_NOSPACE, &sock->flags);
+		result = sock_sendmsg(sock, &msg, slen_part);
+
+		xdr_kunmap(xdr, skip, niov);
+
+		skip += slen_part;
+		slen -= slen_part;
+	} while (result >= 0 && slen);
 	set_fs(oldfs);
 
-	xdr_kunmap(xdr, skip);
-
 	dprintk("RPC:      xprt_sendmsg(%d) = %d\n", slen, result);
 
 	if (result >= 0)

Andrea
