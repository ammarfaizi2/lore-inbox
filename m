Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293019AbSBVWDh>; Fri, 22 Feb 2002 17:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293020AbSBVWDe>; Fri, 22 Feb 2002 17:03:34 -0500
Received: from users.ccur.com ([208.248.32.211]:25820 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S293019AbSBVWDU>;
	Fri, 22 Feb 2002 17:03:20 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200202222202.WAA05655@rudolph.ccur.com>
Subject: Bug report: smp affinity patch
To: rml@tech9.net
Date: Fri, 22 Feb 2002 17:02:28 -0500 (EST)
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, l-k@mindspring.com
Reply-To: joe.korty@ccur.com (Joe Korty)
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
  On occasion, the smp affinity patch can leave one or more runnable
processes in such a state that the scheduler never selects them for
execution.  The reason this occurs is unknown.  This note reports
the symptoms and how the problem may be replicated:

I am using the smp affinity patch from Robert Love, which provides
a /proc/pid/affinity interface to the user.  I presume the problem
is also present in the Ingo Molnar patch, since it is so similar
in implementation, although I have not tested it.

I ran across this problem when I wrote a shell script that
implemented cpu shielding.  The shielding script modifies the
affinities of (most) all proceses in the system -- for each process,
it either forces that process to run only on the shielded cpu, or
forces it to avoid the shielded cpu altogether.  The only processes
to which neither are applied are the ksoftirqd_CPUxx daemons, each of
which has to remain on the cpu originally attached to.

Joe

---------------------------------------

Environment:
    linux-2.4.17.tar.gz
    + patch-2.4.18-rc2.gz
    + cpu-affinity-rml-2.4.16-1.patch (from www.tech9.net/rml/linux)
    PC, Pentium III, dual cpu's, dual IO APIC's, scsi, console via com1.

Test Shell Script used (filename `shield'):

    #!/bin/bash
    # shell script that reserves some cpu to some small
    # set of procs: accomplished by tweaking the affinity
    # masks of all procs -- either by removing that cpu from
    # those pids which are not to use it, or by setting the
    # affinity to only that cpu, for those procs that are
    # to be attached to the shielded cpu..
    #
    # usage: shield unshieldmask shieldmask pid pid ...
    # example: shield 2 1 1027 1028
    # meaning: pids 1027,1028 are to run on cpu0; every
    # other procs is to run on cpu 1.
    # example: shield 3 3
    # meaning: make every cpu available to all procs.
    # note: procs 3 & 4 (ksoftirqd_CPU[0-1]) are not and
    # must not have their affinities changed by this script.

    unshieldmask=${1:-e}
    shift
    shieldmask=${1:-1}
    shift
    cd /proc
    for i in $(/bin/ls -d [0-9]*); do
	if [ -d $i ]; then
	    case $i in
		3|4) ;;
		${1:-no}) echo $shieldmask >$i/affinity ;;
		${2:-no}) echo $shieldmask >$i/affinity ;;
		${3:-no}) echo $shieldmask >$i/affinity ;;
		${4:-no}) echo $shieldmask >$i/affinity ;;
		*)  echo $unshieldmask >$i/affinity ;;
	    esac
	fi
    done

Test initialization sequence:

    in window #1:
	top -d1 -i
    in window #2:
	echo 'main() {for(;;);}' >l.c && make l
	./l &
	[1]  1087
	./l &
	[2]  1088
	./l &
	[3]  1089
	./l &
	[4]  1090

Test sequence and results:

    In the below tests, to `Stall' means that the scheduler fails to
    give a runnable process any time.

    Notation:
      1088 Stalls	- pid 1088 stalls.  viewable in the top(1) window
			  as the bottom `running' proc, but has 0% cpu
			  utilization.

      top Stalls	- the top window stops updating.  Due to
			  top itself being a victim of the scheduling
			  bug.  to see: run another top in another window.


    result		command line executed
    ------------------	---------------------
    ok			shield 1 2
    ok			shield 1 2
    ok			shield 3 1
    ok			shield 3 1 1087
    ok			shield 2 1 1087
    ok			shield 3 3
    top Stalls		shield 2 1 1090
    ok			shield 3 3
    top Stalls		shield 2 1 1090
    ok			shield 3 3
    top Stalls		shield 2 1 1090
    ok			shield 3 3
    1088 Stalls		shield 2 1 1090
    ok			shield 3 3
    ok			shield 2 1
    ok			shield 1 2
    ok			shield 2 1
    ok			shield 1 2
    ok			shield 2 1
    1090 Stalls		shield 1 2 1090
    1090 Stalls		shield 1 2 1090
    top Stalls plus	shield 2 1 1090
    1087, sendmail,
    crond,init,lots
    of kjournals, and
    syslogd
    ok			shield 3 3
    top + shell window	shield 2 1 1090
    Stalls
    ok			shield 3 3		(executed in another window)
    1087 Stalls		shield 1 2 1090


Sample good and bad top(1) Displays:

------------------------------------------------------------------- good

  9:18pm  up 38 min,  3 users,  load average: 4.00, 4.31, 4.69
48 processes: 43 sleeping, 5 running, 0 zombie, 0 stopped
CPU0 states: 100.0% user,  0.0% system,  0.0% nice,  0.0% idle
CPU1 states: 99.0% user,  1.0% system,  0.0% nice,  0.0% idle
Mem:   513160K av,   44600K used,  468560K free,       0K shrd,   10156K buff
Swap: 1052216K av,       0K used, 1052216K free                   17420K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 1088 root      20   0   268  268   220 R    52.0  0.0  15:28 l
 1089 root      20   0   268  268   220 R    50.0  0.0  15:54 l
 1087 root      18   0   268  268   220 R    48.0  0.0  13:38 l
 1090 root      18   0   268  268   220 R    48.0  0.0  22:44 l
 1027 root      10   0  1060 1060   856 R     1.0  0.2   0:13 top

------------------------------------------------------------------- bad

  9:20pm  up 40 min,  3 users,  load average: 6.12, 5.19, 4.97
49 processes: 43 sleeping, 6 running, 0 zombie, 0 stopped
CPU0 states: 97.0% user,  3.0% system,  0.0% nice,  0.0% idle
CPU1 states: 100.0% user,  0.0% system,  0.0% nice,  0.0% idle
Mem:   513160K av,   44940K used,  468220K free,       0K shrd,   10392K buff
Swap: 1052216K av,       0K used, 1052216K free                   17420K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 1090 root      16   0   268  268   220 R    99.9  0.0  24:24 l
 1089 root      16   0   268  268   220 R    64.9  0.0  16:58 l
 1088 root       9   0   268  268   220 R    33.9  0.0  16:31 l
  978 root       9   0   664  664   552 R     0.0  0.1   0:00 in.telnetd
 1027 root       9   0  1060 1060   856 R     0.0  0.2   0:14 top
 1087 root       9   0   268  268   220 R     0.0  0.0  14:05 l

-------------------------------------------------------------------------
