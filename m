Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWIFVL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWIFVL4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 17:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWIFVL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 17:11:56 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:10397
	"EHLO gwia-smtp.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751268AbWIFVLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 17:11:55 -0400
From: Jean Delvare <jdelvare@suse.de>
Organization: SUSE
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] proc: readdir race fix (take 3)
Date: Wed, 6 Sep 2006 23:12:57 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, ak@suse.de
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com> <m1ac5e2woe.fsf_-_@ebiederm.dsl.xmission.com> <200609061101.11544.jdelvare@suse.de>
In-Reply-To: <200609061101.11544.jdelvare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200609062312.57774.jdelvare@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 6 September 2006 11:01, Jean Delvare wrote:
> Eric, Kame, thanks a lot for working on this. I'll be giving some good
> testing to this patch today, and will return back to you when I'm done.

The original issue is indeed fixed, but there's a problem with the patch. 
When stressing /proc (to verify the bug was fixed), my test machine ended 
up crashing. Here are the 2 traces I found in the logs:

Sep  6 12:06:00 arrakis kernel: BUG: warning at 
kernel/fork.c:113/__put_task_struct()
Sep  6 12:06:00 arrakis kernel:  [<c0115f93>] __put_task_struct+0xf3/0x100
Sep  6 12:06:00 arrakis kernel:  [<c019666a>] proc_pid_readdir+0x13a/0x150
Sep  6 12:06:00 arrakis kernel:  [<c01745f0>] vfs_readdir+0x80/0xa0
Sep  6 12:06:00 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 12:06:00 arrakis kernel:  [<c017488c>] sys_getdents+0x6c/0xb0
Sep  6 12:06:00 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 12:06:00 arrakis kernel:  [<c0102fb7>] syscall_call+0x7/0xb
Sep  6 12:06:05 arrakis kernel: BUG: warning at 
kernel/fork.c:113/__put_task_struct()
Sep  6 12:06:05 arrakis kernel:  [<c0115f93>] __put_task_struct+0xf3/0x100
Sep  6 12:06:05 arrakis kernel:  [<c019666a>] proc_pid_readdir+0x13a/0x150
Sep  6 12:06:05 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 12:06:05 arrakis kernel:  [<c01745f0>] vfs_readdir+0x80/0xa0
Sep  6 12:06:05 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 12:06:05 arrakis kernel:  [<c017488c>] sys_getdents+0x6c/0xb0
Sep  6 12:06:05 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 12:06:05 arrakis kernel:  [<c0102fb7>] syscall_call+0x7/0xb
Sep  6 12:06:05 arrakis kernel: BUG: unable to handle kernel NULL pointer 
dereference at virtual address 00000004
Sep  6 12:06:05 arrakis kernel:  printing eip:
Sep  6 12:06:05 arrakis kernel: c0115ede
Sep  6 12:06:05 arrakis kernel: *pde = 00000000
Sep  6 12:06:05 arrakis kernel: Oops: 0002 [#1]
Sep  6 12:06:05 arrakis kernel: PREEMPT 
Sep  6 12:06:05 arrakis kernel: Modules linked in: button battery ac 
thermal processor cpufreq_powersave speedstep_ich speedstep_lib 
freq_table snd_pcm_oss snd_mixer_oss smbfs sg sd_mod nls_iso8859_1 
nls_cp437 vfat fat radeon drm usb_storage scsi_mod eth1394 usbhid 
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer ide_cd 
uhci_hcd snd intel_rng psmouse cdrom usbcore evdev soundcore ohci1394 
intel_agp i2c_i801 snd_page_alloc ieee1394 e100 mii unix
Sep  6 12:06:05 arrakis kernel: CPU:    0
Sep  6 12:06:05 arrakis kernel: EIP:    0060:[<c0115ede>]    Not tainted 
VLI
Sep  6 12:06:05 arrakis kernel: EFLAGS: 00010282   (2.6.18-rc6 #113) 
Sep  6 12:06:05 arrakis kernel: EIP is at __put_task_struct+0x3e/0x100
Sep  6 12:06:05 arrakis kernel: eax: 00000000   ebx: c7ba7580   ecx: 
c0316bd4   edx: 00000000
Sep  6 12:06:05 arrakis kernel: esi: 00000000   edi: cc4b2d40   ebp: 
c953ef48   esp: c953ef14
Sep  6 12:06:05 arrakis kernel: ds: 007b   es: 007b   ss: 0068
Sep  6 12:06:05 arrakis kernel: Process bug (pid: 28719, ti=c953e000 
task=c953da90 task.ti=c953e000)
Sep  6 12:06:05 arrakis kernel: Stack: 00000000 c02ddbf5 00000071 c02c8401 
c7ba7580 c019666a c7ba7580 c953ef48 
Sep  6 12:06:05 arrakis kernel:        00000001 00000101 00000000 00000002 
00000004 39350030 cc4b0038 c953ef98 
Sep  6 12:06:05 arrakis kernel:        c0174750 cc4b2d40 c137bdf0 fffffffe 
c137be60 c01745f0 cc4b2d40 c953ef98 
Sep  6 12:06:05 arrakis kernel: Call Trace:
Sep  6 12:06:05 arrakis kernel:  [<c019666a>] proc_pid_readdir+0x13a/0x150
Sep  6 12:06:05 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 12:06:05 arrakis kernel:  [<c01745f0>] vfs_readdir+0x80/0xa0
Sep  6 12:06:05 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 12:06:05 arrakis kernel:  [<c017488c>] sys_getdents+0x6c/0xb0
Sep  6 12:06:05 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 12:06:05 arrakis kernel:  [<c0102fb7>] syscall_call+0x7/0xb
Sep  6 12:06:05 arrakis kernel: Code: 84 af 00 00 00 8b 43 08 85 c0 75 77 
89 e0 25 00 f0 ff ff 3b 18 74 3e 8b 83 84 01 00 00 89 04 24 e8 68 e0 00 
00 8b 83 70 01 00 00 <ff> 48 04 0f 94 c2 84 d2 75 10 89 5c 24 18 8b 5c 24 
10 83 c4 14 
Sep  6 12:06:05 arrakis kernel: EIP: [<c0115ede>] 
__put_task_struct+0x3e/0x100 SS:ESP 0068:c953ef14


Sep  6 19:38:23 arrakis kernel: BUG: warning at 
kernel/fork.c:113/__put_task_struct()
Sep  6 19:38:23 arrakis kernel:  [<c0115f93>] __put_task_struct+0xf3/0x100
Sep  6 19:38:23 arrakis kernel:  [<c019667e>] proc_pid_readdir+0x14e/0x150
Sep  6 19:38:23 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 19:38:23 arrakis kernel:  [<c01745f0>] vfs_readdir+0x80/0xa0
Sep  6 19:38:23 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 19:38:23 arrakis kernel:  [<c017488c>] sys_getdents+0x6c/0xb0
Sep  6 19:38:23 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 19:38:23 arrakis kernel:  [<c0102fb7>] syscall_call+0x7/0xb
Sep  6 19:38:26 arrakis kernel: BUG: unable to handle kernel NULL pointer 
dereference at virtual address 0000000c
Sep  6 19:38:26 arrakis kernel:  printing eip:
Sep  6 19:38:26 arrakis kernel: c01d2a69
Sep  6 19:38:26 arrakis kernel: *pde = 00000000
Sep  6 19:38:26 arrakis kernel: Oops: 0000 [#1]
Sep  6 19:38:26 arrakis kernel: PREEMPT 
Sep  6 19:38:26 arrakis kernel: Modules linked in: button battery ac 
thermal processor cpufreq_powersave speedstep_ich speedstep_lib 
freq_table snd_pcm_oss snd_mixer_oss smbfs nls_iso8859_1 nls_cp437 vfat 
fat radeon drm sg sd_mod usb_storage scsi_mod eth1394 usbhid snd_intel8x0 
snd_ac97_codec snd_ac97_bus snd_pcm snd_timer intel_rng uhci_hcd snd 
ide_cd intel_agp e100 usbcore i2c_i801 cdrom ohci1394 psmouse soundcore 
evdev mii ieee1394 snd_page_alloc unix
Sep  6 19:38:26 arrakis kernel: CPU:    0
Sep  6 19:38:26 arrakis kernel: EIP:    0060:[<c01d2a69>]    Not tainted 
VLI
Sep  6 19:38:26 arrakis kernel: EFLAGS: 00010017   (2.6.18-rc6 #115) 
Sep  6 19:38:26 arrakis kernel: EIP is at rwsem_wake+0x99/0x140
Sep  6 19:38:26 arrakis kernel: eax: 00000000   ebx: d6e483b4   ecx: 
cd522f64   edx: 00000001
Sep  6 19:38:26 arrakis kernel: esi: cd522f64   edi: b393a000   ebp: 
d6e48380   esp: d34dff58
Sep  6 19:38:26 arrakis kernel: ds: 007b   es: 007b   ss: 0068
Sep  6 19:38:26 arrakis kernel: Process firefox-bin (pid: 2400, 
ti=d34df000 task=d6e6c580 task.ti=d34df000)
Sep  6 19:38:26 arrakis kernel: Stack: cf2d94e8 d6e483b8 00000292 cd784df4 
d6e483b4 b393a000 d6e48380 c013219e 
Sep  6 19:38:26 arrakis kernel:        00000025 c0112b99 d6e483b4 cd784df4 
b393a000 00000000 00030002 00000000 
Sep  6 19:38:26 arrakis kernel:        b393a000 d6e6c580 00000004 d34dffbc 
b77d4b94 09473ed0 c0112810 bfa3ea00 
Sep  6 19:38:26 arrakis kernel: Call Trace:
Sep  6 19:38:26 arrakis kernel:  [<c013219e>] .text.lock.rwsem+0x21/0x43
Sep  6 19:38:26 arrakis kernel:  [<c0112b99>] do_page_fault+0x389/0x580
Sep  6 19:38:26 arrakis kernel:  [<c0112810>] do_page_fault+0x0/0x580
Sep  6 19:38:26 arrakis kernel:  [<c01039f1>] error_code+0x39/0x40
Sep  6 19:38:26 arrakis kernel: Code: c3 e8 1c 0b 0f 00 eb ef 8b 4b 04 89 
ce f6 41 0c 02 75 7c 31 d2 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 01 
42 3b 44 24 04 74 08 <f6> 40 0c 01 89 c1 75 ef 89 d0 89 d5 c1 e0 10 8d 54 
02 ff 01 13 
Sep  6 19:38:26 arrakis kernel: EIP: [<c01d2a69>] rwsem_wake+0x99/0x140 
SS:ESP 0068:d34dff58
Sep  6 19:38:26 arrakis kernel:  <6>note: firefox-bin[2400] exited with 
preempt_count 1
Sep  6 19:38:26 arrakis kernel: BUG: scheduling while atomic: 
firefox-bin/0x00000001/2400
Sep  6 19:38:26 arrakis kernel:  [<c02c3552>] schedule+0x662/0x670
Sep  6 19:38:26 arrakis kernel:  [<c02c4ebd>] 
rwsem_down_read_failed+0xbd/0x1a0
Sep  6 19:38:26 arrakis kernel:  [<c0237435>] vt_console_print+0x85/0x2a0
Sep  6 19:38:26 arrakis kernel:  [<c0132184>] .text.lock.rwsem+0x7/0x43
Sep  6 19:38:26 arrakis kernel:  [<c0133585>] futex_wake+0x25/0xf0
Sep  6 19:38:26 arrakis kernel:  [<c0135210>] do_futex+0x70/0x110
Sep  6 19:38:26 arrakis kernel:  [<c0119a34>] 
release_console_sem+0x104/0x110
Sep  6 19:38:26 arrakis kernel:  [<c013530c>] sys_futex+0x5c/0x130
Sep  6 19:38:26 arrakis kernel:  [<c011633b>] mm_release+0x8b/0x90
Sep  6 19:38:26 arrakis kernel:  [<c011b0e5>] exit_mm+0x25/0x110
Sep  6 19:38:26 arrakis kernel:  [<c011b999>] do_exit+0xf9/0x530
Sep  6 19:38:26 arrakis kernel:  [<c01042cc>] die+0x20c/0x210
Sep  6 19:38:26 arrakis kernel:  [<c0112ab4>] do_page_fault+0x2a4/0x580
Sep  6 19:38:26 arrakis kernel:  [<c0112810>] do_page_fault+0x0/0x580
Sep  6 19:38:26 arrakis kernel:  [<c01039f1>] error_code+0x39/0x40
Sep  6 19:38:26 arrakis kernel:  [<c01d2a69>] rwsem_wake+0x99/0x140
Sep  6 19:38:26 arrakis kernel:  [<c013219e>] .text.lock.rwsem+0x21/0x43
Sep  6 19:38:26 arrakis kernel:  [<c0112b99>] do_page_fault+0x389/0x580
Sep  6 19:38:26 arrakis kernel:  [<c0112810>] do_page_fault+0x0/0x580
Sep  6 19:38:26 arrakis kernel:  [<c01039f1>] error_code+0x39/0x40
Sep  6 19:38:27 arrakis kernel: BUG: warning at 
kernel/fork.c:113/__put_task_struct()
Sep  6 19:38:27 arrakis kernel:  [<c0115f93>] __put_task_struct+0xf3/0x100
Sep  6 19:38:27 arrakis kernel:  [<c019666a>] proc_pid_readdir+0x13a/0x150
Sep  6 19:38:27 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 19:38:27 arrakis kernel:  [<c01745f0>] vfs_readdir+0x80/0xa0
Sep  6 19:38:27 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 19:38:27 arrakis kernel:  [<c017488c>] sys_getdents+0x6c/0xb0
Sep  6 19:38:27 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 19:38:27 arrakis kernel:  [<c0102fb7>] syscall_call+0x7/0xb
Sep  6 19:38:27 arrakis kernel: BUG: unable to handle kernel paging 
request at virtual address 61672d78
Sep  6 19:38:27 arrakis kernel:  printing eip:
Sep  6 19:38:27 arrakis kernel: c01cf5ff
Sep  6 19:38:27 arrakis kernel: *pde = 00000000
Sep  6 19:38:27 arrakis kernel: Oops: 0002 [#2]
Sep  6 19:38:27 arrakis kernel: PREEMPT 
Sep  6 19:38:27 arrakis kernel: Modules linked in: button battery ac 
thermal processor cpufreq_powersave speedstep_ich speedstep_lib 
freq_table snd_pcm_oss snd_mixer_oss smbfs nls_iso8859_1 nls_cp437 vfat 
fat radeon drm sg sd_mod usb_storage scsi_mod eth1394 usbhid snd_intel8x0 
snd_ac97_codec snd_ac97_bus snd_pcm snd_timer intel_rng uhci_hcd snd 
ide_cd intel_agp e100 usbcore i2c_i801 cdrom ohci1394 psmouse soundcore 
evdev mii ieee1394 snd_page_alloc unix
Sep  6 19:38:27 arrakis kernel: CPU:    0
Sep  6 19:38:27 arrakis kernel: EIP:    0060:[<c01cf5ff>]    Not tainted 
VLI
Sep  6 19:38:27 arrakis kernel: EFLAGS: 00010013   (2.6.18-rc6 #115) 
Sep  6 19:38:27 arrakis kernel: EIP is at _atomic_dec_and_lock+0xf/0x50
Sep  6 19:38:27 arrakis kernel: eax: cd772000   ebx: 61672d78   ecx: 
00000000   edx: 00000001
Sep  6 19:38:27 arrakis kernel: esi: 61672d78   edi: cd1f84e0   ebp: 
cd772f48   esp: cd772ef8
Sep  6 19:38:27 arrakis kernel: ds: 007b   es: 007b   ss: 0068
Sep  6 19:38:27 arrakis kernel: Process bug (pid: 10459, ti=cd772000 
task=cd75a030 task.ti=cd772000)
Sep  6 19:38:27 arrakis kernel: Stack: 00000206 c0123f67 61672d78 c03af980 
cd521ab0 00000000 c0115ed8 61672d78 
Sep  6 19:38:27 arrakis kernel:        c02ddbd5 00000071 c02c8401 cd521ab0 
c019666a cd521ab0 cd772f48 00000001 
Sep  6 19:38:27 arrakis kernel:        00000101 00000000 00000002 00000004 
35310030 cd1f8400 cd772f98 c0174750 
Sep  6 19:38:27 arrakis kernel: Call Trace:
Sep  6 19:38:27 arrakis kernel:  [<c0123f67>] free_uid+0x27/0xa0
Sep  6 19:38:27 arrakis kernel:  [<c0115ed8>] __put_task_struct+0x38/0x100
Sep  6 19:38:27 arrakis kernel:  [<c019666a>] proc_pid_readdir+0x13a/0x150
Sep  6 19:38:27 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 19:38:27 arrakis kernel:  [<c01745f0>] vfs_readdir+0x80/0xa0
Sep  6 19:38:27 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 19:38:27 arrakis kernel:  [<c017488c>] sys_getdents+0x6c/0xb0
Sep  6 19:38:27 arrakis kernel:  [<c0174750>] filldir+0x0/0xd0
Sep  6 19:38:27 arrakis kernel:  [<c0102fb7>] syscall_call+0x7/0xb
Sep  6 19:38:27 arrakis kernel: Code: 01 c1 e2 0a 89 06 8b 5c 24 0c 89 d0 
89 ca 8b 74 24 10 83 c4 14 c3 90 90 90 90 90 90 53 b8 01 00 00 00 8b 5c 
24 08 e8 21 52 f4 ff <ff> 0b 0f 94 c0 84 c0 ba 01 00 00 00 74 04 5b 89 d0 
c3 b8 01 00 
Sep  6 19:38:27 arrakis kernel: EIP: [<c01cf5ff>] 
_atomic_dec_and_lock+0xf/0x50 SS:ESP 0068:cd772ef8
Sep  6 19:38:27 arrakis kernel:  <6>note: bug[10459] exited with 
preempt_count 1

Sometimes the machine just hung, with nothing in the logs. The machine is 
a Sony laptop (i686).

I have been testing the patch on another machine (x86_64) and had no 
problem at all, so the reproduceability of the bug might depend on the 
arch or some config option. I'll help nailing down this issue if I can, 
just tell me what to do.

Thanks,
-- 
Jean Delvare
