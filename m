Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280510AbRKGLus>; Wed, 7 Nov 2001 06:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280524AbRKGLuj>; Wed, 7 Nov 2001 06:50:39 -0500
Received: from mail.gmx.de ([213.165.64.20]:884 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S280510AbRKGLuU>;
	Wed, 7 Nov 2001 06:50:20 -0500
Date: Wed, 7 Nov 2001 12:50:12 +0100
From: Jonas Diemer <diemer@gmx.de>
To: Linux Kermel ML <linux-kernel@vger.kernel.org>
Subject: VIA 686 timer bugfix incomplete
Message-Id: <20011107125012.6b1fbdc3.diemer@gmx.de>
X-Mailer: Sylpheed version 0.6.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

I noticed with great happiness that the via timer bugfix had made it into linus'
version of the kernel as of 2.4.10.

but it seems that the patch was incomplete: The bug is still triggered on my
computer using 2.4.14, but the bugfix seems to work whith -ac kernels.
 

now I diffed the ac-version of that file whith the current version of linus'
kernel:

# diff -u arch/i386/kernel/time.c ../linux-2.4.10-ac12/arch/i386/kernel/time.c 


--- arch/i386/kernel/time.c     Wed Oct 24 17:16:13 2001
+++ ../linux-2.4.10-ac12/arch/i386/kernel/time.c        Sun Oct 14 16:23:52 2001
@@ -501,6 +501,24 @@
 
                count = inb_p(0x40);    /* read the latched count */
                count |= inb(0x40) << 8;
+
+
+                /* VIA686a test code... reset the latch if count > max */
+                if (count > LATCH) {
+                        static int last_whine;
+                        outb_p(0x34, 0x43);   
+                        outb_p(LATCH & 0xff, 0x40);
+                        outb(LATCH >> 8, 0x40);
+                        count = LATCH - 1;
+                        if(time_after(jiffies, last_whine))
+                        {
+                                printk(KERN_WARNING "probable hardware bug:
clock timer configuration lost - probably a VIA686a motherboard.\n");
+                                printk(KERN_WARNING "probable hardware bug:
restoring chip configuration.\n");
+                                last_whine = jiffies + HZ;
+                        }                       
+                }                               
+
+
                spin_unlock(&i8253_lock);
 
                count = ((LATCH-1) - count) * TICK_SIZE;


you can see what's missing to actually work around the via timer bug. I hope
this will go into 2.4.15.

regards

PS: CC me in your answers, I am not subscribed to the list
