Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbUAYUwi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 15:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUAYUwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 15:52:38 -0500
Received: from post.tau.ac.il ([132.66.16.11]:34533 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S262901AbUAYUwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 15:52:32 -0500
Date: Sun, 25 Jan 2004 22:52:20 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Re: Is there a way to keep the 2.6 kjournald from writing to idle disks? (to allow spin-downs)
Message-ID: <20040125205219.GE26600@luna.mooo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <40140B0A.90707@isg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40140B0A.90707@isg.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.2; VDF: 6.23.0.42; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 07:29:30PM +0100, Lutz Vieweg wrote:
> Hi everyone,
> 
> I run a server that usually doesn't have to do anything on the local 
> filesystems,
> it just needs to answer some requests and perform some computations in RAM.
> 
> So I use the "hdparm -S 123" parameter setting to keep the (IDE) system 
> disk from
> spinning unneccessarily.
> 
> Alas, since an upgrade to kernel 2.6 and ext3 filesystem, I cannot find a 
> way to
> let the harddisk spin down - I found out that "kjournald" writes a few 
> blocks every
> few seconds.
> 
> As I wouldn't like to downgrade to ext2: Is there any way to keep the 2.6 
> kjournald
> from writing to idle disks?
> 
> I cannot see a good reason why kjournald would write when there are no 
> dirty buffers -
> but still it does.
> 

There are two things to do. First you should mount the disk with the
noatime option.
The other thing is ext3 which is updating its journal every 5
seconds. I was told that laptop-mode was imported into 2.6 by now (I
think that it is in the main stream). Check the kernel docs there
should be some mount option to state the dirty time for the ext3
journal. The method changed since 2.4 so I don't remember the 2.6
option since I don't use it yet, sorry.

> 
> Regards,
> 
> Lutz Vieweg
> 
> 
> BTW: I used the following script to find the source of the write operations,
>      just start it in one terminal, do a "sync" in another, then say 
>      "hdparm -y /dev/hda"
>      and you can see that immediately or a few seconds later kjournald will 
>      enter the
>      "D" state and wake up when the disk has spun up.
> 
> -------------------------------------------------------------------------------------
> #!/usr/bin/tclsh
> 
> cd /proc
> 
> 
> set stat_arr {
>  pid
>  comm
>  state
>  ppid
>  process_group,
>  session
>  tty_nr
>  tty_pgrp
>  flags
>  min_flt
>  cmin_flt
>  maj_flt
>  cmaj_flt
>  utime
>  stime
>  cutime
>  cstime
>  priority
>  nice
>  num_threads
>  it_real_value
>  start_time
>  vsize
>  rss
>  RLIMIT_RSS
>  start_code
>  end_code
>  start_stack
>  esp
>  eip
>  pending_signals
>  blocked_sigs
>  sigign
>  sigcatch
>  wchan
>  nswap
>  cnswap
>  exit_signal
>  task_cpu
>  rt_priorit
>  policy
> }
> 
> proc scan_stat {_pids _dat} {
>    upvar $_dat dat
>    upvar $_pids pids
>    global stat_arr
> 
>    set pids [lsort -integer [glob {[0-9]*}]]
> 
>    foreach pid $pids {
>            set in [open "$pid/stat" "r"]
>            set l [gets $in]
>            close $in
> 
>            set a [split $l " "]
> 
>            foreach x $a n $stat_arr {
>                    set dat($pid,$n) $x
>            }
>    }
> }
> 
> #puts [array get dat]
> 
> array set dat {}
> set pids {}
> 
> scan_stat pids dat
> 
> while {1} {
>         after 1000
> 
>         array set new_dat {}
>         set new_pids {}
> 
>         scan_stat new_pids new_dat
> 
>         foreach pid $new_pids {
>                 if {$pid != [pid]} {
>                    if {![info exists dat($pid,pid)]} {
>                            puts "new process $pid $new_dat($pid,comm)"
>                    } else {
>                            set somechange 0
>                            foreach a $stat_arr {
>                                    if {$new_dat($pid,$a) != $dat($pid,$a)} {
>                                            puts "$pid $new_dat($pid,comm) 
>                                            attribute '$a' from 
>                                            $dat($pid,$a) to $new_dat($pid,$a)"
>                                            set somechange 1
>                                    }
>                            }
>                            if {$somechange} {
>                                    puts ""
>                            }
>                    }
>                 }
>         }
> 
>         array set dat {}
>         array set dat [array get new_dat]
>         set pids $new_pids
> }
> -------------------------------------------------------------------------------------
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
