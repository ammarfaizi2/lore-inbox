Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291606AbSBMMLp>; Wed, 13 Feb 2002 07:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291607AbSBMMLb>; Wed, 13 Feb 2002 07:11:31 -0500
Received: from [195.63.194.11] ([195.63.194.11]:20487 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291606AbSBMMLK>; Wed, 13 Feb 2002 07:11:10 -0500
Message-ID: <3C6A57CE.9010107@evision-ventures.com>
Date: Wed, 13 Feb 2002 13:10:54 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com> <200201290137.g0T1bwB24120@karis.localdomain> <a354iv$ai9$1@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------040107030805070201030109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040107030805070201030109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached 3 patches serve the following purposes:

1. Make the i810_audio.c driver working again. Well it's tested on my 
private hardware.

2. Make the bttv driver work again. I know that there is a GREAT REWRITE 
of this
  driver underway, but still it's a bit annoying to miss the TV until 
that's ready.

3. This is just fixing an obvious mistake from the final release and let's
  the whole compile at all on IA32.



--------------040107030805070201030109
Content-Type: text/plain;
 name="i810_audio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i810_audio.patch"

diff -ur linux/drivers/sound/i810_audio.c linux-new/drivers/sound/i810_audio.c
--- linux/drivers/sound/i810_audio.c	Tue Feb 12 18:32:55 2002
+++ linux-new/drivers/sound/i810_audio.c	Mon Feb 11 01:34:36 2002
@@ -939,7 +939,7 @@
 	  
 		for(i=0;i<dmabuf->numfrag;i++)
 		{
-			sg->busaddr=virt_to_bus(dmabuf->rawbuf+dmabuf->fragsize*i);
+			sg->busaddr=virt_to_phys(dmabuf->rawbuf+dmabuf->fragsize*i);
 			// the card will always be doing 16bit stereo
 			sg->control=dmabuf->fragsamples;
 			if(state->card->pci_id == PCI_DEVICE_ID_SI_7012)
@@ -954,7 +954,7 @@
 		}
 		spin_lock_irqsave(&state->card->lock, flags);
 		outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
-		outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
+		outl(virt_to_phys(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
 		outb(0, state->card->iobase+c->port+OFF_CIV);
 		outb(0, state->card->iobase+c->port+OFF_LVI);
 
@@ -1669,7 +1669,7 @@
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),
 			     size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
@@ -1722,7 +1722,7 @@
 		}
 		if (c != NULL) {
 			outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
-			outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
+			outl(virt_to_phys(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
 			outb(0, state->card->iobase+c->port+OFF_CIV);
 			outb(0, state->card->iobase+c->port+OFF_LVI);
 		}

--------------040107030805070201030109
Content-Type: text/plain;
 name="bttv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bttv.patch"

diff -ur linux/drivers/media/video/bttv-driver.c linux-new/drivers/media/video/bttv-driver.c
--- linux/drivers/media/video/bttv-driver.c	Tue Feb 12 18:32:53 2002
+++ linux-new/drivers/media/video/bttv-driver.c	Mon Feb 11 01:42:05 2002
@@ -166,23 +166,23 @@
 	return ret;
 }
 
-static inline unsigned long uvirt_to_bus(unsigned long adr) 
+static inline unsigned long uvirt_to_phys(unsigned long adr)
 {
         unsigned long kva, ret;
 
         kva = uvirt_to_kva(pgd_offset(current->mm, adr), adr);
-	ret = virt_to_bus((void *)kva);
+	ret = virt_to_phys((void *)kva);
         MDEBUG(printk("uv2b(%lx-->%lx)", adr, ret));
         return ret;
 }
 
-static inline unsigned long kvirt_to_bus(unsigned long adr) 
+static inline unsigned long kvirt_to_phys(unsigned long adr)
 {
         unsigned long va, kva, ret;
 
         va = VMALLOC_VMADDR(adr);
         kva = uvirt_to_kva(pgd_offset_k(va), va);
-	ret = virt_to_bus((void *)kva);
+	ret = virt_to_phys((void *)kva);
         MDEBUG(printk("kv2b(%lx-->%lx)", adr, ret));
         return ret;
 }
@@ -530,29 +530,29 @@
   
 	if (bttv_debug > 1)
 		printk("bttv%d: vbi1: po=%08lx pe=%08lx\n",
-		       btv->nr,virt_to_bus(po), virt_to_bus(pe));
+		       btv->nr,virt_to_phys(po), virt_to_phys(pe));
         
 	*(po++)=cpu_to_le32(BT848_RISC_SYNC|BT848_FIFO_STATUS_FM1); *(po++)=0;
 	for (i=0; i<VBI_MAXLINES; i++) 
 	{
 		*(po++)=cpu_to_le32(VBI_RISC);
-		*(po++)=cpu_to_le32(kvirt_to_bus((unsigned long)btv->vbibuf+i*2048));
+		*(po++)=cpu_to_le32(kvirt_to_phys((unsigned long)btv->vbibuf+i*2048));
 	}
 	*(po++)=cpu_to_le32(BT848_RISC_JUMP);
-	*(po++)=cpu_to_le32(virt_to_bus(btv->risc_jmp+4));
+	*(po++)=cpu_to_le32(virt_to_phys(btv->risc_jmp+4));
 
 	*(pe++)=cpu_to_le32(BT848_RISC_SYNC|BT848_FIFO_STATUS_FM1); *(pe++)=0;
 	for (i=VBI_MAXLINES; i<VBI_MAXLINES*2; i++) 
 	{
 		*(pe++)=cpu_to_le32(VBI_RISC);
-		*(pe++)=cpu_to_le32(kvirt_to_bus((unsigned long)btv->vbibuf+i*2048));
+		*(pe++)=cpu_to_le32(kvirt_to_phys((unsigned long)btv->vbibuf+i*2048));
 	}
 	*(pe++)=cpu_to_le32(BT848_RISC_JUMP|BT848_RISC_IRQ|(0x01<<16));
-	*(pe++)=cpu_to_le32(virt_to_bus(btv->risc_jmp+10));
+	*(pe++)=cpu_to_le32(virt_to_phys(btv->risc_jmp+10));
 
 	if (bttv_debug > 1)
 		printk("bttv%d: vbi2: po=%08lx pe=%08lx\n",
-		       btv->nr,virt_to_bus(po), virt_to_bus(pe));
+		       btv->nr,virt_to_phys(po), virt_to_phys(pe));
 }
 
 static int fmtbppx2[16] = {
@@ -599,9 +599,9 @@
 	for (line=0; line < 640; line++)
 	{
                 *(ro++)=cpu_to_le32(BT848_RISC_WRITE|bpl|BT848_RISC_SOL|BT848_RISC_EOL);
-                *(ro++)=cpu_to_le32(kvirt_to_bus(vadr));
+                *(ro++)=cpu_to_le32(kvirt_to_phys(vadr));
                 *(re++)=cpu_to_le32(BT848_RISC_WRITE|bpl|BT848_RISC_SOL|BT848_RISC_EOL);
-                *(re++)=cpu_to_le32(kvirt_to_bus(vadr+gbufsize/2));
+                *(re++)=cpu_to_le32(kvirt_to_phys(vadr+gbufsize/2));
                 vadr+=bpl;
 	}
 	
@@ -629,7 +629,7 @@
 
 	if (bttv_debug > 1)
 		printk("bttv%d: prisc1: ro=%08lx re=%08lx\n",
-		       btv->nr,virt_to_bus(ro), virt_to_bus(re));
+		       btv->nr,virt_to_phys(ro), virt_to_phys(re));
 
 	switch(fmt)
 	{
@@ -705,13 +705,13 @@
 		 
 		 *((*rp)++)=cpu_to_le32(rcmd|bl);
 		 *((*rp)++)=cpu_to_le32(blcb|(blcr<<16));
-		 *((*rp)++)=cpu_to_le32(kvirt_to_bus(vadr));
+		 *((*rp)++)=cpu_to_le32(kvirt_to_phys(vadr));
 		 vadr+=bl;
 		 if((rcmd&(15<<28))==BT848_RISC_WRITE123)
 		 {
-		 	*((*rp)++)=cpu_to_le32(kvirt_to_bus(cbadr));
+		 	*((*rp)++)=cpu_to_le32(kvirt_to_phys(cbadr));
 		 	cbadr+=blcb;
-		 	*((*rp)++)=cpu_to_le32(kvirt_to_bus(cradr));
+		 	*((*rp)++)=cpu_to_le32(kvirt_to_phys(cradr));
 		 	cradr+=blcr;
 		 }
 		 
@@ -726,7 +726,7 @@
 	
 	if (bttv_debug > 1)
 		printk("bttv%d: prisc2: ro=%08lx re=%08lx\n",
-		       btv->nr,virt_to_bus(ro), virt_to_bus(re));
+		       btv->nr,virt_to_phys(ro), virt_to_phys(re));
 
 	return 0;
 }
@@ -751,7 +751,7 @@
 
 	if (bttv_debug > 1)
 		printk("bttv%d: vrisc1: ro=%08lx re=%08lx\n",
-		       btv->nr,virt_to_bus(ro), virt_to_bus(re));
+		       btv->nr,virt_to_phys(ro), virt_to_phys(re));
 	
 	inter = (height>tvnorms[btv->win.norm].sheight/2) ? 1 : 0;
 	bpl=width*fmtbppx2[palette2fmt[palette]&0xf]/2;
@@ -773,25 +773,25 @@
                 {
 		        *((*rp)++)=cpu_to_le32(BT848_RISC_WRITE|BT848_RISC_SOL|
 			        BT848_RISC_EOL|bpl); 
-			*((*rp)++)=cpu_to_le32(kvirt_to_bus(vadr));
+			*((*rp)++)=cpu_to_le32(kvirt_to_phys(vadr));
 			vadr+=bpl;
 		}
 		else
 		{
 		        todo=bpl;
 		        *((*rp)++)=cpu_to_le32(BT848_RISC_WRITE|BT848_RISC_SOL|bl);
-			*((*rp)++)=cpu_to_le32(kvirt_to_bus(vadr));
+			*((*rp)++)=cpu_to_le32(kvirt_to_phys(vadr));
 			vadr+=bl;
 			todo-=bl;
 			while (todo>PAGE_SIZE)
 			{
 			        *((*rp)++)=cpu_to_le32(BT848_RISC_WRITE|PAGE_SIZE);
-				*((*rp)++)=cpu_to_le32(kvirt_to_bus(vadr));
+				*((*rp)++)=cpu_to_le32(kvirt_to_phys(vadr));
 				vadr+=PAGE_SIZE;
 				todo-=PAGE_SIZE;
 			}
 			*((*rp)++)=cpu_to_le32(BT848_RISC_WRITE|BT848_RISC_EOL|todo);
-			*((*rp)++)=cpu_to_le32(kvirt_to_bus(vadr));
+			*((*rp)++)=cpu_to_le32(kvirt_to_phys(vadr));
 			vadr+=todo;
 		}
 	}
@@ -803,7 +803,7 @@
 
 	if (bttv_debug > 1)
 		printk("bttv%d: vrisc2: ro=%08lx re=%08lx\n",
-		       btv->nr,virt_to_bus(ro), virt_to_bus(re));
+		       btv->nr,virt_to_phys(ro), virt_to_phys(re));
 	
 	return 0;
 }
@@ -896,7 +896,7 @@
 
 	if (bttv_debug)
 		printk("bttv%d: clip: ro=%08lx re=%08lx\n",
-		       btv->nr,virt_to_bus(ro), virt_to_bus(re));
+		       btv->nr,virt_to_phys(ro), virt_to_phys(re));
 
 	if ((clipmap=vmalloc(VIDEO_CLIPMAP_SIZE))==NULL) {
 		/* can't clip, don't generate any risc code */
@@ -1213,8 +1213,8 @@
 	btv->gbuf[mp->frame].fmt     = palette2fmt[mp->format];
 	btv->gbuf[mp->frame].width   = mp->width;
 	btv->gbuf[mp->frame].height  = mp->height;
-	btv->gbuf[mp->frame].ro      = virt_to_bus(ro);
-	btv->gbuf[mp->frame].re      = virt_to_bus(re);
+	btv->gbuf[mp->frame].ro      = virt_to_phys(ro);
+	btv->gbuf[mp->frame].re      = virt_to_phys(re);
 
 #if 1
 	if (mp->height <= tvnorms[btv->win.norm].sheight/2 &&
@@ -1341,7 +1341,7 @@
 	btwrite(0xfffffUL, BT848_INT_STAT);
 	btand(~15, BT848_GPIO_DMA_CTL);
 	btwrite(0, BT848_SRESET);
-	btwrite(virt_to_bus(btv->risc_jmp+2),
+	btwrite(virt_to_phys(btv->risc_jmp+2),
 		BT848_RISC_STRT_ADD);
 
 	/* enforce pll reprogramming */
@@ -2371,7 +2371,7 @@
 
 	if (bttv_debug > 1)
 		printk("bttv%d: set_risc_jmp %08lx:",
-		       btv->nr,virt_to_bus(btv->risc_jmp));
+		       btv->nr,virt_to_phys(btv->risc_jmp));
 
 	/* Sync to start of odd field */
 	btv->risc_jmp[0]=cpu_to_le32(BT848_RISC_SYNC|BT848_RISC_RESYNC
@@ -2382,12 +2382,12 @@
 	btv->risc_jmp[2]=cpu_to_le32(BT848_RISC_JUMP|(0xd<<20));
 	if (flags&8) {
 		if (bttv_debug > 1)
-			printk(" ev=%08lx",virt_to_bus(btv->vbi_odd));
-		btv->risc_jmp[3]=cpu_to_le32(virt_to_bus(btv->vbi_odd));
+			printk(" ev=%08lx",virt_to_phys(btv->vbi_odd));
+		btv->risc_jmp[3]=cpu_to_le32(virt_to_phys(btv->vbi_odd));
 	} else {
 		if (bttv_debug > 1)
 			printk(" -----------");
-		btv->risc_jmp[3]=cpu_to_le32(virt_to_bus(btv->risc_jmp+4));
+		btv->risc_jmp[3]=cpu_to_le32(virt_to_phys(btv->risc_jmp+4));
 	}
 
         /* Jump to odd sub */
@@ -2400,12 +2400,12 @@
 	} else if ((flags&2) &&
 		   (!btv->win.interlace || 0 == btv->risc_cap_even)) {
 		if (bttv_debug > 1)
-			printk(" eo=%08lx",virt_to_bus(btv->risc_scr_odd));
-		btv->risc_jmp[5]=cpu_to_le32(virt_to_bus(btv->risc_scr_odd));
+			printk(" eo=%08lx",virt_to_phys(btv->risc_scr_odd));
+		btv->risc_jmp[5]=cpu_to_le32(virt_to_phys(btv->risc_scr_odd));
 	} else {
 		if (bttv_debug > 1)
 			printk(" -----------");
-		btv->risc_jmp[5]=cpu_to_le32(virt_to_bus(btv->risc_jmp+6));
+		btv->risc_jmp[5]=cpu_to_le32(virt_to_phys(btv->risc_jmp+6));
 	}
 
 
@@ -2418,12 +2418,12 @@
 	btv->risc_jmp[8]=cpu_to_le32(BT848_RISC_JUMP);
 	if (flags&4) {
 		if (bttv_debug > 1)
-			printk(" ov=%08lx",virt_to_bus(btv->vbi_even));
-		btv->risc_jmp[9]=cpu_to_le32(virt_to_bus(btv->vbi_even));
+			printk(" ov=%08lx",virt_to_phys(btv->vbi_even));
+		btv->risc_jmp[9]=cpu_to_le32(virt_to_phys(btv->vbi_even));
 	} else {
 		if (bttv_debug > 1)
 			printk(" -----------");
-		btv->risc_jmp[9]=cpu_to_le32(virt_to_bus(btv->risc_jmp+10));
+		btv->risc_jmp[9]=cpu_to_le32(virt_to_phys(btv->risc_jmp+10));
 	}
 
 	/* Jump to even sub */
@@ -2436,12 +2436,12 @@
 	} else if ((flags&1) &&
 		   btv->win.interlace) {
 		if (bttv_debug > 1)
-			printk(" oo=%08lx",virt_to_bus(btv->risc_scr_even));
-		btv->risc_jmp[11]=cpu_to_le32(virt_to_bus(btv->risc_scr_even));
+			printk(" oo=%08lx",virt_to_phys(btv->risc_scr_even));
+		btv->risc_jmp[11]=cpu_to_le32(virt_to_phys(btv->risc_scr_even));
 	} else {
 		if (bttv_debug > 1)
 			printk(" -----------");
-		btv->risc_jmp[11]=cpu_to_le32(virt_to_bus(btv->risc_jmp+12));
+		btv->risc_jmp[11]=cpu_to_le32(virt_to_phys(btv->risc_jmp+12));
 	}
 
 	if (btv->gq_start) {
@@ -2449,7 +2449,7 @@
 	} else {
 		btv->risc_jmp[12]=cpu_to_le32(BT848_RISC_JUMP);
 	}
-	btv->risc_jmp[13]=cpu_to_le32(virt_to_bus(btv->risc_jmp));
+	btv->risc_jmp[13]=cpu_to_le32(virt_to_phys(btv->risc_jmp));
 
 	/* enable cpaturing and DMA */
 	if (bttv_debug > 1)
@@ -2546,10 +2546,10 @@
 		return -1;
 	btv->vbi_odd=btv->risc_jmp+16;
 	btv->vbi_even=btv->vbi_odd+256;
-	btv->bus_vbi_odd=virt_to_bus(btv->risc_jmp+12);
-	btv->bus_vbi_even=virt_to_bus(btv->risc_jmp+6);
+	btv->bus_vbi_odd=virt_to_phys(btv->risc_jmp+12);
+	btv->bus_vbi_even=virt_to_phys(btv->risc_jmp+6);
 
-	btwrite(virt_to_bus(btv->risc_jmp+2), BT848_RISC_STRT_ADD);
+	btwrite(virt_to_phys(btv->risc_jmp+2), BT848_RISC_STRT_ADD);
 	btv->vbibuf=(unsigned char *) vmalloc_32(VBIBUF_SIZE);
 	if (!btv->vbibuf) 
 		return -1;
@@ -2719,7 +2719,7 @@
 			if (btv->errors < BTTV_ERRORS) {
 				spin_lock(&btv->s_lock);
 				btand(~15, BT848_GPIO_DMA_CTL);
-				btwrite(virt_to_bus(btv->risc_jmp+2),
+				btwrite(virt_to_phys(btv->risc_jmp+2),
 					BT848_RISC_STRT_ADD);
 				bt848_set_geo(btv,0);
 				bt848_set_risc_jmps(btv,-1);

--------------040107030805070201030109
Content-Type: text/plain;
 name="compile-2.5.4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="compile-2.5.4.patch"

diff -ur linux-2.5.4/arch/i386/kernel/process.c linux/arch/i386/kernel/process.c
--- linux-2.5.4/arch/i386/kernel/process.c	Mon Feb 11 02:50:06 2002
+++ linux/arch/i386/kernel/process.c	Tue Feb 12 19:58:33 2002
@@ -468,6 +468,14 @@
 }
 
 /*
+ * Return saved PC of a blocked thread.
+ */
+unsigned long thread_saved_pc(struct task_struct *tsk)
+{
+	return ((unsigned long *)tsk->thread.esp)[3];
+}
+
+/*
  * No need to lock the MM as we are the last user
  */
 void release_segments(struct mm_struct *mm)
diff -ur linux-2.5.4/include/asm-i386/processor.h linux/include/asm-i386/processor.h
--- linux-2.5.4/include/asm-i386/processor.h	Mon Feb 11 02:50:08 2002
+++ linux/include/asm-i386/processor.h	Tue Feb 12 20:03:54 2002
@@ -436,13 +436,8 @@
 extern void copy_segments(struct task_struct *p, struct mm_struct * mm);
 extern void release_segments(struct mm_struct * mm);
 
-/*
- * Return saved PC of a blocked thread.
- */
-static inline unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-	return ((unsigned long *)tsk->thread->esp)[3];
-}
+/* Return saved PC of a blocked thread. */
+extern unsigned long thread_saved_pc(struct task_struct *tsk);
 
 unsigned long get_wchan(struct task_struct *p);
 #define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1019])

--------------040107030805070201030109--

