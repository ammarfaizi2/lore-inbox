Return-Path: <linux-kernel-owner+w=401wt.eu-S932825AbWL0OBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825AbWL0OBM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 09:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932831AbWL0OBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 09:01:12 -0500
Received: from javad.com ([216.122.176.236]:1861 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932825AbWL0OBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 09:01:10 -0500
From: Sergei Organov <osv@javad.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: moxa serial driver testing
References: <45222E7E.3040904@gmail.com> <87wt7hw97c.fsf@javad.com>
	<4522ABC3.2000604@gmail.com> <878xjx6xtf.fsf@javad.com>
	<4522B5C2.3050004@gmail.com> <87mz8borl2.fsf@javad.com>
	<45251211.7010604@gmail.com> <87zmcaokys.fsf@javad.com>
	<45254F61.1080502@gmail.com> <87vemyo9ck.fsf@javad.com>
	<4af2d03a0610061355p5940a538pdcbd2cda249161e8@mail.gmail.com>
	<87vemtnbyg.fsf@javad.com> <452A1862.9030502@gmail.com>
	<87r6urket6.fsf@javad.com> <552766292581216610@wsc.cz>
	<552766292581216610@wsc.cz> <554564654653216610@wsc.cz>
Date: Wed, 27 Dec 2006 17:00:57 +0300
In-Reply-To: <554564654653216610@wsc.cz> (Jiri Slaby's message of "Wed, 27
 Dec
	2006 14:36:56 +0100 (CET)")
Message-ID: <871wml4ew6.fsf@javad.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> writes:

>> Jiri Slaby <jirislaby@gmail.com> writes:
>> 
>> > Could you test the patch below, if something changes?
>> 
>> Just tested with low_latency commented out. Still oopses:
>> 
>> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000008
>>  printing eip:
>> f8f1730f
>> *pde = 00000000
>> Oops: 0000 [#1]
>> SMP 
>> Modules linked in: nvidia agpgart ipv6 nfs lockd nfs_acl sunrpc dm_mod sr_mod sbp2 ieee1394 ide_generic ide_disk e1000 snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer i2c_i801 tsdev psmouse snd soundcore snd_page_alloc i2c_core serio_raw parport_pc parport mxser_new evdev floppy pcspkr rtc ext3 jbd mbcache usb_storage usbhid ide_cd cdrom sd_mod uhci_hcd piix usbcore skge ata_piix libata scsi_mod generic ide_core thermal processor fan
>> CPU:    0
>> EIP:    0060:[<f8f1730f>]    Tainted: P      VLI
>> EFLAGS: 00010046   (2.6.18-3-686 #1) 
>> EIP is at mxser_receive_chars+0x21b/0x249 [mxser_new]
>
> Yes, port->tty still somewhere becomes NULL -- does this patch help?

No, it still oopses (the oops is at the end).

In addition, before this latest patch was applied, when playing with two
simultaneously run programs that do nothing but open/close the port in a
loop (and the port was idle, i.e., nothing came to it from outside),
I've once got this thing:

irq 58: nobody cared (try booting with the "irqpoll" option)
 [<c014037f>] __report_bad_irq+0x2b/0x69
 [<c014056c>] note_interrupt+0x1af/0x1e7
 [<c013fb83>] handle_IRQ_event+0x23/0x49
 [<c013fc5c>] __do_IRQ+0xb3/0xe8
 [<c01050e5>] do_IRQ+0x43/0x52
 [<c01036b6>] common_interrupt+0x1a/0x20
 [<c011007b>] __cpu_up+0x88/0x164
 [<c02810a0>] _spin_unlock_irqrestore+0x8/0x9
 [<f8f8bf57>] mxser_startup+0x177/0x190 [mxser_new]
 [<f8f8c3da>] mxser_open+0x6b/0x251 [mxser_new]
 [<c01fcafd>] tty_open+0x16a/0x2e8
 [<c01619a1>] chrdev_open+0x126/0x141
 [<c016187b>] chrdev_open+0x0/0x141
 [<c0158cb1>] __dentry_open+0xc8/0x1ac
 [<c0158df9>] nameidata_to_filp+0x19/0x28
 [<c0158e33>] do_filp_open+0x2b/0x31
 [<c0158e77>] do_sys_open+0x3e/0xb3
 [<c0158f19>] sys_open+0x16/0x18
 [<c0102c11>] sysenter_past_esp+0x56/0x79
handlers:
[<f8f8cc1b>] (mxser_interrupt+0x0/0x1e6 [mxser_new])
Disabling IRQ #58

Another thing that I've noticed, is that when two programs that
open/close a port in a loop run simultaneously, each of them begin to
sometimes fail to open the port with errno=5 (I/O Errror). Though this
thing happends even if I try to use /dev/ttyS0, so it is not
mxser-specific (/dev/null never fails).

Here is the oops I promised at the beginning:

BUG: unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
f927630f
*pde = 00000000
Oops: 0000 [#1]
SMP 
Modules linked in: mxser_new nvidia agpgart ipv6 nfs lockd nfs_acl sunrpc dm_mod sr_mod sbp2 ieee1394 ide_generic ide_disk e1000 snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm psmouse snd_timer i2c_i801 snd serio_raw i2c_core tsdev parport_pc parport pcspkr evdev rtc soundcore snd_page_alloc floppy ext3 jbd mbcache sd_mod usb_storage usbhid ide_cd cdrom ata_piix libata scsi_mod uhci_hcd piix generic skge usbcore ide_core thermal processor fan
CPU:    0
EIP:    0060:[<f927630f>]    Tainted: P      VLI
EFLAGS: 00010046   (2.6.18-3-686 #1) 
EIP is at mxser_receive_chars+0x21b/0x249 [mxser_new]
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000286
esi: f927b79c   edi: 00000001   ebp: c1991800   esp: c0313efc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, ti=c0312000 task=c02c76a0 task.ti=c0312000)
Stack: c0313f48 f927b8a8 0000903a 00000000 00000fff 000000ff 00000286 0000007b 
       f927b79c 00000006 0000007f 000000c6 f9276d7a 00000007 00000008 00000080 
       00000000 00000000 f927adc0 00000060 dfc74980 00000000 00000000 0000003a 
Call Trace:
 [<f9276d7a>] mxser_interrupt+0x15f/0x1e6 [mxser_new]
 [<c013fb83>] handle_IRQ_event+0x23/0x49
 [<c013fc3c>] __do_IRQ+0x93/0xe8
 [<c01050e5>] do_IRQ+0x43/0x52
 [<c01036b6>] common_interrupt+0x1a/0x20
 [<c0101b91>] mwait_idle+0x25/0x38
 [<c0101b52>] cpu_idle+0x9f/0xb9
 [<c03186fd>] start_kernel+0x379/0x380
Code: ed ff ff eb 1f 8b 06 83 78 18 00 75 17 8b 56 08 83 c2 05 ec 8b 14 24 0f b6 c0 a8 01 89 02 0f 85 d4 fe ff ff 8b 46 04 8b 54 24 18 <8b> 40 08 01 3c 85 c4 dc 27 f9 8b 44 24 04 01 be f4 00 00 00 01 
EIP: [<f927630f>] mxser_receive_chars+0x21b/0x249 [mxser_new] SS:ESP 0068:c0313efc
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 BUG: warning at arch/i386/kernel/smp.c:547/smp_call_function()
 [<c010f5a3>] smp_call_function+0x53/0xfe
 [<c011d97e>] printk+0x14/0x18
 [<c010f661>] smp_send_stop+0x13/0x1c
 [<c011cfc6>] panic+0x4c/0xe2
 [<c0104013>] die+0x256/0x28a
 [<c01156e0>] do_page_fault+0x3b4/0x481
 [<c01f9f8d>] tty_buffer_request_room+0x107/0x112
 [<c011532c>] do_page_fault+0x0/0x481
 [<c01037f9>] error_code+0x39/0x40
 [<f927630f>] mxser_receive_chars+0x21b/0x249 [mxser_new]
 [<f9276d7a>] mxser_interrupt+0x15f/0x1e6 [mxser_new]
 [<c013fb83>] handle_IRQ_event+0x23/0x49
 [<c013fc3c>] __do_IRQ+0x93/0xe8
 [<c01050e5>] do_IRQ+0x43/0x52
 [<c01036b6>] common_interrupt+0x1a/0x20
 [<c0101b91>] mwait_idle+0x25/0x38
 [<c0101b52>] cpu_idle+0x9f/0xb9
 [<c03186fd>] start_kernel+0x379/0x380
