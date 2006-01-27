Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbWA0UnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWA0UnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbWA0UnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:43:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44246 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161021AbWA0UnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:43:22 -0500
Date: Fri, 27 Jan 2006 15:43:15 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Make software suspend work with CONFIG_MEMORY_HOTPLUG=n
Message-ID: <20060127204315.GA30447@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=178339

pageset_cpuup_callback() is marked __meminit, but software suspend
needs it.  Unfortunatly, if you don't have CONFIG_MEMORY_HOTPLUG set,
the __meminit translates to __init, resulting in this...

Freezing cpus ...
int3: 0000 [1] SMP
last sysfs file: /power/state
CPU 0
Modules linked in: radeon drm ipv6 ppdev autofs4 rfcomm l2cap sunrpc
ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp
iptable_filter ip_tables x_tables video battery ac lp parport_pc parport nvram
hci_usb bluetooth ehci_hcd ohci1394 ieee1394 uhci_hcd snd_hda_intel saa7134
snd_hda_codec video_buf snd_seq_dummy compat_ioctl32 v4l2_common v4l1_compat
snd_seq_oss snd_seq_midi_event ir_kbd_i2c snd_seq e100 snd_seq_device ir_common
snd_pcm_oss snd_mixer_oss mii videodev snd_pcm snd_timer snd i2c_i801 hw_random
soundcore i2c_core snd_page_alloc dm_snapshot dm_zero dm_mirror dm_mod ext3 jbd
ahci libata sd_mod scsi_mod
Pid: 3373, comm: pm-suspend Not tainted 2.6.15-1.1872_FC5 #1
RIP: 0010:[<ffffffff80558435>] <ffffffff80558435>{pageset_cpuup_callback+1}
RSP: 0018:ffff81002802fdb0  EFLAGS: 00000286
RAX: 0000000000000001 RBX: ffffffff803c8560 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000005 RDI: ffffffff803c8560
RBP: 0000000000000001 R08: ffffffff8053cae8 R09: 0000000000000004
R10: 0000000000000002 R11: 0000000000000004 R12: 0000000000000005
R13: 0000000000000003 R14: 0000000000000003 R15: ffff81002802ff50
FS:  00002aee15c8cd30(0000) GS:ffffffff8051a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aee19023000 CR3: 00000000292a1000 CR4: 00000000000006e0
Process pm-suspend (pid: 3373, threadinfo ffff81002802e000, task
+ffff810026b38040)
Stack: ffffffff80341296 0000000000000001 0000000000000001 0000000000000003
       ffffffff8014b803 ffff81002802fe38 ffffffff80146641 0000000000000296
       0000000000000296 0000000000000000
Call Trace: <ffffffff80341296>{notifier_call_chain+28}
       <ffffffff8014b803>{cpu_down+96} <ffffffff80146641>{remove_wait_queue+17}
       <ffffffff80255149>{vt_waitactive+150}
<ffffffff801535e3>{disable_nonboot_cpus+82}
       <ffffffff80150625>{enter_state+161} <ffffffff80150825>{state_store+113}
       <ffffffff801bf5c3>{sysfs_write_file+201}
+<ffffffff80180d38>{vfs_write+206}
       <ffffffff801812ea>{sys_write+69} <ffffffff8010a906>{system_call+126}

Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc


Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15.noarch/mm/page_alloc.c~	2006-01-27 15:40:35.000000000 -0500
+++ linux-2.6.15.noarch/mm/page_alloc.c	2006-01-27 15:40:40.000000000 -0500
@@ -1939,7 +1939,7 @@ static inline void free_zone_pagesets(in
 	}
 }
 
-static int __meminit pageset_cpuup_callback(struct notifier_block *nfb,
+static int pageset_cpuup_callback(struct notifier_block *nfb,
 		unsigned long action,
 		void *hcpu)
 {
