Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271289AbTG2HYb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 03:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271302AbTG2HYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 03:24:31 -0400
Received: from mgr6.xmission.com ([198.60.22.206]:9181 "EHLO mgr6.xmission.com")
	by vger.kernel.org with ESMTP id S271289AbTG2HY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 03:24:26 -0400
Date: Tue, 29 Jul 2003 01:24:17 -0600
From: "S. Anderson" <sa@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "S. Anderson" <sa@xmission.com>, pavel@xal.co.uk,
       linux-kernel@vger.kernel.org, adaplas@pol.net
Subject: Re: OOPS 2.6.0-test2, modprobe i810fb
Message-ID: <20030729012417.A18449@xmission.xmission.com>
References: <20030728171806.GA1860@xal.co.uk> <20030728201954.A16103@xmission.xmission.com> <20030728202600.18338fa9.akpm@osdl.org> <20030728231812.A20738@xmission.xmission.com> <20030728225914.4f299586.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728225914.4f299586.akpm@osdl.org>; from akpm@osdl.org on Mon, Jul 28, 2003 at 10:59:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 10:59:14PM -0700, Andrew Morton wrote:
> "S. Anderson" <sa@xmission.com> wrote:
> >
> > Thanks, that fixes the oops Pavel reported!
> > 
> > But I now realize the oops I am getting is different...
> > 
> > It happens only if any of these "i810fb, i810_audio or intel-agp"
> > are compiled in the kernel or insterted as modules.
> > 
> > i810fb, i810_audio or intel-agp load up fine and seem to all work
> > properly. I only get the oops when I put a card into my cardbus slot.
> > 
> > this is what i think happens, when I put the card in, it sets off some
> > functions that will try to get a driver for the card I just inserted.
> > when it gets to the pci_bus_match function, my cards vendor and device 
> > numbers are tested against a drivers id_table. when that driver is 
> > "i810fb, i810_audio or intel-agp" (and i810fb, i810_audio or intel-agp
> > is allready loaded) the id_table is at an address that cant be handled, 
> > thus cauing the oops. I am having trouble figuring out why 
> > pci_drv->id_table isnt valid in this case.
> 
> Everything seems happy here:
> 
> vmm:/home/akpm> lsmod
> Module                  Size  Used by
> i810fb                 31572  0 
> cfbcopyarea             4700  1 i810fb
> vgastate               10660  1 i810fb
> cfbimgblt               4068  1 i810fb
> cfbfillrect             4820  1 i810fb
> intel_agp              16940  1 
> agpgart                32496  1 intel_agp
> i810_audio             34208  0 
> ac97_codec             18932  1 i810_audio
> rtc                    15744  0 
> 
> Can you do modprobe-by-hand, see which one causes the oops?

I will try to explain the problem better.

First of all, I can modprobe all three of these modules with no problems.

the oops only occurs when one of these modules are modprobed
_before_ I insert a card into my cardbus.

With no modules inserted, I can insert my card into the cardbus slot 
with no problems. This is what my log looks like. (with my debugging printk)

Jul 29 00:28:48 localhost kernel:  (pci_bus_add_devices) bus 3 devfn 0  1260 3890
Jul 29 00:28:48 localhost kernel: pci_bus_match: bus=3, devfn=0 1260 3890
Jul 29 00:28:48 localhost kernel:  ^ matching? ^ (serial)  ((( &ids->vendor = c0397314 )))
Jul 29 00:28:48 localhost kernel: pci_match_device: &ids->vendor = c0397314
Jul 29 00:28:48 localhost kernel: pci_bus_match: bus=3, devfn=0 1260 3890
Jul 29 00:28:48 localhost kernel:  ^ matching? ^ (eepro100)  ((( &ids->vendor = c0398a60 )))
Jul 29 00:28:48 localhost kernel: pci_match_device: &ids->vendor = c0398a60
Jul 29 00:28:48 localhost kernel: pci_bus_match: bus=3, devfn=0 1260 3890
Jul 29 00:28:48 localhost kernel:  ^ matching? ^ (PCI IDE)  ((( &ids->vendor = c039a630 )))
Jul 29 00:28:48 localhost kernel: pci_match_device: &ids->vendor = c039a630
Jul 29 00:28:48 localhost kernel: pci_bus_match: bus=3, devfn=0 1260 3890
Jul 29 00:28:48 localhost kernel:  ^ matching? ^ (yenta_cardbus)  ((( &ids->vendor = c039df98 )))
Jul 29 00:28:48 localhost kernel: pci_match_device: &ids->vendor = c039df98
Jul 29 00:28:48 localhost pci.agent: ... no modules for PCI slot 0000:03:00.0

then I take my card out of its slot and 
then modprobe i810fb (I could modprobe i810_audio or intel-agp or 
all three at the same time)

Jul 29 00:33:48 localhost kernel: pci_bus_match: bus=0, devfn=0 8086 3575
Jul 29 00:33:48 localhost kernel:  ^ matching? ^ (i810fb)  ((( &ids->vendor = d094ee7c )))
Jul 29 00:33:48 localhost kernel: pci_match_device: &ids->vendor = d094ee7c
Jul 29 00:33:48 localhost kernel: pci_bus_match: bus=0, devfn=16 8086 3577
Jul 29 00:33:48 localhost kernel:  ^ matching? ^ (i810fb)  ((( &ids->vendor = d094ee7c )))
Jul 29 00:33:48 localhost kernel: pci_match_device: &ids->vendor = d094ee7c
Jul 29 00:33:48 localhost kernel: pci_bus_match: bus=0, devfn=17 8086 3577
Jul 29 00:33:48 localhost kernel:  ^ matching? ^ (i810fb)  ((( &ids->vendor = d094ee7c )))
Jul 29 00:33:48 localhost kernel: pci_match_device: &ids->vendor = d094ee7c
Jul 29 00:33:48 localhost kernel: pci_bus_match: bus=0, devfn=232 8086 2482
Jul 29 00:33:48 localhost kernel:  ^ matching? ^ (i810fb)  ((( &ids->vendor = d094ee7c )))
Jul 29 00:33:48 localhost kernel: pci_match_device: &ids->vendor = d094ee7c
[..snip..]

then when i insert my card again this is when the oops occurs:

Jul 29 00:40:12 localhost kernel:  (pci_bus_add_devices) bus 3 devfn 0  1260 3890
Jul 29 00:40:12 localhost kernel: pci_bus_match: bus=3, devfn=0 1260 3890
Jul 29 00:40:12 localhost kernel:  ^ matching? ^ (serial)  ((( &ids->vendor = c0397314 )))
Jul 29 00:40:12 localhost kernel: pci_match_device: &ids->vendor = c0397314
Jul 29 00:40:12 localhost kernel: pci_bus_match: bus=3, devfn=0 1260 3890
Jul 29 00:40:12 localhost kernel:  ^ matching? ^ (eepro100)  ((( &ids->vendor = c0398a60 )))
Jul 29 00:40:12 localhost kernel: pci_match_device: &ids->vendor = c0398a60
Jul 29 00:40:12 localhost kernel: pci_bus_match: bus=3, devfn=0 1260 3890
Jul 29 00:40:12 localhost kernel:  ^ matching? ^ (PCI IDE)  ((( &ids->vendor = c039a630 )))
Jul 29 00:40:12 localhost kernel: pci_match_device: &ids->vendor = c039a630
Jul 29 00:40:12 localhost kernel: pci_bus_match: bus=3, devfn=0 1260 3890
Jul 29 00:40:12 localhost kernel:  ^ matching? ^ (yenta_cardbus)  ((( &ids->vendor = c039df98 )))
Jul 29 00:40:12 localhost kernel: pci_match_device: &ids->vendor = c039df98
Jul 29 00:40:12 localhost pci.agent: ... no modules for PCI slot 0000:03:00.0
Jul 29 00:40:12 localhost kernel: pci_bus_match: bus=3, devfn=0 1260 3890
Jul 29 00:40:12 localhost kernel:  ^ matching? ^ (i810fb)  ((( &ids->vendor = d094ee7c )))
Jul 29 00:40:12 localhost kernel: pci_match_device: &ids->vendor = d094ee7c
Jul 29 00:40:12 localhost kernel: Unable to handle kernel paging request at virtual address d094ee7c
Jul 29 00:40:12 localhost kernel:  printing eip:
Jul 29 00:40:12 localhost kernel: c01f7da3
Jul 29 00:40:12 localhost kernel: *pde = 0f913067
Jul 29 00:40:12 localhost kernel: *pte = 00000000
Jul 29 00:40:12 localhost kernel: Oops: 0000 [#1]
Jul 29 00:40:12 localhost kernel: CPU:    0
Jul 29 00:40:12 localhost kernel: EIP:    0060:[quirk_transparent_bridge+15/20]    Not tainted
Jul 29 00:40:12 localhost kernel: EIP:    0060:[<c01f7da3>]    Not tainted
Jul 29 00:40:12 localhost kernel: EFLAGS: 00010286
Jul 29 00:40:12 localhost kernel: EIP is at pci_match_device+0x73/0x90
Jul 29 00:40:12 localhost kernel: eax: 0000002a   ebx: d094ee7c   ecx: 00000001   edx: c035fa38
Jul 29 00:40:12 localhost kernel: esi: c67c4004   edi: c67c4004   ebp: cf619e94   esp: cf619e84
Jul 29 00:40:12 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jul 29 00:40:12 localhost kernel: Process pccardd (pid: 9, threadinfo=cf618000 task=cf636000)
Jul 29 00:40:12 localhost kernel: Stack: c031aa20 d094ee7c d096e800 d094ee7c cf619eb4 c01f84fb d094ee7c c67c4004 
Jul 29 00:40:12 localhost kernel:        ffffffed d096e828 c67c4058 c039e09c cf619ed0 c021f0f9 c67c4058 d096e828 
Jul 29 00:40:12 localhost kernel:        d096e870 c03918f4 c67c4058 cf619eec c021f18a c67c4058 d096e828 c0391880 
Jul 29 00:40:12 localhost kernel: Call Trace:
Jul 29 00:40:12 localhost kernel:  [pci_free_dynids+3/360] pci_bus_match+0x5f/0x2b0
Jul 29 00:40:12 localhost kernel:  [<c01f84fb>] pci_bus_match+0x5f/0x2b0
Jul 29 00:40:12 localhost kernel:  [acpi_tb_verify_table_checksum+113/148] bus_match+0x21/0x64
Jul 29 00:40:12 localhost kernel:  [<c021f0f9>] bus_match+0x21/0x64
Jul 29 00:40:12 localhost kernel:  [acpi_tb_find_table+58/308] device_attach+0x4e/0x70
Jul 29 00:40:12 localhost kernel:  [<c021f18a>] device_attach+0x4e/0x70
Jul 29 00:40:12 localhost kernel:  [acpi_get_firmware_table+126/848] bus_add_device+0x72/0xb4
Jul 29 00:40:12 localhost kernel:  [<c021f302>] bus_add_device+0x72/0xb4
Jul 29 00:40:12 localhost kernel:  [acpi_tb_verify_rsdp+320/344] device_add+0xd0/0x108
Jul 29 00:40:12 localhost kernel:  [<c021dc40>] device_add+0xd0/0x108
Jul 29 00:40:12 localhost kernel:  [pci_bus_write_config_word+100/324] pci_bus_add_devices+0x50/0x300
Jul 29 00:40:12 localhost kernel:  [<c01f4864>] pci_bus_add_devices+0x50/0x300
Jul 29 00:40:12 localhost kernel:  [i830_cleanup_buf_error+121/184] cb_alloc+0xad/0xc8
Jul 29 00:40:12 localhost kernel:  [<c02553cd>] cb_alloc+0xad/0xc8
Jul 29 00:40:12 localhost kernel:  [agp_3_5_isochronous_node_enable+342/1020] socket_insert+0x56/0xa4
Jul 29 00:40:12 localhost kernel:  [<c0252362>] socket_insert+0x56/0xa4
Jul 29 00:40:12 localhost kernel:  [agp_3_5_isochronous_node_enable+869/1020] socket_detect_change+0x69/0x70
Jul 29 00:40:13 localhost kernel:  [<c0252571>] socket_detect_change+0x69/0x70
Jul 29 00:40:13 localhost kernel:  [agp_3_5_enable+167/704] pccardd+0x1ef/0x2a0
Jul 29 00:40:13 localhost kernel:  [<c0252767>] pccardd+0x1ef/0x2a0
Jul 29 00:40:13 localhost kernel:  [agp_3_5_isochronous_node_enable+876/1020] pccardd+0x0/0x2a0
Jul 29 00:40:13 localhost kernel:  [<c0252578>] pccardd+0x0/0x2a0
Jul 29 00:40:13 localhost kernel:  [schedule+404/1156] default_wake_function+0x0/0x20
Jul 29 00:40:13 localhost kernel:  [<c011ae7c>] default_wake_function+0x0/0x20
Jul 29 00:40:13 localhost kernel:  [schedule+404/1156] default_wake_function+0x0/0x20
Jul 29 00:40:13 localhost kernel:  [<c011ae7c>] default_wake_function+0x0/0x20
Jul 29 00:40:13 localhost kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Jul 29 00:40:13 localhost kernel:  [<c01070c5>] kernel_thread_helper+0x5/0xc
Jul 29 00:40:13 localhost kernel: 
Jul 29 00:40:13 localhost kernel: Code: 83 3b 00 75 a0 83 7b 08 00 75 9a 83 7b 14 00 75 94 31 c0 8d 

I hope this makes sense.
