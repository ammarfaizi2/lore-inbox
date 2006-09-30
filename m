Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWI3WGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWI3WGA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWI3WGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:06:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:47259 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751413AbWI3WF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:05:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=GvYkAlPeCa6iGGrmV5d0ih5gMNLuaNewYxbBHjdmJtyb5qpa0jE9oBKa058OhakE6NI9ScFb+FDJTigpVU/cE1pvcjjdqQTGcDjZZTESLx0KaTAoyE8ILtsbCpUQFFoEH8K/vZxG5zGq29G5jiqMurX4tE4gyNPHRaq9f1P8uEM=
Date: Sun, 1 Oct 2006 00:06:00 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.18-git] Lost all PCI devices
Message-ID: <20060930220600.GA19990@dreamland.darkstar.lan>
References: <20060930174247.GA31793@dreamland.darkstar.lan> <200609302011.13457.ak@suse.de> <20060930202240.GA15952@dreamland.darkstar.lan> <200609302234.24778.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609302234.24778.ak@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sat, Sep 30, 2006 at 10:34:24PM +0200, Andi Kleen ha scritto: 
> On Saturday 30 September 2006 22:22, Luca Tettamanti wrote:
> > Il Sat, Sep 30, 2006 at 08:11:13PM +0200, Andi Kleen ha scritto: 
> > > On Saturday 30 September 2006 19:42, Luca Tettamanti wrote:
> > > > Hi Andi,
> > > > I'm testing current git on my notebook, but kernel doesn't find any
> > > > PCI device: no video card, no IDE, nothing.
> > > 
> > > Can you test it with this patch please?
> > 
> > Works fine, I can boot with it. Thank you!
> 
> Just curious - i assume you have CONFIG_PCI_GOBIOS set.

Not really, it's set to any:

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y

I'm a bit clueless about those options so I let the default.

> Does your system also work when you set CONFIG_PCI_GODIRECT instead?

Without the patch I assume. No, I tried both PCI_GODIRECT and
PCI_GOMMCONFIG; the former survive the boot but doesn't find any device,
the latter explodes somewhere in ACPI code.

PCI_GODIRECT with a few printk and initcall_debug:

Calling initcall 0xc036cc40: acpi_pci_init+0x0/0x30()
ACPI: bus type pci registered
Calling initcall 0xc036e4ff: init_acpi_device_notify+0x0/0x43()
Calling initcall 0xc0372270: pci_access_init+0x0/0x40()
inside pci_access_init
calling pci_direct_probe
pci_direct_probe conf1
pci_direct_probe conf2
pci_direct_probe fail2
PCI: Using configuration type 0
Calling initcall 0xc035e1f0: request_standard_resources+0x0/0x320()
Setting up standard PCI resources

"pci_direct_probe conf*" printk are placed before calling into
pci_check_type{1,2}, it doesn't call pci_sanity_check so it's the I/O
check that fails.
I can do further debugging if you're interested.

PCI_GOMMCONFIG:

ACPI: Access to PCI configuration space unavailable
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
------------[ cut here ]------------
Kernel BUG at [verbose debug info unavailable]
invalid opcode: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c0233103>]    Not tainted VLI
EFLAGS: 00010246   (2.6.18-g5ffd1a6a-dirty #20)
EIP is at acpi_os_read_pci_configuration+0x4f/0x87
eax: 00000001   ebx: defd0aa0   ecx: defc9c53   edx: 00000008
esi: 00000001   edi: 00000000   ebp: defc9c34   esp: defc9c20
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, ti=defc9000 task=defc8a50 task.ti=defc9000)
Stack: defc9c53 0000000e defc9c53 defc9c70 defc9c77 defc9c60 c0233342 00000008
       00000006 00020000 defd0aa0 c144d9b4 c02d3630 defc9c70 00000000 c02cfc3e
       defc9c7c c02333cb defc9c70 defc9c77 00000001 00fc9c9c defc9c9c defc9cb4
Call Trace:
 [<c0233342>] acpi_os_derive_pci_id_2+0xab/0x110
 [<c02333cb>] acpi_os_derive_pci_id+0x24/0x2b
 [<c0238807>] acpi_ev_pci_config_region_setup+0x1d4/0x1e8
 [<c0237893>] acpi_ev_address_space_dispatch+0xb5/0x186
 [<c023b831>] acpi_ex_access_region+0x1c0/0x1d9
 [<c023b980>] acpi_ex_field_datum_io+0x136/0x1bb
 [<c023ba96>] acpi_ex_extract_from_field+0x91/0x224
 [<c023a3b9>] acpi_ex_read_data_from_field+0x125/0x151
 [<c023f41c>] acpi_ex_resolve_node_to_value+0x14c/0x1cc
 [<c023af77>] acpi_ex_resolve_to_value+0x201/0x20e
 [<c023cf92>] acpi_ex_resolve_operands+0x1f5/0x4df
 [<c02351a1>] acpi_ds_exec_end_op+0xaf/0x3be
 [<c0243a3c>] acpi_ps_parse_loop+0x59c/0x8a8
 [<c024309e>] acpi_ps_parse_aml+0x68/0x20b
 [<c02441ba>] acpi_ps_execute_pass+0x73/0x87
 [<c02442cd>] acpi_ps_execute_method+0xcb/0x15a
 [<c02416cf>] acpi_ns_evaluate+0x97/0xf4
 [<c024133c>] acpi_evaluate_object+0x11f/0x1bf
 [<c0233914>] acpi_evaluate_integer+0x7d/0xb0
 [<c024a1f9>] acpi_bus_get_status+0x31/0x83
 [<c0250bcf>] acpi_add_single_object+0x1b6/0x807
 [<c0251319>] acpi_bus_scan+0xf9/0x163
 [<c036ef77>] acpi_scan_init+0x14a/0x16c
 [<c01003b5>] init+0x75/0x290
 [<c0103c3b>] kernel_thread_helper+0x7/0x1c
 =======================
Code: 20 74 12 83 fa 08 66 b8 01 00 75 4f eb 0e be 02 00 00 00 eb 0c be
04 00 00 00 eb 05 be 01 00 00 00 8b 3d 14 63 3a c0 85 ff 75 02 <0f> 0b
0f b7 4b 04 0f b7 43 06 ff 75 ec 0f b7 53 02 56 ff 75 f0
EIP: [<c0233103>] acpi_os_read_pci_configuration+0x4f/0x87 SS:ESP
0068:defc9c20

BTW changing those 2 options causes the re-compilation of almost all the
kernel (due to: include/config/pci/mmconfig.h), it's a bit awkward on my
not-very-fast machine...

Luca
-- 
"L'abilita` politica e` l'abilita` di prevedere quello che
 accadra` domani, la prossima settimana, il prossimo mese e
 l'anno prossimo. E di essere cosi` abili, piu` tardi,
 da spiegare  perche' non e` accaduto."
