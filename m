Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289124AbSAPLOM>; Wed, 16 Jan 2002 06:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289126AbSAPLOD>; Wed, 16 Jan 2002 06:14:03 -0500
Received: from mail.zeelandnet.nl ([212.115.192.194]:44963 "HELO
	mail.zeelandnet.nl") by vger.kernel.org with SMTP
	id <S289124AbSAPLNq>; Wed, 16 Jan 2002 06:13:46 -0500
Message-ID: <3C4560A5.7010209@core-lan.nl>
Date: Wed, 16 Jan 2002 12:14:45 +0100
From: Dennis Fleurbaaij <dennis@core-lan.nl>
Organization: Stichting CORE / The CORE foundation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: nl, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] pci-irq.c
In-Reply-To: <3C3A1D32.7020000@core-lan.nl> <20020108140252.GE7515@atrey.karlin.mff.cuni.cz>
Content-Type: multipart/mixed;
 boundary="------------060601030500070505040408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060601030500070505040408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Hereby a patch for irq-bug I mailed you while ago. I've made it an
option in the config because it is not allways wanted/good. It basically
expands the IRQ-mask unpon selecting.

-- Dennis Fleurbaaij


Problem description:

I have stumbled upon an error in linux 2.4 that prevents my laptop from
using it's PCMCIA and PS2 mouse together. This is with every known 2.4
kernel and is a result of the BIOS not acknowleging the cardbus controller.
This problem was posted a couple of times to the lkm but has never been
fixed.

A simple solution is offered by suse in the form of a lilo trick. As can be
read in:
http://sdb.suse.de/en/sdb/html/pcmcia_install_kernel2.4.x.html. There is
also another problem description there.

In anycase I've been working to get rid of the bug without having to apply
tricks. The solution as it seems is very simple.

The problem is a follows:

If the kernel detects the controllers (there are 2 of them) it find that
thay both have an IRQ of 255 set by the bios. This is ofcourse rediculous.
It also finds ou that they have a irq map of f000 which is to use only irq
12, 13 and 14. The secont time that the IRQ handler is called is when the
yenta driver (i guess) orders the card to be found. This triggers a loop
that will search for a free IRQ. This loop is located inside
arch/i386/kernel/pci-irq.c line 574.

Now with that mapping, we are nearly guaranteed to cllide with either PS/2
or ide. And that is exactly what happens. This is avoided by allowing the
device to also look at the 'free' irq's 5, 8-11. this is done by adding the
bitmask of those irq's.

Just below the if statement on line 573 and above the loop place the code

mask |= 0x1e60;

that will allow linux to circumvent my braindead BIOS. In my computer it
also has the advantage of spreading the 2 controllers to 2 free IRQ's which
(in theory) should allow for more efficient communications. If the space
gets really cramped they both are put on the same irq, which is hwo it was
originally meant.

I hope that you will make this mainstream or give me pointers where to look
next in order to get rid of this bug.




Martin Mares wrote:

 >Hello!
 >
 >>I'm having a problem on my laptop with wrong IRQ's being assigned. I'm
 >>running the 2.4.17 kernel and I'm quite stuck.
 >>
 >>I have a cardbus interface with the yenta driver. For some insane reason
 >>I cannot get the interfaces (there are 2 as there are
 >>2 cardbus slots) to move away from IRQ 12.
 >>
 >
 >And is there any problem with it using IRQ 12? :-)
 >
Irq 12 is the mouse. And my PCMCIA controller is unfamiliar with the
concept of sharing ;)

 >
 >>I've tried: hardcoding, editing pirq_penalty and about 20 patches
 >>throughout all the code. As that didn't have any effect I'm now
 >>looking for implementing more debugging messages. As I am quite new to
 >>kernel developement I can't figure the DBG() calls out.
 >>
 >>I've tried #define DBG(x...) printk(x) but that did not succeed. I've
 >>also tried #define DBG(x...) printk(KERN_INFO x).
 >>
 >>Can you give me any pointers on how to correcty implement the debugging
 >>messages.
 >>
 >
 >Just look at arch/i386/kernel/pci*.h, there is a debugging switch there.
 >
 > 
			Have a nice fortnight
 >



--------------060601030500070505040408
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -ur linux-werkt/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-werkt/Documentation/Configure.help	Fri Jan 11 21:44:55 2002
+++ linux/Documentation/Configure.help	Wed Jan 16 11:23:48 2002
@@ -3613,6 +3613,25 @@
   "Bridge" is the name used for the hardware inside your computer that
   PCMCIA cards are plugged into. If unsure, say N.
 
+Allow IRQ mask expantion
+CONFIG_BIGGER_IRQ_MASK
+  Say Y here if you see that some devices are using the same IRQ while
+  there are free IRQ's available. This mostly due to bad BIOSes and
+  can be fixed by selecting this option.
+   
+  This will improve selection of IRQ's that are not correctly set 
+  by the BIOS. There is however a very slight chance that your hardware 
+  can't be set to an IRQ that it was not build/programmed for and will
+  therefor refuse service, this is however not very likely.
+   
+  This also fixes crashes from TI Cardbus controllers on laptops amongst
+  other IRQ-related crashes/hangs. 
+
+  It will allow devices to also choose between IRQ 5,8,9,10 and 11 no
+  matter what the BIOS says.
+  
+  If unsure say N.
+
 System V IPC
 CONFIG_SYSVIPC
   Inter Process Communication is a suite of library functions and
diff -ur linux-werkt/arch/i386/config.in linux/arch/i386/config.in
--- linux-werkt/arch/i386/config.in	Fri Jan 11 21:44:20 2002
+++ linux/arch/i386/config.in	Wed Jan 16 11:22:31 2002
@@ -250,6 +250,9 @@
    define_bool CONFIG_HOTPLUG_PCI n
 fi
 
+bool 'Enable bigger IRQ mask.' CONFIG_BIGGER_IRQ_MASK
+
+
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
diff -ur linux-werkt/arch/i386/kernel/pci-irq.c linux/arch/i386/kernel/pci-irq.c
--- linux-werkt/arch/i386/kernel/pci-irq.c	Sat Jan 12 11:48:03 2002
+++ linux/arch/i386/kernel/pci-irq.c	Wed Jan 16 11:24:56 2002
@@ -19,6 +19,8 @@
 
 #include "pci-i386.h"
 
+#define IRQ_SAFE_MASK 0x1e60;
+
 #define PIRQ_SIGNATURE	(('$' << 0) + ('P' << 8) + ('I' << 16) + ('R' << 24))
 #define PIRQ_VERSION 0x0100
 
@@ -571,6 +573,16 @@
 	 */
 	newirq = dev->irq;
 	if (!newirq && assign) {
+
+                /* 
+ 		 * This adds the IRQ's that are marked as safe, this in order to prevent wierd
+ 		 * BIOSes to set insane values for irq-masks. It's a selectable option.
+ 		 */
+ 	        #ifdef CONFIG_BIGGER_IRQ_MASK
+ 		mask |= IRQ_SAFE_MASK;
+ 	        DBG(" -> mask expanded with %04x to %04x", CONFIG_BIGGER_IRQ_MASK, mask);
+ 		#endif
+
 		for (i = 0; i < 16; i++) {
 			if (!(mask & (1 << i)))
 				continue;


--------------060601030500070505040408--

