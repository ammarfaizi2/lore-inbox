Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270201AbTGMKS1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 06:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270204AbTGMKS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 06:18:27 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:43431 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S270201AbTGMKSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 06:18:25 -0400
Message-ID: <3F11354B.1080501@portrix.net>
Date: Sun, 13 Jul 2003 12:32:43 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Three drivers/i2c/ patches
References: <3F107F0F.40701@portrix.net> <20030713102407.A24901@infradead.org>
In-Reply-To: <20030713102407.A24901@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> Sleeping with interrupts disabled and a spinlock held still isn't exactly a
> good idea.  As is sleep_on..

So something like the following does make more sense?
I don't quite understand, how that code worked before - I suppose
interruptible_sleep_on_timeout activates irqs again, otherwise the interrupt 
handler would have never been called? But then, the sti() doesn't make much 
sense and should have been moved to the else path?

Thanks,

Jan

--- 2.5.75/drivers/i2c/i2c-elektor.c    2003-07-11 09:35:37.000000000 +0200
+++ 2.5.75-bk1/drivers/i2c/i2c-elektor.c        2003-07-13 12:06:06.000000000
+0200
@@ -59,6 +59,8 @@
    need to be rewriten - but for now just remove this for simpler reading */

  static wait_queue_head_t pcf_wait;
+
+spinlock_t pcf_pending_lock = SPIN_LOCK_UNLOCKED;
  static int pcf_pending;

  /* ----- global defines ----------------------------------------------- 
    */
@@ -120,12 +122,14 @@
         int timeout = 2;

         if (irq > 0) {
-               cli();
+               spin_lock_irq(&pcf_pending_lock);
                 if (pcf_pending == 0) {
+                       spin_unlock_irq(&pcf_pending_lock);
                         interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );
-               } else
+               } else {
                         pcf_pending = 0;
-               sti();
+                       spin_unlock_irq(&pcf_pending_lock);
+               }
         } else {
                 udelay(100);
         }
@@ -133,7 +137,10 @@


  static irqreturn_t pcf_isa_handler(int this_irq, void *dev_id, struct pt_regs
*regs) {
+       unsigned long flags;
+       spin_lock_irqsave(&pcf_pending_lock, flags);
         pcf_pending = 1;
+       spin_unlock_irqrestore(&pcf_pending_lock, flags);
         wake_up_interruptible(&pcf_wait);
         return IRQ_HANDLED;
  }


-- 
Linux rubicon 2.5.75-mm1-jd10 #1 SMP Sat Jul 12 19:40:28 CEST 2003 i686

