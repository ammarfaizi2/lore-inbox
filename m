Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbTHUKYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 06:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbTHUKYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 06:24:48 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:63695 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262576AbTHUKXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 06:23:18 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Wes Janzen <superchkn@sbcglobal.net>, Adam Belay <ambx1@neo.rr.com>
Subject: Re: 2.6.0-test3-mm3 reserve IRQ for isapnp (2.6.0-test3-mm3 <sigh>)
Date: Thu, 21 Aug 2003 12:23:03 +0200
User-Agent: KMail/1.5.9
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <3F440387.5090902@sbcglobal.net> <20030820223344.GA10163@neo.rr.com> <3F44977A.6050705@sbcglobal.net>
In-Reply-To: <3F44977A.6050705@sbcglobal.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_J2JR/E1M3IAGfRl"
Message-Id: <200308211223.05614.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_J2JR/E1M3IAGfRl
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I had similar problems with the ACPI IRQ routing, too.

For me everything worked fine if I used acpi=off. I didn't see your results 
trying this... If this works you may be interested in the attached patch 
which also makes pci=noacpi work for me!

I'd be interested in your results with the patch...

Best regards
  Thomas Schlichter

On Thursday 21 August 2003 11:57, Wes Janzen wrote:
> Hi again!
>
> OK, finally managed to boot, though I had to disable USB and ISAPNP to
> do that.  I couldn't get it to work until I disabled ISA PNP in the
> build menu.
>
> Even without ISAPNP I had trouble.  I tried nousb on its own, which did
> not work.  I had to use both pci=noacpi, nolapic, noapic and nousb.  Now
> I don't know if I HAD to use the apic ones, but it probably doesn't
> matter since my box isn't capable anyway.  I just wanted it to boot
> because it takes a while for those Promise cards to detect the drives.
>
> Finally it would boot, but then I lose a lot without usb.  Oddly, IRQ 5
> is freed with both nousb AND pci=noacpi.  That was not the case with
> just pci=noacpi or just nousb.  But then maybe that isn't so odd since
> the USB card sucks up 3 irqs.  With just pci=noacpi I made it several
> lines farther.  Instead of "mice: PS/2 mouse device...", I got to see
> "hub 1-0:0: new USB device on port2, assigned address 2", which was
> proceeded by some ACPI message that also said something (IIRC) about
> states S4 and S5.  Usually it only says something about C1 and C2.
>
> Anyway, for what it's worth, here's cat /proc/interrupts:
>            CPU0
>   0:     199807          XT-PIC  timer
>   1:        822          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   7:          1          XT-PIC  parport0
>   8:          2          XT-PIC  rtc
>   9:          7          XT-PIC  acpi, eth0
>  11:       7631          XT-PIC  ide2, ide3
>  12:         70          XT-PIC  ide4, ide5
>  14:          1          XT-PIC  ide0
> NMI:          0
> LOC:          0
> ERR:          0
> MIS:          0
>
> I've attached lspic -vv and boot.msg this time rather than include them in.
>
> Sure would be nice to get mm3 working with those reiserfs fixes...I
> guess I'll just hand patch for now.  Sure beats the rebuild-tree I have
> to do every 5 days or so ;-)
>
> Thanks,
>
> Wes

--Boundary-00=_J2JR/E1M3IAGfRl
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="fix_noacpi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="fix_noacpi.diff"

--- linux-2.6.0-test3-mm3/arch/i386/kernel/acpi/boot.c.orig	Wed Aug 20 03:42:13 2003
+++ linux-2.6.0-test3-mm3/arch/i386/kernel/acpi/boot.c	Wed Aug 20 04:03:56 2003
@@ -39,6 +39,7 @@
 #define PREFIX			"ACPI: "
 
 extern int acpi_disabled;
+extern int acpi_irq;
 extern int acpi_ht;
 
 /* --------------------------------------------------------------------------
@@ -416,7 +417,7 @@
 	 * If MPS is present, it will handle them,
 	 * otherwise the system will stay in PIC mode
 	 */
-	if (acpi_disabled) {
+	if (acpi_disabled || !acpi_irq) {
 		return 1;
         }
 
@@ -451,15 +452,13 @@
 
 	acpi_ioapic = 1;
 
+#ifdef CONFIG_X86_LOCAL_APIC
+	smp_found_config = 1;
+	clustered_apic_check();
+#endif
+
 #endif /*CONFIG_ACPI*/
 #endif /*CONFIG_X86_IO_APIC*/
-
-#ifdef CONFIG_X86_LOCAL_APIC
-	if (acpi_lapic && acpi_ioapic) {
-		smp_found_config = 1;
-		clustered_apic_check();
-	}
-#endif
 
 	return 0;
 }
--- linux-2.6.0-test3-mm3/arch/i386/kernel/setup.c.orig	Wed Aug 20 03:41:56 2003
+++ linux-2.6.0-test3-mm3/arch/i386/kernel/setup.c	Wed Aug 20 04:03:03 2003
@@ -70,6 +70,7 @@
 EXPORT_SYMBOL(acpi_disabled);
 
 #ifdef	CONFIG_ACPI_BOOT
+	int acpi_irq __initdata = 1;	/* enable IRQ */
 	int acpi_ht __initdata = 1;	/* enable HT */
 #endif
 
@@ -541,6 +542,11 @@
 		else if (!memcmp(from, "acpi=ht", 7)) {
 			acpi_ht = 1;
 			if (!acpi_force) acpi_disabled = 1;
+		}
+
+		/* "pci=noacpi" disables ACPI interrupt routing */
+		else if (!memcmp(from, "pci=noacpi", 10)) {
+			acpi_irq = 0;
 		}
 #endif
 

--Boundary-00=_J2JR/E1M3IAGfRl--
