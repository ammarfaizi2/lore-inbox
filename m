Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265167AbUAYSXG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 13:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbUAYSWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 13:22:54 -0500
Received: from rzfoobar.is-asp.com ([217.11.194.155]:3752 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id S265167AbUAYSWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 13:22:40 -0500
Message-ID: <40140B0A.90707@isg.de>
Date: Sun, 25 Jan 2004 19:29:30 +0100
From: Lutz Vieweg <lkv@isg.de>
Organization: IS Innovative Software AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030613
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Is there a way to keep the 2.6 kjournald from writing to idle disks?
 (to allow spin-downs)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I run a server that usually doesn't have to do anything on the local filesystems,
it just needs to answer some requests and perform some computations in RAM.

So I use the "hdparm -S 123" parameter setting to keep the (IDE) system disk from
spinning unneccessarily.

Alas, since an upgrade to kernel 2.6 and ext3 filesystem, I cannot find a way to
let the harddisk spin down - I found out that "kjournald" writes a few blocks every
few seconds.

As I wouldn't like to downgrade to ext2: Is there any way to keep the 2.6 kjournald
from writing to idle disks?

I cannot see a good reason why kjournald would write when there are no dirty buffers -
but still it does.


Regards,

Lutz Vieweg


BTW: I used the following script to find the source of the write operations,
      just start it in one terminal, do a "sync" in another, then say "hdparm -y /dev/hda"
      and you can see that immediately or a few seconds later kjournald will enter the
      "D" state and wake up when the disk has spun up.

-------------------------------------------------------------------------------------
#!/usr/bin/tclsh

cd /proc


set stat_arr {
  pid
  comm
  state
  ppid
  process_group,
  session
  tty_nr
  tty_pgrp
  flags
  min_flt
  cmin_flt
  maj_flt
  cmaj_flt
  utime
  stime
  cutime
  cstime
  priority
  nice
  num_threads
  it_real_value
  start_time
  vsize
  rss
  RLIMIT_RSS
  start_code
  end_code
  start_stack
  esp
  eip
  pending_signals
  blocked_sigs
  sigign
  sigcatch
  wchan
  nswap
  cnswap
  exit_signal
  task_cpu
  rt_priorit
  policy
}

proc scan_stat {_pids _dat} {
    upvar $_dat dat
    upvar $_pids pids
    global stat_arr

    set pids [lsort -integer [glob {[0-9]*}]]

    foreach pid $pids {
            set in [open "$pid/stat" "r"]
            set l [gets $in]
            close $in

            set a [split $l " "]

            foreach x $a n $stat_arr {
                    set dat($pid,$n) $x
            }
    }
}

#puts [array get dat]

array set dat {}
set pids {}

scan_stat pids dat

while {1} {
         after 1000

         array set new_dat {}
         set new_pids {}

         scan_stat new_pids new_dat

         foreach pid $new_pids {
                 if {$pid != [pid]} {
                    if {![info exists dat($pid,pid)]} {
                            puts "new process $pid $new_dat($pid,comm)"
                    } else {
                            set somechange 0
                            foreach a $stat_arr {
                                    if {$new_dat($pid,$a) != $dat($pid,$a)} {
                                            puts "$pid $new_dat($pid,comm) attribute '$a' from $dat($pid,$a) to 
$new_dat($pid,$a)"
                                            set somechange 1
                                    }
                            }
                            if {$somechange} {
                                    puts ""
                            }
                    }
                 }
         }

         array set dat {}
         array set dat [array get new_dat]
         set pids $new_pids
}
-------------------------------------------------------------------------------------


