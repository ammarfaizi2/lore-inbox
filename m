Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLaKNH>; Sun, 31 Dec 2000 05:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129429AbQLaKM5>; Sun, 31 Dec 2000 05:12:57 -0500
Received: from www.wen-online.de ([212.223.88.39]:17683 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129324AbQLaKMy>;
	Sun, 31 Dec 2000 05:12:54 -0500
Date: Sun, 31 Dec 2000 10:42:26 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: scheduling problem test13-pre7
Message-ID: <Pine.Linu.4.10.10012311014280.1247-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While running iozone, I notice severe stalls of vmstat output
despite vmstat running SCHED_RR and mlockall().

With IKD, I ran a million line ktrace of such a stall, and find
no occurance of vmstat's pid.  (trace covers a ~full second of
kernel time)  The only user process which was scheduled during
this second was iozone itself (p262).  I have seen such stalls
last for ~5 seconds.

%TOT_TIME    TOT_USECS  AVG/CALL NCALLS KADDR    FUNCTION    PID
  0.0002%         2.15      2.15      1 c01077db __switch_to p4
  0.0025%        24.18      2.69      9 c01077db __switch_to p262
  0.0043%        41.91      0.86     49 c01077db __switch_to p0
  0.0049%        47.54      2.97     16 c01077db __switch_to p3
  0.0107%       102.83      1.80     57 c01077db __switch_to p6

Tail end of profile of this trace by pid:

%TOT_TIME    TOT_USECS  AVG/CALL NCALLS KADDR    FUNCTION          PID
  0.2485%      2394.91      1.22   1964 c0108fea ret_from_sys_call p262
  0.2496%      2405.70      0.61   3925 c0134f8b get_hash_table p262
  0.2555%      2462.40      0.31   7854 c0135052 buffer_insert_inode_queue p262
  0.2731%      2632.40      0.65   4029 c01a9bc7 ide_do_request p6
  0.3339%      3218.32      0.85   3788 c012bdd0 kmem_cache_alloc p262
  0.3899%      3757.91      0.18  21110 c012f1ee nr_free_pages p262
  0.4086%      3937.88      0.50   7848 c013573f getblk p262
  0.4385%      4225.65      0.32  13255 c011612a wake_up_process p262
  0.5245%      5055.25      0.24  21110 c012f23a nr_inactive_clean_pages p262
  0.5468%      5269.94      9.38    562 c012d017 swap_out p4
  0.7403%      7134.44      1.76   4046 c018a907 elevator_linus_merge p6
  2.8165%     27144.72      0.54  50589 c0137527 try_to_free_buffers p4
  3.1803%     30650.25     43.05    712 c0111caa apm_bios_call_simple p3
  3.8435%     37041.89      0.20 185504 c012cbf7 try_to_swap_out p4
  5.0470%     48641.41      0.95  51157 c012f179 __free_pages p4
  9.8731%     95152.96      0.54 177443 c0137527 try_to_free_buffers p6
 10.7010%    103132.39     26.28   3925 c020bb80 __generic_copy_from_user p262
 17.5982%    169604.69      0.94 180429 c012f179 __free_pages p6
 33.8960%    326677.23   2916.76    112 c0107171 default_idle p0
1048352 entries;    963762.98 total usecs.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
