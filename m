Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbTIIUev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTIIUdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:33:04 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:12771 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264460AbTIIUbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:31:43 -0400
Date: Tue, 9 Sep 2003 22:31:32 +0200 (MEST)
Message-Id: <200309092031.h89KVWIA027982@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: mathieu.desnoyers@polymtl.ca
Subject: Re: PROBLEM: APIC on a Pentium Classic SMP, 2.4.21-pre2 and 2.4.21-pre3 ksymoops
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Sep 2003 19:22:17 -0400, Mathieu Desnoyers wrote:
>> >On kernel 2.4.21-pre2, there is a kernel oops before this, with a
>> >"Dereferencing NULL pointer".
>> 
>> You didn't run that through ksymoops and post it, so how is anyone
>> supposed to be able to debug it?
>
>As only 2.4.21-pre2 and 2.4.21-pre3 kernels show this problem, I thought
>it has been corrected in 2.4.21-pre4. But, as it can be very useful in
>finding the problem, here are the ksymoops for 2.4.21-pre2 and
>2.4.21-pre3 kernels, quite similar though.
...
>Code;  c0115da7 <IO_APIC_get_PCI_irq_vector+17/130>
>00000000 <_EIP>:
>Code;  c0115da7 <IO_APIC_get_PCI_irq_vector+17/130>   <=====
>   0:   83 3c 90 ff               cmpl   $0xffffffff,(%eax,%edx,4)   <=====

Ok, that one is line 295 in io_apic.c. It bombs in 2.4.21-pre{2,3}
because mp_bus_id_to_pci_bus was changed from a static array to
a dynamically allocated array. On your machine, smp_read_mpc() in
mpparse.c doesn't get to the point where it allocates that array,
so the array is NULL in io_apic.c and you get an oops.

Fixing the oops is easy (see below), but the real problem is
that 2.4.21-pre2 apparently broke MP table parsing on your HW.
I suggest you sprinkle tracing printk()s in setup/smpboot/mpparse
and compare 2.4.20 (good) and later (bad) to see where things
start to diverge.

/Mikael

--- linux-2.4.21-pre2/arch/i386/kernel/io_apic.c.~1~	2003-09-09 21:27:39.000000000 +0200
+++ linux-2.4.21-pre2/arch/i386/kernel/io_apic.c	2003-09-09 22:17:02.464082064 +0200
@@ -292,7 +292,7 @@
 
 	Dprintk("querying PCI -> IRQ mapping bus:%d, slot:%d, pin:%d.\n",
 		bus, slot, pin);
-	if (mp_bus_id_to_pci_bus[bus] == -1) {
+	if ((mp_bus_id_to_pci_bus==NULL) || mp_bus_id_to_pci_bus[bus] == -1) {
 		printk(KERN_WARNING "PCI BIOS passed nonexistent PCI bus %d!\n", bus);
 		return -1;
 	}
