Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263101AbVHETdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbVHETdy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbVHETb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:31:56 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:28408 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S263100AbVHETaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:30:39 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Fri, 5 Aug 2005 21:30:31 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Michael Stenzel <m.stenzel@tronix.homelinux.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] module ns558
Message-ID: <20050805193031.GA17969@localhost.localdomain>
References: <200508052052.42128.m.stenzel@tronix.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508052052.42128.m.stenzel@tronix.homelinux.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 08:52:41PM +0200 Michael Stenzel wrote:

> Hello dear Kernel People,
> 
> I have a problem with my gameport, it uses the ns558 driver, the module gets 
> loaded via hotplug/udev at boot, but the gameport gets deactivated somehow.
> I have this Problem for a long time now, and my solution always was rmmod the 
> module and load it again after that the gameport is working.
> But now i have 2.6.13-rc5 with debug stuff turned on and noticed that:
>

Please take this up with the input guys, I'm guessing it shouldn't
happen in the first place, but regarding this bug look at the bottom.

> Unable to handle kernel paging request at virtual address 6b6b6b6b
>  printing eip:
> e0afc4ab
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in: snd_seq_midi snd_seq_midi_event snd_seq video_buf_dvb 
> video_buf w83627hf w83781d i2c_sensor i2c_isa snd_pcm_oss snd_mixer_oss 
> ipt_MASQUERADE ipt_state iptable_mangle iptable_nat iptable_filter 
> ip_conntrack_ftp ip_conntrack_irc ip_conntrack ip_tables rtc joydev analog 
> ns558 budget s5h1420 l64781 ves1820 budget_core saa7146 ttpci_eeprom stv0299 
> tda8083 ves1x93 dvb_core 8139too snd_via82xx gameport snd_mpu401_uart 
> snd_rawmidi snd_seq_device via_rhine crc32 ide_scsi
> CPU:    0
> EIP:    0060:[<e0afc4ab>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.13-rc5-debug)
> EIP is at ns558_exit+0x4b/0x79 [ns558]
> eax: 6b6b6b57   ebx: 6b6b6b57   ecx: 00000000   edx: 6b6b6b6b
> esi: 00000000   edi: 00000002   ebp: d7cfdf60   esp: d7cfdf5c
> ds: 007b   es: 007b   ss: 0068
> Process rmmod (pid: 3267, threadinfo=d7cfc000 task=dfc94080)
> Stack: e0afd140 d7cfdfb4 c0146b4d 00000000 3535736e d7cf0038 c0169941 b7f43000
>        b7f42000 d7cfdfa4 c0169de5 b7f42000 b7f43000 df6a6f44 df6a61fc df17d3a4
>        df17d3d4 00000000 00cfdfb4 c0169e6a bf856ae0 b7f2917c d7cfc000 c0103889
> Call Trace:
>  [<c010483a>] show_stack+0x7a/0x90
>  [<c01049c6>] show_registers+0x156/0x1c0
>  [<c0104c1c>] die+0x14c/0x2c0
>  [<c0118093>] do_page_fault+0x343/0x655
>  [<c010430f>] error_code+0x4f/0x54
>  [<c0146b4d>] sys_delete_module+0x14d/0x190
>  [<c0103889>] syscall_call+0x7/0xb
> Code: 8b 43 10 e8 98 65 de ff 8b 4b 08 b8 a0 2f 46 c0 89 ca f7 da 23 53 04 e8 
> 64 c7 62 df 89 d8 e8 5d 01 66 df 8b 53 14 8d 42 ec 89 c3 <8b> 40 14 0f 18 00 
> 90 81 fa 20 cf af e0 75 c6 8b 1d c0 d2 af e0
> 

Please try this:

Index: linux-2.6/drivers/input/gameport/ns558.c
===================================================================
--- linux-2.6.orig/drivers/input/gameport/ns558.c	2005-07-31 18:10:26.000000000 +0200
+++ linux-2.6/drivers/input/gameport/ns558.c	2005-08-05 21:20:59.000000000 +0200
@@ -275,9 +275,9 @@
 
 static void __exit ns558_exit(void)
 {
-	struct ns558 *ns558;
+	struct ns558 *ns558, *safe;
 
-	list_for_each_entry(ns558, &ns558_list, node) {
+	list_for_each_entry_safe(ns558, safe, &ns558_list, node) {
 		gameport_unregister_port(ns558->gameport);
 		release_region(ns558->io & ~(ns558->size - 1), ns558->size);
 		kfree(ns558);
