Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTHUIn4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 04:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTHUIn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 04:43:56 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:12684 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262522AbTHUInx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 04:43:53 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH][2.5] fix 'pci=noacpi'  was: Re: [patch] remove mount_root_failed_msg()
Date: Thu, 21 Aug 2003 10:43:41 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, andrew.grover@intel.com, len.brown@intel.com
References: <20030820232045.GA25921@gtf.org> <20030820234114.GA5518@kroah.com>
In-Reply-To: <20030820234114.GA5518@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/YIR/dbOJc7YJa7"
Message-Id: <200308211043.43566.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_/YIR/dbOJc7YJa7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 21 August 2003 01:41, Greg KH wrote:
> On Wed, Aug 20, 2003 at 07:20:45PM -0400, Jeff Garzik wrote:
> > * overall, I disagree with adding messages like this.  The number one
> >   bug report, by far, for networking drivers is ACPI-related (no
> >   interrupts delivered).  You don't see me adding "boot with acpi=off"
> >   messages to the net subsystem.
>
> It's the number one bug report for USB drivers too :(
>
> It has gotten smaller, and I would hope that is due to advances in the
> ACPI code, but they still do crop up quite frequently.

Well, I've got a board with these problems, too... (Epox 8K9A)
It seems the ACPI IRQ override tables are buggy, so it cannot work... :-(
But with 'pci=noacpi' it should work as the Documentation states:

       noacpi                  [IA-32] Do not use ACPI for IRQ routing.

Unfortunately the ACPI IO-APIC setup is not overridden and without the 
attached patch, which corrects this issue, I had to use 'acpi=off'...

I think this will help people easily working around their APCI interrupt 
routing problems, as I think most of these are due to buggy ACPI IRQ override 
tables. Windows seems not to use them and so they are often badly 
tested... :-(

Best regards
   Thomas Schlichter

BTW: Hunk 3 of this patch is only a simplification, because(acpi_lapic && 
acpi_ioapic) is always true here when that code is reached...

--Boundary-00=_/YIR/dbOJc7YJa7
Content-Type: text/x-diff;
  charset="iso-8859-1";
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
 

--Boundary-00=_/YIR/dbOJc7YJa7--
