Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTDIUUA (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 16:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263776AbTDIUUA (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 16:20:00 -0400
Received: from air-2.osdl.org ([65.172.181.6]:25238 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263765AbTDIUT5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 16:19:57 -0400
Date: Wed, 9 Apr 2003 13:30:59 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       vandrove@vc.cvut.cz
Subject: Re: 2.5.67-mm1 cause framebuffer crash at bootup
Message-Id: <20030409133059.338c47ad.rddunlap@osdl.org>
In-Reply-To: <PAO-EX01DJb0LxA56iY0000151b@pao-ex01.pao.digeo.com>
References: <20030408042239.053e1d23.akpm@digeo.com>
	<3E93EB0E.4030609@aitel.hist.no>
	<PAO-EX01DJb0LxA56iY0000151b@pao-ex01.pao.digeo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Apr 2003 03:18:45 -0700 Andrew Morton <akpm@digeo.com> wrote:

| 
| Helge Hafting <helgehaf@aitel.hist.no> wrote:
| >
| > 2.5.67 works with framebuffer console, 2.5.67-mm1 dies before activating
| > graphichs mode on two different machines:
| > 
| > smp with matroxfb, also using a patch that makes matroxfb work in 2.5
| > up with radeonfb, also using patches that fixes the broken devfs in mm1.
| > 
| > I use devfs and preempt in both cases, and monolithic kernels without module
| > support.
| > 
| > 2.5.67-mm1 works if I drop framebuffer support completely.
| >
| > Here is the printed backtrace for the radeon case, the matrox case was 
| > similiar:
| 
| Well I tried to reproduce this with an
| 
| 	nVidia Corporation NV17 [GeForce4 MX440] (rev a3)
| 
| and the screen came up in a strange mixture of penguins and obviously uninitialised
| video RAM overlayed on top of text.  I can't read a thing.
| 
| But there is no oops.
| 
| The Cirrus drivers still do not compile, so scrub that test box.
| 
| We have some compilation scruffies:
| drivers/video/aty/mach64_gx.c:194: warning: initialization from incompatible pointer type
....
| 
| Another machine here uses
| 
| 	ATI Technologies Inc Rage Mobility M3 AGP 2x (rev 02)
| 
| and..... it oopses!   Backing out 
| 
| ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm1/broken-out/earlier-keyboard-init.patch
| 
| prevents it oopsing.  Can you please try that?
| 
| 
| Despite the lack of oopses, framebuffer support is sick on this machine also.
| The LCD alternates between blackness and a strange smeary set of flickering
| lines.

Argh.  This is ridiculous.... OK, I'm over it.  I'll look into this more.
I'd settle for Vojtech making an appearance.  :)

I can reproduce the problem with the earlier-keyboard-init.patch, but if
I reverse it, I get this [using Petr's 2.5.66-bk12 mga patch].  Is that the
right one to use?  do I need to use any kernel command line options with it?
Matrox G400 dual-head capable, but only using one of them.


matroxfb: Matrox G450 detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x26208)
matroxfb: framebuffer at 0xEC000000, mapped to 0xf8805000, size 16777216
<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010246
EIP is at 0x0
eax: c04b77c8   ebx: f7f9fccc   ecx: c1ada17f   edx: c04b6f40
esi: ffffffff   edi: 00000030   ebp: 00000030   esp: f7f9fc78
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=f7f9e000 task=f7f9c080)
Stack: c0292c1e c04b6f40 f7f9fccc ffffffff ffffffff 00000000 00000000 00000400 
       00000008 00000001 000000ff 0000000c c04b6f40 00000030 c1a41480 c0292e65 
       c1a41480 c04b6f40 f7f9fccc 00000030 c00bb1c0 00000000 00000108 00000180 
Call Trace:
 [<c0292c1e>] putcs_aligned+0x16e/0x1b0
 [<c0292e65>] accel_putcs+0xc5/0xf0
 [<c02939ce>] fbcon_putcs+0x7e/0x90
 [<c01feb73>] vt_console_print+0x103/0x2b0
 [<c011f616>] __call_console_drivers+0x46/0x60
 [<c011f762>] call_console_drivers+0xc2/0xf0
 [<c011fb23>] release_console_sem+0xa3/0x140
 [<c011f9d8>] printk+0x1d8/0x230
 [<c029367a>] fbcon_set_display+0x33a/0x4c0
 [<c01f8031>] set_inverse_transl+0x41/0xa0
 [<c013ecad>] kmalloc+0xdd/0x190
 [<c010b592>] do_IRQ+0x112/0x1f0
 [<c02930cd>] fbcon_init+0xdd/0xf0
 [<c01fba0f>] visual_init+0x9f/0x100
 [<c01ff3bd>] take_over_console+0xad/0x180
 [<c02981f5>] register_framebuffer+0x175/0x1a0
 [<c029be10>] initMatrox2+0x8e0/0x990
 [<c02d07ad>] pcibios_enable_device+0x1d/0x20
 [<c029c3c2>] matroxfb_probe+0x2c2/0x2f0
 [<c01e320f>] pci_device_probe+0x3f/0x60
 [<c021d4c4>] bus_match+0x34/0x60
 [<c021d594>] driver_attach+0x34/0x60
 [<c021d847>] bus_add_driver+0x97/0xd0
 [<c01e3326>] pci_register_driver+0x46/0x60
 [<c01050fb>] init+0x7b/0x220
 [<c0105080>] init+0x0/0x220
 [<c0107165>] kernel_thread_helper+0x5/0x10

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill init!


--
~Randy
