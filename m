Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272899AbRIMHRz>; Thu, 13 Sep 2001 03:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272901AbRIMHRp>; Thu, 13 Sep 2001 03:17:45 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:49419 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S272899AbRIMHRe>; Thu, 13 Sep 2001 03:17:34 -0400
Date: Thu, 13 Sep 2001 09:17:48 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: chris@boojiboy.eorbit.net
Cc: linux-kernel@vger.kernel.org, bmacy@macykids.net
Subject: Re: 2.4.9-ac9 APM w/Compaq 16xx laptop...
Message-ID: <20010913091748.A21626@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010913011606.H20118@arthur.ubicom.tudelft.nl> <200109130124.SAA22845@boojiboy.eorbit.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109130124.SAA22845@boojiboy.eorbit.net>; from chris@boojiboy.eorbit.net on Wed, Sep 12, 2001 at 06:24:18PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2001 at 06:24:18PM -0700, chris@boojiboy.eorbit.net wrote:
> > > When my bios is set ACPI=NO, and APM is compiled in:
> > > A 'shutdown -r' hangs after the "Restarting System" message.  
> > > Depressing the power switch cause a power off.
> > 
> > Try "Use real mode APM BIOS call to power off".
> 
> With 2.4.9-ac9 'shutdown -r' does not work.  The
> halt '-h' flag does work.  '-r' hangs at "Restarting System."

OK, so at least the system switches off.

> I set my machine bios to acpi=no, and also acpi=yes the same 
> hang occurred both times.
> 
> Here is the APM config:
> 
> CONFIG_PM=y
> # CONFIG_ACPI is not set
> CONFIG_APM=y
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> # CONFIG_APM_DO_ENABLE is not set
> # CONFIG_APM_CPU_IDLE is not set
    ^^^^^^^^^^^^^^^^^^^
Any reason why this is not enabled? There's no much use for APM without
it.

> # CONFIG_APM_DISPLAY_BLANK is not set
> # CONFIG_APM_RTC_IS_GMT is not set
> # CONFIG_APM_ALLOW_INTS is not set
> CONFIG_APM_REAL_MODE_POWER_OFF=y
> 
> 
> Here is the pertinent dmesg stuff:
> 
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
>  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000ecc00 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000c000000 (usable)
>  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
> No local APIC present or hardware disabled
> Kernel command line: auto BOOT_IMAGE=linux ro root=302
> Initializing RT netlink socket
> Compaq 12XL125 machine detected. Enabling interrupts during APM calls.

Hmm, that's a clue, it's not a 12XL125. Could you try this patch to see
if it works?

--- arch/i386/kernel/dmi_scan.c.orig	Thu Sep 13 08:59:19 2001
+++ arch/i386/kernel/dmi_scan.c	Thu Sep 13 09:14:02 2001
@@ -17,8 +17,8 @@
 	u16	handle;
 };
 
-#define dmi_printk(x)
-//#define dmi_printk(x) printk x
+//#define dmi_printk(x)
+#define dmi_printk(x) printk x
 
 static char * __init dmi_string(struct dmi_header *dm, u8 s)
 {
@@ -437,12 +437,14 @@
 			MATCH(DMI_PRODUCT_NAME, "Inspiron 4000"),
 			NO_MATCH, NO_MATCH
 			} },
+#if 0
 	{ set_apm_ints, "Compaq 12XL125", {	/* Allow interrupts during suspend on Compaq Laptops*/
 			MATCH(DMI_SYS_VENDOR, "Compaq"),
 			MATCH(DMI_PRODUCT_NAME, "Compaq PC"),
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION,"4.06")
 			} },
+#endif
 	{ set_apm_ints, "ASUSTeK", {   /* Allow interrupts during APM or the clock goes slow */
 			MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
 			MATCH(DMI_PRODUCT_NAME, "L8400K series Notebook PC"),

Could you also tell what the kernel thinks about your laptop? It should
print things like "BIOS Vendor: Phoenix Technologies LTD".


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
