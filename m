Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266849AbSKKRyL>; Mon, 11 Nov 2002 12:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266858AbSKKRyL>; Mon, 11 Nov 2002 12:54:11 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:3200 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S266849AbSKKRyH>;
	Mon, 11 Nov 2002 12:54:07 -0500
Date: Mon, 11 Nov 2002 19:00:37 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kraxel@bytesex.org
Subject: Re: 2.5.47: Uninitialized timer in bttv code
Message-ID: <20021111180037.GA1856@vana>
References: <20021111182641.104131b6.us15@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021111182641.104131b6.us15@os.inf.tu-dresden.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 06:26:41PM +0100, Udo A. Steinberg wrote:
> 
> Hi,
> 
> The bttv code in 2.5.47 triggers the following warning about use of
> uninitialized timer here. If a patch exists for this issue, I'll happily
> test it.
> 
> Uninitialised timer!
> This is just a warning.  Your computer is OK
> function=0xc0269630, data=0xc04f3380

Hi,
  first diff fixes this problem. Second diff marks all printk() from
bttv with (im)proper KERN_* defines, so they do not end up on my
console.

  This patch does not fix problem that 'rmmod bttv' kills my system
(do_IRQ is trying to do bad things, but I have no idea why as
bttv_remove does free_irq()). I have bt848 + bt878 in the box,
if it could matter.
						Petr Vandrovec
						vandrove@vc.cvut.cz

First diff:
diff -urNX .exclude linux-2.5.47.dist/drivers/media/video/bttv-driver.c linux-2.5.47/drivers/media/video/bttv-driver.c
--- linux-2.5.47.dist/drivers/media/video/bttv-driver.c	2002-11-11 12:26:17.000000000 +0100
+++ linux-2.5.47/drivers/media/video/bttv-driver.c	2002-11-11 18:41:31.000000000 +0100
@@ -3225,6 +3225,7 @@
         INIT_LIST_HEAD(&btv->capture);
         INIT_LIST_HEAD(&btv->vcapture);
 
+	init_timer(&btv->timeout);
 	btv->timeout.function = bttv_irq_timeout;
 	btv->timeout.data     = (unsigned long)btv;
 
Second diff:
diff -urNX .exclude linux-2.5.47.dist/drivers/media/video/bttv-driver.c linux-2.5.47/drivers/media/video/bttv-driver.c
--- linux-2.5.47.dist/drivers/media/video/bttv-driver.c	2002-11-11 12:26:17.000000000 +0100
+++ linux-2.5.47/drivers/media/video/bttv-driver.c	2002-11-11 18:41:31.000000000 +0100
@@ -591,7 +591,7 @@
 #if 1 /* DEBUG */
 	if ((fh->resources & bits) != bits) {
 		/* trying to free ressources not allocated by us ... */
-		printk("bttv: BUG! (btres)\n");
+		printk(KERN_EMERG "bttv: BUG! (btres)\n");
 	}
 #endif
 	down(&btv->reslock);
@@ -646,7 +646,7 @@
                 /* no PLL needed */
                 if (btv->pll.pll_current == 0)
                         return 0;
-		vprintk("bttv%d: PLL: switching off\n",btv->nr);
+		vprintk(KERN_DEBUG "bttv%d: PLL: switching off\n",btv->nr);
                 btwrite(0x00,BT848_TGCTRL);
                 btwrite(0x00,BT848_PLL_XCI);
                 btv->pll.pll_current = 0;
@@ -656,7 +656,7 @@
         if (btv->pll.pll_ofreq == btv->pll.pll_current)
                 return 0;
 
-	vprintk("bttv%d: PLL: %d => %d ",btv->nr,
+	vprintk(KERN_DEBUG "bttv%d: PLL: %d => %d ",btv->nr,
 		btv->pll.pll_ifreq, btv->pll.pll_ofreq);
 	set_pll_freq(btv, btv->pll.pll_ifreq, btv->pll.pll_ofreq);
 
@@ -693,7 +693,7 @@
        btwrite(0x00, BT848_TGCTRL);
        
        if (btv->digital_video  &&  -1 != table_idx) {
-               dprintk("bttv%d: load digital timing table (table_idx=%d)\n",
+               dprintk(KERN_DEBUG "bttv%d: load digital timing table (table_idx=%d)\n",
 		       btv->nr,table_idx);
 	       dvsif_val = 0x41;
                for(i = 0; i < 51; i++)
@@ -834,7 +834,7 @@
 	if (btv->opt_automute && !signal && !btv->radio_user)
 		mux = AUDIO_OFF;
 #if 0
-	printk("bttv%d: amux: mode=%d audio=%d signal=%s mux=%d/%d irq=%s\n",
+	printk(KERN_DEBUG "bttv%d: amux: mode=%d audio=%d signal=%s mux=%d/%d irq=%s\n",
 	       btv->nr, mode, btv->audio, signal ? "yes" : "no",
 	       mux, i2c_mux, in_interrupt() ? "yes" : "no");
 #endif
@@ -1948,16 +1948,16 @@
 	if (bttv_debug > 1) {
 		switch (_IOC_TYPE(cmd)) {
 		case 'v':
-			printk("bttv%d: ioctl 0x%x (v4l1, VIDIOC%s)\n",
+			printk(KERN_DEBUG "bttv%d: ioctl 0x%x (v4l1, VIDIOC%s)\n",
 			       btv->nr, cmd, (_IOC_NR(cmd) < V4L1_IOCTLS) ?
 			       v4l1_ioctls[_IOC_NR(cmd)] : "???");
 			break;
 		case 'V':
-			printk("bttv%d: ioctl 0x%x (v4l2, VIDIOC_%s)\n",
+			printk(KERN_DEBUG "bttv%d: ioctl 0x%x (v4l2, VIDIOC_%s)\n",
 			       btv->nr, cmd,  v4l2_ioctl_names[_IOC_NR(cmd)]);
 			break;
 		default:
-			printk("bttv%d: ioctl 0x%x (???)\n",
+			printk(KERN_DEBUG "bttv%d: ioctl 0x%x (???)\n",
 			       btv->nr, cmd);
 		}
 	}
@@ -2551,7 +2551,7 @@
 
 	if (fh->btv->errors)
 		bttv_reinit_bt848(fh->btv);
-	dprintk("read count=%d type=%s\n",
+	dprintk(KERN_DEBUG "read count=%d type=%s\n",
 		(int)count,v4l2_type_names[fh->type]);
 
 	switch (fh->type) {
@@ -2698,7 +2698,7 @@
 {
 	struct bttv_fh *fh = file->private_data;
 
-	dprintk("bttv%d: mmap type=%s 0x%lx+%ld\n",
+	dprintk(KERN_DEBUG "bttv%d: mmap type=%s 0x%lx+%ld\n",
 		fh->btv->nr, v4l2_type_names[fh->type],
 		vma->vm_start, vma->vm_end - vma->vm_start);
 	return videobuf_mmap_mapper(vma,bttv_queue(fh));
@@ -2745,7 +2745,7 @@
 	unsigned long v = 400*16;
 	int i;
 
-	dprintk("bttv: open minor=%d\n",minor);
+	dprintk(KERN_DEBUG "bttv: open minor=%d\n",minor);
 
 	for (i = 0; i < bttv_num; i++) {
 		if (bttvs[i].radio_dev.minor == minor) {
@@ -2756,7 +2756,7 @@
 	if (NULL == btv)
 		return -ENODEV;
 
-	dprintk("bttv%d: open called (radio)\n",btv->nr);
+	dprintk(KERN_DEBUG "bttv%d: open called (radio)\n",btv->nr);
 	down(&btv->lock);
 	if (btv->radio_user) {
 		up(&btv->lock);
@@ -2869,7 +2869,7 @@
 {
 	int i;
 	
-	printk("bits:");
+	printk(KERN_DEBUG "bits:");
 	for (i = 0; i < (sizeof(irq_name)/sizeof(char*)); i++) {
 		if (print & (1 << i))
 			printk(" %s",irq_name[i]);
@@ -2880,15 +2880,15 @@
 
 static void bttv_print_riscaddr(struct bttv *btv)
 {
-	printk("  main: %08Lx\n",
+	printk(KERN_DEBUG "  main: %08Lx\n",
 	       (u64)btv->main.dma);
-	printk("  vbi : o=%08Lx e=%08Lx\n",
+	printk(KERN_DEBUG "  vbi : o=%08Lx e=%08Lx\n",
 	       btv->vcurr ? (u64)btv->vcurr->top.dma : 0,
 	       btv->vcurr ? (u64)btv->vcurr->bottom.dma : 0);
-	printk("  cap : o=%08Lx e=%08Lx\n",
+	printk(KERN_DEBUG "  cap : o=%08Lx e=%08Lx\n",
 	       btv->top    ? (u64)btv->top->top.dma : 0,
 	       btv->bottom ? (u64)btv->bottom->bottom.dma : 0);
-	printk("  scr : o=%08Lx e=%08Lx\n",
+	printk(KERN_DEBUG "  scr : o=%08Lx e=%08Lx\n",
 	       btv->screen ? (u64)btv->screen->top.dma  : 0,
 	       btv->screen ? (u64)btv->screen->bottom.dma : 0);
 }
@@ -3264,7 +3265,7 @@
 	pci_set_command(dev);
 	pci_set_drvdata(dev,btv);
 	if (!pci_dma_supported(dev,0xffffffff)) {
-		printk("bttv: Oops: no 32bit PCI DMA ???\n");
+		printk(KERN_WARNING "bttv: Oops: no 32bit PCI DMA ???\n");
 		result = -EIO;
 		goto fail1;
 	}
@@ -3385,7 +3386,7 @@
         struct bttv *btv = pci_get_drvdata(pci_dev);
 
 	if (bttv_verbose)
-		printk("bttv%d: unloading\n",btv->nr);
+		printk(KERN_DEBUG "bttv%d: unloading\n",btv->nr);
 
         /* shutdown everything (DMA+IRQs) */
 	btand(~15, BT848_GPIO_DMA_CTL);
