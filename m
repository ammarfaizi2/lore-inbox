Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbTEPSWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTEPSWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:22:18 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:32992 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264549AbTEPSWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:22:15 -0400
Subject: Re: 2.5.69-mm6: pccard oops while booting
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@digeo.com>
Cc: rmk@arm.linux.org.uk, LKML <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <1053090184.653.0.camel@teapot.felipe-alfaro.com>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>
	 <20030514191735.6fe0998c.akpm@digeo.com>
	 <1052998601.726.1.camel@teapot.felipe-alfaro.com>
	 <20030515130019.B30619@flint.arm.linux.org.uk>
	 <1053004615.586.2.camel@teapot.felipe-alfaro.com>
	 <20030515144439.A31491@flint.arm.linux.org.uk>
	 <1053037915.569.2.camel@teapot.felipe-alfaro.com>
	 <20030515160015.5dfea63f.akpm@digeo.com>
	 <1053090184.653.0.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1053110098.648.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 16 May 2003 20:34:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-16 at 15:03, Felipe Alfaro Solana wrote:
> On Fri, 2003-05-16 at 01:00, Andrew Morton wrote: 
> > Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> > >
> > > The test kernel is
> > > a 2.5.69-mm5 with the "i8259-shutdown.patch" reverted, plus the above
> > > patch and your previous "verbose" patch. Attached to this message is the
> > > new "dmesg" from this patched kernel.
> > > 
> > > As I told Andrew, reverting "make-KOBJ_NAME-match-BUS_ID_SIZE.patch"
> > > solves the oops.
> > 
> > The weird thing is that this patch really doesn't do anything apart from
> > increasing KOBJ_NAME_LEN from 16 to 20.
> 
> OK, this is what I guessed by playing with 2.5.69-mm6:
> 
> 1. Simply by changing KOBJ_NAME_LEN from 20 to 16 fixes the problem.
> This leads me to think there are some parts of the kernel (a driver, to
> be more exact) that are corrupting memory or doing something really
> nasty that is affecting PCI ID's tables and pci_bus_match() function.
> 
> 2. Disabling or enabling preemptible kernel does not help.
> 
> 3. Now, changing KOBJ_NAME_LEN back to 20, and then disabling support
> for the ALSA Yamaha PCI driver (YMFPCI) fixes the problem. I have tried
> disabling other drivers, like USB-UHCI, AGPGART, but it doesn't help.
> However, disabling YMFPCI solves the problem. So I guess, we've got a
> problem at alsa_card_ymfpci_init() function. Note that the YMFPCI was
> built-in into the kernel, and not as a module. However, building YMFPCI
> as a module still produces an oops. I'll post more information when I
> investigate a little more about this.
> 
> Any ideas on what's could be going on here? It's driving me nutts!
> 
> Thanks!

OK, this is the oops caused when trying to modprobe snd-ymfpci on
2.5.69-mm6:

Linux version 2.5.69-mm6 (root@glass.felipe-alfaro.com) (gcc version
3.2.3 20030422 (Red Hat Linux 3.2.3-4)) #25 Fri May 16 15:04:26 CEST
2003
Unable to handle kernel paging request at virtual address 50464d59
 printing eip:
c01d07bf
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01d07bf>]    Not tainted VLI
EFLAGS: 00010202
EIP is at driver_attach+0x3f/0x60
eax: 50464d59   ebx: 50464d59   ecx: 59004943   edx: d08a821e
esi: cfdec780   edi: d08aaa48   ebp: c030d100   esp: cfa0bf40
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 152, threadinfo=cfa0a000 task=cfde2690)
Stack: cff3884c d08aaa48 c030d14c 00000000 d08aaa76 c01d0a98 d08aaa48
00000009 
       c02e1830 00000000 c02e1818 cfa0a000 c01d0f1f d08aaa48 00000015
00000017 
       d0894c4c cfdec8a0 c0192527 d08aaa48 d087f019 d08aaa20 c02e1830
d08b1200 
Call Trace:
 [<d08aaa48>] driver+0x28/0xa0 [snd_ymfpci]
 [<d08aaa76>] driver+0x56/0xa0 [snd_ymfpci]
 [<c01d0a98>] bus_add_driver+0xa8/0xc0
 [<d08aaa48>] driver+0x28/0xa0 [snd_ymfpci]
 [<c01d0f1f>] driver_register+0x2f/0x40
 [<d08aaa48>] driver+0x28/0xa0 [snd_ymfpci]
 [<c0192527>] pci_register_driver+0x47/0x60
 [<d08aaa48>] driver+0x28/0xa0 [snd_ymfpci]
 [<d087f019>] +0x19/0x5b [snd_ymfpci]
 [<d08aaa20>] driver+0x0/0xa0 [snd_ymfpci]
 [<d08b1200>] +0x0/0xe0 [snd_ymfpci]
 [<c012eb2c>] sys_init_module+0x12c/0x240
 [<d08b1200>] +0x0/0xe0 [snd_ymfpci]
 [<c0109349>] sysenter_past_esp+0x52/0x71

Code: db 74 32 8b 9a a8 00 00 00 8b 03 0f 18 00 90 8d b2 a8 00 00 00 39
f3 74 1c 8d 76 00 8d 53 f8 8b 8a a4 00 00 00 85 c9 74 13 89 c3 <8b> 00
0f 18 00 90 39 f3 75 e7 83 c4 08 5b 5e 5f c3 89 7c 24 04 
 

