Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbUBTTnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbUBTTmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:42:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:57011 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261388AbUBTTiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:38:06 -0500
Date: Fri, 20 Feb 2004 11:30:31 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Elliot Mackenzie" <macka@adixein.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Panic booting from USB disk in ioremap.c (line 81)
Message-Id: <20040220113031.0414ff65.rddunlap@osdl.org>
In-Reply-To: <000b01c3f7c7$7eaf8310$4301a8c0@waverunner>
References: <000b01c3f7c7$7eaf8310$4301a8c0@waverunner>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Feb 2004 01:37:47 +1000 "Elliot Mackenzie" <macka@adixein.com> wrote:

| Dear Penguins:
| 
| We have a problem booting vanilla 2.6.2 and 2.6.3 kernels from a USB
| disk (Transcend JetFlash, both 128MB USB 2 and 256MB USB 1). During what
| appears to be PCI device enumeration, we get the following panic:
| 
| kernel BUG at arch/i386/mm/ioremap.c:81!
| invalid operand: 0000 [#1]
| CPU: 0
| EIP:	0060:[<c011913c>]		Not tainted
| EFLAGS: 00010206
| EIP is at remap_area_pages+0x34/0x1f1
| eax: c0101000    ebx: edeb0000   ecx: bc6b0000   edx: c0101ce8
| esi: 0dffc0000   edi: ce800000   ebp: 00000000   esp: cde55f48
| ds:  007b    es: 007b   ss: 0068
| Process swapper (pid: 1, theadinfo=cde54000 task=cdfb3900)
| Stack:  c01490cd cdffb100 000000d0 c0101cec edeb0000 0dffc000 bc6b0000
| c0101ce8
|         c014913d edeb0000 0dffc000 ce800000 00000000 c01193d3 ce800000
| 3f7fc000
|         edeb0000 00000000 00000000 00000024 ce800000 edeafed7 c03e9249
| 0dffc000
| Call Trace:
|  [<c01490cd>] __get_vm_area+0xb5/0xf3
|  [<c014913d>] get_vm_area+0x32/0x36
|  [<c01193d3>] __ioremap+0xda/0x104
|  [<c03e9249>] sbf_init+0x167/0x180
|  [<c03e46f1>] do_init_calls+0x28/0x93
|  [<c012ca28>] init_workqueues+0xf/0x27
|  [<c01050bc>] init+0x30/0x134
|  [<c010508c>] init+0x0/0x134
|  [<c0109255>] kernel_thread_helper+0x5/0xb
| 
| Code: 0f 0b 51 00 8b 4d 32 c0 ba 00 e0 ff ff 21 e0 83 40 14 01 8b
|  <0>Kernel panic: Attempted to kill init!
| 
| This does not occur when booting from the hard disk, or when booting 2.4
| series kernels (tried 2.4.18 through 2.4.22).
| 
| Hardware info: P4-based Intel Celeron, motherboard is SiS chipset.
| 
| We have tried to circumvent the problem by changing the kernel PCI
| probing from "Any" to "BIOS" and "Direct".
| 
| The bootloader is SysLinux (1.66), using an initrd image.  Kernel
| parameters are set to run a serial console, but other than that, it's
| just kernel and initrd.
| 
| Output from lspci (-vvv), /proc/cpuinfo and /proc/iomem from a working
| 2.4 kernel on the same machine is below.  The kernel was compiled with
| gcc 3.2.
| 
| Can anyone provide some further insight into this problem, point us in
| the right direction, or let us know if this is indeed a bug?

The call trace must be missing some helpful info, then.
I say that only because the data supplied does not look usb-device
specific.

Please apply the patch below (for 2.6.3) and reboot that kernel
with "initcall_debug" added to the kernel boot command line,
and send the resulting (failing) output back to us.

--
~Randy


applies_to:	linux-263

diffstat:=
 arch/i386/mm/ioremap.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -Naurp ./arch/i386/mm/ioremap.c~sbfinit ./arch/i386/mm/ioremap.c
--- ./arch/i386/mm/ioremap.c~sbfinit	2004-02-17 19:57:20.000000000 -0800
+++ ./arch/i386/mm/ioremap.c	2004-02-20 11:29:41.000000000 -0800
@@ -77,8 +77,12 @@ static int remap_area_pages(unsigned lon
 	phys_addr -= address;
 	dir = pgd_offset(&init_mm, address);
 	flush_cache_all();
-	if (address >= end)
+	if (address >= end) {
+		printk("remap_area_pages BUG: address=0x%lx, size=0x%lx, end=0x%lx\n",
+				address, size, end);
+		dump_stack();
 		BUG();
+	}
 	spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd;
