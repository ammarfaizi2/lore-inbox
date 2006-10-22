Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWJVDLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWJVDLz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 23:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWJVDLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 23:11:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4764 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751766AbWJVDLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 23:11:54 -0400
Date: Sat, 21 Oct 2006 23:11:45 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Luca Risolia <luca.risolia@studio.unibo.it>
Subject: sn9c10x list corruption in 2.6.18.1
Message-ID: <20061022031145.GA24855@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Luca Risolia <luca.risolia@studio.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a bizarre oops that one of our FC5 users filed since I pushed
out a 2.6.18.1 based kernel update.
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=198869

When the user unplugs the camera, the following oops occurs..

Linux video capture interface: v2.00
sn9c102: V4L2 driver for SN9C10x PC Camera Controllers v1:1.27
usb 2-2: SN9C10[12] PC Camera Controller detected (vid/pid 0x0C45/0x6005)
usb 2-2: TAS5110C1B image sensor detected
usb 2-2: Initialization succeeded
usb 2-2: V4L2 device registered as /dev/video0
usbcore: registered new driver sn9c102
usb 2-2: USB disconnect, address 2
usb 2-2: Disconnecting SN9C10x PC Camera...
usb 2-2: V4L2 device /dev/video0 deregistered
list_add corruption. next->prev should be df7cb7c8, but was 00200200
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:26!
invalid opcode: 0000 [#1]
last sysfs file: /class/net/eth0/carrier
Modules linked in: sn9c102 videodev v4l1_compat v4l2_common i915 drm autofs4 p4_clockmod dm_mirror dm_mod video sbs i2c_ec container button battery asus_acpi ac ipv6 lp parport_pc parport ohci1394 ieee1394 ehci_hcd uhci_hcd joydev snd_intel8x0m natsemi serio_raw snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd i2c_i801 soundcore i2c_i810 i2c_algo_bit i2c_core snd_page_alloc ide_cd pcspkr cdrom ext3 jbd
CPU:    0
EIP:    0060:[<c04d8cfb>]    Not tainted VLI
EFLAGS: 00010096   (2.6.18-1.2200.fc5 #1) 
EIP is at __list_add+0x27/0x62
eax: 00000048   ebx: de4daba0   ecx: c0665450   edx: c9048000
esi: df7cb7c8   edi: de4daba0   ebp: df7cb840   esp: c9048ea4
ds: 007b   es: 007b   ss: 0068
Process udevd (pid: 2225, ti=c9048000 task=c90ded70 task.ti=c9048000)
Stack: c0628352 df7cb7c8 00200200 00000000 de4daba0 0000000b c045d8a5 00000001 
       000000d0 df7cfec0 df7cb7c0 00000000 df7cb7c0 00000010 000000d0 00000001 
       de4dabbc 00000246 000000d0 df7cfec0 caa4c750 c045d766 c906b0c0 c906bcb4 
Call Trace:
 [<c045d8a5>] cache_alloc_refill+0x135/0x409
 [<c045d766>] kmem_cache_alloc+0x45/0x4f
 [<c0419e12>] mm_init+0x94/0xb9
 [<c041a93a>] copy_process+0x96c/0x10f1
 [<c041b110>] do_fork+0x51/0x125
 [<c0401220>] sys_clone+0x36/0x3b
 [<c0402d9b>] syscall_call+0x7/0xb
DWARF2 unwinder stuck at syscall_call+0x7/0xb
Leftover inexact backtrace:
 =======================
Code: c4 0c 5b c3 57 89 c7 56 89 d6 53 89 cb 83 ec 0c 8b 41 04 39 d0 74 1c 89 54 24 04 89 44 24 08 c7 04 24 52 83 62 c0 e8 ae 3a f4 ff <0f> 0b 1a 00 04 83 62 c0 8b 06 39 d8 74 1c 89 5c 24 04 89 44 24 
Oct 21 20:11:32 localhost kernel: EIP: [<c04d8cfb>] __list_add+0x27/0x62 SS:ESP 0068:c9048ea4


What's odd here is that we have a list entry still on a list, with its ->next set to
LIST_POISON2, which should only ever happen after an entry has been removed from
a list.  The list manipulation in cache_alloc_refill is all done under l3->list_lock,
so I'm puzzled how this is possible.

I found one area in the driver where we do list manipulation without any locking,
but I'm not entirely convinced that this is the source of the bug yet.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.18.noarch/drivers/media/video/sn9c102/sn9c102_core.c~	2006-10-21 22:57:32.000000000 -0400
+++ linux-2.6.18.noarch/drivers/media/video/sn9c102/sn9c102_core.c	2006-10-21 22:58:43.000000000 -0400
@@ -197,13 +197,16 @@ static void sn9c102_empty_framequeues(st
 static void sn9c102_requeue_outqueue(struct sn9c102_device* cam)
 {
 	struct sn9c102_frame_t *i;
+	unsigned long lock_flags;
 
+	spin_lock_irqsave(&cam->queue_lock, lock_flags);
 	list_for_each_entry(i, &cam->outqueue, frame) {
 		i->state = F_QUEUED;
 		list_add(&i->frame, &cam->inqueue);
 	}
 
 	INIT_LIST_HEAD(&cam->outqueue);
+	spin_unlock_irqrestore(&cam->queue_lock, lock_flags);
 }
 
 
-- 
http://www.codemonkey.org.uk
