Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129517AbRCBViG>; Fri, 2 Mar 2001 16:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129509AbRCBVh4>; Fri, 2 Mar 2001 16:37:56 -0500
Received: from [62.172.234.2] ([62.172.234.2]:45525 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129517AbRCBVhi>; Fri, 2 Mar 2001 16:37:38 -0500
Date: Fri, 2 Mar 2001 21:37:24 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Hennus Bergman <hennus@cybercomm.nl>, linux-kernel@vger.kernel.org
Subject: [PATCH] QIC-02 tape broken buffaddr
In-Reply-To: <E14YteS-00020L-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0103022135140.1440-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have a QIC-02 tape drive to test, but its driver source
looks long broken.  Note the comment at line 2836 "TODO:
does _get_dma_pages() really return the physical address?" and
follow uses of buffaddr - sometimes physical, sometimes virtual.

Which worked in 2.2, with ISA DMA ignoring PAGE_OFFSET bits, and
bus_to_virt() or'ing them; but 2.4 bus_to_virt() adds PAGE_OFFSET.
Patch below against 2.4.2-ac9, applies to 2.4.[012] offset -2 lines.

Hugh

--- 2.4.2-ac9/drivers/char/tpqic02.c	Fri Mar  2 18:22:36 2001
+++ linux/drivers/char/tpqic02.c	Fri Mar  2 18:23:42 2001
@@ -210,7 +210,7 @@
  * must ensure that a large enough buffer is passed to the kernel, in order
  * to reduce tape repositioning wear and tear.
  */
-static unsigned long buffaddr;	/* physical address of buffer */
+static void *buffaddr;	/* virtual address of buffer */
 
 /* This translates minor numbers to the corresponding recording format: */
 static const char *format_names[] = {
@@ -1378,7 +1378,7 @@
 	flags=claim_dma_lock();
 	clear_dma_ff(QIC02_TAPE_DMA);
 	set_dma_mode(QIC02_TAPE_DMA, dma_mode);
-	set_dma_addr(QIC02_TAPE_DMA, buffaddr+dma_bytes_done);	/* full address */
+	set_dma_addr(QIC02_TAPE_DMA, virt_to_bus(buffaddr) + dma_bytes_done);
 	set_dma_count(QIC02_TAPE_DMA, TAPE_BLKSIZE);
 
 	/* start tape DMA controller */
@@ -1923,7 +1923,7 @@
 	    /* copy buffer to user-space in one go */
 	    if (bytes_done>0)
 	    {
-		err = copy_to_user( (void *) buf, (void *) bus_to_virt(buffaddr), bytes_done);
+		err = copy_to_user(buf, buffaddr, bytes_done);
 		if (err)
 		{
 		    return -EFAULT;
@@ -2076,7 +2076,7 @@
 	/* copy from user to DMA buffer and initiate transfer. */
 	if (bytes_todo>0)
 	{
-	    err = copy_from_user( (void *) bus_to_virt(buffaddr), (const void *) buf, bytes_todo);
+	    err = copy_from_user(buffaddr, buf, bytes_todo);
 	    if (err)
 	    {
 		return -EFAULT;
@@ -2782,7 +2782,7 @@
     release_region(QIC02_TAPE_PORT, QIC02_TAPE_PORT_RANGE);
     if (buffaddr)
     {
-	free_pages(buffaddr, get_order(TPQBUF_SIZE));
+	free_pages((unsigned long)buffaddr, get_order(TPQBUF_SIZE));
     }
     buffaddr = 0; /* Better to cause a panic than overwite someone else */
     status_zombie = YES;
@@ -2832,9 +2832,7 @@
     request_region(QIC02_TAPE_PORT, QIC02_TAPE_PORT_RANGE, TPQIC02_NAME);
     
     /* Setup the page-address for the dma transfer. */
-
-    /*** TODO: does _get_dma_pages() really return the physical address?? ****/
-    buffaddr = __get_dma_pages(GFP_KERNEL,get_order(TPQBUF_SIZE));
+    buffaddr = (void *)__get_dma_pages(GFP_KERNEL, get_order(TPQBUF_SIZE));
     
     if (!buffaddr)
     {
@@ -2842,7 +2840,7 @@
 	return -EBUSY; /* Not ideal, EAGAIN perhaps? */
     }
     
-    memset( (void*) buffaddr, 0, TPQBUF_SIZE );
+    memset(buffaddr, 0, TPQBUF_SIZE);
     
     printk(TPQIC02_NAME ": Settings: IRQ %d, DMA %d, IO 0x%x, IFC %s\n",
 	   QIC02_TAPE_IRQ, QIC02_TAPE_DMA,

