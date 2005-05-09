Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVEINWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVEINWM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 09:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVEINWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 09:22:12 -0400
Received: from gw.exalead.com ([212.234.111.157]:21239 "EHLO exalead.com")
	by vger.kernel.org with ESMTP id S261367AbVEINSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 09:18:10 -0400
Message-ID: <427F6310.9020709@exalead.com>
Date: Mon, 09 May 2005 15:18:08 +0200
From: Xavier Roche <roche+kml2@exalead.com>
Organization: Exalead
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.7) Gecko/20050414
X-Accept-Language: fr, en-us, en, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel (2.6.11) deadlock in user mode when writing data through mmap
 on large files (64-bit systems, xfs or ext3)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

We managed to get a deadlock while writing data through mmap in a 
context where memory is highly stressed.

If you launch the program below with a size far greater than your RAM 
size (let's say 10 times), chances are that you will reproduce this 
deadlock.

This deadlock happens on xfs and on ext3fs, using Linux 2.6.11, on an 
EMT64 system.

$ uname -s -r -m -p -i -o
Linux 2.6.11-gentoo-r6 x86_64 Intel(R) Xeon(TM) CPU 3.20GHz GenuineIntel 
GNU/Linux


Crash test:
========================================================================
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <stdio.h>
#include <string.h>

#define MEGA (1024 * 1024)

/**
  * Usage : fname size (Mo)
  **/
int main(int argc, char* argv[]) {
   int fd0 = open(argv[1], O_RDWR | O_CREAT, S_IREAD | S_IWUSR);
   size_t size0 = ((size_t) atoi(argv[2])) * MEGA;
   char* ptr0;

   if (ftruncate(fd0, size0) != 0) {
     printf("error truncating file");
     return 1;
   }

   ptr0 = mmap(NULL,
	      size0,
	      (PROT_READ | PROT_WRITE),
	      (MAP_FILE | MAP_SHARED),
	      fd0,
	      0);
   {
     size_t i;
     for(i = 0; i < size0; i += MEGA) {
       (void) memset(ptr0 + i, 0, MEGA);
       if (i % ((100 * MEGA)) == 0) {
	int m = (int) (i / MEGA);
	int t = (int) (size0 / MEGA);
	printf("Creating : %d/%d\n", m, t);
       }
     }
   }

   if (msync((void*) ptr0, size0, MS_SYNC) != 0) {
     printf("error syncing file");
     return 1;
   }

   if (munmap(ptr0, size0) != 0) {
     printf("error closing file");
     return 1;
   }

   return 0;
}
========================================================================


Below, the SysRq output (For more lisibility, in the Show State section, 
I moved on top the output of the incriminated program (ngtest))
========================================================================

telnet> send break
SysRq : Changing Loglevel
Loglevel set to 8
XFS: possible memory allocation deadlock in kmem_alloc (mode:0x250)
XFS: possible memory allocation deadlock in kmem_alloc (mode:0x250)
[...]
XFS: possible memory allocation deadlock in kmem_alloc (mode:0x250)
XFS: possible memory allocation deadlock in kmem_alloc (mode:0x250)

telnet> send break
XFS: possible memory allocation deadlock in kmem_alloc (mode:0x250)
XFS: possible memory allocation deadlock in kmem_alloc (mode:0x250)
SysRq : Show State




                                                       sibling
  task                 PC          pid father child younger older

ngtest        D ffff810078303468     0 20514  20505 
(NOTLB)
ffff810078302eb8 0000000000000086 00000001013820a7 0000000000000008
       0000000000000086 0000006e7c5cfe88 ffffffff805915c0 ffff81007fe095a0
       000000000000006e ffff810002c1a780
Call Trace:<ffffffff80139d89>{__mod_timer+318} 
<ffffffff803782c2>{schedule_timeout+165}
       <ffffffff8013a8d0>{process_timeout+0} 
<ffffffff803781ff>{io_schedule_timeout+49}
       <ffffffff802b94cf>{blk_congestion_wait+151} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff8022982e>{kmem_alloc+210}
       <ffffffff802298cd>{kmem_realloc+43} 
<ffffffff8020d181>{xfs_iext_realloc+245}
       <ffffffff801e62a8>{xfs_bmap_insert_exlist+53} 
<ffffffff801e7194>{xfs_bmap_add_extent_hole_real+949}
       <ffffffff801e84df>{xfs_bmap_add_extent+4759} 
<ffffffff8021f92e>{xfs_trans_brelse+84}
       <ffffffff8021faa8>{xfs_trans_log_buf+107} 
<ffffffff801dbb04>{xfs_alloc_ag_vextent+4013}
       <ffffffff8022995c>{kmem_zone_alloc+70} 
<ffffffff801f215f>{xfs_btree_init_cursor+72}
       <ffffffff801eb7b7>{xfs_bmapi+6221} 
<ffffffff801e8be8>{xfs_bmap_do_search_extents+778}
       <ffffffff80210443>{xfs_iomap_write_direct+646} 
<ffffffff803786c7>{__down_write+129}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff8020ff2d>{xfs_iomap+569}
       <ffffffff802ba0ad>{submit_bio+221} 
<ffffffff80229b83>{xfs_map_blocks+66}
       <ffffffff8022a844>{xfs_page_state_convert+996} 
<ffffffff8017281c>{__set_page_dirty_buffers+191}
       <ffffffff801653c5>{page_referenced_file+209} 
<ffffffff80173958>{alloc_buffer_head+50}
       <ffffffff80173fa5>{alloc_page_buffers+99} 
<ffffffff8022af95>{linvfs_writepage+179}
       <ffffffff8015a457>{shrink_zone+3000} 
<ffffffff8022ab3d>{__linvfs_get_block+136}
       <ffffffff80241fc2>{__memset+50} 
<ffffffff80192ed3>{do_mpage_readpage+949}
       <ffffffff80157148>{do_drain+0} <ffffffff8012b801>{try_to_wake_up+755}
       <ffffffff8023e937>{radix_tree_node_alloc+19} 
<ffffffff8023eb29>{radix_tree_insert+291}
       <ffffffff8015aa0c>{try_to_free_pages+278} 
<ffffffff801534d8>{__alloc_pages+531}
       <ffffffff8015575e>{__do_page_cache_readahead+215} 
<ffffffff8014fe07>{filemap_nopage+347}
       <ffffffff8015f511>{do_no_page+984} 
<ffffffff8015f8e4>{handle_mm_fault+419}
       <ffffffff80378992>{_spin_unlock_irqrestore+5} 
<ffffffff8011d090>{do_page_fault+1185}
       <ffffffff8010dd9d>{error_exit+0}

init          D 0000000000000000     0     1      0     2 
(NOTLB)
ffff81007ff13728 0000000000000082 0000000000000000 0000000000000000
       ffff81007f8d1e00 ffffffff802bec15 0000000100000000 ffff81007958dbe8
       ffff81007fd2daa0 0000000000000003
Call Trace:<ffffffff802bec15>{as_insert_request+1073} 
<ffffffff802b9ba8>{__make_request+1270}
       <ffffffff803786c7>{__down_write+129} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff8020a319>{xfs_ilock+96} <ffffffff8020fdfc>{xfs_iomap+264}
       <ffffffff802ba0ad>{submit_bio+221} <ffffffff80173352>{submit_bh+295}
       <ffffffff80229b83>{xfs_map_blocks+66} 
<ffffffff8022a844>{xfs_page_state_convert+996}
       <ffffffff8017281c>{__set_page_dirty_buffers+191} 
<ffffffff801653c5>{page_referenced_file+209}
       <ffffffff80173958>{alloc_buffer_head+50} 
<ffffffff80173fa5>{alloc_page_buffers+99}
       <ffffffff8022af95>{linvfs_writepage+179} 
<ffffffff8015a457>{shrink_zone+3000}
       <ffffffff80157148>{do_drain+0} <ffffffff80157148>{do_drain+0}
       <ffffffff8011978b>{flat_send_IPI_allbutself+20} 
<ffffffff801176c4>{__smp_call_function+111}
       <ffffffff80157148>{do_drain+0} 
<ffffffff8012b2d9>{recalc_task_prio+317}
       <ffffffff8012b801>{try_to_wake_up+755} 
<ffffffff8019beb8>{mb_cache_shrink_fn+100}
       <ffffffff8012bbae>{finish_task_switch+64} 
<ffffffff8015aa0c>{try_to_free_pages+278}
       <ffffffff801534d8>{__alloc_pages+531} 
<ffffffff801536e7>{__get_free_pages+14}
       <ffffffff80182e2c>{__pollwait+75} <ffffffff8017c8d5>{pipe_poll+67}
       <ffffffff801831a8>{do_select+727} <ffffffff80182de1>{__pollwait+0}
       <ffffffff80183694>{sys_select+910} 
<ffffffff8010d39a>{system_call+126}

migration/0   S ffff810002c12760     0     2      1             3 
(L-TLB)
ffff8100032bdeb8 0000000000000046 0000000000000086 0000000000000004
       0000000000000003 0000007500000000 ffffffff805915c0 ffff81007ec19820
       0000000000000075 ffff810002c12780
Call Trace:<ffffffff8012e2f4>{migration_thread+518} 
<ffffffff8012e0ee>{migration_thread+0}
       <ffffffff801459e1>{kthread+218} <ffffffff8010df53>{child_rip+8}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

ksoftirqd/0   S ffffffff80565fb0     0     3      1             4     2 
(L-TLB)
ffff8100032c1f08 0000000000000046 ffff8100790b1210 0000000000000005
       ffffffff80594a00 000000000000000a 0000000000000000 0000000000000292
       0000000000000292 0000000000000000
Call Trace:<ffffffff80136883>{tasklet_action+107} 
<ffffffff801364b6>{__do_softirq+110}
       <ffffffff801369ea>{ksoftirqd+0} <ffffffff801369ea>{ksoftirqd+0}
       <ffffffff80136a2a>{ksoftirqd+64} <ffffffff801369ea>{ksoftirqd+0}
       <ffffffff801459e1>{kthread+218} <ffffffff8010df53>{child_rip+8}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

migration/1   S ffff810002c1a760     0     4      1             5     3 
(L-TLB)
ffff8100032c3eb8 0000000000000046 0000000000000086 0000000000000008
       0000000000000003 0000007600000000 ffffffff805915c0 ffff81007ec19820
       0000000000000076 ffff810002c1a780
Call Trace:<ffffffff8012e2f4>{migration_thread+518} 
<ffffffff8012e0ee>{migration_thread+0}
       <ffffffff801459e1>{kthread+218} <ffffffff8010df53>{child_rip+8}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

ksoftirqd/1   S ffffffff80565fb0     0     5      1             6     4 
(L-TLB)
ffff8100032d5f08 0000000000000046 ffff8100781a9870 0000000000000001
       ffffffff80594a00 0000000000000008 0000000000000001 0000000000000292
       0000000000000292 0000000000000000
Call Trace:<ffffffff80136883>{tasklet_action+107} 
<ffffffff801364b6>{__do_softirq+110}
       <ffffffff801369ea>{ksoftirqd+0} <ffffffff801369ea>{ksoftirqd+0}
       <ffffffff80136a2a>{ksoftirqd+64} <ffffffff801369ea>{ksoftirqd+0}
       <ffffffff801459e1>{kthread+218} <ffffffff8010df53>{child_rip+8}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

migration/2   S ffff810002c22760     0     6      1             7     5 
(L-TLB)
ffff8100032dbeb8 0000000000000046 0000000000000086 0000000000000001
       0000000000000003 0000007400000000 ffffffff805915c0 ffff81007ec19820
       0000000000000074 ffff810002c22780
Call Trace:<ffffffff8012e2f4>{migration_thread+518} 
<ffffffff8012e0ee>{migration_thread+0}
       <ffffffff801459e1>{kthread+218} <ffffffff8010df53>{child_rip+8}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

ksoftirqd/2   S ffffffff80565fb0     0     7      1             8     6 
(L-TLB)
ffff8100032ddf08 0000000000000046 ffff8100795a1990 0000000000000009
       ffffffff80594a00 000000000000000a 0000000000000002 0000000000000292
       0000000000000292 0000000000000000
Call Trace:<ffffffff80136883>{tasklet_action+107} 
<ffffffff801364b6>{__do_softirq+110}
       <ffffffff801369ea>{ksoftirqd+0} <ffffffff801369ea>{ksoftirqd+0}
       <ffffffff80136a2a>{ksoftirqd+64} <ffffffff801369ea>{ksoftirqd+0}
       <ffffffff801459e1>{kthread+218} <ffffffff8010df53>{child_rip+8}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

migration/3   S ffff810002c2a760     0     8      1             9     7 
(L-TLB)
ffff8100032efeb8 0000000000000046 0000000000000086 0000000000000002
       0000000000000003 0000007400000000 ffffffff805915c0 ffff810029b97660
       0000000000000074 ffff810002c2a780
Call Trace:<ffffffff8012e2f4>{migration_thread+518} 
<ffffffff8012e0ee>{migration_thread+0}
       <ffffffff801459e1>{kthread+218} <ffffffff8010df53>{child_rip+8}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

ksoftirqd/3   S ffffffff80565fb0     0     9      1            10     8 
(L-TLB)
ffff8100032f3f08 0000000000000046 0000000000018000 0000000000018000
       0000000000000000 ffffffff802f017f 0000000000000001 ffffffff802e2dcf
       ffff81007f89c800 0000000000002002
Call Trace:<ffffffff802f017f>{sd_rw_intr+704} 
<ffffffff802e2dcf>{scsi_device_unbusy+106}
       <ffffffff801364b6>{__do_softirq+110} <ffffffff801369ea>{ksoftirqd+0}
       <ffffffff801369ea>{ksoftirqd+0} <ffffffff80136a2a>{ksoftirqd+64}
       <ffffffff801369ea>{ksoftirqd+0} <ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} <ffffffff80145907>{kthread+0}
       <ffffffff8010df4b>{child_rip+0}
events/0      S ffffffff80157f98     0    10      1            11     9 
(L-TLB)
ffff8100032ffe58 0000000000000046 ffff81000143e848 ffff81000000c590
       ffff81000000c500 0000000000000292 0000000000000292 0000000000000286
       0000000000000286 0000000000000001
Call Trace:<ffffffff8012d15d>{__wake_up+67} <ffffffff80157f98>{cache_reap+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80141857>{worker_thread+0} <ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} <ffffffff80145907>{kthread+0}
       <ffffffff8010df4b>{child_rip+0}
events/1      S ffffffff80157f98     0    11      1            12    10 
(L-TLB)
ffff81007fe0be58 0000000000000046 ffff810003291cc0 0000000000000008
       ffff8100127fa000 0000007680156df0 ffffffff805915c0 ffff81007f0e5110
       0000000000000076 ffff810002c1a780
Call Trace:<ffffffff8012d15d>{__wake_up+67} <ffffffff80157f98>{cache_reap+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80141857>{worker_thread+0} <ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} <ffffffff80145907>{kthread+0}
       <ffffffff8010df4b>{child_rip+0}
events/2      S ffffffff80157f98     0    12      1            13    11 
(L-TLB)
ffff81007fe0fe58 0000000000000046 ffff810003291cc0 0000000000000001
       ffff810005d94000 0000007380156df0 ffffffff805915c0 ffff81007f871760
       0000000000000073 ffff810002c22780
Call Trace:<ffffffff8012d15d>{__wake_up+67} <ffffffff80157f98>{cache_reap+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80141857>{worker_thread+0} <ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} <ffffffff80145907>{kthread+0}
       <ffffffff8010df4b>{child_rip+0}
events/3      S ffffffff8024f486     0    13      1            14    12 
(L-TLB)
ffff81007fe13e58 0000000000000046 0000000000000001 0000000000000002
       ffff810002c2b600 0000007300000292 ffffffff805915c0 ffff81007ecc2b00
       0000000000000073 ffff810002c2a780
Call Trace:<ffffffff8012d15d>{__wake_up+67} 
<ffffffff8024f486>{flush_to_ldisc+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80141857>{worker_thread+0} <ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} <ffffffff80145907>{kthread+0}
       <ffffffff8010df4b>{child_rip+0}
khelper       S ffff81005db1bcf8     0    14      1            19    13 
(L-TLB)
ffff81007fe15e58 0000000000000046 ffff81005db1bd00 0000000000000008
       0000000000000292 000000705db1bd68 ffffffff805915c0 ffff81007ecc38a0
       0000000000000070 ffff810002c1a780
Call Trace:<ffffffff8012d15d>{__wake_up+67} <ffffffff8010df4b>{child_rip+0}
       <ffffffff8014141f>{__call_usermodehelper+0} 
<ffffffff80141989>{worker_thread+306}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff8012d0f3>{__wake_up_common+64}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff801459e1>{kthread+218} <ffffffff8010df53>{child_rip+8}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

kthread       S ffffffff80145a1c     0    19      1    33     136    14 
(L-TLB)
ffff81007fe2be58 0000000000000046 0000000000000082 ffffffff8012b801
       0000000000000003 000000017fe2bde8 ffff810002c19520 0000000000000002
       000000017fe2be38 0000000000000002
Call Trace:<ffffffff8012b801>{try_to_wake_up+755} 
<ffffffff8012d15d>{__wake_up+67}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141989>{worker_thread+306}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff8012d0f3>{__wake_up_common+64}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff801459e1>{kthread+218} <ffffffff8010df53>{child_rip+8}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

kacpid        S ffffffff80145a1c     0    33     19           120 
(L-TLB)
ffff81007fd2fe58 0000000000000046 ffffffff804f4160 0000000000000118
       000000000000003a 0000000000000000 ffffffff804f4160 0000000000000000
       0000000202c127e0 ffff81007fd2fe80
Call Trace:<ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

kblockd/0     S ffffffff802b84a3     0   120     19           121    33 
(L-TLB)
ffff81007fda5e58 0000000000000046 0000000000000000 ffffffff802bdf81
       ffffffff04000000 0000002300000060 ffff81007f89cb28 ffff81007f8d2280
       000000007fda5da0 ffff81007f8d2280
Call Trace:<ffffffff802bdf81>{as_remove_queued_request+278} 
<ffffffff8012d15d>{__wake_up+67}
       <ffffffff802b84a3>{blk_unplug_work+0} 
<ffffffff80141989>{worker_thread+306}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff8012d0f3>{__wake_up_common+64}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80141857>{worker_thread+0} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff801459e1>{kthread+218} <ffffffff8010df53>{child_rip+8}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80145907>{kthread+0}
       <ffffffff8010df4b>{child_rip+0}
kblockd/1     S ffffffff802bf4cb     0   121     19           122   120 
(L-TLB)
ffff81007fda9e58 0000000000000046 ffffffff00000000 000000bf00000060
       ffff81007f89cb28 ffff81006b19a500 000000006b19b780 ffff81006b19a500
       0000000000000292 ffff81007f89c800
Call Trace:<ffffffff8012d15d>{__wake_up+67} 
<ffffffff802bf4cb>{as_work_handler+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

kblockd/2     S ffffffff802b84a3     0   122     19           123   121 
(L-TLB)
ffff81007fdabe58 0000000000000046 0000000000000001 00002002802bdf81
       0000022b04000000 000000ec00000060 ffff81007f89cb28 ffff81007db3ac80
       0000022b7fdabda0 ffff81007db3ac80
Call Trace:<ffffffff8012d15d>{__wake_up+67} 
<ffffffff802b84a3>{blk_unplug_work+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

kblockd/3     S ffffffff802b84a3     0   123     19           194   122 
(L-TLB)
ffff81007fdade58 0000000000000046 0000000000000000 ffff81007f812200
       ffffffff04000000 0000001e00000060 ffff81007f89cb28 ffff81007f8d2280
       00000000032ca780 ffff81007f8d2280
Call Trace:<ffffffff8012d15d>{__wake_up+67} 
<ffffffff802b84a3>{blk_unplug_work+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

khubd         S ffffffff80565fb0     0   136      1           196    19 
(L-TLB)
ffff81007f803e38 0000000000000046 0000000000000000 ffffffffffffffff
       0000003000000008 ffff81007f803e48 ffff81007f803d88 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff80309d69>{hub_thread+2583} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff8010df53>{child_rip+8}
       <ffffffff80309352>{hub_thread+0} <ffffffff8010df4b>{child_rip+0}

pdflush       D ffffffff8014e993     0   194     19           197   123 
(L-TLB)
ffff81007f8159c8 0000000000000046 ffffffff80145f95 ffff81007f815920
       ffff81007f815920 ffffffff802bdf81 0000000000000000 ffff81007fda2880
       ffffffff80145f95 ffff81007f815920
Call Trace:<ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff802bdf81>{as_remove_queued_request+278}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff802e3f3d>{scsi_request_fn+1143}
       <ffffffff8014e993>{sync_page+0} <ffffffff803781c0>{io_schedule+49}
       <ffffffff8014e9d5>{sync_page+66} 
<ffffffff80378527>{__wait_on_bit_lock+66}
       <ffffffff8014f0b1>{__lock_page+164} 
<ffffffff80145fc3>{wake_bit_function+0}
       <ffffffff8014f3e4>{find_get_pages_tag+154} 
<ffffffff80145fc3>{wake_bit_function+0}
       <ffffffff801590ce>{pagevec_lookup_tag+26} 
<ffffffff801931e3>{mpage_writepages+409}
       <ffffffff8011ab7e>{dma_map_sg+660} 
<ffffffff8022aee2>{linvfs_writepage+0}
       <ffffffff802b6772>{elv_next_request+260} 
<ffffffff802e3f3d>{scsi_request_fn+1143}
       <ffffffff8022c94e>{pagebuf_iorequest+993} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff802158cf>{xfs_log_force+148} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80191f5d>{__writeback_single_inode+486} 
<ffffffff8021ed33>{xfs_trans_first_ail+28}
       <ffffffff80213084>{xfs_log_need_covered+168} 
<ffffffff80222546>{xfs_syncsub+2710}
       <ffffffff8019267d>{sync_sb_inodes+505} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff8019292c>{writeback_inodes+146} 
<ffffffff8015497a>{wb_kupdate+158}
       <ffffffff8015546d>{pdflush+323} <ffffffff801548dc>{wb_kupdate+0}
       <ffffffff8015532a>{pdflush+0} <ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

kswapd0       D 0000000000000000     0   196      1           209   136 
(L-TLB)
ffff81007f8198a8 0000000000000046 0000000100000000 0000000100000001
       ffff81007fd2daa0 ffff81000001e238 ffff810033dc0580 ffffffff802bf06f
       0000000000000000 0000000000000008
Call Trace:<ffffffff802bf06f>{as_merged_request+86} 
<ffffffff802b9ba8>{__make_request+1270}
       <ffffffff803786c7>{__down_write+129} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff8020a319>{xfs_ilock+96} <ffffffff8020fdfc>{xfs_iomap+264}
       <ffffffff802ba0ad>{submit_bio+221} <ffffffff80173352>{submit_bh+295}
       <ffffffff80229b83>{xfs_map_blocks+66} 
<ffffffff8022a844>{xfs_page_state_convert+996}
       <ffffffff8017281c>{__set_page_dirty_buffers+191} 
<ffffffff801653c5>{page_referenced_file+209}
       <ffffffff80173958>{alloc_buffer_head+50} 
<ffffffff80173fa5>{alloc_page_buffers+99}
       <ffffffff8022af95>{linvfs_writepage+179} 
<ffffffff8015a457>{shrink_zone+3000}
       <ffffffff8015ad0a>{balance_pgdat+540} <ffffffff8015af9d>{kswapd+315}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff8010df53>{child_rip+8} <ffffffff8015ae62>{kswapd+0}
       <ffffffff8010df4b>{child_rip+0}
aio/0         S ffffffff80145a1c     0   197     19           198   194 
(L-TLB)
ffff81007f82be58 0000000000000046 0000000000000000 0000000000000000
       0000000000000000 0000000000000000 0000000000000000 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

aio/1         S ffffffff80145a1c     0   198     19           199   197 
(L-TLB)
ffff81007f82fe58 0000000000000046 0000000000000000 0000000000000000
       0000000000000000 0000000000000000 0000000000000000 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

aio/2         S ffffffff80145a1c     0   199     19           200   198 
(L-TLB)
ffff81007f833e58 0000000000000046 0000000000000000 0000000000000000
       0000000000000000 0000000000000000 0000000000000000 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

aio/3         S ffffffff80145a1c     0   200     19           201   199 
(L-TLB)
ffff81007f835e58 0000000000000046 0000000000000000 0000000000000000
       0000000000000000 0000000000000000 0000000000000000 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

xfslogd/0     S ffffffff80145a1c     0   201     19           202   200 
(L-TLB)
ffff81007f859e58 0000000000000046 0000000000000000 0000000000000000
       0000000000000000 0000000000000000 0000000000000000 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

xfslogd/1     S ffffffff80145a1c     0   202     19           203   201 
(L-TLB)
ffff81007f85de58 0000000000000046 0000000000000000 0000000000000000
       0000000000000000 0000000000000000 0000000000000000 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

xfslogd/2     S ffffffff80145a1c     0   203     19           204   202 
(L-TLB)
ffff81007f85fe58 0000000000000046 0000000000000000 0000000000000000
       0000000000000000 0000000000000000 0000000000000000 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

xfslogd/3     S ffff81004fb89730     0   204     19           205   203 
(L-TLB)
ffff81007f863e58 0000000000000046 ffff81007d485cc0 0000000000000002
       0000000000000000 000000767fe07c50 ffffffff805915c0 ffff81007f0e5110
       0000000000000076 ffff810002c2a780
Call Trace:<ffffffff8012d15d>{__wake_up+67} 
<ffffffff8022c32c>{pagebuf_iodone_work+0}
       <ffffffff8022c32c>{pagebuf_iodone_work+0} 
<ffffffff80141989>{worker_thread+306}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff8012d0f3>{__wake_up_common+64}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80141857>{worker_thread+0} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff801459e1>{kthread+218} <ffffffff8010df53>{child_rip+8}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80145907>{kthread+0}
       <ffffffff8010df4b>{child_rip+0}
xfsdatad/0    S ffffffff80145a1c     0   205     19           206   204 
(L-TLB)
ffff81007f865e58 0000000000000046 0000000000000000 0000000000000000
       0000000000000000 0000000000000000 0000000000000000 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

xfsdatad/1    S ffffffff80145a1c     0   206     19           207   205 
(L-TLB)
ffff81007f869e58 0000000000000046 0000000000000000 0000000000000000
       0000000000000000 0000000000000000 0000000000000000 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

xfsdatad/2    S ffffffff80145a1c     0   207     19           208   206 
(L-TLB)
ffff81007f86de58 0000000000000046 0000000000000000 0000000000000000
       0000000000000000 0000000000000000 0000000000000000 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

xfsdatad/3    S ffffffff80145a1c     0   208     19         20564   207 
(L-TLB)
ffff81007f86fe58 0000000000000046 0000000000000000 0000000000000000
       0000000000000000 0000000000000000 0000000000000000 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80141989>{worker_thread+306} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0f3>{__wake_up_common+64} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff80141857>{worker_thread+0}
       <ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

xfsbufd       S ffffffff80565fb0     0   209      1           284   196 
(L-TLB)
ffff81007f873e98 0000000000000046 ffffffff80145f95 0000000000000001
       0000000100000001 0000000000000060 ffff81007f902750 ffff81007f89c000
       ffff81007f902720 0000000000000000
Call Trace:<ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff80139d89>{__mod_timer+318}
       <ffffffff803782c2>{schedule_timeout+165} 
<ffffffff8013a8d0>{process_timeout+0}
       <ffffffff8022d292>{pagebuf_daemon+144} 
<ffffffff8010df53>{child_rip+8}
       <ffffffff8022d202>{pagebuf_daemon+0} <ffffffff8010df4b>{child_rip+0}

kseriod       S ffffffff80565fb0     0   284      1           351   209 
(L-TLB)
ffff81007f8b9eb8 0000000000000046 0000000000000000 ffffffffffffffff
       0000003000000008 ffff81007f8b9ec8 ffff81007f8b9e08 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff802a4aa4>{serio_thread+443} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff8010df53>{child_rip+8}
       <ffffffff802a48e9>{serio_thread+0} <ffffffff8010df4b>{child_rip+0}

scsi_eh_0     S 0000000000000000     0   351      1           370   284 
(L-TLB)
ffff81007f8fbde8 0000000000000046 0000000401c000e1 ffff81007ff0b001
       ffff810003256b00 ffff8100032524b0 0000000100000000 ffff81007f86b344
       0000000000000002 ffff81007f86b34b
Call Trace:<ffffffff8012b36c>{activate_task+141} 
<ffffffff80376ac0>{__down_interruptible+208}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff80378824>{__down_failed_interruptible+53}
       <ffffffff802e2ace>{.text.lock.scsi_error+45} 
<ffffffff8014141f>{__call_usermodehelper+0}
       <ffffffff801342b8>{do_exit+2917} <ffffffff8010df53>{child_rip+8}
       <ffffffff802e1bba>{scsi_error_handler+0} 
<ffffffff8010df4b>{child_rip+0}

kjournald     S 0000000000000000     0   370      1           389   351 
(L-TLB)
ffff81007fb5fe58 0000000000000046 ffff810078b84978 ffff810078b84978
       ffff810078b84978 ffff810078b84978 ffff810078b84978 ffff810078b84978
       ffff810078b84978 ffff810078b84978
Call Trace:<ffffffff8012d15d>{__wake_up+67} 
<ffffffff801bfe70>{kjournald+534}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff801bfc54>{commit_timeout+0} <ffffffff8010df53>{child_rip+8}
       <ffffffff801bfc5a>{kjournald+0} <ffffffff8010df4b>{child_rip+0}

udevd         S 0000000000000028     0   389      1          3616   370 
(NOTLB)
ffff81007ecadd78 0000000000000082 0000000000000292 ffffffff80153152
       0000000000000292 0000007480153152 ffffffff805915c0 ffff81007c0e5110
       0000000000000074 000000d002c22780
Call Trace:<ffffffff80153152>{buffered_rmqueue+524} 
<ffffffff8037823c>{schedule_timeout+31}
       <ffffffff80145d40>{add_wait_queue+28} 
<ffffffff801832b9>{do_select+1000}
       <ffffffff80182de1>{__pollwait+0} <ffffffff80183694>{sys_select+910}
       <ffffffff8010d39a>{system_call+126}
kjournald     S 0000000000000000     0  3616      1          3617   389 
(L-TLB)
ffff81007cd57e58 0000000000000046 ffff81007efc6400 ffffffff80131bb4
       0000003000000010 ffff81007cd57e68 ffff81007cd57da8 ffff81007ce33b48
       ffff81007efc64a0 0000000000000005
Call Trace:<ffffffff80131bb4>{printk+141} <ffffffff8012d15d>{__wake_up+67}
       <ffffffff801bfe70>{kjournald+534} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff801bfc54>{commit_timeout+0}
       <ffffffff8010df53>{child_rip+8} <ffffffff801bfc5a>{kjournald+0}
       <ffffffff8010df4b>{child_rip+0}
kjournald     S ffff81007efc6200     0  3617      1          3618  3616 
(L-TLB)
ffff81007d289e58 0000000000000046 ffff81001d68d660 0000000000000002
       ffff81001d68d660 000000761d68d660 ffffffff805915c0 ffff81007f0e5110
       0000000000000076 ffff810002c2a780
Call Trace:<ffffffff8012d15d>{__wake_up+67} 
<ffffffff801bfe70>{kjournald+534}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff801bfc54>{commit_timeout+0} <ffffffff8010df53>{child_rip+8}
       <ffffffff801bfc5a>{kjournald+0} <ffffffff8010df4b>{child_rip+0}

kjournald     S ffff81007d682200     0  3618      1          3619  3617 
(L-TLB)
ffff81007d397e58 0000000000000046 ffff81005bc965b0 0000000000000002
       ffff81005bc965b0 000000765bc965b0 ffffffff805915c0 ffff81007f0e5110
       0000000000000076 ffff810002c2a780
Call Trace:<ffffffff8012d15d>{__wake_up+67} 
<ffffffff801bfe70>{kjournald+534}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff801bfc54>{commit_timeout+0} <ffffffff8010df53>{child_rip+8}
       <ffffffff801bfc5a>{kjournald+0} <ffffffff8010df4b>{child_rip+0}

xfssyncd      S 0000000000007530     0  3619      1          4821  3618 
(L-TLB)
ffff81007d413e88 0000000000000046 0000000000000031 0000000000000002
       ffffffff8037885e 0000007680222664 ffffffff805915c0 ffff81007f0e5110
       ffffffff8021ed33 ffff81007f8a3800
Call Trace:<ffffffff8037885e>{__down_failed_trylock+53} 
<ffffffff8021ed33>{xfs_trans_first_ail+28}
       <ffffffff80222546>{xfs_syncsub+2710} 
<ffffffff80139d89>{__mod_timer+318}
       <ffffffff803782c2>{schedule_timeout+165} 
<ffffffff8013a8d0>{process_timeout+0}
       <ffffffff80232105>{xfssyncd+150} 
<ffffffff80232621>{linvfs_fill_super+0}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80232621>{linvfs_fill_super+0}
       <ffffffff80221950>{xfs_root+0} <ffffffff8023206f>{xfssyncd+0}
       <ffffffff8010df4b>{child_rip+0}
syslogd       D 0000000000000000     0  4821      1          4887  3619 
(NOTLB)
ffff81007c7ab738 0000000000000086 0000000000000000 ffffffff801bf934
       ffff81001d68d608 ffff81007efc635c ffff81001d68d608 ffff81007b435710
       0000000000000000 ffffffff801bbd3c
Call Trace:<ffffffff801bf934>{journal_cancel_revoke+214} 
<ffffffff801bbd3c>{do_get_write_access+1622}
       <ffffffff803786c7>{__down_write+129} <ffffffff8020a319>{xfs_ilock+96}
       <ffffffff8020fdfc>{xfs_iomap+264} 
<ffffffff801bf934>{journal_cancel_revoke+214}
       <ffffffff8017516d>{__getblk+31} <ffffffff80229b83>{xfs_map_blocks+66}
       <ffffffff8022a844>{xfs_page_state_convert+996} 
<ffffffff8017281c>{__set_page_dirty_buffers+191}
       <ffffffff801653c5>{page_referenced_file+209} 
<ffffffff80173958>{alloc_buffer_head+50}
       <ffffffff80173fa5>{alloc_page_buffers+99} 
<ffffffff8022af95>{linvfs_writepage+179}
       <ffffffff8015a457>{shrink_zone+3000} 
<ffffffff801b3b24>{__ext3_journal_stop+45}
       <ffffffff801ab82f>{ext3_ordered_commit_write+183} 
<ffffffff80150ab9>{generic_file_buffered_write+1162}
       <ffffffff80322190>{skb_dequeue+95} 
<ffffffff80322a71>{skb_recv_datagram+141}
       <ffffffff8015aa0c>{try_to_free_pages+278} 
<ffffffff801534d8>{__alloc_pages+531}
       <ffffffff801536e7>{__get_free_pages+14} 
<ffffffff80182e2c>{__pollwait+75}
       <ffffffff80323217>{datagram_poll+36} 
<ffffffff801831a8>{do_select+727}
       <ffffffff80182de1>{__pollwait+0} <ffffffff80183694>{sys_select+910}
       <ffffffff8010d39a>{system_call+126}
klogd         S ffff81007c5cfd68     0  4887      1          5002  4821 
(NOTLB)
ffff81007c5cfbe8 0000000000000082 ffff81007c5cfb30 ffff81007ede2470
       0000000000000000 ffff81007ede2470 ffffffff80145f95 0000000000000092
       0000000000000092 ffffffff8011a00e
Call Trace:<ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff8011a00e>{flush_gart+225}
       <ffffffff8012b36c>{activate_task+141} 
<ffffffff8037823c>{schedule_timeout+31}
       <ffffffff80145eb9>{prepare_to_wait_exclusive+35} 
<ffffffff8036d39e>{unix_wait_for_peer+217}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff8012d15d>{__wake_up+67}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff80322773>{memcpy_fromiovec+55}
       <ffffffff8036df2c>{unix_dgram_sendmsg+960} 
<ffffffff8031cf65>{sock_aio_write+287}
       <ffffffff80170bbd>{do_sync_write+173} 
<ffffffff80131394>{do_syslog+536}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff8019d9ad>{dnotify_parent+51}
       <ffffffff80170cbd>{vfs_write+211} <ffffffff80170df7>{sys_write+83}
       <ffffffff8010d39a>{system_call+126}
gpm           S 0000000000000018     0  5002      1          5447  4887 
(NOTLB)
ffff81007c3e7d78 0000000000000086 0000000000000086 ffffffff8012b801
       0000000000000003 0000000000000296 0000000000000296 ffffffff80153152
       000000017fd8c528 0000000000000002
Call Trace:<ffffffff8012b801>{try_to_wake_up+755} 
<ffffffff80153152>{buffered_rmqueue+524}
       <ffffffff80139d89>{__mod_timer+318} 
<ffffffff803782c2>{schedule_timeout+165}
       <ffffffff8013a8d0>{process_timeout+0} 
<ffffffff801832b9>{do_select+1000}
       <ffffffff80182de1>{__pollwait+0} <ffffffff80183694>{sys_select+910}
       <ffffffff8010d39a>{system_call+126}
ntpd          D 0000000000000000     0  5447      1          5499  5002 
(NOTLB)
ffff81007bd23718 0000000000000086 ffff810054d0ab88 ffffffff80172d56
       ffff81007eadd6c0 0000000000000296 0000000000000003 ffff81007eadd6c0
       ffff81007bd23758 ffffffff803777de
Call Trace:<ffffffff80172d56>{__find_get_block+400} 
<ffffffff803777de>{thread_return+42}
       <ffffffff801bf934>{journal_cancel_revoke+214} 
<ffffffff803786c7>{__down_write+129}
       <ffffffff8020a319>{xfs_ilock+96} <ffffffff8020fdfc>{xfs_iomap+264}
       <ffffffff801bbd3c>{do_get_write_access+1622} 
<ffffffff801bbd3c>{do_get_write_access+1622}
       <ffffffff80229b83>{xfs_map_blocks+66} 
<ffffffff8022a844>{xfs_page_state_convert+996}
       <ffffffff8017281c>{__set_page_dirty_buffers+191} 
<ffffffff80173958>{alloc_buffer_head+50}
       <ffffffff80173fa5>{alloc_page_buffers+99} 
<ffffffff8022af95>{linvfs_writepage+179}
       <ffffffff8015a457>{shrink_zone+3000} 
<ffffffff8032b34f>{neigh_resolve_output+622}
       <ffffffff8033a645>{ip_finish_output+404} 
<ffffffff8033c65d>{ip_push_pending_frames+821}
       <ffffffff80356e32>{udp_push_pending_frames+530} 
<ffffffff8031f705>{release_sock+25}
       <ffffffff8015aa0c>{try_to_free_pages+278} 
<ffffffff801534d8>{__alloc_pages+531}
       <ffffffff801536e7>{__get_free_pages+14} 
<ffffffff80182e2c>{__pollwait+75}
       <ffffffff80323217>{datagram_poll+36} <ffffffff803587b1>{udp_poll+15}
       <ffffffff801831a8>{do_select+727} <ffffffff80182de1>{__pollwait+0}
       <ffffffff80183694>{sys_select+910} 
<ffffffff8010d39a>{system_call+126}

portmap       S 0000000000000000     0  5499      1          5550  5447 
(NOTLB)
ffff81007c60fe88 0000000000000086 0000000000000292 0000000000000002
       00002aaaaae797f4 000000767c4a64e8 ffffffff805915c0 ffff81007c442980
       0000000000000076 ffff810002c2a780
Call Trace:<ffffffff8037823c>{schedule_timeout+31} 
<ffffffff80145d40>{add_wait_queue+28}
       <ffffffff80145d40>{add_wait_queue+28} 
<ffffffff80183ab0>{sys_poll+620}
       <ffffffff80182de1>{__pollwait+0} <ffffffff8010d39a>{system_call+126}

snmpd         S 0000000000000f50     0  5550      1          5601  5499 
(NOTLB)
ffff81007b83bd78 0000000000000082 ffff81007d779460 0000000000000292
       0000000000000292 ffffffff80153152 ffff81007b83be18 ffffffff80151155
       0000000000000015 ffff81007cb14aa0
Call Trace:<ffffffff80153152>{buffered_rmqueue+524} 
<ffffffff80151155>{__generic_file_aio_write_nolock+964}
       <ffffffff8037823c>{schedule_timeout+31} 
<ffffffff80145d40>{add_wait_queue+28}
       <ffffffff80323217>{datagram_poll+36} <ffffffff803587b1>{udp_poll+15}
       <ffffffff801832b9>{do_select+1000} <ffffffff80182de1>{__pollwait+0}
       <ffffffff80183694>{sys_select+910} 
<ffffffff8010d39a>{system_call+126}

sshd          D 0000000000000000     0  5601      1 20493    5644  5550 
(NOTLB)
ffff81007ba4d7d8 0000000000000086 0000000000001fc9 000171324f6ebb1b
       ffff81007ff10030 ffff81007f8709c0 ffff81007f870c38 ffff81007f810000
       0000000000000002 0000000000000000
Call Trace:<ffffffff8011ab7e>{dma_map_sg+660} 
<ffffffff803786c7>{__down_write+129}
       <ffffffff8020a319>{xfs_ilock+96} <ffffffff8020fdfc>{xfs_iomap+264}
       <ffffffff801ab3b6>{ext3_get_branch+96} 
<ffffffff80229b83>{xfs_map_blocks+66}
       <ffffffff8022a844>{xfs_page_state_convert+996} 
<ffffffff8017281c>{__set_page_dirty_buffers+191}
       <ffffffff80173958>{alloc_buffer_head+50} 
<ffffffff80173fa5>{alloc_page_buffers+99}
       <ffffffff8022af95>{linvfs_writepage+179} 
<ffffffff8015a457>{shrink_zone+3000}
       <ffffffff8012bbae>{finish_task_switch+64} 
<ffffffff803777de>{thread_return+42}
       <ffffffff80167a23>{swap_info_get+189} 
<ffffffff80167a86>{swap_info_put+13}
       <ffffffff80167c1b>{can_share_swap_page+233} 
<ffffffff8015fbaf>{handle_mm_fault+1134}
       <ffffffff8023fa03>{__up_read+33} 
<ffffffff8011d0d3>{do_page_fault+1252}
       <ffffffff8014f10f>{find_get_page+88} 
<ffffffff8015aa0c>{try_to_free_pages+278}
       <ffffffff801534d8>{__alloc_pages+531} 
<ffffffff80156758>{cache_alloc_refill+414}
       <ffffffff801536e7>{__get_free_pages+14} 
<ffffffff8012f72f>{copy_process+209}
       <ffffffff8011d0d3>{do_page_fault+1252} 
<ffffffff80130966>{do_fork+228}
       <ffffffff8031c871>{sock_map_fd+336} 
<ffffffff8031d7b2>{__sock_create+329}
       <ffffffff8010d39a>{system_call+126} 
<ffffffff8010d70f>{ptregscall_common+103}

cron          D 0000000000000000     0  5644      1 20627    5697  5601 
(NOTLB)
ffff81007ba796e8 0000000000000082 0000000100000000 0000000100000001
       ffff81007fd2daa0 ffff810077c14710 ffff81000501b400 ffffffff802bf06f
       0000000000000000 0000000000000008
Call Trace:<ffffffff802bf06f>{as_merged_request+86} 
<ffffffff802b9ba8>{__make_request+1270}
       <ffffffff803786c7>{__down_write+129} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff8020a319>{xfs_ilock+96} <ffffffff8020fdfc>{xfs_iomap+264}
       <ffffffff802ba0ad>{submit_bio+221} <ffffffff80173352>{submit_bh+295}
       <ffffffff80229b83>{xfs_map_blocks+66} 
<ffffffff8022a844>{xfs_page_state_convert+996}
       <ffffffff8017281c>{__set_page_dirty_buffers+191} 
<ffffffff80173958>{alloc_buffer_head+50}
       <ffffffff80173fa5>{alloc_page_buffers+99} 
<ffffffff8022af95>{linvfs_writepage+179}
       <ffffffff8015a457>{shrink_zone+3000} <ffffffff80157148>{do_drain+0}
       <ffffffff80157148>{do_drain+0} 
<ffffffff8011978b>{flat_send_IPI_allbutself+20}
       <ffffffff801176c4>{__smp_call_function+111} 
<ffffffff80157148>{do_drain+0}
       <ffffffff8012b2d9>{recalc_task_prio+317} 
<ffffffff8012b801>{try_to_wake_up+755}
       <ffffffff8019beb8>{mb_cache_shrink_fn+100} 
<ffffffff80153152>{buffered_rmqueue+524}
       <ffffffff8023fa03>{__up_read+33} 
<ffffffff8015aa0c>{try_to_free_pages+278}
       <ffffffff801534d8>{__alloc_pages+531} 
<ffffffff8015375c>{get_zeroed_page+36}
       <ffffffff8015c407>{__pud_alloc+55} 
<ffffffff8015ccfa>{copy_page_range+370}
       <ffffffff80130224>{copy_process+3014} <ffffffff80130966>{do_fork+228}
       <ffffffff80139ff8>{del_singleshot_timer_sync+22} 
<ffffffff8010d39a>{system_call+126}
       <ffffffff8010d70f>{ptregscall_common+103}
xinetd        S 0000000000000068     0  5697      1          5712  5644 
(NOTLB)
ffff81007ba8fd78 0000000000000086 0000000000000000 0000000000000292
       0000000000000292 ffffffff80153152 0000000000000000 0000000000524f70
       0000000000000000 0000000000000000
Call Trace:<ffffffff80153152>{buffered_rmqueue+524} 
<ffffffff8037823c>{schedule_timeout+31}
       <ffffffff80145d40>{add_wait_queue+28} 
<ffffffff801832b9>{do_select+1000}
       <ffffffff80182de1>{__pollwait+0} <ffffffff80183694>{sys_select+910}
       <ffffffff8010d39a>{system_call+126}
agetty        S 0000000a6c99d880     0  5712      1          5713  5697 
(NOTLB)
ffff81007f251d78 0000000000000086 0000000000000292 0000000000000008
       ffff81007f251cc8 000000747c614018 ffffffff805915c0 ffff81007d6d1660
       0000000000000074 ffff810002c1a780
Call Trace:<ffffffff8024bd99>{tty_ldisc_deref+119} 
<ffffffff8037823c>{schedule_timeout+31}
       <ffffffff80131920>{release_console_sem+395} 
<ffffffff80145d40>{add_wait_queue+28}
       <ffffffff80251af8>{read_chan+1149} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff8024bd99>{tty_ldisc_deref+119}
       <ffffffff8024c173>{tty_read+216} <ffffffff80170aa2>{vfs_read+189}
       <ffffffff80170d6b>{sys_read+83} <ffffffff8010d39a>{system_call+126}

agetty        S 0000000000000001     0  5713      1          5714  5712 
(NOTLB)
ffff81007cb4fd78 0000000000000082 0000000000000292 ffffffff8024bd51
       ffff81007cb4fcc8 ffff81007d25d018 0000000300000000 0000000000000292
       0000000000000292 ffffffff80131920
Call Trace:<ffffffff8024bd51>{tty_ldisc_deref+47} 
<ffffffff80131920>{release_console_sem+395}
       <ffffffff8024bd99>{tty_ldisc_deref+119} 
<ffffffff8037823c>{schedule_timeout+31}
       <ffffffff80131920>{release_console_sem+395} 
<ffffffff80145d40>{add_wait_queue+28}
       <ffffffff80251af8>{read_chan+1149} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff8024bd99>{tty_ldisc_deref+119}
       <ffffffff8024c173>{tty_read+216} <ffffffff80170aa2>{vfs_read+189}
       <ffffffff80170d6b>{sys_read+83} <ffffffff8010d39a>{system_call+126}

agetty        S 0000000a6c938c16     0  5714      1          5715  5713 
(NOTLB)
ffff81007c3c9d78 0000000000000086 0000000000000292 0000000000000008
       ffff81007c3c9cc8 000000747ba53018 ffffffff805915c0 ffff81007f8b70d0
       0000000000000074 ffff810002c1a780
Call Trace:<ffffffff8024bd99>{tty_ldisc_deref+119} 
<ffffffff8037823c>{schedule_timeout+31}
       <ffffffff80131920>{release_console_sem+395} 
<ffffffff80145d40>{add_wait_queue+28}
       <ffffffff80251af8>{read_chan+1149} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff8024bd99>{tty_ldisc_deref+119}
       <ffffffff8024c173>{tty_read+216} <ffffffff80170aa2>{vfs_read+189}
       <ffffffff80170d6b>{sys_read+83} <ffffffff8010d39a>{system_call+126}

agetty        S 0000000000000001     0  5715      1          5716  5714 
(NOTLB)
ffff81007bb1fd78 0000000000000086 0000000000000292 ffffffff8024bd51
       ffff81007bb1fcc8 ffff81007ba66018 0000000300000000 0000000000000292
       0000000000000292 ffffffff80131920
Call Trace:<ffffffff8024bd51>{tty_ldisc_deref+47} 
<ffffffff80131920>{release_console_sem+395}
       <ffffffff8024bd99>{tty_ldisc_deref+119} 
<ffffffff8037823c>{schedule_timeout+31}
       <ffffffff80131920>{release_console_sem+395} 
<ffffffff80145d40>{add_wait_queue+28}
       <ffffffff80251af8>{read_chan+1149} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff8024bd99>{tty_ldisc_deref+119}
       <ffffffff8024c173>{tty_read+216} <ffffffff80170aa2>{vfs_read+189}
       <ffffffff80170d6b>{sys_read+83} <ffffffff8010d39a>{system_call+126}

agetty        S 0000000000000001     0  5716      1          5717  5715 
(NOTLB)
ffff81007bf67d78 0000000000000082 0000000000000292 ffffffff8024bd51
       ffff81007bf67cc8 ffff81007c07a018 0000000300000000 0000000000000292
       0000000000000292 ffffffff80131920
Call Trace:<ffffffff8024bd51>{tty_ldisc_deref+47} 
<ffffffff80131920>{release_console_sem+395}
       <ffffffff8024bd99>{tty_ldisc_deref+119} 
<ffffffff8037823c>{schedule_timeout+31}
       <ffffffff80131920>{release_console_sem+395} 
<ffffffff80145d40>{add_wait_queue+28}
       <ffffffff80251af8>{read_chan+1149} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff8024bd99>{tty_ldisc_deref+119}
       <ffffffff8024c173>{tty_read+216} <ffffffff80170aa2>{vfs_read+189}
       <ffffffff80170d6b>{sys_read+83} <ffffffff8010d39a>{system_call+126}

agetty        S ffff81007cb80000     0  5717      1          5718  5716 
(NOTLB)
ffff81007ca87d78 0000000000000082 0000000000000292 0000000000000008
       ffff81007ca87cc8 000000747cb80018 ffffffff805915c0 ffff81007d6d1660
       0000000000000074 ffff810002c1a780
Call Trace:<ffffffff8024bd99>{tty_ldisc_deref+119} 
<ffffffff8037823c>{schedule_timeout+31}
       <ffffffff80131920>{release_console_sem+395} 
<ffffffff80145d40>{add_wait_queue+28}
       <ffffffff80251af8>{read_chan+1149} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff8024bd99>{tty_ldisc_deref+119}
       <ffffffff8024c173>{tty_read+216} <ffffffff80170aa2>{vfs_read+189}
       <ffffffff80170d6b>{sys_read+83} <ffffffff8010d39a>{system_call+126}

agetty        D 0000000000000000     0  5718      1                5717 
(NOTLB)
ffff81007cae54d8 0000000000000086 0000000000000000 0000000000000000
       0000000000000000 0000000000000000 0000000000000000 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff803786c7>{__down_write+129} 
<ffffffff8020a319>{xfs_ilock+96}
       <ffffffff8020fdfc>{xfs_iomap+264} 
<ffffffff80229b83>{xfs_map_blocks+66}
       <ffffffff8022a844>{xfs_page_state_convert+996} 
<ffffffff8017281c>{__set_page_dirty_buffers+191}
       <ffffffff801653c5>{page_referenced_file+209} 
<ffffffff80173958>{alloc_buffer_head+50}
       <ffffffff80173fa5>{alloc_page_buffers+99} 
<ffffffff8022af95>{linvfs_writepage+179}
       <ffffffff8015a457>{shrink_zone+3000} <ffffffff80157148>{do_drain+0}
       <ffffffff80157148>{do_drain+0} 
<ffffffff8011978b>{flat_send_IPI_allbutself+20}
       <ffffffff8012b2d9>{recalc_task_prio+317} 
<ffffffff8012b36c>{activate_task+141}
       <ffffffff8015aa0c>{try_to_free_pages+278} 
<ffffffff801534d8>{__alloc_pages+531}
       <ffffffff80167591>{read_swap_cache_async+125} 
<ffffffff8015f0b7>{swapin_readahead+100}
       <ffffffff8015f999>{handle_mm_fault+600} 
<ffffffff8011d090>{do_page_fault+1185}
       <ffffffff80377806>{thread_return+82} 
<ffffffff8024bd51>{tty_ldisc_deref+47}
       <ffffffff8010dd9d>{error_exit+0} 
<ffffffff80241572>{copy_user_generic+178}
       <ffffffff80251cfc>{read_chan+1665} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff8024bd99>{tty_ldisc_deref+119}
       <ffffffff8024c173>{tty_read+216} <ffffffff80170aa2>{vfs_read+189}
       <ffffffff80170d6b>{sys_read+83} <ffffffff8010d39a>{system_call+126}

sshd          S ffff8100780afd68     0 20493   5601 20498   20525 
(NOTLB)
ffff8100780afbd8 0000000000000082 ffff81007f211580 ffff8100780afb48
       0000000000000001 ffffffff8031f48e ffff8100780afe28 ffffffff80323d65
       ffff810078abaaa0 ffffffff00000000
Call Trace:<ffffffff8031f48e>{sock_alloc_send_skb+102} 
<ffffffff80323d65>{__scm_send+294}
       <ffffffff8036e318>{unix_stream_sendmsg+709} 
<ffffffff8037823c>{schedule_timeout+31}
       <ffffffff80145e41>{prepare_to_wait+35} 
<ffffffff8036e95d>{unix_stream_recvmsg+615}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff8036e318>{unix_stream_sendmsg+709}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff8031ce24>{sock_aio_read+278}
       <ffffffff801709b8>{do_sync_read+173} 
<ffffffff80178e0c>{chrdev_open+391}
       <ffffffff8016ffac>{dentry_open+284} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff801700d2>{filp_open+63} <ffffffff80170ab5>{vfs_read+208}
       <ffffffff80170d6b>{sys_read+83} <ffffffff8010d39a>{system_call+126}

sshd          D 0000000000000000     0 20498  20493 20505 
(NOTLB)
ffff8100787bd708 0000000000000086 0000000000000000 0000000000000000
       0000000000000000 0000000000000000 0000000000000000 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff803786c7>{__down_write+129} 
<ffffffff8020a319>{xfs_ilock+96}
       <ffffffff8020fdfc>{xfs_iomap+264} 
<ffffffff8014f10f>{find_get_page+88}
       <ffffffff80172d56>{__find_get_block+400} 
<ffffffff80229b83>{xfs_map_blocks+66}
       <ffffffff8022a844>{xfs_page_state_convert+996} 
<ffffffff8017281c>{__set_page_dirty_buffers+191}
       <ffffffff80173958>{alloc_buffer_head+50} 
<ffffffff80173fa5>{alloc_page_buffers+99}
       <ffffffff8022af95>{linvfs_writepage+179} 
<ffffffff8015a457>{shrink_zone+3000}
       <ffffffff80156758>{cache_alloc_refill+414} 
<ffffffff80151d86>{mempool_alloc+164}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff8011a00e>{flush_gart+225}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff8015aa0c>{try_to_free_pages+278}
       <ffffffff801534d8>{__alloc_pages+531} 
<ffffffff80167591>{read_swap_cache_async+125}
       <ffffffff8015f0b7>{swapin_readahead+100} 
<ffffffff8015f999>{handle_mm_fault+600}
       <ffffffff8011d090>{do_page_fault+1185} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff8018380c>{sys_select+1286} <ffffffff80170ab5>{vfs_read+208}
       <ffffffff8010dd9d>{error_exit+0}
bash          S ffff81007c443720     0 20505  20498 20514 
(NOTLB)
ffff81007814de58 0000000000000082 ffff810002a4a640 0000000000000296
       0000000000000296 ffffffff8015ec10 ffff81007eadc0a8 ffff81007806a010
       ffff81007c57f378 800000007819e065
Call Trace:<ffffffff8015ec10>{do_wp_page+989} 
<ffffffff8013543e>{do_wait+3483}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8010d39a>{system_call+126}

sshd          S ffff81006d477d68     0 20525   5601 20530         20493 
(NOTLB)
ffff81006d477bd8 0000000000000086 ffff81006d4e5a80 ffff81006d477b48
       0000000000000001 ffffffff8031f48e ffff81006d477e28 ffffffff80323d65
       ffff810078abaaa0 ffffffff00000000
Call Trace:<ffffffff8031f48e>{sock_alloc_send_skb+102} 
<ffffffff80323d65>{__scm_send+294}
       <ffffffff8036e318>{unix_stream_sendmsg+709} 
<ffffffff8037823c>{schedule_timeout+31}
       <ffffffff80145e41>{prepare_to_wait+35} 
<ffffffff8036e95d>{unix_stream_recvmsg+615}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff8036e318>{unix_stream_sendmsg+709}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff8031ce24>{sock_aio_read+278}
       <ffffffff801709b8>{do_sync_read+173} 
<ffffffff80178e0c>{chrdev_open+391}
       <ffffffff8016ffac>{dentry_open+284} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff801700d2>{filp_open+63} <ffffffff80170ab5>{vfs_read+208}
       <ffffffff80170d6b>{sys_read+83} <ffffffff8010d39a>{system_call+126}

sshd          S 0000000000000328     0 20530  20525 20543 
(NOTLB)
ffff81005db1bd78 0000000000000086 0000000100000246 ffffffff8031f705
       0000000000000005 0000000000000296 0000000000000296 ffffffff80153152
       0000000000000292 ffffffff8034045b
Call Trace:<ffffffff8031f705>{release_sock+25} 
<ffffffff80153152>{buffered_rmqueue+524}
       <ffffffff8034045b>{tcp_sendmsg+3985} 
<ffffffff8024bc2f>{tty_ldisc_try+71}
       <ffffffff8037823c>{schedule_timeout+31} 
<ffffffff8024bd99>{tty_ldisc_deref+119}
       <ffffffff80145d40>{add_wait_queue+28} 
<ffffffff801832b9>{do_select+1000}
       <ffffffff80182de1>{__pollwait+0} 
<ffffffff80136417>{current_fs_time+82}
       <ffffffff80183694>{sys_select+910} 
<ffffffff8010d39a>{system_call+126}

bash          S ffff81007ecc38a0     0 20543  20530 20550 
(NOTLB)
ffff81005bd1de58 0000000000000086 ffff810002416980 0000000000000296
       0000000000000296 ffff81005bd1dda8 ffffffff8012b2d9 0000000000000000
       ffff81005bd1ddd8 ffffffff8012b36c
Call Trace:<ffffffff8012b2d9>{recalc_task_prio+317} 
<ffffffff8012b36c>{activate_task+141}
       <ffffffff8013543e>{do_wait+3483} 
<ffffffff8012d0a5>{default_wake_function+0}
       <ffffffff8012d0a5>{default_wake_function+0} 
<ffffffff8010d39a>{system_call+126}

iostat        D 0000000000000000     0 20550  20543 
(NOTLB)
ffff8100316eb5c8 0000000000000082 0000000100000000 0000000100000001
       ffff81007fd2daa0 ffff81007a573140 ffff810066c66d00 ffffffff802bf06f
       0000000000000000 0000000000000008
Call Trace:<ffffffff802bf06f>{as_merged_request+86} 
<ffffffff802b9ba8>{__make_request+1270}
       <ffffffff803786c7>{__down_write+129} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff8020a319>{xfs_ilock+96} <ffffffff8020fdfc>{xfs_iomap+264}
       <ffffffff802ba0ad>{submit_bio+221} <ffffffff80173352>{submit_bh+295}
       <ffffffff80229b83>{xfs_map_blocks+66} 
<ffffffff8022a844>{xfs_page_state_convert+996}
       <ffffffff8017281c>{__set_page_dirty_buffers+191} 
<ffffffff80173958>{alloc_buffer_head+50}
       <ffffffff80173fa5>{alloc_page_buffers+99} 
<ffffffff8022af95>{linvfs_writepage+179}
       <ffffffff8015a457>{shrink_zone+3000} <ffffffff80157148>{do_drain+0}
       <ffffffff80157148>{do_drain+0} 
<ffffffff8011978b>{flat_send_IPI_allbutself+20}
       <ffffffff801176c4>{__smp_call_function+111} 
<ffffffff80157148>{do_drain+0}
       <ffffffff8012b2d9>{recalc_task_prio+317} 
<ffffffff8012b801>{try_to_wake_up+755}
       <ffffffff8019beb8>{mb_cache_shrink_fn+100} 
<ffffffff8015aa0c>{try_to_free_pages+278}
       <ffffffff801534d8>{__alloc_pages+531} 
<ffffffff8015f3c5>{do_no_page+652}
       <ffffffff8015f8e4>{handle_mm_fault+419} 
<ffffffff8011d090>{do_page_fault+1185}
       <ffffffff801a0eaf>{proc_lookup+135} 
<ffffffff8019e3c2>{proc_root_lookup+64}
       <ffffffff8017d81c>{do_lookup+216} <ffffffff8010dd9d>{error_exit+0}
       <ffffffff802414ff>{copy_user_generic+63} 
<ffffffff8018f8e9>{seq_read+507}
       <ffffffff80170aa2>{vfs_read+189} <ffffffff80170d6b>{sys_read+83}
       <ffffffff8010d39a>{system_call+126}
pdflush       S ffff810049617ef0     0 20564     19                 208 
(L-TLB)
ffff810049617ec8 0000000000000046 ffff810049617e10 0000000000000002
       0000000000000000 000000767ecc31d0 ffffffff805915c0 ffff81007f0e5110
       0000000000000076 ffff810002c2a780
Call Trace:<ffffffff80145a1c>{keventd_create_kthread+0} 
<ffffffff801553e6>{pdflush+188}
       <ffffffff8015532a>{pdflush+0} <ffffffff801459e1>{kthread+218}
       <ffffffff8010df53>{child_rip+8} 
<ffffffff80145a1c>{keventd_create_kthread+0}
       <ffffffff80145907>{kthread+0} <ffffffff8010df4b>{child_rip+0}

cron          D 0000000000000000     0 20627   5644 
(NOTLB)
ffff81005e90d738 0000000000000082 0000000005000000 ffff81002f5d41c8
       0000000006000000 ffff810030846110 0000000007010003 ffff81006635c560
       0000000008010002 0000000000000000
Call Trace:<ffffffff803786c7>{__down_write+129} 
<ffffffff8020a319>{xfs_ilock+96}
       <ffffffff8020fdfc>{xfs_iomap+264} 
<ffffffff8021e462>{xfs_trans_committed+0}
       <ffffffff80229b83>{xfs_map_blocks+66} 
<ffffffff8022a844>{xfs_page_state_convert+996}
       <ffffffff8017281c>{__set_page_dirty_buffers+191} 
<ffffffff801653c5>{page_referenced_file+209}
       <ffffffff80173958>{alloc_buffer_head+50} 
<ffffffff80173fa5>{alloc_page_buffers+99}
       <ffffffff8022af95>{linvfs_writepage+179} 
<ffffffff8015a457>{shrink_zone+3000}
       <ffffffff8010dd9d>{error_exit+0} 
<ffffffff8015aa0c>{try_to_free_pages+278}
       <ffffffff801534d8>{__alloc_pages+531} 
<ffffffff80167a86>{swap_info_put+13}
       <ffffffff8015ea7f>{do_wp_page+588} 
<ffffffff8015fbd7>{handle_mm_fault+1174}
       <ffffffff8011d090>{do_page_fault+1185} 
<ffffffff8016101e>{remove_vm_struct+128}
       <ffffffff801624a1>{do_munmap+906} <ffffffff80378712>{__down_read+51}
       <ffffffff8023f8ce>{__up_write+49} <ffffffff8010dd9d>{error_exit+0}





