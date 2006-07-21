Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWGUS3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWGUS3h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 14:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWGUS3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 14:29:37 -0400
Received: from mail1.cenara.com ([193.111.152.3]:31696 "EHLO
	kingpin.cenara.com") by vger.kernel.org with ESMTP id S1751095AbWGUS3g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 14:29:36 -0400
From: Magnus =?iso-8859-1?q?Vigerl=F6f?= <wigge@bigfoot.com>
Subject: input: Oops when unplugging opened Wacom USB device
Date: Fri, 21 Jul 2006 20:29:23 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org,
       Magnus =?iso-8859-1?q?Vigerl=F6f?= <wigge@bigfoot.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200607212029.23617.wigge@bigfoot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

9 times out of 10 I get an oops whenever I unplug my Wacom tablet
when X has it opened, always on the same spot. If only other programs
has it opened it works fine. The oops at the end is from an older
kernel but the same happends with 2.6.17.5 as well.

Making the following change to evdev.c reduced the oopses I got
significantly. Since this helped a bit but not all the way and the
lack of locks/mutexes in this part of the code I suspect a
race-condition.

--- linux-2.6.17.5/drivers/input/evdev.c.orig	2006-07-20 19:14:58.000000000 +0200
+++ linux-2.6.17.5/drivers/input/evdev.c	2006-07-20 19:15:13.000000000 +0200
@@ -668,9 +668,9 @@ static void evdev_disconnect(struct inpu
 
 	if (evdev->open) {
 		input_close_device(handle);
-		wake_up_interruptible(&evdev->wait);
 		list_for_each_entry(list, &evdev->list, node)
 			kill_fasync(&list->fasync, SIGIO, POLL_HUP);
+		wake_up_interruptible(&evdev->wait);
 	} else
 		evdev_free(evdev);
 }

Does somebody knows the reason for the lack of locking in this part
of the code? The code is similar and the problems may be the same
in joydev.c and tsdev.c as well.

Thanks
  Magnus


usb 2-1: USB disconnect, address 2
Unable to handle kernel paging request at virtual address 00100100
 printing eip:
e0c6539f
*pde = 0e662067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: binfmt_misc rfcomm l2cap bluetooth xt_tcpudp xt_state 
ipt_REJECT xt_limit ipt_LOG ip_conntrack_irc ip_conntrack_ftp ip_conntrack 
nfnetlink iptable_filter ip_tables x_tables thermal processor fan button 
battery ac dm_mod md_mod tabletsdev usbhid wacom tsdev joydev b44 sworks_agp 
amd_k7_agp ali_agp sbp2 mii ohci1394 yenta_socket rsrc_nonstatic pcmcia 
firmware_class pcmcia_core sis_agp snd_intel8x0 snd_ac97_codec snd_ac97_bus 
snd_pcm_oss ati_agp psmouse serio_raw evdev uhci_hcd snd_mixer_oss snd_pcm 
snd_timer nvidia_agp via_agp pcspkr rtc snd soundcore snd_page_alloc 
intel_agp agpgart shpchp pci_hotplug
CPU:    0
EIP:    0060:[<e0c6539f>]    Not tainted VLI
EFLAGS: 00210292   (2.6.16.4 #1)
EIP is at evdev_disconnect+0x84/0xa9 [evdev]
eax: 00000000   ebx: 000ffcf0   ecx: cfe5c000   edx: c1558000
esi: dee4e9c0   edi: df782800   ebp: dee4e978   esp: c1559e94
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 108, threadinfo=c1558000 task=c15b3a90)
Stack: <0>dee4e9dc dee4e978 c02ed09e dee4e9dc dee4eb40 def25800 e0d49de4 
def25814
       e0d47068 df782800 dee4eac0 def25800 e0d49dc0 c02d6d99 def25800 def2587c
       def25814 c027d739 def25814 def25814 00000000 c03efa80 c027d8fb def25814
Call Trace:
 [<c02ed09e>] input_unregister_device+0x55/0xe1
 [<e0d47068>] wacom_disconnect+0x2d/0x59 [wacom]
 [<c02d6d99>] usb_unbind_interface+0x36/0x6f
 [<c027d739>] __device_release_driver+0x55/0x6b
 [<c027d8fb>] device_release_driver+0x18/0x26
 [<c027d19d>] bus_remove_device+0x74/0x8c
 [<c027c62c>] device_del+0x39/0x65
 [<c02d60d4>] usb_disable_device+0x6a/0xd4
 [<c02d233c>] usb_disconnect+0x7c/0xe2
 [<c02d30a5>] hub_thread+0x37a/0xa42
 [<c011000a>] io_apic_set_pci_routing+0x1d1/0x293
 [<c01263bc>] autoremove_wake_function+0x0/0x3a
 [<c012634c>] kthread+0x96/0xd7
 [<c02d2d2b>] hub_thread+0x0/0xa42
 [<c0126360>] kthread+0xaa/0xd7
 [<c01262b6>] kthread+0x0/0xd7
 [<c0101005>] kernel_thread_helper+0x5/0xb
Code: 81 eb 10 04 00 00 5a eb 22 8d 83 08 04 00 00 68 06 00 02 00 6a 1d 50 e8 
9f 11 50 df 8b 9b 10 04 00 00 81 eb 10 04 00 00 83 c4 0c <8b> 83 10 04 00 00 
0f 18 00 90 8d 93 10 04 00 00 8d 46 4c 39 c2
