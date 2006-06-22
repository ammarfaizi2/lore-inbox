Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030587AbWFVDIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030587AbWFVDIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 23:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030588AbWFVDIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 23:08:11 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:42237 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1030587AbWFVDIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 23:08:10 -0400
Message-ID: <449A0967.2020701@ak.jp.nec.com>
Date: Thu, 22 Jun 2006 12:07:19 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, linux-kernel@vger.kernel.org
Subject: Re: Add pacct_struct to fix some pacct bugs.
References: <449794BB.8010108@ak.jp.nec.com> <20060619234212.b95e5734.akpm@osdl.org> <4497A34C.2000104@ak.jp.nec.com>
In-Reply-To: <4497A34C.2000104@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The seriese of patches fixes some process accounting bugs.

[PATCH 1/3] two phase process accounting
[PATCH 2/3] avoidance to refer the last thread as a representation
             of the process
[PATCH 3/3] none-delayed process accounting accumulation

* background of the patch.1

     The pacct facility need an i/o operation when an accounting record
     is generated. There is a possibility to wake OOM killer up.
     If OOM killer is activated, it kills some processes to make them
     release process memory regions.
     But acct_process() is called in the killed processes context
     before calling exit_mm(), so those processes cannot release
     own memory. In the results, any processes stop in this point and
     it finally cause a system stall.

     ---- in kernel/exit.c : do_exit() ------------
             group_dead = atomic_dec_and_test(&tsk->signal->live);
             if (group_dead) {
                     hrtimer_cancel(&tsk->signal->real_timer);
                     exit_itimers(tsk->signal);
                     acct_process(code);
             }
                :
            - snip -
                :
             exit_mm(tsk);
     ----------------------------------------------

     This patch separates generating an accounting record facility
     into two-phase.
     In the first one, acct_collect() calculate vitual memory size
     of the process and stores it into pacct_struct before exit_mm().
     Then, acct_process() generates an accounting record and write
     it into medium.


* background of the patch.2

     When pacct facility generate an 'ac_flag' field in accounting record,
     it refers a task_struct of the thread which died last in the process.
     But any other task_structs are ignored.

     Therefore, pacct facility drops ASU flag even if root-privilege
     operations are used by any other threads except the last one.
     In addition, AFORK flag is always set when the thread of group-leader
     didn't die last, although this process has called execve() after fork().

     We have a same matter in ac_exitcode. The recorded ac_exitcode is
     an exit code of the last thread in the process. There is a possibility
     this exitcode is not the group leader's one.

     ---- in kernel/acct.c : do_acct_process() ----
             ac.ac_flag = 0;
             if (current->flags & PF_FORKNOEXEC)
                     ac.ac_flag |= AFORK;
             if (current->flags & PF_SUPERPRIV)
                     ac.ac_flag |= ASU;
             if (current->flags & PF_DUMPCORE)
                     ac.ac_flag |= ACORE;
             if (current->flags & PF_SIGNALED)
                     ac.ac_flag |= AXSIG;
                       :
                    - snip -
                       :
             ac.ac_exitcode = exitcode;
     ----------------------------------------------

     This patch fixes those matters.
     - The exit code of group leader is recorded as ac_exitcode.
     - ASU, ACORE, AXSIG flag are marked if any task_struct satisfy
       the conditions.
     - AFORK flag is marked if only group leader thread satisfy
       the condition.


* background of the patch.3

     In current 2.6.17 implementation, signal_struct refered from task_struct
     is used for per-process data structure. The pacct facility also uses it
     as a per-process data structure to store stime, utime, minflt, majflt.
     But those members are saved in __exit_signal(). It's too late.

     For example, if some threads exits at same time, pacct facility has
     a possibility to drop accountings for a part of those threads.
     (see, the following 'The results of original 2.6.17 kernel')
     I think accounting information should be completely collected into
     the per-process data structure before writing out an accounting record.

     This patch fixes this matter. Accumulation of stime, utime, minflt
     and majflt are done before generating accounting record.


* accounting results

[in original 2.6.17 cases]

# accton acct.log
# time -p ./bugacct
real 10.07
user 5.96
sys 0.10
# time -p ./raceacct 4
real 6.92
user 27.22
sys 0.00
# time -p ./raceacct 4
real 7.71
user 30.14
sys 0.00
# time -p ./raceacct 4
real 6.94
user 27.21
sys 0.00
# time -p ./raceacct 4
real 6.25
user 24.42
sys 0.00
# time -p ./raceacct 4
real 6.92
user 27.22
sys 0.00

-- accounting results --------
FLAG    BTIME  ETIME  UTIME  STIME     MEM  MINFLT MAJFLT      COMM
-P-- 13:41:16      5       0     0    3072     110      0    accton
F--- 13:41:35   1006     596     9  143232    8200      0   bugacct *
F--- 13:41:53    692    2032     0   28528      38      0  raceacct *
---- 13:42:10    771    3014     0   28528     170      0  raceacct
F--- 13:42:19    694    2027     0   28528       8      0  raceacct *
F--- 13:42:26    625    1832     0   28528      40      0  raceacct *
---- 13:45:40    692    2722     0   28528     171      0  raceacct

'P' means this process used root privilege operations.
'F' means this process didn't execve() after fork().

=> bugacct used root privilege operation, but pacct facility droped it.
=> In raceacct, some threads exit on same time. pacct facility often drops
    a part of utime, stime, minflt and majflt.
=> When group leader thread didn't die last in raceacct, incorrent flag 'F'
    is set.


[in patched 2.6.17-kg cases]

# touch acct.log
# accton acct.log
# time -p ./bugacct
real 10.07
user 5.97
sys 0.09
# time -p ./raceacct 4
real 7.11
user 27.76
sys 0.00
# time -p ./raceacct 4
real 6.93
user 27.18
sys 0.00
# time -p ./raceacct 4
real 7.11
user 27.76
sys 0.00
# time -p ./raceacct 4
real 7.12
user 27.77
sys 0.00
# time -p ./raceacct 4
real 6.92
user 27.17
sys 0.00

-- accounting results --------
FLAG    BTIME  ETIME  UTIME  STIME     MEM  MINFLT MAJFLT      COMM
-P-- 13:24:01      0      0      0    3072     111      0    accton
-P-- 13:24:05   1007    597      8  143232    8360      0   bugacct
---- 13:24:35    711   2776      0   28528     171      0  raceacct
---- 13:24:44    693   2718      0   28528     172      0  raceacct
---- 13:24:51    711   2776      0   28528     172      0  raceacct
---- 13:25:05    712   2777      0   28528     174      0  raceacct
---- 13:25:14    692   2717      0   28528     171      0  raceacct

I hope your any comments. Thanks,

KaiGai Kohei wrote:
 >>> Hi, I noticed three problems in pacct facility.
 >>>
 >>> 1. Pacct facility has a possibility to write incorrect ac_flag
 >>>    in multi-threading cases.
 >>> 2. There is a possibility to be waken up OOM Killer from
 >>>    pacct facility. It will cause system stall.
 >>> 3. If several threads are killed at same time, There is
 >>>    a possibility not to pick up a part of those accountings.
 >>>
 >>> The attached patch will resolve those matters.
 >>> Any comments please. Thanks,
 >>
 >> Thanks, but you have three quite distinct bugs here, and three quite
 >> distinct descriptions and, I think, three quite distinct fixes.
 >>
 >> Would it be possible for you to prepare three patches?
 >
 > It may be possible. Please wait for a while to separate it into
 > three-part and to confirm its correct behavior.
 >
 > Thanks,
-- 
Open Source Software Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>
