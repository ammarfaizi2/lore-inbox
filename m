Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284908AbRLFAvS>; Wed, 5 Dec 2001 19:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284911AbRLFAvI>; Wed, 5 Dec 2001 19:51:08 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:7043 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S284908AbRLFAvA>; Wed, 5 Dec 2001 19:51:00 -0500
Message-ID: <3C0EC0ED.3000603@optonline.net>
Date: Wed, 05 Dec 2001 19:50:53 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net> <3C0DA1CC.1070408@redhat.com> <3C0DAD26.1020906@optonline.net> <3C0DAF35.50008@redhat.com> <3C0E7DCB.6050600@optonline.net> <3C0E7DFB.2030400@optonline.net> <3C0E7F1C.4060603@redhat.com> <3C0E8DBF.5010000@optonline.net> <3C0E90B2.1030601@redhat.com> <3C0EB1F2.7050007@optonline.net> <3C0EB46C.4010806@optonline.net> <3C0EBAEF.5090402@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------070901000609000406040100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070901000609000406040100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Doug Ledford wrote:

> Nathan Bryant wrote:
>
> OK, on my site there is now a 0.10 version of the driver.  This one 
> stands a reasonable chance of working in mmap mode.  Please give it a 
> try and let me know what happens (see my comments in 
> __i810_update_lvi() to see what I think the actual problem is).
>
> http://people.redhat.com/dledford/i810_audio.c.gz
>
>
>
>
some fixes needed, attached


--------------070901000609000406040100
Content-Type: text/plain;
 name="foo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="foo"

--- /home/nbryant/i810_audio.c	Wed Dec  5 19:49:38 2001
+++ drivers/sound/i810_audio.c	Wed Dec  5 19:49:00 2001
@@ -953,7 +953,7 @@
 	 * the CIV value to the next sg segment to be played so that when
 	 * we call start_{dac,adc}, things will operate properly
 	 */
-	if (!dmabuf->enabled)
+	if (!dmabuf->enable)
 		outb((inb(port+OFF_CIV)+1)&31, port+OFF_CIV);
 
 	/* swptr - 1 is the tail of our transfer */
@@ -961,7 +961,7 @@
 	x /= dmabuf->fragsize;
 #ifdef DEBUG_MMAP
 	if (dmabuf->count > dmabuf->fragsize && inb(port+OFF_CIV) == x)
-		printk(KERN_DEBUG,"i810_audio: update_lvi - CIV == LVI\n");
+		printk(KERN_DEBUG "i810_audio: update_lvi - CIV == LVI\n");
 #endif
 	outb(x, port+OFF_LVI);
 }
@@ -1124,7 +1124,6 @@
 	if(count <= 0 || timeout) {
 		stop_dac(state);
 		synchronize_irq();
-		resync_dma_ptrs(state, 0 /* record channel */);
 	}
 	if (signal_pending(current))
 		return -ERESTARTSYS;
@@ -1595,7 +1594,7 @@
 static int i810_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct i810_state *state = (struct i810_state *)file->private_data;
-	struct i810_channel *c;
+	struct i810_channel *c = NULL;
 	struct dmabuf *dmabuf = &state->dmabuf;
 	unsigned long flags;
 	audio_buf_info abinfo;
@@ -1629,10 +1628,12 @@
 			c = dmabuf->read_channel;
 			__stop_adc(state);
 		}
-		outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
-		outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
-		outb(0, state->card->iobase+c->port+OFF_CIV);
-		outb(0, state->card->iobase+c->port+OFF_LVI);
+		if (c != NULL) {
+			outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
+			outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
+			outb(0, state->card->iobase+c->port+OFF_CIV);
+			outb(0, state->card->iobase+c->port+OFF_LVI);
+		}
 
 		spin_unlock_irqrestore(&state->card->lock, flags);
 		synchronize_irq();

--------------070901000609000406040100--

