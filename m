Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283600AbRK3Jj1>; Fri, 30 Nov 2001 04:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283580AbRK3JjI>; Fri, 30 Nov 2001 04:39:08 -0500
Received: from danielle.hinet.hr ([195.29.148.143]:24208 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S283588AbRK3JjD>; Fri, 30 Nov 2001 04:39:03 -0500
Date: Fri, 30 Nov 2001 10:38:49 +0100
From: Mario Mikocevic <mozgy@hinet.hr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dledford@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: i810_audio ? (possible patch)
Message-ID: <20011130103849.A7126@danielle.hinet.hr>
In-Reply-To: <20011128112843.A28887@danielle.hinet.hr> <E16926Y-0004Rw-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16926Y-0004Rw-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 28, 2001 at 10:38:14AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 28, 2001 at 10:38:14AM +0000, Alan Cox wrote:
> If I had it handy I would

Well, I checked 17pre1 and does _not_ fix my problem.
Included patch does make the difference.
No more oopses and all bitrates work in realproducer.
(it's filtered from RH's -ac kernel i810_audio.c)

(I took the liberty of upping th version to 0.04a :)



--- i810_audio.c-2.4.17-pre1	Thu Nov 29 13:53:26 2001
+++ i810_audio.c	Fri Nov 30 10:30:45 2001
@@ -197,7 +197,7 @@
 #define INT_MASK (INT_SEC|INT_PRI|INT_MC|INT_PO|INT_PI|INT_MO|INT_NI|INT_GPI)
 
 
-#define DRIVER_VERSION "0.04"
+#define DRIVER_VERSION "0.04a"
 
 /* magic numbers to protect our data structures */
 #define I810_CARD_MAGIC		0x5072696E /* "Prin" */
@@ -1231,7 +1231,6 @@
 	unsigned long flags;
 	unsigned int swptr;
 	int cnt;
-        DECLARE_WAITQUEUE(waita, current);
 
 #ifdef DEBUG2
 	printk("i810_audio: i810_read called, count = %d\n", count);
@@ -1257,7 +1256,6 @@
 	dmabuf->trigger &= ~PCM_ENABLE_OUTPUT;
 	ret = 0;
 
-        add_wait_queue(&dmabuf->wait, &waita);
 	while (count > 0) {
 		spin_lock_irqsave(&card->lock, flags);
                 if (PM_SUSPENDED(card)) {
@@ -1322,7 +1320,7 @@
 
 		if (copy_to_user(buffer, dmabuf->rawbuf + swptr, cnt)) {
 			if (!ret) ret = -EFAULT;
-			goto done;
+			return ret;
 		}
 
 		swptr = (swptr + cnt) % dmabuf->dmasize;
@@ -1344,10 +1342,6 @@
 	i810_update_lvi(state,1);
 	if(!(dmabuf->enable & ADC_RUNNING))
 		start_adc(state);
- done:
-        set_current_state(TASK_RUNNING);
-        remove_wait_queue(&dmabuf->wait, &waita);
-
 	return ret;
 }
 
@@ -1362,7 +1356,6 @@
 	unsigned long flags;
 	unsigned int swptr = 0;
 	int cnt, x;
-        DECLARE_WAITQUEUE(waita, current);
 
 #ifdef DEBUG2
 	printk("i810_audio: i810_write called, count = %d\n", count);
@@ -1387,7 +1380,6 @@
 	dmabuf->trigger &= ~PCM_ENABLE_INPUT;
 	ret = 0;
 
-        add_wait_queue(&dmabuf->wait, &waita);
 	while (count > 0) {
 		spin_lock_irqsave(&state->card->lock, flags);
                 if (PM_SUSPENDED(card)) {
@@ -1427,7 +1419,7 @@
 			}
 			if (file->f_flags & O_NONBLOCK) {
 				if (!ret) ret = -EAGAIN;
-				goto ret;
+				return ret;
 			}
 			/* Not strictly correct but works */
 			tmo = (dmabuf->dmasize * HZ) / (dmabuf->rate * 4);
@@ -1451,13 +1443,13 @@
 			}
 			if (signal_pending(current)) {
 				if (!ret) ret = -ERESTARTSYS;
-				goto ret;
+				return ret;
 			}
 			continue;
 		}
 		if (copy_from_user(dmabuf->rawbuf+swptr,buffer,cnt)) {
 			if (!ret) ret = -EFAULT;
-			goto ret;
+			return ret;
 		}
 
 		swptr = (swptr + cnt) % dmabuf->dmasize;
@@ -1483,9 +1475,6 @@
 	i810_update_lvi(state,0);
 	if (!dmabuf->enable && dmabuf->count >= dmabuf->userfragsize)
 		start_dac(state);
- ret:
-        set_current_state(TASK_RUNNING);
-        remove_wait_queue(&dmabuf->wait, &waita);
 
 	return ret;
 }

-- 
Mario Mikoèeviæ (Mozgy)
mozgy at hinet dot hr
My favourite FUBAR ...
