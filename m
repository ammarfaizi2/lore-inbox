Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUJETlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUJETlg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUJETlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:41:31 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:57866 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S266463AbUJETkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:40:00 -0400
Message-ID: <32787.192.168.1.5.1097005084.squirrel@192.168.1.5>
In-Reply-To: <20041005184226.GA10318@elte.hu>
References: <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>
    <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>
    <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu>
    <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu>
    <20041005134707.GA32033@elte.hu>
    <32799.192.168.1.5.1096994246.squirrel@192.168.1.5>
    <20041005184226.GA10318@elte.hu>
Date: Tue, 5 Oct 2004 20:38:04 +0100 (WEST)
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm2-T1
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>, "Florian Schmidt" <mista.tapas@gmx.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 05 Oct 2004 19:39:55.0790 (UTC) FILETIME=[175CC2E0:01C4AB13]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> * Rui Nuno Capela wrote:
>
>> Still the same ugliness here with T1. As before, there goes some info
>> attached, which I could collect while barely up and running.
>
> the dmesg info shows you had a crash early on, in khubd:
>
>  Badness in remove_proc_entry at fs/proc/generic.c:688
>   [<c018c8e8>] remove_proc_entry+0x152/0x15a
>   [<f8b8e116>] uhci_hcd_init+0x116/0x133 [uhci_hcd]
>   [<c0135f0e>] sys_init_module+0x1df/0x2da
>   [<c01044ed>] sysenter_past_esp+0x52/0x71
>  usb 3-1: new low speed USB device using address 2
>  Unable to handle kernel paging request at virtual address a49c0e0c
>
> i believe this is a crash present in -mm too. In theory such a crash
> could mess up the kernel so best would be if you could try a kernel with
> USB disabled? Hopefully none of your critical devices is on USB ...
>

Yeah, I've found it the hard way :) One of my trials discovered just that,
by booting without any USB devices plugged in. It booted apparently fine.

Then, exacltly when I plug in my USB mouse (Wacom Graphire2 tablet), I
immediately get the following kernel oops (on dmesg):

IRQ#23 thread started up.
IRQ#19 thread started up.
usb 2-1: new low speed USB device using address 2
Unable to handle kernel paging request at virtual address aaf7ee8f
 printing eip:
c014284b
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: mga ohci1394 ieee1394 ehci_hcd uhci_hcd intel_mch_agp
agpgart snd_usb_usx2y snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep
snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc
evdev sk98lin realtime commoncap w83781d i2c_sensor i2c_isa i2c_i801
i2c_core wacom usbcore subfs dm_mod
CPU:    1
EIP:    0060:[<c014284b>]    Not tainted VLI
EFLAGS: 00010093   (2.6.9-rc3-mm2-T1.0smp)
EIP is at check_poison_obj+0x98/0x1d0
eax: 0000006b   ebx: f6e8a780   ecx: f6d254b8   edx: ffffffa5
esi: 00000000   edi: aaf7ee8f   ebp: f74d3d10   esp: f74d3ce8
ds: 007b   es: 007b   ss: 0068   preempt: 00000002
Process khubd (pid: 1306, threadinfo=f74d3000 task=f7df2a40)
Stack: f6e8a780 f74d3cfc c0130ce3 0000002b c0144658 00000000 0000002c
f6e8a780
       aaf7ee8b f6e8a780 f74d3d34 c01442f5 f6e8a780 aaf7ee8b f6d254b8
f6d254b8
       f6e8a780 00000046 00000020 f74d3d58 c0144658 f6e8a780 00000020
aaf7ee8b
Call Trace:
 [<c0130ce3>] __mcount+0x1d/0x1f
 [<c0144658>] kmem_cache_alloc+0x6b/0xa5
 [<c01442f5>] cache_alloc_debugcheck_after+0x129/0x162
 [<c0144658>] kmem_cache_alloc+0x6b/0xa5
 [<f8c35ff9>] uhci_alloc_urb_priv+0x26/0x81 [uhci_hcd]
 [<f8c35ff9>] uhci_alloc_urb_priv+0x26/0x81 [uhci_hcd]
 [<f8c36fbb>] uhci_urb_enqueue+0x5d/0x2bc [uhci_hcd]
 [<c0110350>] mcount+0x14/0x18
 [<f8b424f4>] hcd_submit_urb+0x127/0x194 [usbcore]
 [<f8b42e38>] usb_submit_urb+0x1e2/0x244 [usbcore]
 [<f8b430c7>] usb_start_wait_urb+0xe/0xe2 [usbcore]
 [<f8b4310c>] usb_start_wait_urb+0x53/0xe2 [usbcore]
 [<c0130ce3>] __mcount+0x1d/0x1f
 [<c01ea660>] kref_init+0x8/0x13
 [<f8b42ba8>] usb_init_urb+0x27/0x3c [usbcore]
 [<c0110350>] mcount+0x14/0x18
 [<f8b42bef>] usb_alloc_urb+0x32/0x52 [usbcore]
 [<f8b43215>] usb_internal_control_msg+0x7a/0x83 [usbcore]
 [<f8b432aa>] usb_control_msg+0x8c/0xa0 [usbcore]
 [<f8b3fe23>] hub_set_address+0x6d/0x90 [usbcore]
 [<f8b3fff7>] hub_port_init+0x1b1/0x39a [usbcore]
 [<f8b404d9>] hub_port_connect_change+0xfe/0x43a [usbcore]
 [<f8b409d3>] hub_events+0x1be/0x395 [usbcore]
 [<f8b40be1>] hub_thread+0x37/0x109 [usbcore]
 [<c0130845>] autoremove_wake_function+0x0/0x50
 [<c0104416>] ret_from_fork+0x6/0x14
 [<c0130845>] autoremove_wake_function+0x0/0x50
 [<f8b40baa>] hub_thread+0x0/0x109 [usbcore]
 [<c0102601>] kernel_thread_helper+0x5/0xb
Code: 89 44 24 08 e8 09 fe ff ff 83 45 ec 01 83 7d ec 05 7f 5b 83 c6 01 3b
75 f0 7d 53 3b 75 e4 b8 6b 00 00 00 ba a5 ff ff ff 0f 44 c2 <38> 04 3e 2e
74 e2 8b 45 ec 85 c0 75 a0 8b 55 f0 89 7c 24 04 c7
 <6>note: khubd[1306] exited with preempt_count 1


Guess what? It's right after this crash that ksoftirqd/1 pulls up to
99.99%CPU#1 and stays still on that figure, forever. Of course, as Ingo
noted, this was happening behind the scenes every time I was boot/initing.

OTOH, I've tested T1 with CONFIG_SCHED_SMT and/or CONFIG_SMP not set, and
got similar crashes too. So this seems to be some nasty bug introduced by
-mm{1,2}, not by VP on SMP/SMT.

Yes, I do have some critical USB devices around here. One is that wacom
tablet (mouse) and the other is a tascam us-224 audio/midi control surface
that a love very much :)

Don't know if this makes me feeling better, doh.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

