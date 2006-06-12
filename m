Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWFLXV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWFLXV3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 19:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWFLXV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 19:21:29 -0400
Received: from rtr.ca ([64.26.128.89]:18151 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932445AbWFLXV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 19:21:28 -0400
Message-ID: <448DF6F6.2050803@rtr.ca>
Date: Mon, 12 Jun 2006 19:21:26 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb,
 error -28
References: <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD50F.3060002@rtr.ca> <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD968.2010000@rtr.ca> <20060612212812.GA17458@suse.de> <448DE28D.3040708@rtr.ca> <20060612220321.GA19792@suse.de> <448DE6EA.8020708@rtr.ca> <20060612222304.GA21459@suse.de> <448DF59D.3050606@rtr.ca>
In-Reply-To: <448DF59D.3050606@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Greg KH wrote:
>> So we should have finally covered both of them now.
> 
> Yes, agreed.
> 
> So if modify pl2303_open() to have it simulate -ENOMEM from 
> usb_submit_urb(),
> then this should not crash the entire USB subsystem.  Right?
> 
> Ditto if it happens due to low-memory, rather than me hacking the code 
> to test it?

Mmmm.. looks like it's still buggy, but we manage to avoid the bug
under *most* circumstances.   Which is good!

But the bug will still need to be fixed.  A failure from usb_submit_urb()
should not require a reboot to recover.
Here's the results of a simulated -ENOMEM test:

kernel BUG at kernel/workqueue.c:110!
invalid opcode: 0000 [#1]
PREEMPT
Modules linked in: pl2303 mct_u232 usblp usbserial usbhid snd_pcm_oss uhci_hcd ehci_hcd vmnet vmmon nfsd exportfs lockd nfs_acl sunrpc speedstep_centrino cpufreq_conservative cpufreq_stats cpufreq_userspace cpufreq_powersave freq_table cpufreq_ondemand thermal fan battery ac processor container video button rfcomm l2cap bluetooth cfq_iosched deflate zlib_deflate twofish serpent aes blowfish des sha256 sha1 crypto_null af_key af_packet sbp2 pcmcia ipw2200 ieee80211 ieee80211_crypt snd_intel8x0 snd_ac97_codec snd_ac97_bus yenta_socket ohci1394 ieee1394 snd_mixer_oss mousedev rsrc_nonstatic pcmcia_core mmc_core b44 mii firmware_class snd_pcm snd_timer snd soundcore serio_raw pcspkr snd_page_alloc psmouse intel_agp agpgart usbcore sg sr_mod cdrom unix
CPU:    0
EIP:    0060:[queue_work+81/96]    Tainted: P      VLI
EFLAGS: 00010286   (2.6.17-rc6-git2 #3)
EIP is at queue_work+0x51/0x60
eax: f317093c   ebx: 00000000   ecx: b21b9f80   edx: f3170938
esi: f4782640   edi: f4782640   ebp: f7333414   esp: f7cc3e4c
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 1737, threadinfo=f7cc2000 task=b21bb070)
Stack: 00000000 f8a30d63 b01ca38f b02e136b f8884ad3 f7333400 f8c52080 f8c520a4
       f7333414 f88867f2 f733347c f7333414 b022240f f7333414 f7333414 f889bae0
       b02226a6 f7333414 b0221c87 f7333414 f7519c58 00000001 b0220e35 f7333400
Call Trace:
 <f8a30d63> usb_serial_disconnect+0x53/0xd0 [usbserial]  <b01ca38f> kref_put+0x2f/0x80
 <f8884ad3> usb_disable_interface+0x53/0x70 [usbcore]  <f88867f2> usb_unbind_interface+0x32/0x70 [usbcore]
 <b022240f> __device_release_driver+0x5f/0xc0  <b02226a6> device_release_driver+0x16/0x30
 <b0221c87> bus_remove_device+0x77/0x90  <b0220e35> device_del+0x35/0x70
 <f8885733> usb_disable_device+0xb3/0x100 [usbcore]  <f887f404> usb_disconnect+0x94/0x100 [usbcore]
 <f887f3f2> usb_disconnect+0x82/0x100 [usbcore]  <f887f3f2> usb_disconnect+0x82/0x100 [usbcore]
 <f8881c1e> hub_thread+0x3be/0xc75 [usbcore]  <b012efc0> autoremove_wake_function+0x0/0x50
 <b02b6d9f> preempt_schedule+0x4f/0x70  <b012eed6> kthread+0xd6/0xe0
 <f8881860> hub_thread+0x0/0xc75 [usbcore]  <b012ee00> kthread+0x0/0xe0
 <b0101005> kernel_thread_helper+0x5/0x10
Code: a8 08 75 1c 89 d8 5b c3 89 f6 8d 42 04 3b 42 04 75 19 8b 01 bb 01 00 00 00 e8 dc fa ff ff eb d3 e8 85 ae 18 00 89 d8 5b 89 f6 c3 <0f> 0b 6e 00 d1 de 2c b0 eb dd 90 8d 74 26 00 89 c2 a1 d4 d1 38
EIP: [queue_work+81/96] queue_work+0x51/0x60 SS:ESP 0068:f7cc3e4c
 <6>note: khubd[1737] exited with preempt_count 1
