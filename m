Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283836AbRLWGqy>; Sun, 23 Dec 2001 01:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283860AbRLWGqp>; Sun, 23 Dec 2001 01:46:45 -0500
Received: from nlaknet.slt.lk ([203.115.0.2]:51085 "EHLO laknet.slt.lk")
	by vger.kernel.org with ESMTP id <S283836AbRLWGq2>;
	Sun, 23 Dec 2001 01:46:28 -0500
Message-ID: <3C26255B.70AE386A@sltnet.lk>
Date: Sun, 23 Dec 2001 12:41:31 -0600
From: Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] a bit smarter dmi-scan.c
Content-Type: multipart/mixed;
 boundary="------------82B97E587CCBF0FA4D20469A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------82B97E587CCBF0FA4D20469A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Greetings.
	First things first:
		MERRY CHRISTMAS !!!

	I couldn't pinpoint a maintainer responsible for this code, so here
goes...

	linux/arch/i386/kernel/dmi-scan.c contains a bit of code that takes APM
specific decisions even when APM isn't in the kernel. For that matter,
even setup.c maintains a apm_info variable of type (struct apm_info)
that's created regardless of whether APM is enabled in the kernel or
not. Is this a deliberate decision or am I missing something? 
	Yes, I know that it doesn't hurt, but it still looks funny when a a
function in dmi-scan.c declares "IBM machine detected. Enabling
interrupts during APM BIOS calls." even when APM is disabled in the
_BIOS_.
	Should we make the APM specific lines in linux/arch/i386/kernel/setup.c
(this code fills up the apm_info struct) conditional? I didn't touch it
because the gains are insignificant. It would be better to do this stuff
if the kernel finds an APM compliant (or non-compliant ;) BIOS.
	I _know_ that dmi-scan.c can be improved further, but I only want to
bring up a point, not start a [un]holy war or feed the trolls (no
offense ;)

Here's the patch for quick reference. It's also attached. (please
observe the proper patch -p{x} option)

--- src/linux/arch/i386/kernel/dmi_scan.c       Sat Dec 22 16:31:11 2001
+++ src/linux/arch/i386/kernel/dmi_scan.c.mod   Sat Dec 22 17:06:22 2001
@@ -255,26 +255,29 @@
 
 static __init int set_realmode_power_off(struct dmi_blacklist *d)
 {
+#if defined (CONFIG_APM)
        if (apm_info.realmode_power_off == 0)
        {
                apm_info.realmode_power_off = 1;
                printk(KERN_INFO "%s bios detected. Using realmode power
off only.\n", d->ident);
        }
+#endif
        return 0;
 }
 
-
 /* 
  * Some laptops require interrupts to be enabled during APM calls 
  */
 
 static __init int set_apm_ints(struct dmi_blacklist *d)
 {
+#if defined (CONFIG_APM)
        if (apm_info.allow_ints == 0)
        {
                apm_info.allow_ints = 1;
                printk(KERN_INFO "%s machine detected. Enabling interrup
ts during APM calls.\n", d->ident);
        }
+#endif
        return 0;
 }
 
@@ -284,15 +287,16 @@
 
 static __init int apm_is_horked(struct dmi_blacklist *d)
 {
+#if defined (CONFIG_APM)
        if (apm_info.disabled == 0)
        {
                apm_info.disabled = 1;
                printk(KERN_INFO "%s machine detected. Disabling APM.\n"
, d->ident);
        }
+#endif
        return 0;
 }
 
-  *  Check for clue free BIOS implementations who use
  *  the following QA technique
@@ -311,10 +315,12 @@
 
 static __init int broken_apm_power(struct dmi_blacklist *d)
 {
+#if defined (CONFIG_APM)
        apm_info.get_power_status_broken = 1;
        printk(KERN_WARNING "BIOS strings suggest APM bugs, disabling po
wer status reporting.\n");
+#endif
        return 0;
-}              
+}
 
 /*
  * Check for a Sony Vaio system
@@ -341,8 +347,10 @@
  
 static __init int swab_apm_power_in_minutes(struct dmi_blacklist *d)
 {
+#if defined (CONFIG_APM)
        apm_info.get_power_status_swabinminutes = 1;
        printk(KERN_WARNING "BIOS strings suggest APM reports battery li
fe in minutes and wrong byte order.\n");
+#endif
        return 0;
 }
 /*

-----------------
Thanks, and again, Merry Christmas and Happy New Year!

	- ioj

~~~~
    Ask not of race, but ask of conduct: 
    From the stick is born the sacred fire:
    The wise ascetic, though lowly born,
    Is noble in his modest self-control.
                - Gotama Buddha
.
--------------82B97E587CCBF0FA4D20469A
Content-Type: text/plain; charset=us-ascii;
 name="dmi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmi.patch"

--- src/linux/arch/i386/kernel/dmi_scan.c	Sat Dec 22 16:31:11 2001
+++ src/linux/arch/i386/kernel/dmi_scan.c.mod	Sat Dec 22 17:06:22 2001
@@ -255,26 +255,29 @@
 
 static __init int set_realmode_power_off(struct dmi_blacklist *d)
 {
+#if defined (CONFIG_APM)
        if (apm_info.realmode_power_off == 0)
        {
                apm_info.realmode_power_off = 1;
                printk(KERN_INFO "%s bios detected. Using realmode poweroff only.\n", d->ident);
        }
+#endif
        return 0;
 }
 
-
 /* 
  * Some laptops require interrupts to be enabled during APM calls 
  */
 
 static __init int set_apm_ints(struct dmi_blacklist *d)
 {
+#if defined (CONFIG_APM)
 	if (apm_info.allow_ints == 0)
 	{
 		apm_info.allow_ints = 1;
 		printk(KERN_INFO "%s machine detected. Enabling interrupts during APM calls.\n", d->ident);
 	}
+#endif
 	return 0;
 }
 
@@ -284,15 +287,16 @@
 
 static __init int apm_is_horked(struct dmi_blacklist *d)
 {
+#if defined (CONFIG_APM)
 	if (apm_info.disabled == 0)
 	{
 		apm_info.disabled = 1;
 		printk(KERN_INFO "%s machine detected. Disabling APM.\n", d->ident);
 	}
+#endif
 	return 0;
 }
 
-
 /*
  *  Check for clue free BIOS implementations who use
  *  the following QA technique
@@ -311,10 +315,12 @@
 
 static __init int broken_apm_power(struct dmi_blacklist *d)
 {
+#if defined (CONFIG_APM)
 	apm_info.get_power_status_broken = 1;
 	printk(KERN_WARNING "BIOS strings suggest APM bugs, disabling power status reporting.\n");
+#endif
 	return 0;
-}		
+}
 
 /*
  * Check for a Sony Vaio system
@@ -341,8 +347,10 @@
  
 static __init int swab_apm_power_in_minutes(struct dmi_blacklist *d)
 {
+#if defined (CONFIG_APM)
 	apm_info.get_power_status_swabinminutes = 1;
 	printk(KERN_WARNING "BIOS strings suggest APM reports battery life in minutes and wrong byte order.\n");
+#endif
 	return 0;
 }
 

--------------82B97E587CCBF0FA4D20469A--

