Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262582AbRFBOfq>; Sat, 2 Jun 2001 10:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262583AbRFBOfg>; Sat, 2 Jun 2001 10:35:36 -0400
Received: from pop.gmx.net ([194.221.183.20]:31413 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262582AbRFBOfZ>;
	Sat, 2 Jun 2001 10:35:25 -0400
Date: Sat, 2 Jun 2001 16:35:18 +0200
From: Jonas Diemer <diemer@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: VIA timer bugfix, patch for 2.4.5
Message-Id: <20010602163518.090988d8.diemer@gmx.de>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have compiled a little patch that contains the VIA timer bugfix (from the ac kernel). the patch is against linus' 2.4.5 kernel. I have compiled and ran the patched kernel sucessfully.

the only changes made by this patch are done to linux/arch/i386/kernel/timer.c

I would like to have this patch applied to linus' kernel tree (so that it comes in 2.4.6), because alan's kernel has USB problems on my machine.


Here's the patch:

--- arch/i386/kernel/time.c.orig	Sat Jun  2 16:06:59 2001
+++ arch/i386/kernel/time.c	Sat Jun  2 16:07:20 2001
@@ -178,6 +178,15 @@
  	jiffies_t = jiffies;
 
 	count |= inb_p(0x40) << 8;
+	
+        /* VIA686a test code... reset the latch if count > max + 1 */
+        if (count > LATCH) {
+                outb_p(0x34, 0x43);
+                outb_p(LATCH & 0xff, 0x40);
+                outb(LATCH >> 8, 0x40);
+                count = LATCH - 1;
+        }
+	
 	spin_unlock(&i8253_lock);
 
 	/*
@@ -413,7 +422,7 @@
 	if (!user_mode(regs))
 		x86_do_profile(regs->eip);
 #else
-	if (!smp_found_config)
+	if (!using_apic_timer)
 		smp_local_timer_interrupt(regs);
 #endif
 
@@ -492,6 +501,24 @@
 
 		count = inb_p(0x40);    /* read the latched count */
 		count |= inb(0x40) << 8;
+		
+
+                /* VIA686a test code... reset the latch if count > max */
+                if (count > LATCH-1) {
+                        static int last_whine;
+                        outb_p(0x34, 0x43);   
+                        outb_p(LATCH & 0xff, 0x40);
+                        outb(LATCH >> 8, 0x40);
+                        count = LATCH - 1;
+                        if(time_after(jiffies, last_whine))
+                        {
+                                printk(KERN_WARNING "probable hardware bug: clock timer configuration lost - probably a VIA686a motherboard.\n");
+                                printk(KERN_WARNING "probable hardware bug: restoring chip configuration.\n");
+                                last_whine = jiffies + HZ;
+                        }                       
+                }                               
+
+		
 		spin_unlock(&i8253_lock);
 
 		count = ((LATCH-1) - count) * TICK_SIZE;

--end of patch---

This is my first patch, i hope it is ok. i followed the instructions in Documentation/SubmittingPatches to create it.

- Jonas

PS: please CC me any reply, i haven't registered to the mailinglist.
