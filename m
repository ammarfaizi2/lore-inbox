Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTHYIc6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 04:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbTHYIc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 04:32:58 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:37041 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261568AbTHYIcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 04:32:53 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6.0-test4] Fix 'pci=noacpi' with buggy ACPI BIOSes
Date: Mon, 25 Aug 2003 10:32:19 +0200
User-Agent: KMail/1.5.9
Cc: LKML <linux-kernel@vger.kernel.org>, Joonas Koivunen <rzei@mbnet.fi>,
       Peter Lieverdink <cafuego@cc.com.au>,
       Andy Grover <andrew.grover@intel.com>
References: <3F492601.7090405@comcast.net> <5.1.0.14.2.20030825110731.00bd1248@caffeine.cc.com.au>
In-Reply-To: <5.1.0.14.2.20030825110731.00bd1248@caffeine.cc.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UmcS/at7Y2+eXeh"
Message-Id: <200308251032.20324.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_UmcS/at7Y2+eXeh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andrew,

the attached patch fixes interrupt routing probems for (at least 3) people 
with broken ACPI BIOSes. If only the ACPI interrupt routing part is broken, 
'pci=noacpi' should help as the documantation states:

pci=option[,option...]
	[...]
	noacpi	[IA-32] Do not use ACPI for IRQ routing.

The problem was that ACPI interrupt routing was not correctly disabled.
The patch applies cleanly to 2.6.0-test4...

   Thomas

On Monday 25 August 2003 03:13, Peter Lieverdink wrote:
> Hi Thomas,
>
> Your patch works beautifully. 'acpi=nopci' previously caused IDE to work
> fine, but made the kernel not detect USB and network devices. With your
> patch it sees all peripherals AND acpi is available for the cpu. I wonder
> if it would be accepted into the kernel as a patch to workaround buggy acpi
> bioses.
>
> Thanks heaps!
>
> - Peter.
> --
>
> At 23:44 24/08/2003 +0200, you wrote:
> >Am Sunday 24 August 2003 22:54 schrieb David van Hoose:
> > > Kevin P. Fleming wrote:
> > > > Peter Lieverdink wrote:
> > > >> When I enable ACPI on 2.6.0-test4 (also on 2.6.0-test3-*), the
> > > >> kernel no longer recognises my IDE controller and drops down to PIO
> > > >> mode for harddisk access. Additionally, USB devices don't get
> > > >> detected.
> > > >
> > > > I'm running -test4 here with ACPI and have no trouble with USB
> > > > devices.
> > >
> > > I'm running test4 here with ACPI and have no USB following a call trace
> > > with "IRQ 20: nobody cared". ACPI seems to make odd reports. I've been
> > > having this problem since 2.5.70'ish. Posted numerous times, but nobody
> > > seems to care about it. I also have a PS/2 mouse detection when I have
> > > no mice attached to my system.
> > >
> > > >> The system is an Athlon 2400+ on a Gibabyte GA-7VAXP mainboard.
> > > >> (KT400)
> > > >
> > > > My system is an Athlon 1000 on an MSI KT266-based board.
> > >
> > > I have a Pentium 4 2.53 GHz on a Asus P4S8X mainboard.
> > >
> > > -David
> > >
> > > PS. dmesg is attached with ACPI debug and USB debug enabled.
> >
> >I had similar problems with my Epox 8K9A (KT400) Board.
> >
> >If I wanted to use my USB ports I had to boot wiht 'acpi=off'. But with
> > the patch attached it is possible for me to boot with 'pci=noacpi'. It
> > has the advantage that ACPI stays enabled...
> >
> >You are free to give it a try...
> >
> >   Thomas

On Sunday 10 August 2003 01:24, Joonas Koivunen:
> On Saturday 09 August 2003 19:02, Thomas Schlichter wrote:
> > It's not a problem with ACPI, it's more a problem with the interrupt
> > routing based on the ACPI tables. These tables seem to be not correctly
> > implemented in the BIOS and, as the german EPOX support admits, are not
> > really tested. To change this you may contact the EPOX support and
> > describe your problems, too....
>
> Thanks for letting me know.. I had a image of EPOX being pretty good with
> motherboards.. Guess not then.
>
> > If you want to use ACPI while this BIOS bug is not fixed you may use the
> > attached patch and boot with pci=noacpi. Without the patch this doesn't
> > work for me here...
>
> Why isn't this patch in the mainstream kernel? There are many other
> chipset/bios fixes in the kernel.. This would save many
> reboot/recompilings/worries until or if ever epox does something with the
> bios.
>
> The patch works nicely. Though I did apply it manually to -test3 :) But it
> works.
>
> > Best regards
> >   Thomas Schlichter
>
> Thanks again
> -rzei

--Boundary-00=_UmcS/at7Y2+eXeh
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix_noacpi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="fix_noacpi.diff"

--- linux-2.6.0-test4/arch/i386/kernel/acpi/boot.c.orig	Sat Aug 23 01:59:02 2003
+++ linux-2.6.0-test4/arch/i386/kernel/acpi/boot.c	Sat Aug 23 16:39:57 2003
@@ -41,6 +41,7 @@
 #define PREFIX			"ACPI: "
 
 extern int acpi_disabled;
+extern int acpi_irq;
 extern int acpi_ht;
 
 int acpi_lapic = 0;
@@ -407,7 +408,7 @@
 	 * If MPS is present, it will handle them,
 	 * otherwise the system will stay in PIC mode
 	 */
-	if (acpi_disabled) {
+	if (acpi_disabled || !acpi_irq) {
 		return 1;
         }
 
--- linux-2.6.0-test4/arch/i386/kernel/setup.c.orig	Sat Aug 23 01:55:38 2003
+++ linux-2.6.0-test4/arch/i386/kernel/setup.c	Sat Aug 23 16:34:21 2003
@@ -71,6 +71,7 @@
 EXPORT_SYMBOL(acpi_disabled);
 
 #ifdef	CONFIG_ACPI_BOOT
+	int acpi_irq __initdata = 1;	/* enable IRQ */
 	int acpi_ht __initdata = 1;	/* enable HT */
 #endif
 
@@ -542,6 +543,11 @@
 		else if (!memcmp(from, "acpi=ht", 7)) {
 			acpi_ht = 1;
 			if (!acpi_force) acpi_disabled = 1;
+		}
+
+		/* "pci=noacpi" disables ACPI interrupt routing */
+		else if (!memcmp(from, "pci=noacpi", 10)) {
+			acpi_irq = 0;
 		}
 
 #ifdef CONFIG_X86_LOCAL_APIC

--Boundary-00=_UmcS/at7Y2+eXeh--
