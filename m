Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbVLES1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbVLES1A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVLES1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:27:00 -0500
Received: from [216.240.47.197] ([216.240.47.197]:31682 "EHLO
	delight.idiom.com") by vger.kernel.org with ESMTP id S932500AbVLES07
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:26:59 -0500
Message-ID: <4394864D.3000704@obviously.com>
Date: Mon, 05 Dec 2005 10:26:21 -0800
From: Bryce Nesbitt <bryce1@obviously.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix ECC error counting for AMD76x chipset, char/ecc.c driver
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:
* Patch is relevant to driver "char/ecc.c", for the AMD76x Athlon chipset.

* Write 1 bits, not 0 bits, to clear the ECC error flag status.
* Without this patch, Linux will detect ONLY the first single and multibit
  error.  All subsequent errors are ignored by the hardware until the
  register is properly cleared.
* The patch also fast-paths the common polled operation, and simplifies
code.
* Includes reference to AMD 761 spec sheet documenting the ECC register
values.

* Note: this module is often not installed by default: do "modprobe ecc"
then "cat /proc/ram" to check your ECC memory for detected soft errors.
* Patch is against Linux-2.6.13, the last kernel I could find with ecc.c
* Tabs suck.

I am an infrequent contributor, and did not find a matching entry in the
./MAINTAINERS file.  Please help me to understand the proper procedure
for submitting this patch.  I understand that perhaps ecc.c is changing
soon.  So maybe it's not the most important patch, but it does fix a
real bug, and is quite simple.


----------------------------------------------------------------------------------------
linux:/usr/src # diff -u -b orig/drivers/char/ecc.c
linux-2.6.13-15/drivers/char/ecc.c  > /tmp/ecc.diff
linux:/usr/src # cat /tmp/ecc.diff
--- orig/drivers/char/ecc.c     2005-09-13 08:52:29.000000000 -0700
+++ linux-2.6.13-15/drivers/char/ecc.c  2005-12-05 09:36:26.000000000 -0800
@@ -10,6 +10,7 @@
  */
 #define DEBUG  0

+
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/module.h>
@@ -22,7 +23,7 @@
 #include <asm/io.h>
 #include <linux/proc_fs.h>

-#define        ECC_VER "0.14 (Oct 10 2001)"
+#define        ECC_VER "0.15 (Dec 1 2005)"
 #define KERN_ECC KERN_ALERT

 static struct timer_list ecctimer;
@@ -1102,15 +1103,20 @@
        }
 }

+
+// Spec source: AMD 761 System Controller/BIOS Guide, 24081D-February 2002
+//
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/24081.pdf
 void check_amd76x(void)
 {
-       unsigned long eccstat = pci_dword(0x48);
+       u32 eccstat;
+       pci_read_config_dword(bridge, 0x48, &eccstat);
+       if(eccstat & 0x30)
+       {
        if(eccstat & 0x10)
        {
                /* bits 7-4 of eccstat indicate the row the MBE occurred. */
                int row = (eccstat >> 4) & 0xf;
                printk("<1>ECC: MBE Detected in DRAM row %d\n", row);
-               scrub_needed |= 2;
                bank[row].mbecount++;
        }
        if(eccstat & 0x20)
@@ -1118,22 +1124,9 @@
                /* bits 3-0 of eccstat indicate the row the SBE occurred. */
                int row = eccstat & 0xf;
                printk("<1>ECC: SBE Detected in DRAM row %d\n", row);
-               scrub_needed |= 1;
                bank[row].sbecount++;
        }
-       if (scrub_needed)
-       {
-               /*
-                * clear error flag bits that were set by writing 0 to them
-                * we hope the error was a fluke or something :)
-                */
-               unsigned long value = eccstat;
-               if (scrub_needed & 1)
-                       value &= 0xFFFFFDFF;
-               if (scrub_needed & 2)
-                       value &= 0xFFFFFEFF;
-               pci_write_config_dword(bridge, 0x48, value);
-               scrub_needed = 0;
+               pci_write_config_dword(bridge, 0x48, eccstat);  // clear
by writing a 1
        }
 }


