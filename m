Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752540AbWAGPEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbWAGPEL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 10:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbWAGPEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 10:04:11 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:5098 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S1752540AbWAGPEJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 10:04:09 -0500
Date: Sat, 07 Jan 2006 16:04:03 +0100
From: Jan Spitalnik <lkml@spitalnik.net>
Subject: Re: [PATCH] Disable swsusp on CONFIG_HIGHMEM64
In-reply-to: <20060105234327.GA2951@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Message-id: <200601071604.03846.lkml@spitalnik.net>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
User-Agent: KMail/1.9
References: <200601061945.09466.lkml@spitalnik.net>
 <20060105234327.GA2951@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne pátek 06 leden 2006 00:43 Pavel Machek napsal(a):
> On Fri 06-01-06 19:45:09, Jan Spitalnik wrote:
> > Hello,
> >
> > suspending to disk is not supported on CONFIG_HIGHMEM64G setups
> > (http://suspend2.net/features). Also suspend to ram doesn't work. This
> > patch
>
> NAK. suspend2.net describes very different code.

Well, I was using suspend2.net's page just as reference, to point out the fact 
that HIGHMEM is on both suspend "platforms" supported only up to 4G. 
I was not refering to suspend2's actual features, but rather swsusp's 
(or what's the proper name for suspend1 code). So i guess the patch still 
holds, no?

>
> > fixes Kconfig to disallow such combination. I'm not 100% sure about the
> > ACPI_SLEEP part, as it might be disabling some working setup - but i
> > think that s2r and s2d are the only acpi sleeps allowed, no?
>
> s2ram probably works. Try getting it working without highmem64,
> then turn it on.

It works with HIGHMEM but not HIGHMEM64G. You can find the oops from 
HIGHMEM64G below. It crashes very reliably on little stress after resume.

Jan  5 20:12:47 hathor Unable to handle kernel paging request at virtual address dc025000
Jan  5 20:12:47 hathor printing eip:
Jan  5 20:12:47 hathor c013edcc
Jan  5 20:12:47 hathor *pde = 00000000
Jan  5 20:12:47 hathor Oops: 0002 [#3]
Jan  5 20:12:47 hathor Modules linked in: usbmouse i915 drm autofs4 bridge snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss pcspkr parport_pc\
 parport irtty_sir sir_dev irda crc_ccitt 8250_pnp snd_intel8x0m snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd usbhid uhc\
i_hcd intel_agp agpgart usbcore binfmt_misc nls_iso8859_2 nls_cp852 vfat fat nls_base tg3 evdev thermal fan 8250_acpi 8250 serial_core tun loop yenta_socket rsrc_nonstatic \
pcmcia pcmcia_core firmware_class rfcomm l2cap bluetooth
Jan  5 20:12:47 hathor CPU:    0
Jan  5 20:12:47 hathor EIP:    0060:[<c013edcc>]    Not tainted VLI
Jan  5 20:12:47 hathor EFLAGS: 00010296   (2.6.15)
Jan  5 20:12:47 hathor EIP is at buffered_rmqueue+0x1bc/0x230
Jan  5 20:12:47 hathor eax: 00000000   ebx: c13804a0   ecx: 00000400   edx: dc025000
Jan  5 20:12:47 hathor esi: 00000000   edi: dc025000   ebp: 00000000   esp: de021e64
Jan  5 20:12:47 hathor ds: 007b   es: 007b   ss: 0068
Jan  5 20:12:47 hathor Process konqueror (pid: 11756, threadinfo=de020000 task=ed4600b0)
Jan  5 20:12:47 hathor Stack: c13804a0 00000003 0000001f c0319690 000081a4 00000001 00000000 c13804a0
Jan  5 20:12:47 hathor c03198ec 00000044 00000000 00000003 c013efda c0319660 00000000 000280d2
Jan  5 20:12:47 hathor 00000003 00000044 c03198e8 000280d2 ed4600b0 df0b4320 c013f05f 000280d2
Jan  5 20:12:47 hathor Call Trace:
Jan  5 20:12:47 hathor [<c013efda>] get_page_from_freelist+0xba/0xe0
Jan  5 20:12:47 hathor [<c013f05f>] __alloc_pages+0x5f/0x320
Jan  5 20:12:47 hathor [<c0150557>] anon_vma_prepare+0x17/0xa0
Jan  5 20:12:47 hathor [<c014b4e4>] do_anonymous_page+0x54/0x1e0
Jan  5 20:12:47 hathor [<c014baec>] __handle_mm_fault+0x12c/0x330
Jan  5 20:12:47 hathor [<c02cf5f5>] notifier_call_chain+0x25/0x50
Jan  5 20:12:47 hathor [<c02cf0c3>] do_page_fault+0x1c3/0x6d0
Jan  5 20:12:47 hathor [<c0159f33>] sys_close+0x53/0x70
Jan  5 20:12:47 hathor [<c02cef00>] do_page_fault+0x0/0x6d0
Jan  5 20:12:47 hathor [<c0103b03>] error_code+0x4f/0x54
Jan  5 20:12:47 hathor Code: fb 00 7e 44 89 5c 24 14 8b 5c 24 1c 31 f6 90 89 1c 24 ba 03 00 00 00 89 54 24 04 e8 6f 8a fd ff 89 c2 89 c7 b9 00 04 00 00 89 f0 <f3> ab 89 14 \
24 b8 03 00 00 00 45 89 44 24 04 e8 10 8b fd ff 83
Jan  5 20:12:47 hathor <6>note: konqueror[11756] exited with preempt_count 1

-- 
Jan Spitalnik
jan@spitalnik.net
