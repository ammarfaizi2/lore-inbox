Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbUDHRC5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 13:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbUDHRC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 13:02:57 -0400
Received: from mailr-2.tiscali.it ([212.123.84.82]:7954 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S262026AbUDHRCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 13:02:52 -0400
X-BrightmailFiltered: true
Date: Thu, 8 Apr 2004 19:02:50 +0200
From: Kronos <kronos@people.it>
To: alsa-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6.5-rc3] Hang on module unload
Message-ID: <20040408170250.GA11590@dreamland.darkstar.lan>
Reply-To: kronos@people.it
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm running debian unstable on my PC. With kernel 2.6.5-rc3 the shutdown hang
while unloading ALSA modules. PC is alive (ie. responds to ping and to SysRq).
This is from lsmod:
snd_pcm_oss            51492  0
snd_mixer_oss          18752  1 snd_pcm_oss
snd_intel8x0           32004  0
snd_ac97_codec         59268  1 snd_intel8x0
snd_pcm                95204  2 snd_pcm_oss,snd_intel8x0
snd_timer              25668  1 snd_pcm
snd_page_alloc         11140  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         7360  1 snd_intel8x0
snd_rawmidi            24736  1 snd_mpu401_uart
snd_seq_device          8264  1 snd_rawmidi
snd                    54884  9 snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device

Alsa script is unloading everything:

for i in $(lsmod | awk '/^snd/ {print $1}'); do
        $rmmod $i >/dev/null 2>&1 || :
done

I can reproduce using "rmmod snd_intel8x0", and this is the relevant part of SysRq-T:

rmmod         D DDFC6840     0 20120   3843                     (NOTLB)
d8e8bef0 00000086 dd6176c0 ddfc6840 dccf9e40 d8e8bed4 c016e150 4075837a
       39adce53 dca940c0 dca940e0 000f4240 d2175e40 000f45af dd472d00 dd472ec0
       e09cc60c 00000246 d8e8a000 d8e8bf2c c01060a5 e09cc614 dd472d00 00000001
Call Trace:
 [<c016e150>] simple_unlink+0x40/0x50
 [<c01060a5>] __down+0x85/0x100
 [<c0119c80>] default_wake_function+0x0/0x10
 [<c01062bf>] __down_failed+0xb/0x14
 [<c02314f0>] .text.lock.driver+0x5/0x15
 [<c01d4a1e>] pci_unregister_driver+0xe/0x20
 [<e09c7ecd>] alsa_card_intel8x0_exit+0xd/0x23 [snd_intel8x0]
 [<c0131245>] sys_delete_module+0x125/0x180
 [<c01467ac>] do_munmap+0x10c/0x150
 [<c01071af>] syscall_call+0x7/0xb
                        
In case it does matter udevd (from udev 0.024-2) is running:

udevd         S C013AE36     0  5521      1                2523 (NOTLB)
cc50feb4 00000082 cc50feb4 c013ae36 13b94045 13b94045 dd20a7e0 cc50fed4
       00000000 dd20a240 dd20a260 00000000 d2ecfdc0 000f45af c440eb80 c440ed40
       00000000 7fffffff 00000004 cc50fef0 c0125247 00000000 cc50fed8 00000246
Call Trace:
 [<c013ae36>] __alloc_pages+0x96/0x310
 [<c0125247>] schedule_timeout+0xa7/0xb0
 [<c029a4d5>] datagram_poll+0x15/0xc0
 [<c0162362>] do_select+0x152/0x270
 [<c0162070>] __pollwait+0x0/0xc0
 [<c0162733>] sys_select+0x283/0x460
 [<c011ff17>] sys_waitpid+0x27/0x29
 [<c01071af>] syscall_call+0x7/0xb
                      

Any clue?
Luca
-- 
Home: http://kronoz.cjb.net
Se il  destino di un uomo  e` annegare, anneghera` anche  in un bicchier
d'acqua.
Proverbio yddish
