Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWBKWD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWBKWD4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 17:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWBKWD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 17:03:56 -0500
Received: from thorn.pobox.com ([208.210.124.75]:29376 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1750703AbWBKWD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 17:03:56 -0500
Date: Sat, 11 Feb 2006 16:03:53 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: sysfs-related oops during module unload (2.6.16-rc2)
Message-ID: <20060211220351.GA3293@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the refcnt attribute of a module is open when the module is
unloaded, we get an oops when the file is closed.  I used ide_cd for
this report but I don't think the oops is caused by the driver itself.
This bug seems to be restricted to the /sys/module hierarchy; it
doesn't happen with /sys/class etc.

I suspect it's an extra put or a missing get somewhere, but the fix
isn't obvious to me after looking at it for a little while, so I'm
punting.

I'm pretty sure this happens with 2.6.15; I can double-check if
needed.


Testcase:

#!/bin/sh

tail -f /sys/module/ide_cd/refcnt > /dev/null &

sleep 1

modprobe -r ide_cd

sleep 2

kill $!


Messages and oops with CONFIG_DEBUG_KOBJECT=y, starting from the
time of modprobe -r:

 kobject iosched: unregistering
 kobject_uevent
 kobject iosched: cleaning up
 kobject queue: unregistering
 kobject_uevent
 kobject queue: cleaning up
 kobject_uevent
 fill_kobj_path: path = '/block/hdc'
 fill_kobj_path: path = '/devices/pci0000:00/0000:00:1f.1/ide1/1.0'
 kobject hdc: cleaning up
 kobject ide-cdrom: unregistering
 kobject_uevent
 fill_kobj_path: path = '/bus/ide/drivers/ide-cdrom'
 kobject ide-cdrom: cleaning up
 kobject ide_cd: unregistering
 kobject_uevent
 fill_kobj_path: path = '/module/ide_cd'
 Uniform CD-ROM driver unloaded
 kobject cdrom: unregistering
 kobject_uevent
 fill_kobj_path: path = '/module/cdrom'
 kobject cdrom: cleaning up
 Unable to handle kernel paging request at virtual address c0f62b60
  printing eip:
 781af1f8
 *pde = 45214067
 Oops: 0002 [#1]
 SMP 
 Modules linked in: speedstep_lib cpufreq_userspace cpufreq_stats freq_table cpufreq_powersave cpufreq_ondemand cpufreq_conservative nfsd exportfs lockd sunrpc autofs4 video container button battery ac floppy rtc pcspkr tsdev 3c59x snd_cs46xx gameport snd_rawmidi snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc 8139cp usbhid 8139too mii uhci_hcd usbcore hw_random intel_agp agpgart psmouse parport_pc lp parport jfs ext3 jbd unix thermal processor fan
 CPU:    1
 EIP:    0060:[<781af1f8>]    Not tainted VLI
 EFLAGS: 00010216   (2.6.16-rc2 #2) 
 EIP is at kref_put+0x37/0x57
 eax: c0f62b60   ebx: c0f62b60   ecx: b839fc18   edx: 781aeb38
 esi: 781aeb38   edi: b13c744c   ebp: aff82e0c   esp: aff82e04
 ds: 007b   es: 007b   ss: 0068
 Process tail (pid: 5536, threadinfo=aff82000 task=af6b8bd0)
 Stack: <0>00000000 c0f62b48 aff82e14 781aeb59 aff82e28 7818c41d 00000010 bb8bb840 
        af7a16e8 aff82e48 781575b1 bb8bb840 bff90e38 b839fc18 af7a16e8 bd8cea1c 
        00000000 aff82e50 781574fb aff82e64 7815616a 00000001 0000000c b13c757c 
 Call Trace:
  [<78103a68>] show_stack_log_lvl+0xa8/0xb0
  [<78103ba0>] show_registers+0x10a/0x174
  [<78103d7a>] die+0xfb/0x16f
  [<78295744>] do_page_fault+0x370/0x522
  [<78103713>] error_code+0x4f/0x54
  [<781aeb59>] kobject_put+0x14/0x16
  [<7818c41d>] sysfs_release+0x2c/0x76
  [<781575b1>] __fput+0xb4/0x151
  [<781574fb>] fput+0x17/0x19
  [<7815616a>] filp_close+0x4e/0x58
  [<7811fb88>] close_files+0x57/0x67
  [<7811fbde>] put_files_struct+0x18/0x3e
  [<7812059f>] do_exit+0x1bc/0x35b
  [<78120803>] sys_exit_group+0x0/0x11
  [<7812847c>] get_signal_to_deliver+0x253/0x27b
  [<78102a2c>] do_signal+0x5f/0x10a
  [<78102b04>] do_notify_resume+0x2d/0x3d
  [<78102ca2>] work_notifysig+0x13/0x19
 Code: 04 6a 34 eb 0a 81 fa ed 41 15 78 75 1e 6a 35 68 1c 17 2b 78 68 34 cd 29 78 68 53 47 2a 78 e8 6e f0 f6 ff e8 8a 48 f5 ff 83 c4 10 <f0> ff 0b 0f 94 c0 31 d2 84 c0 74 09 89 d8 ff d6 ba 01 00 00 00 
  <1>Fixing recursive fault but reboot is needed!


