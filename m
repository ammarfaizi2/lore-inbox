Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268299AbUJOSe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268299AbUJOSe6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 14:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268295AbUJOScn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 14:32:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:31443 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S268294AbUJOSbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 14:31:45 -0400
Message-ID: <4170158B.6020802@osdl.org>
Date: Fri, 15 Oct 2004 11:23:07 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ak@suse.de
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: [PATCH] x86_64/io_apic init section fixups
References: <416F6166.7010207@osdl.org>
In-Reply-To: <416F6166.7010207@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------030404020604060707060005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030404020604060707060005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Randy.Dunlap wrote:
> 
> scripts/reference_init.pl found a couple of errors in i386/io_apic.c.
> When changing them, one more function had to be un-init-ed.
> 
> I should check x86_64 also ... tomorrow.

Here's the x86_64 version of this patch.

There was one function in i386 where __init was already removed,
and 'make buildcheck' flagged it on x86_64, so I changed it also.

-- 
~Randy


--------------030404020604060707060005
Content-Type: text/x-patch;
 name="ioapic_init_x64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioapic_init_x64.patch"


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
 arch/x86_64/kernel/io_apic.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -Naurp ./arch/x86_64/kernel/io_apic.c~ioapic_init_x64 ./arch/x86_64/kernel/io_apic.c
--- ./arch/x86_64/kernel/io_apic.c~ioapic_init_x64	2004-10-11 21:17:55.000000000 -0700
+++ ./arch/x86_64/kernel/io_apic.c	2004-10-15 10:56:29.000000000 -0700
@@ -83,7 +83,7 @@ int vector_irq[NR_VECTORS] = { [0 ... NR
  * shared ISA-space IRQs, so we have to support them. We are super
  * fast in the common case, and fast for shared ISA-space IRQs.
  */
-static void __init add_pin_to_irq(unsigned int irq, int apic, int pin)
+static void add_pin_to_irq(unsigned int irq, int apic, int pin)
 {
 	static int first_free_entry = NR_IRQS;
 	struct irq_pin_list *entry = irq_2_pin + irq;
@@ -315,7 +315,7 @@ __setup("pirq=", ioapic_pirq_setup);
 /*
  * Find the IRQ entry number of a certain pin.
  */
-static int __init find_irq_entry(int apic, int pin, int type)
+static int find_irq_entry(int apic, int pin, int type)
 {
 	int i;
 
@@ -399,7 +399,7 @@ int IO_APIC_get_PCI_irq_vector(int bus, 
 /*
  * EISA Edge/Level control register, ELCR
  */
-static int __init EISA_ELCR(unsigned int irq)
+static int EISA_ELCR(unsigned int irq)
 {
 	if (irq < 16) {
 		unsigned int port = 0x4d0 + (irq >> 3);
@@ -504,7 +504,7 @@ static int __init MPBIOS_polarity(int id
 	return polarity;
 }
 
-static int __init MPBIOS_trigger(int idx)
+static int MPBIOS_trigger(int idx)
 {
 	int bus = mp_irqs[idx].mpc_srcbus;
 	int trigger;

--------------030404020604060707060005--
