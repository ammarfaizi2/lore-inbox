Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWACVD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWACVD0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWACVD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:03:26 -0500
Received: from ns1.suse.de ([195.135.220.2]:7570 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932467AbWACVDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:03:25 -0500
Date: Tue, 3 Jan 2006 22:03:23 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: blk_cleanup_queue, sleep in invalid context
Message-ID: <20060103210323.GA5227@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this with 2.6.15 on a ppc64 JS20, while debugging something else:


.....
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
udev on /dev type tmpfs (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
/dev/hda3 on /test type ext3 (rw,acl,user_xattr)                      done
Loading required kernel modules                                       done
/usr/sbin/855resolution not installed
Retry device configuration                                            done
Setting up the CMOS clock                                             done
Creating /var/log/boot.msg                                            done
Initialising lsvpd database  Vendor: TEAC      Model: FD-05PUB          Rev: 2000
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: LG        Model: CD-ROM CRN-8245B  Rev: 1.16
  Type:   CD-ROM                             ANSI SCSI revision: 00
Debug: sleeping function called from invalid context at kernel/workqueue.c:266
in_atomic():1, irqs_disabled():0
Call Trace:
[C00000000FFFF3F0] [C000000002027FB4] .show_stack+0x68/0x1b0 (unreliable)
[C00000000FFFF490] [C000000002053FEC] .__might_sleep+0xd8/0xf4
[C00000000FFFF510] [C0000000020747C8] .flush_workqueue+0x2c/0x15c
[C00000000FFFF5A0] [C0000000021AA134] .kblockd_flush+0x24/0x3c
[C00000000FFFF620] [C0000000021B4694] .as_exit_queue+0x2c/0xac
[C00000000FFFF6B0] [C0000000021A7D44] .elevator_exit+0x44/0x78
[C00000000FFFF730] [C0000000021ABF14] .blk_cleanup_queue+0x60/0x15c
[C00000000FFFF7D0] [D0000000002595C4] .scsi_free_queue+0x10/0x24 [scsi_mod]
[C00000000FFFF850] [D00000000025F2B8] .scsi_device_dev_release+0xf8/0x160 [scsi_mod]
[C00000000FFFF8F0] [C000000002241E9C] .device_release+0x4c/0x7c
[C00000000FFFF970] [C0000000021BB820] .kobject_cleanup+0x90/0xf0
[C00000000FFFFA10] [C0000000021BCA40] .kref_put+0x74/0x94
[C00000000FFFFA90] [C0000000021BB6FC] .kobject_put+0x28/0x40
[C00000000FFFFB10] [C000000002241FD8] .put_device+0x1c/0x30
[C00000000FFFFB90] [D00000000025988C] .scsi_next_command+0x50/0x70 [scsi_mod]
[C00000000FFFFC30] [D000000000259C44] .scsi_end_request+0x108/0x130 [scsi_mod]
[C00000000FFFFCD0] [D00000000025A11C] <7>usb-storage: device scan complete
sd 0:0:0:0: Attached scsi removable disk sda
.scsi_io_completion+0x4b0/0x4f0 [scsi_mod]
[C00000000FFFFDB0] [D000000000252934] .scsi_finish_command+0x104/0x128 [scsi_mod]
[C00000000FFFFE40] [D000000000253990] .scsi_softirq+0x1c0/0x214 [scsi_mod]
[C00000000FFFFEF0] [C000000002065560] .__do_softirq+0x98/0x170
[C00000000FFFFF90] [C00000000202D0B8] .call_do_softirq+0x14/0x24
[C00000000F1CF880] [C00000000200BD90] .do_softirq+0x70/0x98
[C00000000F1CF910] [C000000002065430] .local_bh_enable+0x58/0x8c
[C00000000F1CF990] [C00000000235F3C0] ._spin_unlock_bh+0x18/0x2c
[C00000000F1CFA10] [C0000000022CC900] .lock_sock+0x110/0x138
[C00000000F1CFB10] [C0000000022CA254] .sock_fasync+0xa0/0x1b4
[C00000000F1CFBD0] [C0000000022CA3A4] .sock_close+0x3c/0x60
[C00000000F1CFC50] [C0000000020C255C] .__fput+0x114/0x26c
[C00000000F1CFD00] [C0000000020BE8D4] .filp_close+0xac/0xd4
[C00000000F1CFD90] [C0000000020BE9E0] .sys_close+0xe4/0x114
[C00000000F1CFE30] [C000000002008700] syscall_exit+0x0/0x18
Debug: sleeping function called from invalid context at include/asm/semaphore.h:62
in_atomic():1, irqs_disabled():0
Call Trace:
[C00000000FFFF370] [C000000002027FB4] .show_stack+0x68/0x1b0 (unreliable)
[C00000000FFFF410] [C000000002053FEC] .__might_sleep+0xd8/0xf4
[C00000000FFFF490] [C00000000207F714] .__lock_cpu_hotplug+0x90/0x118
[C00000000FFFF510] [C00000000207487C] .flush_workqueue+0xe0/0x15c
[C00000000FFFF5A0] [C0000000021AA134] .kblockd_flush+0x24/0x3c
[C00000000FFFF620] [C0000000021B4694] .as_exit_queue+0x2c/0xac
[C00000000FFFF6B0] [C0000000021A7D44] .elevator_exit+0x44/0x78
[C00000000FFFF730] [C0000000021ABF14] .blk_cleanup_queue+0x60/0x15c
[C00000000FFFF7D0] [D0000000002595C4] .scsi_free_queue+0x10/0x24 [scsi_mod]
[C00000000FFFF850] [D00000000025F2B8] .scsi_device_dev_release+0xf8/0x160 [scsi_mod]
[C00000000FFFF8F0] [C000000002241E9C] .device_release+0x4c/0x7c
[C00000000FFFF970] [C0000000021BB820] .kobject_cleanup+0x90/0xf0
[C00000000FFFFA10] [C0000000021BCA40] .kref_put+0x74/0x94
[C00000000FFFFA90] [C0000000021BB6FC] .kobject_put+0x28/0x40
[C00000000FFFFB10] [C000000002241FD8] .put_device+0x1c/0x30
[C00000000FFFFB90] [D00000000025988C] .scsi_next_command+0x50/0x70 [scsi_mod]
[C00000000FFFFC30] [D000000000259C44] .scsi_end_request+0x108/0x130 [scsi_mod]
[C00000000FFFFCD0] [D00000000025A11C] .scsi_io_completion+0x4b0/0x4f0 [scsi_mod]
[C00000000FFFFDB0] [D000000000252934] .scsi_finish_command+0x104/0x128 [scsi_mod]
[C00000000FFFFE40] [D000000000253990] .scsi_softirq+0x1c0/0x214 [scsi_mod]
[C00000000FFFFEF0] [C000000002065560] .__do_softirq+0x98/0x170
[C00000000FFFFF90] [C00000000202D0B8] .call_do_softirq+0x14/0x24
[C00000000F1CF880] [C00000000200BD90] .do_softirq+0x70/0x98
[C00000000F1CF910] [C000000002065430] .local_bh_enable+0x58/0x8c
[C00000000F1CF990] [C00000000235F3C0] ._spin_unlock_bh+0x18/0x2c
[C00000000F1CFA10] [C0000000022CC900] .lock_sock+0x110/0x138
[C00000000F1CFB10] [C0000000022CA254] .sock_fasync+0xa0/0x1b4
[C00000000F1CFBD0] [C0000000022CA3A4] .sock_close+0x3c/0x60
[C00000000F1CFC50] [C0000000020C255C] .__fput+0x114/0x26c
[C00000000F1CFD00] [C0000000020BE8D4] .filp_close+0xac/0xd4
[C00000000F1CFD90] [C0000000020BE9E0] .sys_close+0xe4/0x114
[C00000000F1CFE30] [C000000002008700] syscall_exit+0x0/0x18
scheduling while atomic: udevd/0x00000200/1426
Call Trace:
[C00000000FFFF1F0] [C000000002027FB4] .show_stack+0x68/0x1b0 (unreliable)
[C00000000FFFF290] [C00000000235CDD4] .schedule+0x98/0xdc0
[C00000000FFFF3A0] [C00000000235CA88] .__down+0x78/0xf8
[C00000000FFFF490] [C00000000207F748] .__lock_cpu_hotplug+0xc4/0x118
[C00000000FFFF510] [C00000000207487C] .flush_workqueue+0xe0/0x15c
[C00000000FFFF5A0] [C0000000021AA134] .kblockd_flush+0x24/0x3c
[C00000000FFFF620] [C0000000021B4694] .as_exit_queue+0x2c/0xac
[C00000000FFFF6B0] [C0000000021A7D44] .elevator_exit+0x44/0x78
[C00000000FFFF730] [C0000000021ABF14] .blk_cleanup_queue+0x60/0x15c
[C00000000FFFF7D0] [D0000000002595C4] .scsi_free_queue+0x10/0x24 [scsi_mod]
[C00000000FFFF850] [D00000000025F2B8] .scsi_device_dev_release+0xf8/0x160 [scsi_mod]
[C00000000FFFF8F0] [C000000002241E9C] .device_release+0x4c/0x7c
[C00000000FFFF970] [C0000000021BB820] .kobject_cleanup+0x90/0xf0
[C00000000FFFFA10] [C0000000021BCA40] .kref_put+0x74/0x94
[C00000000FFFFA90] [C0000000021BB6FC] .kobject_put+0x28/0x40
[C00000000FFFFB10] [C000000002241FD8] .put_device+0x1c/0x30
[C00000000FFFFB90] [D00000000025988C] .scsi_next_command+0x50/0x70 [scsi_mod]
[C00000000FFFFC30] [D000000000259C44] .scsi_end_request+0x108/0x130 [scsi_mod]
[C00000000FFFFCD0] [D00000000025A11C] .scsi_io_completion+0x4b0/0x4f0 [scsi_mod]
[C00000000FFFFDB0] [D000000000252934] .scsi_finish_command+0x104/0x128 [scsi_mod]
[C00000000FFFFE40] [D000000000253990] .scsi_softirq+0x1c0/0x214 [scsi_mod]
[C00000000FFFFEF0] [C000000002065560] .__do_softirq+0x98/0x170
[C00000000FFFFF90] [C00000000202D0B8] .call_do_softirq+0x14/0x24
[C00000000F1CF880] [C00000000200BD90] .do_softirq+0x70/0x98
[C00000000F1CF910] [C000000002065430] .local_bh_enable+0x58/0x8c
[C00000000F1CF990] [C00000000235F3C0] ._spin_unlock_bh+0x18/0x2c
[C00000000F1CFA10] [C0000000022CC900] .lock_sock+0x110/0x138
[C00000000F1CFB10] [C0000000022CA254] .sock_fasync+0xa0/0x1b4
[C00000000F1CFBD0] [C0000000022CA3A4] .sock_close+0x3c/0x60
[C00000000F1CFC50] [C0000000020C255C] .__fput+0x114/0x26c
[C00000000F1CFD00] [C0000000020BE8D4] .filp_close+0xac/0xd4
[C00000000F1CFD90] [C0000000020BE9E0] .sys_close+0xe4/0x114
[C00000000F1CFE30] [C000000002008700] syscall_exit+0x0/0x18
sd 0:0:0:0: Attached scsi generic sg0 type 0
cpu 0x1: Vector: 800 (FPU Unavailable) at [c00000000ffff790]
    pc: c0000000024d80f0: iosched_deadline+0x28/0xb8
    lr: c0000000024d80f0: iosched_deadline+0x28/0xb8
    sp: c00000000ffffa10
   msr: 8000000000009032
  current = 0xc000000000fec040
  paca    = 0xc000000002456400
    pid   = 1426, comm = udevd
 1:0:0:0: Attached scsi generic sg1 type 5


(it finally jumped to some invalid code which happend to be a FP instruction)

I found no related block patches in our CVS, so a plain 2.6.15 may have the same bug.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
