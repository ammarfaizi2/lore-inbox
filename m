Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276951AbSIVJKr>; Sun, 22 Sep 2002 05:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276882AbSIVJJw>; Sun, 22 Sep 2002 05:09:52 -0400
Received: from smtpout.mac.com ([204.179.120.86]:16381 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S276951AbSIVJIm>;
	Sun, 22 Sep 2002 05:08:42 -0400
Date: Sat, 21 Sep 2002 22:40:08 +0200
Subject: [PATCH] 6/11 sound/oss replace cli() 
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Richard Zidlicky <rz@linux-m68k.org>
To: linux-kernel@vger.kernel.org
From: Peter Waechtler <pwaechtler@mac.com>
Content-Transfer-Encoding: 7bit
Message-Id: <50EF4A49-CDA2-11D6-8873-00039387C942@mac.com>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I left the IRQ handler as is: releasing and requesting an IRQ
handler on every frame.

--- vanilla-2.5.36/sound/oss/dmasound/dmasound_q40.c	Sat Aug 10 
00:03:13 2002
+++ linux-2.5-cli-oss/sound/oss/dmasound/dmasound_q40.c	Sat Sep 21 
18:53:15 2002
@@ -459,28 +459,32 @@
  		  */
  	         return;
  	}
-	save_flags(flags); cli();
+	spin_lock_irqsave(&dmasound.lock, flags);
  	Q40PlayNextFrame(1);
-	restore_flags(flags);
+	spin_unlock_irqrestore_flags(&dmasound.lock, flags);
  }

  static void Q40StereoInterrupt(int irq, void *dummy, struct pt_regs *fp)
  {
+	spin_lock(&dmasound.lock);
          if (q40_sc>1){
              *DAC_LEFT=*q40_pp++;
  	    *DAC_RIGHT=*q40_pp++;
  	    q40_sc -=2;
  	    master_outb(1,SAMPLE_CLEAR_REG);
  	}else Q40Interrupt();
+	spin_unlock(&dmasound.lock);
  }
  static void Q40MonoInterrupt(int irq, void *dummy, struct pt_regs *fp)
  {
+	spin_lock(&dmasound.lock);
          if (q40_sc>0){
              *DAC_LEFT=*q40_pp;
  	    *DAC_RIGHT=*q40_pp++;
  	    q40_sc --;
  	    master_outb(1,SAMPLE_CLEAR_REG);
  	}else Q40Interrupt();
+	spin_unlock(&dmasound.lock);
  }
  static void Q40Interrupt(void)
  {

