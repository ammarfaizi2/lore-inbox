Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbVLOTjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbVLOTjU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbVLOTjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:39:20 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:11704 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750974AbVLOTjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:39:19 -0500
Message-ID: <43A1C6E9.2060205@ru.mvista.com>
Date: Thu, 15 Dec 2005 22:41:29 +0300
From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org,
       Konstantin Baidarov <kbaidarov@ru.mvista.com>
Subject: [PATCH] Au1550 AC'97 OSS driver spinlock fixes
Content-Type: multipart/mixed;
 boundary="------------070308000602040202030306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070308000602040202030306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    Forwarding this patch from linux-mips in hopes it gets into the kernel at 
last...
    The original problem it dealt with was a single spinlock being grabbed 
twice (by start_dac() and its caller) causing BUG with mutex based spinlock 
implementation from Ingo's realtime patch. It then became clear that the 
driver still wasn't safe in this respect because the spinlocks weren't grabbed 
in all the places where they should have been (start_adc() and both interrupt 
handlers) which could have broken the driver in case of the interrupt handlers 
being threaded.
    The patch should apply to the current kernel.org driver.

WBR, Sergei

PS: I'm not reading linux-kernel, so please CC me when replying.

-------- Original Message --------
Subject: Re: [Alsa-devel] Au1550 OSS driver issues
Date: Thu, 08 Dec 2005 23:46:05 +0300
From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
To: linux-mips@linux-mips.org
CC: Jordan Crouse <jordan.crouse@amd.com>
References: <43452054.2090305@ru.mvista.com> <436FB1DE.6010405@ru.mvista.com>
<43988C42.2060904@ru.mvista.com>

Sergei Shtylylov wrote:
> Hello, I wrote:
> 
>>>     We have found some issues with Au1550 AC'97 OSS driver in 2.6
>>> (sound/oss/au1550_ac97.c), though it also should concern 2.4 driver
>>> (drivers/sound/au1550_psc.c).

> [au_readl() issue skipped]

>>>     Second, start_dac() grabs a spinlock already held by its caller, 
>>> au1550_write(). This doesn't show up with the standard UP spinlock 
>>> impelmentation but when the different one (mutex based) is in use, a 
>>> lockup happens. The second patch demonstates a possible solution but 
>>> here's a question: why there's no "symmetric" spinlock logic in 
>>> start_adc(), may be here exits another potential issue?
> 
> 
>    Unfortunately, the proposed solution was incorrect for that mutex case
> because it was breaking the "critical section" by temporarily dropping the
> spinlock to call start_dac(). So, here's the updated version of that 
> patch in
> which start_dac() and start_adc() don't grab the spinlocks anymore but 
> their
> callers do instead.
> 
>>         After having a look at sound/oss/au1000.c,
> 
> 
>    Now I don't think that this trick is always correct but since that 
> driver
> is obsoleted by ALSA one I don't care that much. ;-)
> 
>> here's an updated patch that deals with "nested" spinlocks the same 
>> way that driver does, and adds spinlock to start_adc() as well.
> 
> 
>    And the interrupt handlers also didn't grab the spinlock -- that's OK
> in the usual kernel but not when the IRQ handlers are threaded. So, they're
> grabbing the spinlock now (as every correct interrupt handler should do).

      Failed to change the the subject and forgot about the sign-off, silly
me... :-(

WBR, Sergei

Signed-off-by: Konstantin Baidarov <kbaidarov@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

--------------070308000602040202030306
Content-Type: text/plain;
 name="Au1550-AC97-OSS-spinlocks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1550-AC97-OSS-spinlocks.patch"

diff --git a/sound/oss/au1550_ac97.c b/sound/oss/au1550_ac97.c
index cdce915..f70effd 100644
--- a/sound/oss/au1550_ac97.c
+++ b/sound/oss/au1550_ac97.c
@@ -579,17 +579,15 @@ set_recv_slots(int num_channels)
 	} while ((stat & PSC_AC97STAT_DR) == 0);
 }
 
+/* Hold spinlock for both start_dac() and start_adc() calls */
 static void
 start_dac(struct au1550_state *s)
 {
 	struct dmabuf  *db = &s->dma_dac;
-	unsigned long   flags;
 
 	if (!db->stopped)
 		return;
 
-	spin_lock_irqsave(&s->lock, flags);
-
 	set_xmit_slots(db->num_channels);
 	au_writel(PSC_AC97PCR_TC, PSC_AC97PCR);
 	au_sync();
@@ -599,8 +597,6 @@ start_dac(struct au1550_state *s)
 	au1xxx_dbdma_start(db->dmanr);
 
 	db->stopped = 0;
-
-	spin_unlock_irqrestore(&s->lock, flags);
 }
 
 static void
@@ -719,7 +715,6 @@ prog_dmabuf_dac(struct au1550_state *s)
 }
 
 
-/* hold spinlock for the following */
 static void
 dac_dma_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
@@ -727,6 +722,8 @@ dac_dma_interrupt(int irq, void *dev_id,
 	struct dmabuf  *db = &s->dma_dac;
 	u32	ac97c_stat;
 
+	spin_lock(&s->lock);
+
 	ac97c_stat = au_readl(PSC_AC97STAT);
 	if (ac97c_stat & (AC97C_XU | AC97C_XO | AC97C_TE))
 		pr_debug("AC97C status = 0x%08x\n", ac97c_stat);
@@ -748,6 +745,8 @@ dac_dma_interrupt(int irq, void *dev_id,
 	/* wake up anybody listening */
 	if (waitqueue_active(&db->wait))
 		wake_up(&db->wait);
+
+	spin_unlock(&s->lock);
 }
 
 
@@ -759,6 +758,8 @@ adc_dma_interrupt(int irq, void *dev_id,
 	u32	obytes;
 	char	*obuf;
 
+	spin_lock(&s->lock);
+
 	/* Pull the buffer from the dma queue.
 	*/
 	au1xxx_dbdma_get_dest(dp->dmanr, (void *)(&obuf), &obytes);
@@ -766,6 +767,7 @@ adc_dma_interrupt(int irq, void *dev_id,
 	if ((dp->count + obytes) > dp->dmasize) {
 		/* Overrun. Stop ADC and log the error
 		*/
+		spin_unlock(&s->lock);
 		stop_adc(s);
 		dp->error++;
 		err("adc overrun");
@@ -788,6 +790,7 @@ adc_dma_interrupt(int irq, void *dev_id,
 	if (waitqueue_active(&dp->wait))
 		wake_up(&dp->wait);
 
+	spin_unlock(&s->lock);
 }
 
 static loff_t
@@ -1049,9 +1052,9 @@ au1550_read(struct file *file, char *buf
 		/* wait for samples in ADC dma buffer
 		*/
 		do {
+			spin_lock_irqsave(&s->lock, flags);
 			if (db->stopped)
 				start_adc(s);
-			spin_lock_irqsave(&s->lock, flags);
 			avail = db->count;
 			if (avail <= 0)
 				__set_current_state(TASK_INTERRUPTIBLE);
@@ -1571,15 +1574,19 @@ au1550_ioctl(struct inode *inode, struct
 		if (get_user(val, (int *) arg))
 			return -EFAULT;
 		if (file->f_mode & FMODE_READ) {
-			if (val & PCM_ENABLE_INPUT)
+			if (val & PCM_ENABLE_INPUT) {
+				spin_lock_irqsave(&s->lock, flags);
 				start_adc(s);
-			else
+				spin_unlock_irqrestore(&s->lock, flags);
+			} else
 				stop_adc(s);
 		}
 		if (file->f_mode & FMODE_WRITE) {
-			if (val & PCM_ENABLE_OUTPUT)
+			if (val & PCM_ENABLE_OUTPUT) {
+				spin_lock_irqsave(&s->lock, flags);
 				start_dac(s);
-			else
+				spin_unlock_irqrestore(&s->lock, flags);
+			} else
 				stop_dac(s);
 		}
 		return 0;



--------------070308000602040202030306--
