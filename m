Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUJOFiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUJOFiO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 01:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUJOFiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 01:38:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:39628 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266271AbUJOFiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 01:38:05 -0400
Message-ID: <416F6166.7010207@osdl.org>
Date: Thu, 14 Oct 2004 22:34:30 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: [PATCH] i386/io_apic init section fixups
Content-Type: multipart/mixed;
 boundary="------------080908080106000105080104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080908080106000105080104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


scripts/reference_init.pl found a couple of errors in i386/io_apic.c.
When changing them, one more function had to be un-init-ed.

I should check x86_64 also ... tomorrow.

-- 
~Randy

--------------080908080106000105080104
Content-Type: text/x-patch;
 name="ioapic_not_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioapic_not_init.patch"


Code section errors in i386/io_apic.c found by scripts/reference_init.pl.
Looks like they could cause problems for a few drivers or in
a real hotplug environment.

Error: ./arch/i386/kernel/io_apic.o .text refers to 000018ff R_386_PC32        .init.text

call chain:
  snd_mpu401_acpi_resource
    acpi_register_gsi
      mp_register_gsi
	io_apic_set_pci_routing
{A}	  ioapic_register_intr
	    IO_APIC_irq_trigger
	      find_irq_entry

Error: ./arch/i386/kernel/io_apic.o .text refers to 00001967 R_386_PC32        .init.text

	(as above thru {A}, then:)
	  IO_APIC_irq_trigger
	    irq_trigger
	      MPBIOS_trigger	>> removing __init from this led to
				   needing to remove __init from
				   EISA_ELCR also.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 arch/i386/kernel/io_apic.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -Naurp ./arch/i386/kernel/io_apic.c~ioapic_not_init ./arch/i386/kernel/io_apic.c
--- ./arch/i386/kernel/io_apic.c~ioapic_not_init	2004-10-11 21:09:52.000000000 -0700
+++ ./arch/i386/kernel/io_apic.c	2004-10-14 22:23:28.882239448 -0700
@@ -728,7 +728,7 @@ __setup("pirq=", ioapic_pirq_setup);
 /*
  * Find the IRQ entry number of a certain pin.
  */
-static int __init find_irq_entry(int apic, int pin, int type)
+static int find_irq_entry(int apic, int pin, int type)
 {
 	int i;
 
@@ -838,7 +838,7 @@ void __init setup_ioapic_dest(void)
 /*
  * EISA Edge/Level control register, ELCR
  */
-static int __init EISA_ELCR(unsigned int irq)
+static int EISA_ELCR(unsigned int irq)
 {
 	if (irq < 16) {
 		unsigned int port = 0x4d0 + (irq >> 3);
@@ -955,7 +955,7 @@ static int __init MPBIOS_polarity(int id
 	return polarity;
 }
 
-static int __init MPBIOS_trigger(int idx)
+static int MPBIOS_trigger(int idx)
 {
 	int bus = mp_irqs[idx].mpc_srcbus;
 	int trigger;

--------------080908080106000105080104--
