Return-Path: <linux-kernel-owner+w=401wt.eu-S1754529AbWLYQR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529AbWLYQR7 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 11:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754538AbWLYQR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 11:17:58 -0500
Received: from javad.com ([216.122.176.236]:4438 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529AbWLYQR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 11:17:58 -0500
From: Sergei Organov <osv@javad.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: moxa serial driver testing (oopses)
References: <45222E7E.3040904@gmail.com> <87wt7hw97c.fsf@javad.com>
	<4522ABC3.2000604@gmail.com> <878xjx6xtf.fsf@javad.com>
	<4522B5C2.3050004@gmail.com> <87mz8borl2.fsf@javad.com>
	<45251211.7010604@gmail.com> <87zmcaokys.fsf@javad.com>
	<45254F61.1080502@gmail.com> <87vemyo9ck.fsf@javad.com>
	<4af2d03a0610061355p5940a538pdcbd2cda249161e8@mail.gmail.com>
	<87vemtnbyg.fsf@javad.com> <452A1862.9030502@gmail.com>
	<87r6urket6.fsf@javad.com> <552766292581216610@wsc.cz>
Date: Mon, 25 Dec 2006 19:17:32 +0300
In-Reply-To: <552766292581216610@wsc.cz> (Jiri Slaby's message of "Sat, 23
 Dec
	2006 02:35:46 +0100 (CET)")
Message-ID: <871wmoeyqr.fsf_-_@javad.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> writes:
> osv@javad.com wrote:
>> Hi Jiri,
>> 
>> I've figured out that both old and new mxser drivers have two similar
>> problems:
>> 
>> 1. When there are data coming to a port, sometimes opening of the port
>>    entirely locks the box. This is quite reproducible. Any idea what's
>>    wrong and how can I help to debug it?
>
> Could you test the patch below, if something changes?

In addition to my previous answer, fortunately I was able to log oopses
to a serial console, so below are two of them.

They seem to appear from in a few seconds to in a few minutes after I
run:

$ while true; do cat /dev/ttyM7 > /dev/null; done

when /dev/ttyM7 is setup so that 'cat' immediately returns (due to zero
timeout).

Note that unpatched version always hangs in less than a second.

First oops is taken from the kernel with lock debugging enabled:

BUG: unable to handle kernel NULL pointer dereference at virtual address 00000080
 printing eip:
f8fa5136
*pde = 00000000
Oops: 0000 [#1]
SMP 
Modules linked in: ipv6 nfs lockd nfs_acl sunrpc dm_mod sr_mod sbp2 ieee1394 ide_generic ide_disk e1000 snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd evdev mxser_new tsdev soundcore psmouse snd_page_alloc serio_raw floppy i2c_i801 parport_pc parport pcspkr i2c_core rtc ext3 jbd mbcache usb_storage sd_mod usbhid ide_cd cdrom ata_piix libata uhci_hcd scsi_mod piix generic usbcore ide_core skge thermal processor fan
CPU:    0
EIP:    0060:[<f8fa5136>]    Not tainted VLI
EFLAGS: 00010046   (2.6.18 #1) 
EIP is at mxser_stoprx+0x5a/0x7e [mxser_new]
eax: 00000000   ebx: f7a55000   ecx: f8fabc1c   edx: f76f6340
esi: c1e4651b   edi: eb466fff   ebp: f3af3de8   esp: f3af3de4
ds: 007b   es: 007b   ss: 0068
Process cc1plus (pid: 9540, ti=f3af2000 task=f4012ab0 task.ti=f3af2000)
Stack: f7a55000 f3af3df0 f8fa5162 f3af3ec0 c020aedb 000000ff c1e4641c f7a554dc 
       00000002 00000008 00000000 00000008 f4012ff0 00000001 0000017d 00000000 
       0000017d f4012ff0 00000001 0000017d 00000000 f4012ff0 0000017d 00000000 
Call Trace:
 [<c0103e2f>] show_stack_log_lvl+0x8c/0x97
 [<c0103fa6>] show_registers+0x130/0x19d
 [<c0104194>] die+0x181/0x287
 [<c0115b92>] do_page_fault+0x3ca/0x49e
 [<c01039cd>] error_code+0x39/0x40
 [<f8fa5162>] mxser_throttle+0x8/0xa [mxser_new]
 [<c020aedb>] n_tty_receive_buf+0xdce/0xdf0
 [<c02062fc>] flush_to_ldisc+0x112/0x149
 [<c0206370>] tty_flip_buffer_push+0x3d/0x53
 [<f8fa63c4>] mxser_receive_chars+0x23c/0x244 [mxser_new]
 [<f8fa6e48>] mxser_interrupt+0x14c/0x1cb [mxser_new]
 [<c014563a>] handle_IRQ_event+0x20/0x4d
 [<c01456fb>] __do_IRQ+0x94/0xef
 [<c0105342>] do_IRQ+0x4e/0x60
 [<c0103835>] common_interrupt+0x25/0x2c
Code: 83 e0 ee 89 41 3c 25 ee 00 00 00 42 eb 19 0f b6 42 1a 8b 51 08 89 41 38 31 c0 42 ee 89 d8 83 c8 02 89 41 3c 0f b6 c0 ee 8b 41 04 <8b> 80 80 00 00 00 83 78 08 00 79 15 8b 41 40 8b 51 08 83 e0 fd 
EIP: [<f8fa5136>] mxser_stoprx+0x5a/0x7e [mxser_new] SS:ESP 0068:f3af3de4
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 BUG: warning at arch/i386/kernel/smp.c:547/smp_call_function()
 [<c0103e73>] show_trace+0xd/0x10
 [<c010444c>] dump_stack+0x19/0x1b
 [<c010f600>] smp_call_function+0x55/0xfd
 [<c010f6be>] smp_send_stop+0x16/0x2a
 [<c011d885>] panic+0x4d/0xec
 [<c0104265>] die+0x252/0x287
 [<c0115b92>] do_page_fault+0x3ca/0x49e
 [<c01039cd>] error_code+0x39/0x40
 [<f8fa5162>] mxser_throttle+0x8/0xa [mxser_new]
 [<c020aedb>] n_tty_receive_buf+0xdce/0xdf0
 [<c02062fc>] flush_to_ldisc+0x112/0x149
 [<c0206370>] tty_flip_buffer_push+0x3d/0x53
 [<f8fa63c4>] mxser_receive_chars+0x23c/0x244 [mxser_new]
 [<f8fa6e48>] mxser_interrupt+0x14c/0x1cb [mxser_new]
 [<c014563a>] handle_IRQ_event+0x20/0x4d
 [<c01456fb>] __do_IRQ+0x94/0xef
 [<c0105342>] do_IRQ+0x4e/0x60
 [<c0103835>] common_interrupt+0x25/0x2c

Another oops is form kernel with lock debugging disabled:

BUG: unable to handle kernel NULL pointer dereference at virtual address 00000068
 printing eip:
f8f0911f
*pde = 00000000
Oops: 0000 [#1]
SMP 
Modules linked in: nvidia agpgart ipv6 nfs lockd nfs_acl sunrpc dm_mod sr_mod sbp2 ieee1394 ide_generic ide_disk e1000 snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm i2c_i801 psmouse snd_timer rtc parport_pc serio_raw i2c_core snd soundcore snd_page_alloc evdev pcspkr floppy parport tsdev mxser_new ext3 jbd mbcache usb_storage usbhid sd_mod ide_cd cdrom uhci_hcd ata_piix usbcore piix skge libata scsi_mod generic ide_core thermal processor fan
CPU:    0
EIP:    0060:[<f8f0911f>]    Tainted: P      VLI
EFLAGS: 00010246   (2.6.18-3-686 #1) 
EIP is at mxser_stoprx+0x54/0x74 [mxser_new]
eax: 00000000   ebx: 00000001   ecx: f8f0f79c   edx: f643a4c0
esi: efe6d51b   edi: ee75dfff   ebp: f6e2e000   esp: ec901e20
ds: 007b   es: 007b   ss: 0068
Process cc1plus (pid: 17764, ti=ec900000 task=dff41000 task.ti=ec900000)
Stack: 00000001 c01fe4af 000000ff efe6d41c f6e2e404 c02d6c68 00000000 00000001 
       ec901e64 c011669e 00000000 00000000 00000003 00000086 f6e2e00c 00000286 
       00000001 00000086 c01f97c9 00000000 f524bc00 00000286 f8f0a335 ec901ec8 
Call Trace:
 [<c01fe4af>] n_tty_receive_buf+0xcd6/0xcf9
 [<c011669e>] __wake_up+0x2a/0x3d
 [<c01f97c9>] tty_ldisc_deref+0x50/0x5f
 [<f8f0a335>] mxser_receive_chars+0x241/0x249 [mxser_new]
 [<f8f09678>] mxser_transmit_chars+0x14/0x164 [mxser_new]
 [<f8f0adab>] mxser_interrupt+0x190/0x1e6 [mxser_new]
 [<c0116412>] __activate_task+0x1c/0x29
 [<c011776e>] try_to_wake_up+0x355/0x35f
 [<c0116d0a>] find_busiest_group+0x177/0x46a
 [<c01f9d21>] flush_to_ldisc+0x104/0x15c
 [<f8f0a335>] mxser_receive_chars+0x241/0x249 [mxser_new]
 [<f8f0ad7a>] mxser_interrupt+0x15f/0x1e6 [mxser_new]
 [<c013fb83>] handle_IRQ_event+0x23/0x49
 [<c013fc3c>] __do_IRQ+0x93/0xe8
 [<c01050e5>] do_IRQ+0x43/0x52
 [<c01036b6>] common_interrupt+0x1a/0x20
Code: 83 e0 ee 89 41 3c 25 ee 00 00 00 42 eb 19 0f b6 42 1a 8b 51 08 89 41 38 31 c0 42 ee 89 d8 83 c8 02 89 41 3c 0f b6 c0 ee 8b 41 04 <8b> 40 68 83 78 08 00 79 15 8b 41 40 8b 51 08 83 e0 fd 89 41 40 
EIP: [<f8f0911f>] mxser_stoprx+0x54/0x74 [mxser_new] SS:ESP 0068:ec901e20
 <0>Kernel panic - not syncing: Fatal exception in interrupt

-- Sergei.

 
