Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267389AbUIJM6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267389AbUIJM6o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 08:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267391AbUIJM6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 08:58:44 -0400
Received: from lax-gate4.raytheon.com ([199.46.200.233]:54762 "EHLO
	lax-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S267389AbUIJM6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 08:58:20 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Date: Fri, 10 Sep 2004 07:57:22 -0500
Message-ID: <OFFF07CECA.A4F18108-ON86256F0B.00472BB6-86256F0B.00472BCC@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/10/2004 07:57:30 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>You could also try lower DMA modes, I don't know if that will help or
>not but UDMA133 is essentially "one entire PCI 32/33Mhz bus worth of
>traffic so the effects are not too suprising. IDE control ports can give
>you long stalls too especially if IORDY is in use.

It appears I finally figured it out and have the drive running with udma2
instead of udma4. For reference:

# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 64 (on)
 geometry     = 58168/16/63, sectors = 58633344, start = 0
# hdparm -i /dev/hda

/dev/hda:

 Model=WDC WD300BB-00AUA1, FwRev=18.20D18, SerialNo=WD-WMA6W1764218
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=58633344
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:

 * signifies the current active mode

The same test I ran yesterday
 head -c 750000000 /dev/zero >tmpfile (disk writes)
 cp tmpfile tmpfile2 (disk copy)
 cat tmpfile tmpfile2 >/dev/null
ran with the following results late last night. All are traces > 200 usec
[much smaller limit than before] No traces > 600 usec.

Exit Mmap - Traces 00 01 02 03 04 05 10 13 24 26
Kswapd0   - Traces 06 07 08 09 11 12 14 16..23 25 27
Spin lock - Trace  15

Exit Mmap
=========

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 209 us, entries: 34 (34)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: sleep/4436, uid:0 nice:-9 policy:0 rt_prio:0
    -----------------
 => started at: cond_resched_lock+0x1d/0xa0
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): touch_preempt_timing (cond_resched_lock)
00000001 0.000ms (+0.001ms): __bitmap_weight (unmap_vmas)
00000001 0.001ms (+0.002ms): vm_acct_memory (exit_mmap)
00000001 0.003ms (+0.113ms): clear_page_tables (exit_mmap)
00010001 0.117ms (+0.000ms): do_nmi (clear_page_tables)
00010001 0.117ms (+0.003ms): do_nmi (avc_has_perm)
00010001 0.121ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010001 0.121ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010001 0.121ms (+0.000ms): profile_hook (profile_tick)
00010001 0.121ms (+0.000ms): read_lock (profile_hook)
00010002 0.121ms (+0.000ms): read_lock (<00000000>)
00010002 0.122ms (+0.000ms): notifier_call_chain (profile_hook)
00010002 0.122ms (+0.000ms): _read_unlock (profile_tick)
00010001 0.122ms (+0.078ms): profile_hit (nmi_watchdog_tick)
00000001 0.200ms (+0.002ms): flush_tlb_mm (exit_mmap)
00000001 0.202ms (+0.000ms): free_pages_and_swap_cache (exit_mmap)

Kswapd0
=======

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 539 us, entries: 719 (719)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: kswapd0/40, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: spin_lock+0x24/0x90
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): spin_lock (page_referenced_file)
00000001 0.000ms (+0.000ms): spin_lock (<00000000>)
00000001 0.000ms (+0.000ms): vma_prio_tree_next (page_referenced_file)
00000001 0.000ms (+0.000ms): prio_tree_first (vma_prio_tree_next)
00000001 0.001ms (+0.001ms): prio_tree_left (prio_tree_first)
00000001 0.003ms (+0.000ms): page_referenced_one (page_referenced_file)
00000001 0.004ms (+0.000ms): spin_lock (page_referenced_one)
00000002 0.005ms (+0.001ms): spin_lock (<00000000>)
00000002 0.006ms (+0.000ms): kmap_atomic (page_referenced_one)
00000003 0.006ms (+0.000ms): page_address (page_referenced_one)
00000003 0.007ms (+0.000ms): kunmap_atomic (page_referenced_one)
00000002 0.007ms (+0.000ms): _spin_unlock (page_referenced_one)
00000001 0.007ms (+0.000ms): vma_prio_tree_next (page_referenced_file)
00000001 0.008ms (+0.001ms): page_referenced_one (page_referenced_file)
00000001 0.009ms (+0.000ms): spin_lock (page_referenced_one)
00000002 0.009ms (+0.002ms): spin_lock (<00000000>)
... cycle repeats a number of times ...
00000001 0.535ms (+0.000ms): preempt_schedule (page_referenced_one)
00000001 0.536ms (+0.000ms): vma_prio_tree_next (page_referenced_file)
00000001 0.536ms (+0.000ms): page_referenced_one (page_referenced_file)
00000001 0.537ms (+0.000ms): spin_lock (page_referenced_one)
00000002 0.537ms (+0.000ms): spin_lock (<00000000>)
00000002 0.538ms (+0.000ms): kmap_atomic (page_referenced_one)
00000003 0.538ms (+0.000ms): page_address (page_referenced_one)
00000003 0.538ms (+0.000ms): kunmap_atomic (page_referenced_one)
00000002 0.538ms (+0.000ms): preempt_schedule (page_referenced_one)
00000002 0.539ms (+0.000ms): _spin_unlock (page_referenced_one)
00000001 0.539ms (+0.000ms): preempt_schedule (page_referenced_one)
00000001 0.539ms (+0.000ms): _spin_unlock (page_referenced_file)
00000001 0.540ms (+0.000ms): sub_preempt_count (_spin_unlock)
00000001 0.541ms (+0.000ms): update_max_trace (check_preempt_timing)

Spin Lock
=========

preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-R8-nd
-------------------------------------------------------
 latency: 235 us, entries: 18 (18)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: kswapd0/40, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: spin_lock+0x24/0x90
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): spin_lock (get_swap_page)
00000001 0.000ms (+0.000ms): spin_lock (<00000000>)
00000001 0.000ms (+0.000ms): spin_lock (get_swap_page)
00000002 0.000ms (+0.113ms): spin_lock (<00000000>)
00010002 0.113ms (+0.000ms): do_nmi (get_swap_page)
00010002 0.114ms (+0.002ms): do_nmi (default_idle)
00010002 0.116ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010002 0.116ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010002 0.117ms (+0.000ms): profile_hook (profile_tick)
00010002 0.117ms (+0.000ms): read_lock (profile_hook)
00010003 0.117ms (+0.000ms): read_lock (<00000000>)
00010003 0.117ms (+0.000ms): notifier_call_chain (profile_hook)
00010003 0.117ms (+0.000ms): _read_unlock (profile_tick)
00010002 0.118ms (+0.116ms): profile_hit (nmi_watchdog_tick)
00000002 0.235ms (+0.000ms): _spin_unlock (get_swap_page)
00000001 0.235ms (+0.000ms): _spin_unlock (get_swap_page)
00000001 0.235ms (+0.001ms): sub_preempt_count (_spin_unlock)
00000001 0.237ms (+0.000ms): update_max_trace (check_preempt_timing)

Are you SURE the spin lock counter works properly on SMP systems?
I did a quick check of yesterday's results:
  # grep -ir '<.*>' latencytest0.42-png/lt040909  | wc -l
  6978
  # grep -ir '<.*>' latencytest0.42-png/lt040909  | grep -v '<00000000>' |
less -im
  ...
  latencytest0.42-png/lt040909/lt004.v3k1/lt.10:00010002 0.382ms
(+0.000ms): do_IRQ (<0000000e>)
latencytest0.42-png/lt040909/lt004.v3k1/lt.11:00010001 0.003ms (+0.000ms):
do_IRQ (<0000000a>)
latencytest0.42-png/lt040909/lt004.v3k1/lt.11:00020001 0.308ms (+0.000ms):
do_IRQ (<0000000e>)
latencytest0.42-png/lt040909/lt005.v3k1/lt.00:00010002 0.263ms (+0.005ms):
do_nmi (<0804bd56>)
latencytest0.42-png/lt040909/lt006.v3k1/lt.00:00010001 0.501ms (+0.005ms):
do_nmi (<0864d2b2>)
latencytest0.42-png/lt040909/lt006.v3k1/lt.01:00010001 0.067ms (+0.003ms):
do_nmi (<0815f06c>)
  ...
No entries that are non zero and lock related.

  --Mark

