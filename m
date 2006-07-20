Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWGTQk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWGTQk3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 12:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWGTQk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 12:40:29 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:41919 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1030363AbWGTQk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 12:40:28 -0400
Date: Thu, 20 Jul 2006 09:40:27 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz, tk@maintech.de,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: PCMCIA IDE eject atomic counter underflow (was Re: +revert-pcmcia-ma...)
Message-ID: <20060720164027.GS2038@hexapodia.org>
References: <200607090207.k6927S4D007223@shell0.pdx.osdl.net> <20060720151202.GQ2038@hexapodia.org> <20060720090957.07681381.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060720090957.07681381.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2006 at 09:09:57AM -0700, Andrew Morton wrote:
> On Thu, 20 Jul 2006 08:12:02 -0700
> Andy Isaacson <adi@hexapodia.org> wrote:
> > I finally got a chance to test, and 2.6.18-rc1-mm2 does fix my PCMCIA.
> > Thanks!
> 
> Thanks.  I think that patch has propagated into Dominik's git tree.

FWIW, I have a BUG on ejecting the PCMCIA CF card, followed by a NULL
pointer dereference.

The sequence was

boot 2.6.18-rc1-mm2
swsusp-to-disk, resume
insert PCMCIA/CF adapter
mount FS, read data, unmount FS
eject PCMCIA/CF adapter using eject button

resulting in

[44149.624000] pccard: card ejected from slot 0
[44149.624000] BUG: atomic counter underflow at:
[44149.624000]  [<c01ed6b1>] kref_put+0x61/0xd0
[44149.624000]  [<c01ecdff>] kobject_put+0x1f/0x30
[44149.624000]  [<c02dea1b>] klist_dec_and_del+0x1b/0x20
[44149.624000]  [<c02de980>] klist_release+0x0/0x80
[44149.624000]  [<c02dea43>] klist_remove+0x13/0x30
[44149.624000]  [<c024d634>] bus_remove_device+0x84/0xb0
[44149.624000]  [<c024beeb>] device_del+0x6b/0x180
[44149.624000]  [<c024c013>] device_unregister+0x13/0x30
[44149.624000]  [<c025529c>] ide_unregister+0x28c/0x2d0
[44149.624000]  [<c02de9d9>] klist_release+0x59/0x80
[44149.624000]  [<f8b09742>] ide_release+0x42/0x50 [ide_cs]
[44149.624000]  [<f8b09093>] ide_detach+0x13/0x30 [ide_cs]
[44149.624000]  [<f8b0f758>] pcmcia_device_remove+0xf8/0x110 [pcmcia]
[44149.624000]  [<c02de980>] klist_release+0x0/0x80
[44149.624000]  [<c024e22c>] __device_release_driver+0xac/0xc0
[44149.624000]  [<c024e25f>] device_release_driver+0x1f/0x40
[44149.624000]  [<c024d63c>] bus_remove_device+0x8c/0xb0
[44149.624000]  [<c024beeb>] device_del+0x6b/0x180
[44149.624000]  [<c024c013>] device_unregister+0x13/0x30
[44149.624000]  [<f8b0f632>] pcmcia_card_remove+0x82/0xb0 [pcmcia]
[44149.624000]  [<f8b10915>] ds_event+0x95/0xd0 [pcmcia]
[44149.624000]  [<f8a42666>] send_event+0x56/0xa0 [pcmcia_core]
[44149.624000]  [<f8a426d1>] socket_remove_drivers+0x21/0x30 [pcmcia_core]
[44149.624000]  [<f8a427d0>] socket_shutdown+0x10/0xf0 [pcmcia_core]
[44149.624000]  [<f8a42dca>] socket_detect_change+0x6a/0x80 [pcmcia_core]
[44149.624000]  [<f8a42fd8>] pccardd+0x1f8/0x200 [pcmcia_core]
[44149.624000]  [<c0116940>] default_wake_function+0x0/0x20
[44149.624000]  [<c0116940>] default_wake_function+0x0/0x20
[44149.624000]  [<f8a42de0>] pccardd+0x0/0x200 [pcmcia_core]
[44149.624000]  [<c012e467>] kthread+0xb7/0xc0
[44149.624000]  [<c012e3b0>] kthread+0x0/0xc0
[44149.624000]  [<c01013b5>] kernel_thread_helper+0x5/0x10
[44149.624000] BUG: unable to handle kernel NULL pointer dereference at virtual 
[44149.624000]  printing eip:
[44149.624000] c02df405
[44149.624000] *pde = 00000000
[44149.624000] Oops: 0002 [#1]
[44149.624000] 8K_STACKS 
[44149.624000] last sysfs file: /class/vc/vcsa12/dev
[44149.624000] Modules linked in: nls_cp437 msdos fat ide_cs af_packet ipv6 pcmc
[44149.624000] CPU:    0
[44149.624000] EIP:    0060:[<c02df405>]    Not tainted VLI
[44149.624000] EFLAGS: 00010002   (2.6.18-rc1-mm2 #1) 
[44149.624000] EIP is at wait_for_completion+0x55/0xc0
[44149.624000] eax: c0477dac   ebx: c0477da8   ecx: 00000000   edx: 00000000
[44149.624000] esi: c0477d50   edi: f7e57dcc   ebp: f7e57de8   esp: f7e57da0
[44149.624000] ds: 007b   es: 007b   ss: 0068
[44149.624000] Process pccardd (pid: 4838, ti=f7e56000 task=dfd23ab0 task.ti=f7e
[44149.624000] Stack: 00000000 dfd23ab0 c0116940 00000000 00000000 f7e57dc0 c01e
[44149.624000]        00000001 dfd23ab0 c0116940 c0477dac c0477d50 c02dea1b c047
[44149.624000]        c0477db8 c04781b0 00000001 c024d634 c0477d98 c0477d50 c047
[44149.624000] Call Trace:
[44149.624000]  [<c0116940>] default_wake_function+0x0/0x20
[44149.624000]  [<c01ed6b1>] kref_put+0x61/0xd0
[44149.624000]  [<c0116940>] default_wake_function+0x0/0x20
[44149.624000]  [<c02dea1b>] klist_dec_and_del+0x1b/0x20
[44149.624000]  [<c02de980>] klist_release+0x0/0x80
[44149.624000]  [<c024d634>] bus_remove_device+0x84/0xb0
[44149.624000]  [<c024beeb>] device_del+0x6b/0x180
[44149.624000]  [<c024c013>] device_unregister+0x13/0x30
[44149.624000]  [<c025529c>] ide_unregister+0x28c/0x2d0
[44149.624000]  [<c02de9d9>] klist_release+0x59/0x80
[44149.624000]  [<f8b09742>] ide_release+0x42/0x50 [ide_cs]
[44149.624000]  [<f8b09093>] ide_detach+0x13/0x30 [ide_cs]
[44149.624000]  [<f8b0f758>] pcmcia_device_remove+0xf8/0x110 [pcmcia]
[44149.624000]  [<c02de980>] klist_release+0x0/0x80
[44149.624000]  [<c024e22c>] __device_release_driver+0xac/0xc0
[44149.624000]  [<c024e25f>] device_release_driver+0x1f/0x40
[44149.624000]  [<c024d63c>] bus_remove_device+0x8c/0xb0
[44149.624000]  [<c024beeb>] device_del+0x6b/0x180
[44149.624000]  [<c024c013>] device_unregister+0x13/0x30
[44149.624000]  [<f8b0f632>] pcmcia_card_remove+0x82/0xb0 [pcmcia]
[44149.624000]  [<f8b10915>] ds_event+0x95/0xd0 [pcmcia]
[44149.624000]  [<f8a42666>] send_event+0x56/0xa0 [pcmcia_core]
[44149.624000]  [<f8a426d1>] socket_remove_drivers+0x21/0x30 [pcmcia_core]
[44149.624000]  [<f8a427d0>] socket_shutdown+0x10/0xf0 [pcmcia_core]
[44149.624000]  [<f8a42dca>] socket_detect_change+0x6a/0x80 [pcmcia_core]
[44149.624000]  [<f8a42fd8>] pccardd+0x1f8/0x200 [pcmcia_core]
[44149.624000]  [<c0116940>] default_wake_function+0x0/0x20
[44149.624000]  [<c0116940>] default_wake_function+0x0/0x20
[44149.624000]  [<f8a42de0>] pccardd+0x0/0x200 [pcmcia_core]
[44149.624000]  [<c012e467>] kthread+0xb7/0xc0
[44149.624000]  [<c012e3b0>] kthread+0x0/0xc0
[44149.624000]  [<c01013b5>] kernel_thread_helper+0x5/0x10
[44149.624000] Code: 8b 10 8b 45 b8 c7 45 c0 40 69 11 c0 89 55 bc 83 c8 01 89 45
[44149.624000] EIP: [<c02df405>] wait_for_completion+0x55/0xc0 SS:ESP 0068:f7e57

Complete dmesg, and just about everything else, at
http://web.hexapodia.org/~adi/bobble/bobble_2.6.18-rc1-mm2_20060720121127/

-andy
