Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262836AbVHESxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbVHESxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbVHESwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:52:42 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:16581 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S262836AbVHESuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:50:50 -0400
From: Michael Stenzel <m.stenzel@tronix.homelinux.org>
Organization: Unorganized since 1886
To: linux-kernel@vger.kernel.org
Subject: [BUG] module ns558
Date: Fri, 5 Aug 2005 20:52:41 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508052052.42128.m.stenzel@tronix.homelinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello dear Kernel People,

I have a problem with my gameport, it uses the ns558 driver, the module gets 
loaded via hotplug/udev at boot, but the gameport gets deactivated somehow.
I have this Problem for a long time now, and my solution always was rmmod the 
module and load it again after that the gameport is working.
But now i have 2.6.13-rc5 with debug stuff turned on and noticed that:

#rmmod ns558
Speicherzugriffsfehler <-- Segfault

This is from dmesg:
kobject_hotplug: /sbin/hotplug input seq=393 HOME=/ 
PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/input/js0 
SUBSYSTEM=input
kobject js0: cleaning up
analog.c: 0 out of 0 reads (0%) on pnp00:03/gameport0 failed
kobject_hotplug
fill_kobj_path: path = '/devices/pnp0/00:03/gameport0'
kobject_hotplug: /sbin/hotplug gameport seq=394 HOME=/ 
PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove 
DEVPATH=/devices/pnp0/00:03/gameport0 SUBSYSTEM=gameport
kobject gameport0: cleaning up
Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
e0afc4ab
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: snd_seq_midi snd_seq_midi_event snd_seq video_buf_dvb 
video_buf w83627hf w83781d i2c_sensor i2c_isa snd_pcm_oss snd_mixer_oss 
ipt_MASQUERADE ipt_state iptable_mangle iptable_nat iptable_filter 
ip_conntrack_ftp ip_conntrack_irc ip_conntrack ip_tables rtc joydev analog 
ns558 budget s5h1420 l64781 ves1820 budget_core saa7146 ttpci_eeprom stv0299 
tda8083 ves1x93 dvb_core 8139too snd_via82xx gameport snd_mpu401_uart 
snd_rawmidi snd_seq_device via_rhine crc32 ide_scsi
CPU:    0
EIP:    0060:[<e0afc4ab>]    Not tainted VLI
EFLAGS: 00010282   (2.6.13-rc5-debug)
EIP is at ns558_exit+0x4b/0x79 [ns558]
eax: 6b6b6b57   ebx: 6b6b6b57   ecx: 00000000   edx: 6b6b6b6b
esi: 00000000   edi: 00000002   ebp: d7cfdf60   esp: d7cfdf5c
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 3267, threadinfo=d7cfc000 task=dfc94080)
Stack: e0afd140 d7cfdfb4 c0146b4d 00000000 3535736e d7cf0038 c0169941 b7f43000
       b7f42000 d7cfdfa4 c0169de5 b7f42000 b7f43000 df6a6f44 df6a61fc df17d3a4
       df17d3d4 00000000 00cfdfb4 c0169e6a bf856ae0 b7f2917c d7cfc000 c0103889
Call Trace:
 [<c010483a>] show_stack+0x7a/0x90
 [<c01049c6>] show_registers+0x156/0x1c0
 [<c0104c1c>] die+0x14c/0x2c0
 [<c0118093>] do_page_fault+0x343/0x655
 [<c010430f>] error_code+0x4f/0x54
 [<c0146b4d>] sys_delete_module+0x14d/0x190
 [<c0103889>] syscall_call+0x7/0xb
Code: 8b 43 10 e8 98 65 de ff 8b 4b 08 b8 a0 2f 46 c0 89 ca f7 da 23 53 04 e8 
64 c7 62 df 89 d8 e8 5d 01 66 df 8b 53 14 8d 42 ec 89 c3 <8b> 40 14 0f 18 00 
90 81 fa 20 cf af e0 75 c6 8b 1d c0 d2 af e0

However after modprobe ns558 the gameport works and rmmod isn't possible 
anymore:
# rmmod ns558
ERROR: Removing 'ns558': Device or resource busy

Output of scripts/ver_linux follows(note the nvidia module, i have loaded it 
after the oops so no problem, right?)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux yellow 2.6.13-rc5-debug #1 Fri Aug 5 01:39:18 CEST 2005 i686 AMD 
Athlon(tm) XP 2400+ AuthenticAMD GNU/Linux

Gnu C                  3.3.6
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.35
reiserfsprogs          3.6.18
reiser4progs           line
quota-tools            3.12.
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Linux C++ Library      5.0.7
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   064
Modules Loaded         nvidia snd_seq_midi snd_seq_midi_event snd_seq 
video_buf_dvb video_buf w83627hf w83781d i2c_sensor i2c_isa snd_pcm_oss 
snd_mixer_oss ipt_MASQUERADE ipt_state iptable_mangle iptable_nat 
iptable_filter ip_conntrack_ftp ip_conntrack_irc ip_conntrack ip_tables rtc 
joydev analog ns558 budget s5h1420 l64781 ves1820 budget_core saa7146 
ttpci_eeprom stv0299 tda8083 ves1x93 dvb_core 8139too snd_via82xx gameport 
snd_mpu401_uart snd_rawmidi snd_seq_device via_rhine crc32 ide_scsi

I'll provide more info, if it's needed. 
Please CC me because i'm not subscribed. 
TIA and keep up the great work!

