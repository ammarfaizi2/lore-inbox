Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288595AbSAQLwc>; Thu, 17 Jan 2002 06:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288575AbSAQLwX>; Thu, 17 Jan 2002 06:52:23 -0500
Received: from mail.zeelandnet.nl ([212.115.192.194]:57764 "HELO
	mail.zeelandnet.nl") by vger.kernel.org with SMTP
	id <S288565AbSAQLwS>; Thu, 17 Jan 2002 06:52:18 -0500
Message-ID: <3C46BB2E.10901@core-lan.nl>
Date: Thu, 17 Jan 2002 12:53:18 +0100
From: Dennis Fleurbaaij <dennis@core-lan.nl>
Organization: Stichting CORE / The CORE foundation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: nl, en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] pci-irq.c fix
Content-Type: multipart/mixed;
 boundary="------------010408090506070504030308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010408090506070504030308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

A small bug in the patch, hereby the fixed version.

diff -ur linux-werkt/Documentation/Configure.help
linux/Documentation/Configure.help
--- linux-werkt/Documentation/Configure.help    Fri Jan 11 21:44:55 2002
+++ linux/Documentation/Configure.help    Wed Jan 16 11:23:48 2002
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
--- linux-werkt/arch/i386/config.in    Fri Jan 11 21:44:20 2002
+++ linux/arch/i386/config.in    Wed Jan 16 11:22:31 2002
@@ -250,6 +250,9 @@
     define_bool CONFIG_HOTPLUG_PCI n
  fi

+bool 'Enable bigger IRQ mask.' CONFIG_BIGGER_IRQ_MASK
+
+
  bool 'System V IPC' CONFIG_SYSVIPC
  bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
  bool 'Sysctl support' CONFIG_SYSCTL
diff -ur linux-werkt/arch/i386/kernel/pci-irq.c
linux/arch/i386/kernel/pci-irq.c
--- linux-werkt/arch/i386/kernel/pci-irq.c    Sat Jan 12 11:48:03 2002
+++ linux/arch/i386/kernel/pci-irq.c    Wed Jan 16 11:24:56 2002
@@ -19,6 +19,8 @@

  #include "pci-i386.h"

+#define IRQ_SAFE_MASK 0x1e60
+
  #define PIRQ_SIGNATURE    (('$' << 0) + ('P' << 8) + ('I' << 16) + ('R'
<< 24))
  #define PIRQ_VERSION 0x0100

@@ -571,6 +573,16 @@
       */
      newirq = dev->irq;
      if (!newirq && assign) {
+
+                /*
+          * This adds the IRQ's that are marked as safe, this in order 
to prevent wierd
+          * BIOSes to set insane values for irq-masks. It's a
selectable option.
+          */
+             #ifdef CONFIG_BIGGER_IRQ_MASK
+         mask |= IRQ_SAFE_MASK;
+             DBG(" -> mask expanded with %04x to %04x", IRQ_SAFE_MASK,
mask);
+         #endif
+
          for (i = 0; i < 16; i++) {
              if (!(mask & (1 << i)))
                  continue;

-- 
Cheers,

Dennis Fleurbaaij



--------------010408090506070504030308
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
 
+#define IRQ_SAFE_MASK 0x1e60
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
+ 	        DBG(" -> mask expanded with %04x to %04x", IRQ_SAFE_MASK, mask);
+ 		#endif
+
 		for (i = 0; i < 16; i++) {
 			if (!(mask & (1 << i)))
 				continue;

--------------010408090506070504030308--

