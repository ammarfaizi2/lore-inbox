Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268535AbUJTQ1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268535AbUJTQ1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 12:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268436AbUJTQ1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 12:27:03 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:56047 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S268535AbUJTQSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:18:43 -0400
Subject: Livelock with the shmctl04 test program from linux test project
From: Alexander Nyberg <alexn@dsv.su.se>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1098289120.657.1.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 18:18:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing some sort of livelock on my dual amd64 with the shmctl04 test program
from the linux test project. xfce4 has to be running for it too happen (might
be the only program actually using shmem). Preempt on/off doesn't appear to matter.
debug_spinlock or debug_spinlock_sleep don't appear to catch anything.

shmctl04 is basically:

#include <sys/ipc.h>
#include <sys/shm.h>

int main()
{
        struct shm_info shm_info;
        shmctl(20, SHM_INFO, (struct shmid_ds *)&shm_info);
        return 0;
}



I tried doing below (this isn't a suggested patch...) and voila livelock
is gone. Many of the stack traces below look quite bogus, anything I can
do about it?
===== ipc/shm.c 1.42 vs edited =====
--- 1.42/ipc/shm.c	2004-10-19 07:26:38 +02:00
+++ edited/ipc/shm.c	2004-10-20 17:55:02 +02:00
@@ -394,10 +394,10 @@
 			*rss += (HPAGE_SIZE/PAGE_SIZE)*mapping->nrpages;
 		} else {
 			struct shmem_inode_info *info = SHMEM_I(inode);
-			spin_lock(&info->lock);
+/*			spin_lock(&info->lock);*/
 			*rss += inode->i_mapping->nrpages;
 			*swp += info->swapped;
-			spin_unlock(&info->lock);
+/*			spin_unlock(&info->lock);*/
 		}
 	}
 }

SysRq : Show Regs

Modules linked in: snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 8139too mii crc32 e1000
Pid: 606, comm: shmctl04 Not tainted 2.6.9
RIP: 0010:[<ffffffff80293240>] <ffffffff80293240>{_spin_lock+160}
RSP: 0018:000001003634fd38  EFLAGS: 00000246
RAX: 0000000000000000 RBX: 00000100373b0f78 RCX: 0000000000000000
RDX: 0000000000000004 RSI: 0000000000000004 RDI: 00000100373b0f78
RBP: 0000000000000000 R08: fefefefefefefeff R09: 000000000050c000
R10: 0000000000000002 R11: 0000000000000206 R12: 00000100373b0f78
R13: 000001003634feb0 R14: 000001003634fea8 R15: 00000000005077e0
FS:  0000002a958ab520(0000) GS:ffffffff803b4040(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000002a9573f7c0 CR3: 000000003ffba000 CR4: 00000000000006e0

Call Trace:<ffffffff80154e0a>{filemap_nopage+410} <ffffffff801c4042>{sys_shmctl+386} 
       <ffffffff80163b7a>{do_no_page+1226} <ffffffff80163d50>{handle_mm_fault+368} 
       <ffffffff80187911>{dput+33} <ffffffff801c99bd>{__up_read+29} 
       <ffffffff8011ec1c>{do_page_fault+524} <ffffffff8017d41c>{path_release+12} 
       <ffffffff8016e81b>{sys_chdir+107} <ffffffff8010f3e6>{system_call+126} 
       
SysRq : Show Regs

Modules linked in: snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 8139too mii crc32 e1000
Pid: 606, comm: shmctl04 Not tainted 2.6.9
RIP: 0010:[<ffffffff80293240>] <ffffffff80293240>{_spin_lock+160}
RSP: 0018:000001003634fd38  EFLAGS: 00000246
RAX: 0000000000000000 RBX: 00000100373b0f78 RCX: 0000000000000000
RDX: 0000000000000004 RSI: 0000000000000004 RDI: 00000100373b0f78
RBP: 0000000000000000 R08: fefefefefefefeff R09: 000000000050c000
R10: 0000000000000002 R11: 0000000000000206 R12: 00000100373b0f78
R13: 000001003634feb0 R14: 000001003634fea8 R15: 00000000005077e0
FS:  0000002a958ab520(0000) GS:ffffffff803b4040(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000002a9573f7c0 CR3: 000000003ffba000 CR4: 00000000000006e0

Call Trace:<ffffffff80154e0a>{filemap_nopage+410} <ffffffff801c4042>{sys_shmctl+386} 
       <ffffffff80163b7a>{do_no_page+1226} <ffffffff80163d50>{handle_mm_fault+368} 
       <ffffffff80187911>{dput+33} <ffffffff801c99bd>{__up_read+29} 
       <ffffffff8011ec1c>{do_page_fault+524} <ffffffff8017d41c>{path_release+12} 
       <ffffffff8016e81b>{sys_chdir+107} <ffffffff8010f3e6>{system_call+126} 
       
SysRq : Show Regs

Modules linked in: snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 8139too mii crc32 e1000
Pid: 606, comm: shmctl04 Not tainted 2.6.9
RIP: 0010:[<ffffffff80293240>] <ffffffff80293240>{_spin_lock+160}
RSP: 0018:000001003634fd38  EFLAGS: 00000246
RAX: 0000000000000000 RBX: 00000100373b0f78 RCX: 0000000000000000
RDX: 0000000000000004 RSI: 0000000000000004 RDI: 00000100373b0f78
RBP: 0000000000000000 R08: fefefefefefefeff R09: 000000000050c000
R10: 0000000000000002 R11: 0000000000000206 R12: 00000100373b0f78
R13: 000001003634feb0 R14: 000001003634fea8 R15: 00000000005077e0
FS:  0000002a958ab520(0000) GS:ffffffff803b4040(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000002a9573f7c0 CR3: 000000003ffba000 CR4: 00000000000006e0

Call Trace:<ffffffff80154e0a>{filemap_nopage+410} <ffffffff801c4042>{sys_shmctl+386} 
       <ffffffff80163b7a>{do_no_page+1226} <ffffffff80163d50>{handle_mm_fault+368} 
       <ffffffff80187911>{dput+33} <ffffffff801c99bd>{__up_read+29} 
       <ffffffff8011ec1c>{do_page_fault+524} <ffffffff8017d41c>{path_release+12} 
       <ffffffff8016e81b>{sys_chdir+107} <ffffffff8010f3e6>{system_call+126} 
       
SysRq : Show Regs

Modules linked in: snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 8139too mii crc32 e1000
Pid: 606, comm: shmctl04 Not tainted 2.6.9
RIP: 0010:[<ffffffff80293240>] <ffffffff80293240>{_spin_lock+160}
RSP: 0018:000001003634fd38  EFLAGS: 00000246
RAX: 0000000000000000 RBX: 00000100373b0f78 RCX: 0000000000000000
RDX: 0000000000000004 RSI: 0000000000000004 RDI: 00000100373b0f78
RBP: 0000000000000000 R08: fefefefefefefeff R09: 000000000050c000
R10: 0000000000000002 R11: 0000000000000206 R12: 00000100373b0f78
R13: 000001003634feb0 R14: 000001003634fea8 R15: 00000000005077e0
FS:  0000002a958ab520(0000) GS:ffffffff803b4040(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000002a9573f7c0 CR3: 000000003ffba000 CR4: 00000000000006e0

Call Trace:<ffffffff80154e0a>{filemap_nopage+410} <ffffffff801c4042>{sys_shmctl+386} 
       <ffffffff80163b7a>{do_no_page+1226} <ffffffff80163d50>{handle_mm_fault+368} 
       <ffffffff80187911>{dput+33} <ffffffff801c99bd>{__up_read+29} 
       <ffffffff8011ec1c>{do_page_fault+524} <ffffffff8017d41c>{path_release+12} 
       <ffffffff8016e81b>{sys_chdir+107} <ffffffff8010f3e6>{system_call+126} 
       
SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S 000000181d075f60     0     1      0     2               (NOTLB)
000001003ffa3d88 0000000000000002 0000000000000001 000001003ffa14a0 
       00000000000008f6 ffffffff80315780 000001003ffa1738 0000000000000001 
       000001003ffa3e68 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
migration/0   S 0000010001e146e0     0     2      1             3       (L-TLB)
000001003ff2fea8 0000000000000046 000000000000007c 000001003ffa0700 
       00000000000000f5 000001003da8af50 000001003ffa0998 000001003b303e98 
       000001003b303ea0 0000000000000202 
Call Trace:<ffffffff80130c43>{migration_thread+547} <ffffffff80130a20>{migration_thread+0} 
       <ffffffff80148f19>{kthread+217} <ffffffff80110087>{child_rip+8} 
       <ffffffff80148e40>{kthread+0} <ffffffff8011007f>{child_rip+0} 
       
ksoftirqd/0   S 00000004a5084ea9     0     3      1             4     2 (L-TLB)
000001003ff31f08 0000000000000046 0000000001e168a0 000001003ffa0030 
       0000000000000dbf ffffffff80315780 000001003ffa02c8 0000000000000000 
       0000000000000000 ffffffff80138dc1 
Call Trace:<ffffffff80138dc1>{__do_softirq+113} <ffffffff80139330>{ksoftirqd+0} 
       <ffffffff80139330>{ksoftirqd+0} <ffffffff80139375>{ksoftirqd+69} 
       <ffffffff80139330>{ksoftirqd+0} <ffffffff80148f19>{kthread+217} 
       <ffffffff80110087>{child_rip+8} <ffffffff80148e40>{kthread+0} 
       <ffffffff8011007f>{child_rip+0} 
migration/1   R  running task       0     4      1             5     3 (L-TLB)
ksoftirqd/1   S 00000009f2354f8e     0     5      1             6     4 (L-TLB)
000001003ff69f08 0000000000000046 000000018042c880 000001003ff32e10 
       00000000000007f3 000001003ffa0dd0 000001003ff330a8 0000000000000000 
       0000000000000080 ffffffff80138dc1 
Call Trace:<ffffffff80138dc1>{__do_softirq+113} <ffffffff80139330>{ksoftirqd+0} 
       <ffffffff80139330>{ksoftirqd+0} <ffffffff80139375>{ksoftirqd+69} 
       <ffffffff80139330>{ksoftirqd+0} <ffffffff80148f19>{kthread+217} 
       <ffffffff80110087>{child_rip+8} <ffffffff80148e40>{kthread+0} 
       <ffffffff8011007f>{child_rip+0} 
events/0      S 0000010001e16a40     0     6      1     8       7     5 (L-TLB)
000001003ff7be58 0000000000000046 0000000000000073 000001003ff32740 
       0000000000000a01 000001003bd95090 000001003ff329d8 0000000000000001 
       0000000000000002 0000000000000003 
Call Trace:<ffffffff8015d5e0>{cache_reap+0} <ffffffff80144941>{worker_thread+305} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff80144810>{worker_thread+0} <ffffffff80148f19>{kthread+217} 
       <ffffffff80110087>{child_rip+8} <ffffffff80148e40>{kthread+0} 
       <ffffffff8011007f>{child_rip+0} 
events/1      R  running task       0     7      1            14     6 (L-TLB)
khelper       S 0000010039091bd8     0     8      6             9       (L-TLB)
0000010002183e58 0000000000000046 000000000000006f 0000010002181520 
       00000000000013a1 000001003fd48800 00000100021817b8 0000000000000001 
       0000000000000002 0000000000000003 
Call Trace:<ffffffff8011007f>{child_rip+0} <ffffffff80144350>{__call_usermodehelper+0} 
       <ffffffff80144941>{worker_thread+305} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80144810>{worker_thread+0} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80148f19>{kthread+217} <ffffffff80110087>{child_rip+8} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80148e40>{kthread+0} 
       <ffffffff8011007f>{child_rip+0} 
kacpid        S 0000000004e15631     0     9      6            10     8 (L-TLB)
000001003fc95e58 0000000000000046 0000000100000000 0000010002180e50 
       0000000000002c8d 000001003ffa0dd0 00000100021810e8 0000000000000001 
       0000000004d1c745 0000000000010000 
Call Trace:<ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80144810>{worker_thread+0} 
       <ffffffff80144941>{worker_thread+305} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff80144810>{worker_thread+0} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80148f19>{kthread+217} 
       <ffffffff80110087>{child_rip+8} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80148e40>{kthread+0} <ffffffff8011007f>{child_rip+0} 
       
kblockd/0     S 0000001985c024ab     0    10      6            11     9 (L-TLB)
000001003fd07e58 0000000000000046 00000000803a7be8 0000010002180780 
       000000000000122f ffffffff80315780 0000010002180a18 0000000000000001 
       0000000000000002 0000000000000003 
Call Trace:<ffffffff80215240>{blk_unplug_work+0} <ffffffff80144941>{worker_thread+305} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80144810>{worker_thread+0} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80148f19>{kthread+217} 
       <ffffffff80110087>{child_rip+8} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80148e40>{kthread+0} <ffffffff8011007f>{child_rip+0} 
       
kblockd/1     S 000001003ffd7318     0    11      6            12    10 (L-TLB)
000001003fd0be58 0000000000000046 0000000100000076 00000100021800b0 
       00000000000008bf 000001003bd95760 0000010002180348 0000000000000001 
       0000000000000002 0000000000000003 
Call Trace:<ffffffff8021c7e0>{as_work_handler+0} <ffffffff80144941>{worker_thread+305} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80144810>{worker_thread+0} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80148f19>{kthread+217} 
       <ffffffff80110087>{child_rip+8} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80148e40>{kthread+0} <ffffffff8011007f>{child_rip+0} 
       
pdflush       S 000001003fd2fef0     0    12      6            13    11 (L-TLB)
000001003fd2fec8 0000000000000046 000000000000007d 000001003fd2d560 
       00000000000001f5 000001003ffa14a0 000001003fd2d7f8 ffffffff80292439 
       0000000000000246 000000000000000e 
Call Trace:<ffffffff80292439>{preempt_schedule+57} <ffffffff8012fd1c>{set_user_nice+204} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff8015a34b>{pdflush+187} 
       <ffffffff8015a290>{pdflush+0} <ffffffff80148f19>{kthread+217} 
       <ffffffff80110087>{child_rip+8} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80148e40>{kthread+0} <ffffffff8011007f>{child_rip+0} 
       
pdflush       S 0000001985932d2c     0    13      6            15    12 (L-TLB)
000001003fd31ec8 0000000000000046 00000000fffca7e0 000001003fd2ce90 
       0000000000018594 ffffffff80315780 000001003fd2d128 0000000000000001 
       0000000000000005 0000000000000000 
Call Trace:<ffffffff80148f60>{keventd_create_kthread+0} <ffffffff8015a34b>{pdflush+187} 
       <ffffffff8015a290>{pdflush+0} <ffffffff80148f19>{kthread+217} 
       <ffffffff80110087>{child_rip+8} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80148e40>{kthread+0} <ffffffff8011007f>{child_rip+0} 
       
aio/0         S 000001003ffdc400     0    15      6            16    13 (L-TLB)
000001003fd47e58 0000000000000046 000000000000006b 000001003fd2c0f0 
       0000000000000440 000001003fd495a0 000001003fd2c388 0000000000000001 
       0000000020ff6a8a 0000000000010000 
Call Trace:<ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80144810>{worker_thread+0} 
       <ffffffff80144941>{worker_thread+305} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80144810>{worker_thread+0} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80148f19>{kthread+217} <ffffffff80110087>{child_rip+8} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80148e40>{kthread+0} 
       <ffffffff8011007f>{child_rip+0} 
kswapd0       S ffffffff80325b60     0    14      1            17     7 (L-TLB)
000001003fd35eb8 0000000000000046 000000000000007d 000001003fd2c7c0 
       00000000000015b6 000001003ffa14a0 000001003fd2ca58 000001003fd2c7c0 
       0000000000000187 000001003fd2c7c0 
Call Trace:<ffffffff80160845>{kswapd+261} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff8012e540>{finish_task_switch+64} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff8012e59e>{schedule_tail+14} <ffffffff80110087>{child_rip+8} 
       <ffffffff80160740>{kswapd+0} <ffffffff8011007f>{child_rip+0} 
       
aio/1         S 0000000020ffd1a1     0    16      6                  15 (L-TLB)
000001003fd4be58 0000000000000046 000000013fd4be88 000001003fd495a0 
       0000000000001003 000001003ffa0dd0 000001003fd49838 0000000000000001 
       000001003fd4bfd8 0000000000010000 
Call Trace:<ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80144810>{worker_thread+0} 
       <ffffffff80144941>{worker_thread+305} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80144810>{worker_thread+0} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80148f19>{kthread+217} <ffffffff80110087>{child_rip+8} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80148e40>{kthread+0} 
       <ffffffff8011007f>{child_rip+0} 
kseriod       S 0000000033e73817     0    17      1            18    14 (L-TLB)
000001003fd7deb8 0000000000000046 0000000100000000 000001003fd48ed0 
       000000000f51e7c3 000001003ffa0dd0 000001003fd49168 0000000000000000 
       ffffffff803b4280 ffffffffffffffef 
Call Trace:<ffffffff80293240>{_spin_lock+160} <ffffffff80207712>{serio_thread+498} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff80110087>{child_rip+8} <ffffffff80207520>{serio_thread+0} 
       <ffffffff8011007f>{child_rip+0} 
kjournald     S 000000194730a8ef     0    18      1           143    17 (L-TLB)
000001003de77e58 0000000000000046 000000003689c450 000001003fd48130 
       00000000000038bc ffffffff80315780 000001003fd483c8 0000000000000001 
       0000000000000202 0000000000000003 
Call Trace:<ffffffff801bc414>{kjournald+548} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff801bc1d0>{commit_timeout+0} 
       <ffffffff80110087>{child_rip+8} <ffffffff801bc1f0>{kjournald+0} 
       <ffffffff8011007f>{child_rip+0} 
kjournald     S 000000038e7dd557     0   143      1           144    18 (L-TLB)
000001003d0f9e58 0000000000000046 0000000100000000 000001003d050fd0 
       0000000001823720 000001003ffa0dd0 000001003d051268 0000000000000000 
       0000000000000202 0000000000000003 
Call Trace:<ffffffff801bc414>{kjournald+548} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff801bc1d0>{commit_timeout+0} 
       <ffffffff80110087>{child_rip+8} <ffffffff801bc1f0>{kjournald+0} 
       <ffffffff8011007f>{child_rip+0} 
kjournald     S 0000000397505e7c     0   144      1           145   143 (L-TLB)
000001003c90be58 0000000000000046 000000003d050ba0 000001003d050900 
       000000000000118c ffffffff80315780 000001003d050b98 0000000000000001 
       0000000000000202 0000000000000003 
Call Trace:<ffffffff801bc414>{kjournald+548} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff801bc1d0>{commit_timeout+0} 
       <ffffffff80110087>{child_rip+8} <ffffffff801bc1f0>{kjournald+0} 
       <ffffffff8011007f>{child_rip+0} 
kjournald     S 000000039f7f6bf0     0   145      1           146   144 (L-TLB)
000001003c94de58 0000000000000046 000000013d0504d0 000001003d050230 
       0000000000006889 000001003ffa0dd0 000001003d0504c8 0000000000000000 
       0000000000000202 0000000000000003 
Call Trace:<ffffffff801bc414>{kjournald+548} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff801bc1d0>{commit_timeout+0} 
       <ffffffff80110087>{child_rip+8} <ffffffff801bc1f0>{kjournald+0} 
       <ffffffff8011007f>{child_rip+0} 
kjournald     S 00000003f14cdd0a     0   146      1           483   145 (L-TLB)
000001003bd13e58 0000000000000046 000000003bd11980 000001003bd116e0 
       0000000000000ef9 ffffffff80315780 000001003bd11978 0000000000000001 
       0000000000000202 0000000000000003 
Call Trace:<ffffffff801bc414>{kjournald+548} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff801bc1d0>{commit_timeout+0} 
       <ffffffff80110087>{child_rip+8} <ffffffff801bc1f0>{kjournald+0} 
       <ffffffff8011007f>{child_rip+0} 
syslogd       S 000001003fd9d5c0     0   483      1           486   146 (NOTLB)
000001003bf75d88 0000000000000002 0000000000000074 000001003bd942f0 
       00000000000009f4 000001003b9b77a0 000001003bd94588 0000000000000001 
       00000000000000d0 ffffffff801581fe 
Call Trace:<ffffffff801581fe>{__alloc_pages+190} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
klogd         R  running task       0   486      1           493   483 (NOTLB)
dbus-daemon-1 S 0000000000000000     0   493      1           497   486 (NOTLB)
000001003baabe88 0000000000000006 0000000100000075 000001003b9b70d0 
       00000000000c6616 000001003da8a880 000001003b9b7368 0000000000000001 
       00000000000000d0 ffffffff801581fe 
Call Trace:<ffffffff801581fe>{__alloc_pages+190} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff8010f3e6>{system_call+126} 
       
dhcpd3        S 00000004fcb07709     0   497      1           505   493 (NOTLB)
000001003b48fd88 0000000000000002 0000000100000074 000001003b9b6330 
       0000000000057805 000001003bd942f0 000001003b9b65c8 0000000000000001 
       00000000000000d0 ffffffff801581fe 
Call Trace:<ffffffff801581fe>{__alloc_pages+190} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
inetd         S 000001003fd9d9c0     0   505      1           514   497 (NOTLB)
000001003b4e3d88 0000000000000006 0000000100000075 000001003b4e1110 
       00000000000a903e 000001003b9b6a00 000001003b4e13a8 0000000000000001 
       00000000000000d0 ffffffff801581fe 
Call Trace:<ffffffff801581fe>{__alloc_pages+190} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
pxe           S 000001003b95f880     0   514      1           518   505 (NOTLB)
0000010039f5dd88 0000000000000006 0000000100000077 000001003da8a880 
       000000000001af8d 000001003b4e0a40 000001003da8ab18 0000000000000001 
       00000000000000d0 ffffffff801581fe 
Call Trace:<ffffffff801581fe>{__alloc_pages+190} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
nmbd          S 0000001915b6b06d     0   518      1           525   514 (NOTLB)
00000100392efd88 0000000000000002 0000000000000286 000001003b4e0370 
       0000000000007bc8 ffffffff80315780 000001003b4e0608 0000000000000001 
       00000000000000d0 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
smbd          S 00000005a7bfbd65     0   525      1   528     534   518 (NOTLB)
0000010038ab9d88 0000000000000002 0000000100000001 000001003da908c0 
       0000000000081164 000001003ffa0dd0 000001003da90b58 0000000000000000 
       00000000000000d2 00000000801581fe 
Call Trace:<ffffffff8029286e>{schedule_timeout+30} <ffffffff801492bc>{add_wait_queue+28} 
       <ffffffff8017c742>{pipe_poll+50} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
smbd          S 0000000000000000     0   528    525                     (NOTLB)
0000010038ad9f68 0000000000000002 0000000100000076 000001003b9b6a00 
       000000000005ec36 000001003da908c0 000001003b9b6c98 0000000000000000 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80141429>{sys_pause+25} <ffffffff8010f3e6>{system_call+126} 
       
sshd          S 00000005b6d3a9a6     0   534      1           541   525 (NOTLB)
00000100384e1d88 0000000000000006 0000000100000001 000001003da90f90 
       0000000000029eef 000001003ffa0dd0 000001003da91228 0000000000000000 
       0000000000000004 00000000801ace6f 
Call Trace:<ffffffff8029286e>{schedule_timeout+30} <ffffffff801492bc>{add_wait_queue+28} 
       <ffffffff80260f1f>{tcp_poll+47} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
cron          S 000000186152f456     0   541      1           547   534 (NOTLB)
000001003b509ee8 0000000000000006 0000000000000000 000001003b947050 
       0000000000008f3a ffffffff80315780 000001003b9472e8 0000000000000001 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff8013d2e2>{sys_nanosleep+194} 
       <ffffffff8010f3e6>{system_call+126} 
bash          S 000000072a66055a     0   547      1   555     548   541 (NOTLB)
0000010038b51e58 0000000000000006 000000013d977010 000001003d80f5e0 
       0000000000014973 000001003ffa0dd0 000001003d80f878 0000000000000000 
       000001003d80f880 ffffffff80131853 
Call Trace:<ffffffff80131853>{copy_mm+931} <ffffffff80137db9>{do_wait+3465} 
       <ffffffff8011ec1c>{do_page_fault+524} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8010f3e6>{system_call+126} 
       
getty         S 0000010038b64000     0   548      1           549   547 (NOTLB)
000001003b775d78 0000000000000002 0000000100000075 000001003bd10270 
       0000000000018c02 000001003d80f5e0 000001003bd10508 0000000000000075 
       0000010001d8d638 ffffffff80154e0a 
Call Trace:<ffffffff80154e0a>{filemap_nopage+410} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff801f6ec7>{read_chan+1143} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff801f0e94>{tty_ldisc_deref+116} <ffffffff801f138d>{tty_read+269} 
       <ffffffff8016fb87>{vfs_read+199} <ffffffff8016fe33>{sys_read+83} 
       <ffffffff8010f3e6>{system_call+126} 
getty         S 00000005feb547b1     0   549      1           550   548 (NOTLB)
000001003dffdd78 0000000000000002 0000000000000000 000001003b947720 
       000000000001e538 ffffffff80315780 000001003b9479b8 0000000000000001 
       0000010001d8d638 ffffffff80154e0a 
Call Trace:<ffffffff80154e0a>{filemap_nopage+410} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff801f6ec7>{read_chan+1143} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff801f0e94>{tty_ldisc_deref+116} <ffffffff801f138d>{tty_read+269} 
       <ffffffff8016fb87>{vfs_read+199} <ffffffff8016fe33>{sys_read+83} 
       <ffffffff8010f3e6>{system_call+126} 
getty         S 00000005feb322d8     0   550      1           551   549 (NOTLB)
0000010038ba1d78 0000000000000006 0000000000000000 000001003bd11010 
       0000000000014d2f ffffffff80315780 000001003bd112a8 0000000000000000 
       0000010001d8d638 ffffffff80154e0a 
Call Trace:<ffffffff80154e0a>{filemap_nopage+410} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff801f6ec7>{read_chan+1143} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff801f0e94>{tty_ldisc_deref+116} <ffffffff801f138d>{tty_read+269} 
       <ffffffff8016fb87>{vfs_read+199} <ffffffff8016fe33>{sys_read+83} 
       <ffffffff8010f3e6>{system_call+126} 
getty         S 00000005feb6d904     0   551      1           552   550 (NOTLB)
0000010038bb9d78 0000000000000002 0000000100000000 000001003d80e840 
       000000000000c0b1 000001003ffa0dd0 000001003d80ead8 0000000000000000 
       0000010001d8d638 ffffffff80154e0a 
Call Trace:<ffffffff80154e0a>{filemap_nopage+410} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff801f6ec7>{read_chan+1143} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff801f0e94>{tty_ldisc_deref+116} <ffffffff801f138d>{tty_read+269} 
       <ffffffff8016fb87>{vfs_read+199} <ffffffff8016fe33>{sys_read+83} 
       <ffffffff8010f3e6>{system_call+126} 
getty         S 000001003b9aa000     0   552      1           586   551 (NOTLB)
000001003b51dd78 0000000000000002 0000000100000075 000001003d80e170 
       000000000000c955 000001003d80e840 000001003d80e408 0000000000000075 
       0000010001d8d638 ffffffff80154e0a 
Call Trace:<ffffffff80154e0a>{filemap_nopage+410} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff801f6ec7>{read_chan+1143} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff801f0e94>{tty_ldisc_deref+116} <ffffffff801f138d>{tty_read+269} 
       <ffffffff8016fb87>{vfs_read+199} <ffffffff8016fe33>{sys_read+83} 
       <ffffffff8010f3e6>{system_call+126} 
xinit         S 000001003d80f028     0   555    547   556               (NOTLB)
000001003a2efe58 0000000000000006 0000000100000076 000001003d80ef10 
       0000000000001f19 000001003fd48800 000001003d80f1a8 000001003fd48928 
       00000000fffffff2 000001003a2eff00 
Call Trace:<ffffffff80137db9>{do_wait+3465} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff8010f3e6>{system_call+126} <ffffffff8010f3e6>{system_call+126} 
       
XFree86       S 00000019ca0a254c     0   556    555           577       (NOTLB)
0000010039091d88 0000000000000006 0000000000000074 000001003da8af50 
       00000000000001c4 ffffffff80315780 000001003da8b1e8 0000000000000001 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff8013c5ed>{__mod_timer+317} 
       <ffffffff80183df5>{sys_select+885} <ffffffff8010f3e6>{system_call+126} 
       
xfce4-session S 00000019b9f441b1     0   577    555   580           556 (NOTLB)
000001003874fe88 0000000000000006 0000000000000073 000001003fd48800 
       0000000000000f8a 000001003da8af50 000001003fd48a98 0000000000000202 
       00000000000000d0 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80182f09>{sys_ioctl+1001} 
       <ffffffff8010f3e6>{system_call+126} 
sh            S 000001003da8a2c8     0   580    577   582               (NOTLB)
0000010038791e58 0000000000000002 0000000100000076 000001003da8a1b0 
       0000000000014554 000001003b9462b0 000001003da8a448 000001003b946980 
       000001003da8a450 ffffffff80131853 
Call Trace:<ffffffff80131853>{copy_mm+931} <ffffffff80137db9>{do_wait+3465} 
       <ffffffff8011ec1c>{do_page_fault+524} <ffffffff80140f61>{do_sigaction+577} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff801412f4>{sys_rt_sigaction+148} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8010f3e6>{system_call+126} 
       
xscreensaver  S 00000019c9b0da39     0   582    580                     (NOTLB)
000001003a405d88 0000000000000002 0000000000000073 000001003b946980 
       00000000000009aa 000001003bd95090 000001003b946c18 0000000000000202 
       00000000000000d0 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
xfce-mcs-mana S 00000019c9b4351f     0   586      1           590   552 (NOTLB)
000001003aed7e88 0000000000000002 0000000000000073 000001003d0516a0 
       0000000000000d88 000001003b4e17e0 000001003d051938 0000000000000202 
       00000000000000d0 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80182f09>{sys_ioctl+1001} 
       <ffffffff8010f3e6>{system_call+126} 
xfwm4         S 00000019c9b4bec2     0   590      1           591   586 (NOTLB)
00000100383dbe88 0000000000000006 0000000000000073 000001003b4e17e0 
       0000000000000dc3 000001003bd10940 000001003b4e1a78 0000000000000001 
       00000000000000d0 ffffffff801581fe 
Call Trace:<ffffffff801581fe>{__alloc_pages+190} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80182f09>{sys_ioctl+1001} 
       <ffffffff8010f3e6>{system_call+126} 
xftaskbar4    S 00000019c9b57384     0   591      1           592   590 (NOTLB)
000001003afb9e88 0000000000000002 0000000000000073 000001003bd10940 
       0000000000001213 000001003da901f0 000001003bd10bd8 0000000000000001 
       00000000000000d0 ffffffff801581fe 
Call Trace:<ffffffff801581fe>{__alloc_pages+190} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80182f09>{sys_ioctl+1001} 
       <ffffffff8010f3e6>{system_call+126} 
xfdesktop     S 00000019c9b6226f     0   592      1           594   591 (NOTLB)
0000010037c0de88 0000000000000002 0000000000000073 000001003da901f0 
       000000000000117d 000001003da91660 000001003da90488 0000000000000001 
       00000000000000d0 ffffffff801581fe 
Call Trace:<ffffffff801581fe>{__alloc_pages+190} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80182f09>{sys_ioctl+1001} 
       <ffffffff8010f3e6>{system_call+126} 
xfce4-panel   S 00000019c9b6ea7b     0   594      1           596   592 (NOTLB)
0000010037c1fe88 0000000000000002 0000000000000073 000001003da91660 
       0000000000001401 000001003da8af50 000001003da918f8 0000000000000202 
       00000000000000d0 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80182f09>{sys_ioctl+1001} 
       <ffffffff8010f3e6>{system_call+126} 
gnome-termina S 00000019ca0a1567     0   596      1   601     598   594 (NOTLB)
0000010037ac7e88 0000000000000002 0000000000000074 000001003bd95090 
       0000000000000ff9 000001003da8af50 000001003bd95328 0000000000000202 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80182f09>{sys_ioctl+1001} 
       <ffffffff8010f3e6>{system_call+126} 
gnome-termina S 0000000b42e34df9     0   603      1                 600 (NOTLB)
0000010036291df8 0000000000000002 0000000100000075 000001003b9462b0 
       000000000000bba5 000001003bd949c0 000001003b946548 0000000000000001 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff8017c070>{pipe_wait+160} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff8017c2c3>{pipe_readv+531} 
       <ffffffff8017c36a>{pipe_read+26} <ffffffff8016fb87>{vfs_read+199} 
       <ffffffff8016fe33>{sys_read+83} <ffffffff8010f3e6>{system_call+126} 
       
gconfd-2      S 00000018c9415cf5     0   598      1           600   596 (NOTLB)
0000010037389e88 0000000000000002 0000000000000001 000001003bd95760 
       0000000000009124 ffffffff80315780 000001003bd959f8 0000000000000001 
       0000000000000212 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff8010f3e6>{system_call+126} 
       
bonobo-activa S 0000000af989b5d9     0   600      1           603   598 (NOTLB)
0000010036d2be88 0000000000000002 0000000000000001 000001003b4e0a40 
       00000000000007c9 ffffffff80315780 000001003b4e0cd8 0000000000000001 
       0000010036d46d18 000000008018bece 
Call Trace:<ffffffff8029286e>{schedule_timeout+30} <ffffffff80170c4b>{fget+91} 
       <ffffffff80184215>{sys_poll+629} <ffffffff80183560>{__pollwait+0} 
       <ffffffff80170473>{sys_writev+83} <ffffffff8010f3e6>{system_call+126} 
       
gnome-pty-hel S 0000000b42e56bf9     0   601    596           602       (NOTLB)
00000100361edbe8 0000000000000006 0000000100000007 000001003bd949c0 
       0000000000021e00 000001003ffa0dd0 000001003bd94c58 0000000000000001 
       000001003dff9a50 ffffffff801b3c6d 
Call Trace:<ffffffff801b3c6d>{__ext3_journal_stop+45} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff80155c20>{generic_file_buffered_write+1040} 
       <ffffffff801493e3>{prepare_to_wait+35} <ffffffff8028ed51>{unix_stream_recvmsg+625} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff8018a461>{inode_update_time+193} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff8023e5a6>{sock_aio_read+278} 
       <ffffffff80170a25>{file_kill+21} <ffffffff8016fa8d>{do_sync_read+173} 
       <ffffffff80186b85>{fcntl_setlk+757} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff80187911>{dput+33} <ffffffff8016fba1>{vfs_read+225} 
       <ffffffff8016fe33>{sys_read+83} <ffffffff8010f3e6>{system_call+126} 
       
bash          S 0000000e08736929     0   602    596   606           601 (NOTLB)
0000010036237e58 0000000000000002 0000000036227010 000001003da8b620 
       000000000001b94f ffffffff80315780 000001003da8b8b8 0000000000000000 
       000001003da8b8c0 ffffffff80131853 
Call Trace:<ffffffff80131853>{copy_mm+931} <ffffffff80137db9>{do_wait+3465} 
       <ffffffff8011ec1c>{do_page_fault+524} <ffffffff80140f61>{do_sigaction+577} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff8010f3e6>{system_call+126} 
shmctl04      R  running task       0   606    602                     (NOTLB)
atkbd.c: Unknown key released (translated set 2, code 0xe0 on isa0060/serio0).
atkbd.c: Use 'setkeycodes e060 <keycode>' to make it known.
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount 
SysRq : Show Regs

Modules linked in: snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 8139too mii crc32 e1000
Pid: 606, comm: shmctl04 Not tainted 2.6.9
RIP: 0010:[<ffffffff80293240>] <ffffffff80293240>{_spin_lock+160}
RSP: 0018:000001003634fd38  EFLAGS: 00000246
RAX: 0000000000000000 RBX: 00000100373b0f78 RCX: 0000000000000000
RDX: 0000000000000004 RSI: 0000000000000004 RDI: 00000100373b0f78
RBP: 0000000000000000 R08: fefefefefefefeff R09: 000000000050c000
R10: 0000000000000002 R11: 0000000000000206 R12: 00000100373b0f78
R13: 000001003634feb0 R14: 000001003634fea8 R15: 00000000005077e0
FS:  0000002a958ab520(0000) GS:ffffffff803b4040(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000002a9573f7c0 CR3: 000000003ffba000 CR4: 00000000000006e0

Call Trace:<ffffffff80154e0a>{filemap_nopage+410} <ffffffff801c4042>{sys_shmctl+386} 
       <ffffffff80163b7a>{do_no_page+1226} <ffffffff80163d50>{handle_mm_fault+368} 
       <ffffffff80187911>{dput+33} <ffffffff801c99bd>{__up_read+29} 
       <ffffffff8011ec1c>{do_page_fault+524} <ffffffff8017d41c>{path_release+12} 
       <ffffffff8016e81b>{sys_chdir+107} <ffffffff8010f3e6>{system_call+126} 
       
SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S 0000002390bc8924     0     1      0     2               (NOTLB)
000001003ffa3d88 0000000000000002 0000000000000001 000001003ffa14a0 
       00000000000005b9 ffffffff80315780 000001003ffa1738 0000000000000001 
       000001003ffa3e68 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
migration/0   S 0000010001e146e0     0     2      1             3       (L-TLB)
000001003ff2fea8 0000000000000046 000000000000007c 000001003ffa0700 
       00000000000000f5 000001003da8af50 000001003ffa0998 000001003b303e98 
       000001003b303ea0 0000000000000202 
Call Trace:<ffffffff80130c43>{migration_thread+547} <ffffffff80130a20>{migration_thread+0} 
       <ffffffff80148f19>{kthread+217} <ffffffff80110087>{child_rip+8} 
       <ffffffff80148e40>{kthread+0} <ffffffff8011007f>{child_rip+0} 
       
ksoftirqd/0   S 00000004a5084ea9     0     3      1             4     2 (L-TLB)
000001003ff31f08 0000000000000046 0000000001e168a0 000001003ffa0030 
       0000000000000dbf ffffffff80315780 000001003ffa02c8 0000000000000000 
       0000000000000000 ffffffff80138dc1 
Call Trace:<ffffffff80138dc1>{__do_softirq+113} <ffffffff80139330>{ksoftirqd+0} 
       <ffffffff80139330>{ksoftirqd+0} <ffffffff80139375>{ksoftirqd+69} 
       <ffffffff80139330>{ksoftirqd+0} <ffffffff80148f19>{kthread+217} 
       <ffffffff80110087>{child_rip+8} <ffffffff80148e40>{kthread+0} 
       <ffffffff8011007f>{child_rip+0} 
migration/1   R  running task       0     4      1             5     3 (L-TLB)
ksoftirqd/1   S 00000009f2354f8e     0     5      1             6     4 (L-TLB)
000001003ff69f08 0000000000000046 000000018042c880 000001003ff32e10 
       00000000000007f3 000001003ffa0dd0 000001003ff330a8 0000000000000000 
       0000000000000080 ffffffff80138dc1 
Call Trace:<ffffffff80138dc1>{__do_softirq+113} <ffffffff80139330>{ksoftirqd+0} 
       <ffffffff80139330>{ksoftirqd+0} <ffffffff80139375>{ksoftirqd+69} 
       <ffffffff80139330>{ksoftirqd+0} <ffffffff80148f19>{kthread+217} 
       <ffffffff80110087>{child_rip+8} <ffffffff80148e40>{kthread+0} 
       <ffffffff8011007f>{child_rip+0} 
events/0      S 000000244384930e     0     6      1     8       7     5 (L-TLB)
000001003ff7be58 0000000000000046 0000000002175000 000001003ff32740 
       000000000000088b ffffffff80315780 000001003ff329d8 0000000000000001 
       0000000000000002 0000000000000003 
Call Trace:<ffffffff8015d5e0>{cache_reap+0} <ffffffff80144941>{worker_thread+305} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff80144810>{worker_thread+0} <ffffffff80148f19>{kthread+217} 
       <ffffffff80110087>{child_rip+8} <ffffffff80148e40>{kthread+0} 
       <ffffffff8011007f>{child_rip+0} 
events/1      R  running task       0     7      1            14     6 (L-TLB)
khelper       S 0000010039091bd8     0     8      6             9       (L-TLB)
0000010002183e58 0000000000000046 000000000000006f 0000010002181520 
       00000000000013a1 000001003fd48800 00000100021817b8 0000000000000001 
       0000000000000002 0000000000000003 
Call Trace:<ffffffff8011007f>{child_rip+0} <ffffffff80144350>{__call_usermodehelper+0} 
       <ffffffff80144941>{worker_thread+305} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80144810>{worker_thread+0} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80148f19>{kthread+217} <ffffffff80110087>{child_rip+8} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80148e40>{kthread+0} 
       <ffffffff8011007f>{child_rip+0} 
kacpid        S 0000000004e15631     0     9      6            10     8 (L-TLB)
000001003fc95e58 0000000000000046 0000000100000000 0000010002180e50 
       0000000000002c8d 000001003ffa0dd0 00000100021810e8 0000000000000001 
       0000000004d1c745 0000000000010000 
Call Trace:<ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80144810>{worker_thread+0} 
       <ffffffff80144941>{worker_thread+305} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff80144810>{worker_thread+0} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80148f19>{kthread+217} 
       <ffffffff80110087>{child_rip+8} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80148e40>{kthread+0} <ffffffff8011007f>{child_rip+0} 
       
kblockd/0     S 0000001985c024ab     0    10      6            11     9 (L-TLB)
000001003fd07e58 0000000000000046 00000000803a7be8 0000010002180780 
       000000000000122f ffffffff80315780 0000010002180a18 0000000000000001 
       0000000000000002 0000000000000003 
Call Trace:<ffffffff80215240>{blk_unplug_work+0} <ffffffff80144941>{worker_thread+305} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80144810>{worker_thread+0} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80148f19>{kthread+217} 
       <ffffffff80110087>{child_rip+8} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80148e40>{kthread+0} <ffffffff8011007f>{child_rip+0} 
       
kblockd/1     S 000001003ffd7318     0    11      6            12    10 (L-TLB)
000001003fd0be58 0000000000000046 0000000100000076 00000100021800b0 
       00000000000008bf 000001003bd95760 0000010002180348 0000000000000001 
       0000000000000002 0000000000000003 
Call Trace:<ffffffff8021c7e0>{as_work_handler+0} <ffffffff80144941>{worker_thread+305} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80144810>{worker_thread+0} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80148f19>{kthread+217} 
       <ffffffff80110087>{child_rip+8} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80148e40>{kthread+0} <ffffffff8011007f>{child_rip+0} 
       
pdflush       S 000001003fd2fef0     0    12      6            13    11 (L-TLB)
000001003fd2fec8 0000000000000046 000000000000007d 000001003fd2d560 
       00000000000001f5 000001003ffa14a0 000001003fd2d7f8 ffffffff80292439 
       0000000000000246 000000000000000e 
Call Trace:<ffffffff80292439>{preempt_schedule+57} <ffffffff8012fd1c>{set_user_nice+204} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff8015a34b>{pdflush+187} 
       <ffffffff8015a290>{pdflush+0} <ffffffff80148f19>{kthread+217} 
       <ffffffff80110087>{child_rip+8} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80148e40>{kthread+0} <ffffffff8011007f>{child_rip+0} 
       
pdflush       S 0000002390ad1eed     0    13      6            15    12 (L-TLB)
000001003fd31ec8 0000000000000046 00000000fffd5069 000001003fd2ce90 
       00000000000000e4 ffffffff80315780 000001003fd2d128 0000000000000001 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80148f60>{keventd_create_kthread+0} <ffffffff8015a34b>{pdflush+187} 
       <ffffffff8015a290>{pdflush+0} <ffffffff80148f19>{kthread+217} 
       <ffffffff80110087>{child_rip+8} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80148e40>{kthread+0} <ffffffff8011007f>{child_rip+0} 
       
aio/0         S 000001003ffdc400     0    15      6            16    13 (L-TLB)
000001003fd47e58 0000000000000046 000000000000006b 000001003fd2c0f0 
       0000000000000440 000001003fd495a0 000001003fd2c388 0000000000000001 
       0000000020ff6a8a 0000000000010000 
Call Trace:<ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80144810>{worker_thread+0} 
       <ffffffff80144941>{worker_thread+305} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80144810>{worker_thread+0} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80148f19>{kthread+217} <ffffffff80110087>{child_rip+8} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80148e40>{kthread+0} 
       <ffffffff8011007f>{child_rip+0} 
kswapd0       S ffffffff80325b60     0    14      1            17     7 (L-TLB)
000001003fd35eb8 0000000000000046 000000000000007d 000001003fd2c7c0 
       00000000000015b6 000001003ffa14a0 000001003fd2ca58 000001003fd2c7c0 
       0000000000000187 000001003fd2c7c0 
Call Trace:<ffffffff80160845>{kswapd+261} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff8012e540>{finish_task_switch+64} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff8012e59e>{schedule_tail+14} <ffffffff80110087>{child_rip+8} 
       <ffffffff80160740>{kswapd+0} <ffffffff8011007f>{child_rip+0} 
       
aio/1         S 0000000020ffd1a1     0    16      6                  15 (L-TLB)
000001003fd4be58 0000000000000046 000000013fd4be88 000001003fd495a0 
       0000000000001003 000001003ffa0dd0 000001003fd49838 0000000000000001 
       000001003fd4bfd8 0000000000010000 
Call Trace:<ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80144810>{worker_thread+0} 
       <ffffffff80144941>{worker_thread+305} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80144810>{worker_thread+0} <ffffffff80148f60>{keventd_create_kthread+0} 
       <ffffffff80148f19>{kthread+217} <ffffffff80110087>{child_rip+8} 
       <ffffffff80148f60>{keventd_create_kthread+0} <ffffffff80148e40>{kthread+0} 
       <ffffffff8011007f>{child_rip+0} 
kseriod       S 0000000033e73817     0    17      1            18    14 (L-TLB)
000001003fd7deb8 0000000000000046 0000000100000000 000001003fd48ed0 
       000000000f51e7c3 000001003ffa0dd0 000001003fd49168 0000000000000000 
       ffffffff803b4280 ffffffffffffffef 
Call Trace:<ffffffff80293240>{_spin_lock+160} <ffffffff80207712>{serio_thread+498} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff80110087>{child_rip+8} <ffffffff80207520>{serio_thread+0} 
       <ffffffff8011007f>{child_rip+0} 
kjournald     S 0000001ee8e389e1     0    18      1           143    17 (L-TLB)
000001003de77e58 0000000000000046 00000000398f3a28 000001003fd48130 
       0000000000001211 ffffffff80315780 000001003fd483c8 0000000000000001 
       0000000000000202 0000000000000003 
Call Trace:<ffffffff801bc414>{kjournald+548} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff801bc1d0>{commit_timeout+0} 
       <ffffffff80110087>{child_rip+8} <ffffffff801bc1f0>{kjournald+0} 
       <ffffffff8011007f>{child_rip+0} 
kjournald     S 000000038e7dd557     0   143      1           144    18 (L-TLB)
000001003d0f9e58 0000000000000046 0000000100000000 000001003d050fd0 
       0000000001823720 000001003ffa0dd0 000001003d051268 0000000000000000 
       0000000000000202 0000000000000003 
Call Trace:<ffffffff801bc414>{kjournald+548} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff801bc1d0>{commit_timeout+0} 
       <ffffffff80110087>{child_rip+8} <ffffffff801bc1f0>{kjournald+0} 
       <ffffffff8011007f>{child_rip+0} 
kjournald     S 0000000397505e7c     0   144      1           145   143 (L-TLB)
000001003c90be58 0000000000000046 000000003d050ba0 000001003d050900 
       000000000000118c ffffffff80315780 000001003d050b98 0000000000000001 
       0000000000000202 0000000000000003 
Call Trace:<ffffffff801bc414>{kjournald+548} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff801bc1d0>{commit_timeout+0} 
       <ffffffff80110087>{child_rip+8} <ffffffff801bc1f0>{kjournald+0} 
       <ffffffff8011007f>{child_rip+0} 
kjournald     S 000000039f7f6bf0     0   145      1           146   144 (L-TLB)
000001003c94de58 0000000000000046 000000013d0504d0 000001003d050230 
       0000000000006889 000001003ffa0dd0 000001003d0504c8 0000000000000000 
       0000000000000202 0000000000000003 
Call Trace:<ffffffff801bc414>{kjournald+548} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff801bc1d0>{commit_timeout+0} 
       <ffffffff80110087>{child_rip+8} <ffffffff801bc1f0>{kjournald+0} 
       <ffffffff8011007f>{child_rip+0} 
kjournald     S 00000003f14cdd0a     0   146      1           483   145 (L-TLB)
000001003bd13e58 0000000000000046 000000003bd11980 000001003bd116e0 
       0000000000000ef9 ffffffff80315780 000001003bd11978 0000000000000001 
       0000000000000202 0000000000000003 
Call Trace:<ffffffff801bc414>{kjournald+548} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff801bc1d0>{commit_timeout+0} 
       <ffffffff80110087>{child_rip+8} <ffffffff801bc1f0>{kjournald+0} 
       <ffffffff8011007f>{child_rip+0} 
syslogd       S 000001003fd9d5c0     0   483      1           486   146 (NOTLB)
000001003bf75d88 0000000000000002 0000000000000074 000001003bd942f0 
       0000000000000a02 000001003b9b77a0 000001003bd94588 0000000000000001 
       00000000000000d0 ffffffff801581fe 
Call Trace:<ffffffff801581fe>{__alloc_pages+190} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
klogd         R  running task       0   486      1           493   483 (NOTLB)
dbus-daemon-1 S 0000000000000000     0   493      1           497   486 (NOTLB)
000001003baabe88 0000000000000006 0000000100000075 000001003b9b70d0 
       00000000000c6616 000001003da8a880 000001003b9b7368 0000000000000001 
       00000000000000d0 ffffffff801581fe 
Call Trace:<ffffffff801581fe>{__alloc_pages+190} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff8010f3e6>{system_call+126} 
       
dhcpd3        S 00000004fcb07709     0   497      1           505   493 (NOTLB)
000001003b48fd88 0000000000000002 0000000100000074 000001003b9b6330 
       0000000000057805 000001003bd942f0 000001003b9b65c8 0000000000000001 
       00000000000000d0 ffffffff801581fe 
Call Trace:<ffffffff801581fe>{__alloc_pages+190} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
inetd         S 000001003fd9d9c0     0   505      1           514   497 (NOTLB)
000001003b4e3d88 0000000000000006 0000000100000075 000001003b4e1110 
       00000000000a903e 000001003b9b6a00 000001003b4e13a8 0000000000000001 
       00000000000000d0 ffffffff801581fe 
Call Trace:<ffffffff801581fe>{__alloc_pages+190} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
pxe           S 000001003b95f880     0   514      1           518   505 (NOTLB)
0000010039f5dd88 0000000000000006 0000000100000077 000001003da8a880 
       000000000001af8d 000001003b4e0a40 000001003da8ab18 0000000000000001 
       00000000000000d0 ffffffff801581fe 
Call Trace:<ffffffff801581fe>{__alloc_pages+190} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
nmbd          S 000000239a0713e8     0   518      1           525   514 (NOTLB)
00000100392efd88 0000000000000002 0000000000000286 000001003b4e0370 
       00000000000911d3 ffffffff80315780 000001003b4e0608 0000000000000001 
       00000000000000d0 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
smbd          S 00000005a7bfbd65     0   525      1   528     534   518 (NOTLB)
0000010038ab9d88 0000000000000002 0000000100000001 000001003da908c0 
       0000000000081164 000001003ffa0dd0 000001003da90b58 0000000000000000 
       00000000000000d2 00000000801581fe 
Call Trace:<ffffffff8029286e>{schedule_timeout+30} <ffffffff801492bc>{add_wait_queue+28} 
       <ffffffff8017c742>{pipe_poll+50} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
smbd          S 0000000000000000     0   528    525                     (NOTLB)
0000010038ad9f68 0000000000000002 0000000100000076 000001003b9b6a00 
       000000000005ec36 000001003da908c0 000001003b9b6c98 0000000000000000 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80141429>{sys_pause+25} <ffffffff8010f3e6>{system_call+126} 
       
sshd          S 00000005b6d3a9a6     0   534      1           541   525 (NOTLB)
00000100384e1d88 0000000000000006 0000000100000001 000001003da90f90 
       0000000000029eef 000001003ffa0dd0 000001003da91228 0000000000000000 
       0000000000000004 00000000801ace6f 
Call Trace:<ffffffff8029286e>{schedule_timeout+30} <ffffffff801492bc>{add_wait_queue+28} 
       <ffffffff80260f1f>{tcp_poll+47} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
cron          S 000000186152f456     0   541      1           547   534 (NOTLB)
000001003b509ee8 0000000000000006 0000000000000000 000001003b947050 
       0000000000008f3a ffffffff80315780 000001003b9472e8 0000000000000001 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff8013d2e2>{sys_nanosleep+194} 
       <ffffffff8010f3e6>{system_call+126} 
bash          S 000000072a66055a     0   547      1   555     548   541 (NOTLB)
0000010038b51e58 0000000000000006 000000013d977010 000001003d80f5e0 
       0000000000014973 000001003ffa0dd0 000001003d80f878 0000000000000000 
       000001003d80f880 ffffffff80131853 
Call Trace:<ffffffff80131853>{copy_mm+931} <ffffffff80137db9>{do_wait+3465} 
       <ffffffff8011ec1c>{do_page_fault+524} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8010f3e6>{system_call+126} 
       
getty         S 0000010038b64000     0   548      1           549   547 (NOTLB)
000001003b775d78 0000000000000002 0000000100000075 000001003bd10270 
       0000000000018c02 000001003d80f5e0 000001003bd10508 0000000000000075 
       0000010001d8d638 ffffffff80154e0a 
Call Trace:<ffffffff80154e0a>{filemap_nopage+410} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff801f6ec7>{read_chan+1143} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff801f0e94>{tty_ldisc_deref+116} <ffffffff801f138d>{tty_read+269} 
       <ffffffff8016fb87>{vfs_read+199} <ffffffff8016fe33>{sys_read+83} 
       <ffffffff8010f3e6>{system_call+126} 
getty         S 00000005feb547b1     0   549      1           550   548 (NOTLB)
000001003dffdd78 0000000000000002 0000000000000000 000001003b947720 
       000000000001e538 ffffffff80315780 000001003b9479b8 0000000000000001 
       0000010001d8d638 ffffffff80154e0a 
Call Trace:<ffffffff80154e0a>{filemap_nopage+410} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff801f6ec7>{read_chan+1143} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff801f0e94>{tty_ldisc_deref+116} <ffffffff801f138d>{tty_read+269} 
       <ffffffff8016fb87>{vfs_read+199} <ffffffff8016fe33>{sys_read+83} 
       <ffffffff8010f3e6>{system_call+126} 
getty         S 00000005feb322d8     0   550      1           551   549 (NOTLB)
0000010038ba1d78 0000000000000006 0000000000000000 000001003bd11010 
       0000000000014d2f ffffffff80315780 000001003bd112a8 0000000000000000 
       0000010001d8d638 ffffffff80154e0a 
Call Trace:<ffffffff80154e0a>{filemap_nopage+410} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff801f6ec7>{read_chan+1143} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff801f0e94>{tty_ldisc_deref+116} <ffffffff801f138d>{tty_read+269} 
       <ffffffff8016fb87>{vfs_read+199} <ffffffff8016fe33>{sys_read+83} 
       <ffffffff8010f3e6>{system_call+126} 
getty         S 00000005feb6d904     0   551      1           552   550 (NOTLB)
0000010038bb9d78 0000000000000002 0000000100000000 000001003d80e840 
       000000000000c0b1 000001003ffa0dd0 000001003d80ead8 0000000000000000 
       0000010001d8d638 ffffffff80154e0a 
Call Trace:<ffffffff80154e0a>{filemap_nopage+410} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff801f6ec7>{read_chan+1143} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff801f0e94>{tty_ldisc_deref+116} <ffffffff801f138d>{tty_read+269} 
       <ffffffff8016fb87>{vfs_read+199} <ffffffff8016fe33>{sys_read+83} 
       <ffffffff8010f3e6>{system_call+126} 
getty         S 000001003b9aa000     0   552      1           586   551 (NOTLB)
000001003b51dd78 0000000000000002 0000000100000075 000001003d80e170 
       000000000000c955 000001003d80e840 000001003d80e408 0000000000000075 
       0000010001d8d638 ffffffff80154e0a 
Call Trace:<ffffffff80154e0a>{filemap_nopage+410} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff801f6ec7>{read_chan+1143} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff801f0e94>{tty_ldisc_deref+116} <ffffffff801f138d>{tty_read+269} 
       <ffffffff8016fb87>{vfs_read+199} <ffffffff8016fe33>{sys_read+83} 
       <ffffffff8010f3e6>{system_call+126} 
xinit         S 000001003d80f028     0   555    547   556               (NOTLB)
000001003a2efe58 0000000000000006 0000000100000076 000001003d80ef10 
       0000000000001f19 000001003fd48800 000001003d80f1a8 000001003fd48928 
       00000000fffffff2 000001003a2eff00 
Call Trace:<ffffffff80137db9>{do_wait+3465} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff8010f3e6>{system_call+126} <ffffffff8010f3e6>{system_call+126} 
       
XFree86       S 000000246ca99392     0   556    555           577       (NOTLB)
0000010039091d88 0000000000000006 0000000000000073 000001003da8af50 
       00000000000001c4 ffffffff80315780 000001003da8b1e8 0000000000000001 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff8013c5ed>{__mod_timer+317} 
       <ffffffff80183df5>{sys_select+885} <ffffffff8010f3e6>{system_call+126} 
       
xfce4-session S 0000002463eff0a5     0   577    555   580           556 (NOTLB)
000001003874fe88 0000000000000006 0000000000000286 000001003fd48800 
       0000000000000bce ffffffff80315780 000001003fd48a98 0000000000000001 
       00000000000000d0 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80182f09>{sys_ioctl+1001} 
       <ffffffff8010f3e6>{system_call+126} 
sh            S 000001003da8a2c8     0   580    577   582               (NOTLB)
0000010038791e58 0000000000000002 0000000100000076 000001003da8a1b0 
       0000000000014554 000001003b9462b0 000001003da8a448 000001003b946980 
       000001003da8a450 ffffffff80131853 
Call Trace:<ffffffff80131853>{copy_mm+931} <ffffffff80137db9>{do_wait+3465} 
       <ffffffff8011ec1c>{do_page_fault+524} <ffffffff80140f61>{do_sigaction+577} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff801412f4>{sys_rt_sigaction+148} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8010f3e6>{system_call+126} 
       
xscreensaver  S 000000246ca42e29     0   582    580                     (NOTLB)
000001003a405d88 0000000000000002 0000000000000073 000001003b946980 
       00000000000008d5 000001003bd95090 000001003b946c18 0000000000000202 
       00000000000000d0 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80183a2c>{do_select+988} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80183df5>{sys_select+885} 
       <ffffffff8010f3e6>{system_call+126} 
xfce-mcs-mana S 000000246ca71a02     0   586      1           590   552 (NOTLB)
000001003aed7e88 0000000000000002 0000000000000073 000001003d0516a0 
       0000000000000e88 000001003b4e17e0 000001003d051938 0000000000000202 
       00000000000000d0 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80182f09>{sys_ioctl+1001} 
       <ffffffff8010f3e6>{system_call+126} 
xfwm4         S 000000246ca79721     0   590      1           591   586 (NOTLB)
00000100383dbe88 0000000000000006 0000000000000073 000001003b4e17e0 
       0000000000000c83 000001003bd10940 000001003b4e1a78 0000000000000001 
       00000000000000d0 ffffffff801581fe 
Call Trace:<ffffffff801581fe>{__alloc_pages+190} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80182f09>{sys_ioctl+1001} 
       <ffffffff8010f3e6>{system_call+126} 
xftaskbar4    S 000000246ca833ff     0   591      1           592   590 (NOTLB)
000001003afb9e88 0000000000000002 0000000000000073 000001003bd10940 
       0000000000000faf 000001003da901f0 000001003bd10bd8 0000000000000001 
       00000000000000d0 ffffffff801581fe 
Call Trace:<ffffffff801581fe>{__alloc_pages+190} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80182f09>{sys_ioctl+1001} 
       <ffffffff8010f3e6>{system_call+126} 
xfdesktop     S 000000246ca8d365     0   592      1           594   591 (NOTLB)
0000010037c0de88 0000000000000002 0000000000000073 000001003da901f0 
       0000000000000ff0 000001003da91660 000001003da90488 0000000000000001 
       00000000000000d0 ffffffff801581fe 
Call Trace:<ffffffff801581fe>{__alloc_pages+190} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff801492bc>{add_wait_queue+28} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80182f09>{sys_ioctl+1001} 
       <ffffffff8010f3e6>{system_call+126} 
xfce4-panel   S 000000246ca981e1     0   594      1           596   592 (NOTLB)
0000010037c1fe88 0000000000000002 0000000000000073 000001003da91660 
       0000000000001172 000001003da8af50 000001003da918f8 0000000000000202 
       00000000000000d0 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80182f09>{sys_ioctl+1001} 
       <ffffffff8010f3e6>{system_call+126} 
gnome-termina S 000000246ca688ae     0   596      1   601     598   594 (NOTLB)
0000010037ac7e88 0000000000000002 0000000000000073 000001003bd95090 
       0000000000000b69 000001003d0516a0 000001003bd95328 0000000000000202 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff80182f09>{sys_ioctl+1001} 
       <ffffffff8010f3e6>{system_call+126} 
gnome-termina S 0000000b42e34df9     0   603      1                 600 (NOTLB)
0000010036291df8 0000000000000002 0000000100000075 000001003b9462b0 
       000000000000bba5 000001003bd949c0 000001003b946548 0000000000000001 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff8017c070>{pipe_wait+160} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff8017c2c3>{pipe_readv+531} 
       <ffffffff8017c36a>{pipe_read+26} <ffffffff8016fb87>{vfs_read+199} 
       <ffffffff8016fe33>{sys_read+83} <ffffffff8010f3e6>{system_call+126} 
       
gconfd-2      S 0000001fc5544e62     0   598      1           600   596 (NOTLB)
0000010037389e88 0000000000000002 0000000000000001 000001003bd95760 
       000000000000af35 ffffffff80315780 000001003bd959f8 0000000000000001 
       0000000000000212 0000000000000000 
Call Trace:<ffffffff8013c5ed>{__mod_timer+317} <ffffffff802928fd>{schedule_timeout+173} 
       <ffffffff8013d1f0>{process_timeout+0} <ffffffff80184215>{sys_poll+629} 
       <ffffffff80183560>{__pollwait+0} <ffffffff8010f3e6>{system_call+126} 
       
bonobo-activa S 0000000af989b5d9     0   600      1           603   598 (NOTLB)
0000010036d2be88 0000000000000002 0000000000000001 000001003b4e0a40 
       00000000000007c9 ffffffff80315780 000001003b4e0cd8 0000000000000001 
       0000010036d46d18 000000008018bece 
Call Trace:<ffffffff8029286e>{schedule_timeout+30} <ffffffff80170c4b>{fget+91} 
       <ffffffff80184215>{sys_poll+629} <ffffffff80183560>{__pollwait+0} 
       <ffffffff80170473>{sys_writev+83} <ffffffff8010f3e6>{system_call+126} 
       
gnome-pty-hel S 0000000b42e56bf9     0   601    596           602       (NOTLB)
00000100361edbe8 0000000000000006 0000000100000007 000001003bd949c0 
       0000000000021e00 000001003ffa0dd0 000001003bd94c58 0000000000000001 
       000001003dff9a50 ffffffff801b3c6d 
Call Trace:<ffffffff801b3c6d>{__ext3_journal_stop+45} <ffffffff8029286e>{schedule_timeout+30} 
       <ffffffff80155c20>{generic_file_buffered_write+1040} 
       <ffffffff801493e3>{prepare_to_wait+35} <ffffffff8028ed51>{unix_stream_recvmsg+625} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff8018a461>{inode_update_time+193} 
       <ffffffff80149550>{autoremove_wake_function+0} <ffffffff8023e5a6>{sock_aio_read+278} 
       <ffffffff80170a25>{file_kill+21} <ffffffff8016fa8d>{do_sync_read+173} 
       <ffffffff80186b85>{fcntl_setlk+757} <ffffffff80149550>{autoremove_wake_function+0} 
       <ffffffff80187911>{dput+33} <ffffffff8016fba1>{vfs_read+225} 
       <ffffffff8016fe33>{sys_read+83} <ffffffff8010f3e6>{system_call+126} 
       
bash          S 0000000e08736929     0   602    596   606           601 (NOTLB)
0000010036237e58 0000000000000002 0000000036227010 000001003da8b620 
       000000000001b94f ffffffff80315780 000001003da8b8b8 0000000000000000 
       000001003da8b8c0 ffffffff80131853 
Call Trace:<ffffffff80131853>{copy_mm+931} <ffffffff80137db9>{do_wait+3465} 
       <ffffffff8011ec1c>{do_page_fault+524} <ffffffff80140f61>{do_sigaction+577} 
       <ffffffff8012f9f0>{default_wake_function+0} <ffffffff8012f9f0>{default_wake_function+0} 
       <ffffffff8010f3e6>{system_call+126} 
shmctl04      R  running task       0   606    602                     (NOTLB)

