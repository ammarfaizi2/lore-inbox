Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSDHGEt>; Mon, 8 Apr 2002 02:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313560AbSDHGEs>; Mon, 8 Apr 2002 02:04:48 -0400
Received: from mout1.freenet.de ([194.97.50.132]:29355 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S313060AbSDHGEq>;
	Mon, 8 Apr 2002 02:04:46 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Annoying timer problems with via boards
Date: Mon, 08 Apr 2002 08:06:15 +0200
Organization: privat
Message-ID: <a8rc0n$pg$1@ID-44327.news.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: susi.maya.org 1018245975 816 192.168.1.3 (8 Apr 2002 06:06:15 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.6.1
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Unfortunately the timer problem isn't fixed and I know other persons having 
this problem, too.

We found another patch for kernel 2.4.15 at 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0111.1/0951.html

Unfortunately this patch doesn't fit to kernel 2.4.18. Could somebody 
please adopt it to the actual kernel for testing? Or could somebody please 
find a better solution?

Sometime ago, I tested this patch, which didn't help:

--- linux-2.4.15-pre3/arch/i386/kernel/time.c   Sun Nov 11 21:33:31 2001
+++ linux-2.4.15-pre3-new/arch/i386/kernel/time.c       Mon Nov 12 14:04:20 2001
@@ -501,6 +501,19 @@
 
                count = inb_p(0x40);    /* read the latched count */
                count |= inb(0x40) << 8;
+
+               /*
+                * When using some via chipsets (as the vt82c686a, for example)
+                * the system timer counter (i8253) should be reprogrammed in
+                * this case, otherwise it may be reset to a wrong value.
+                */
+               if (count > LATCH-1) {
+                       outb_p(0x34, 0x43);
+                       outb_p(LATCH & 0xff, 0x40);
+                       outb(LATCH >> 8, 0x40);
+                       count = LATCH - 1;
+               }
+
                spin_unlock(&i8253_lock);
 
                count = ((LATCH-1) - count) * TICK_SIZE;

------------------------------------------------------------------------------------


http://www.uwsg.iu.edu/hypermail/linux/kernel/0111.1/0951.html is:

diff -urN linux-2.4.15-pre4/arch/i386/kernel/time.c 
linux/arch/i386/kernel/time.c
--- linux-2.4.15-pre4/arch/i386/kernel/time.c   Mon Nov 12 22:31:52 2001
+++ linux/arch/i386/kernel/time.c       Mon Nov 12 22:52:25 2001
@@ -112,6 +112,50 @@
        return delay_at_last_interrupt + edx;
 }

+/*
+ * VIA hardware bug workaround with check if it is really needed and
+ * a printk that could tell us what's exactly happening on machines which
+ * trigger the check, but are not VIA-based.
+ *
+ * Must be called with the i8253_spinlock held.
+ */
+
+static void via_reset_and_whine(int *count)
+{
+       static unsigned long last_whine = 0;
+       unsigned long new_whine;
+       int count2;
+
+       new_whine = last_whine;
+
+       outb_p(0x00, 0x43);             /* Re-read the timer */
+       count2 = inb_p(0x40);
+       count2 |= inb(0x40) << 8;
+
+       if (time_after(jiffies, last_whine)) {
+               printk(KERN_WARNING "timer.c: VIA bug check triggered. "
+                       "Value read %d [%#x], re-read %d [%#x]\n",
+                       *count, *count, count2, count2);
+               new_whine = jiffies + HZ;
+       }
+
+       *count = count2;
+
+       if (count2 > LATCH) {           /* Still bad */
+               if (time_after(jiffies, last_whine)) {
+                       printk(KERN_WARNING "timer.c VIA bug really 
present. "
+                               "Resetting PIT timer.\n");
+                       new_whine = jiffies + HZ;
+               }
+               outb_p(0x34, 0x43);
+               outb_p(LATCH & 0xff, 0x40);
+               outb(LATCH >> 8, 0x40);
+               *count = LATCH - 1;
+       }
+
+       last_whine = new_whine;
+}
+
 #define TICK_SIZE tick

 spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
@@ -180,12 +224,8 @@
        count |= inb_p(0x40) << 8;

         /* VIA686a test code... reset the latch if count > max + 1 */
-        if (count > LATCH) {
-                outb_p(0x34, 0x43);
-                outb_p(LATCH & 0xff, 0x40);
-                outb(LATCH >> 8, 0x40);
-                count = LATCH - 1;
-        }
+        if (count > LATCH)
+               via_reset_and_whine(&count);

        spin_unlock(&i8253_lock);

@@ -501,6 +541,10 @@

                count = inb_p(0x40);    /* read the latched count */
                count |= inb(0x40) << 8;
+
+               if (count > LATCH)
+                       via_reset_and_whine(&count);
+
                spin_unlock(&i8253_lock);

                count = ((LATCH-1) - count) * TICK_SIZE;
-----------------------------------------------------------------------------

I hope, that this patch could help and I'd like to test it with kernel 
2.4.18.

The problem is very annoying and should really be solved. I have to reboot 
all few hours because of crazy programms according to suddenly changing 
time.


lspci says about my hardware:
00:00.0 Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 02)
        Flags: bus master, medium devsel, latency 0
        Memory at d6000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [PCI-PCI Bridge] (prog-if 
        00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: d4000000-d5ffffff
        Prefetchable memory behind bridge: d0000000-d3ffffff
        Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 
10) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev 30)
        Flags: medium devsel, IRQ 9
        Capabilities: [68] Power Management version 2

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 
[Apollo Super AC97/Audio] (rev 20)
        Subsystem: VIA Technologies, Inc.: Unknown device 4511
        Flags: medium devsel, IRQ 7
        I/O ports at dc00 [size=256]
        I/O ports at e000 [size=4]
        I/O ports at e400 [size=4]
        Capabilities: [c0] Power Management version 2

[...]


Regards,
Andreas Hartmann
