Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbWADMCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbWADMCa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 07:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbWADMCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 07:02:30 -0500
Received: from hera.kernel.org ([140.211.167.34]:23949 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751692AbWADMC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 07:02:28 -0500
Date: Wed, 4 Jan 2006 07:40:53 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client on interactive response
Message-ID: <20060104094053.GA4577@dmt.cnet>
References: <43A8EF87.1080108@bigpond.net.au> <1135145341.7910.17.camel@lade.trondhjem.org> <43A8F714.4020406@bigpond.net.au> <20060102110145.GA25624@aitel.hist.no> <43B9BD19.5050408@bigpond.net.au> <43BB2414.6060400@bigpond.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <43BB2414.6060400@bigpond.net.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

On Wed, Jan 04, 2006 at 12:25:40PM +1100, Peter Williams wrote:
> Peter Williams wrote:
> >Helge Hafting wrote:
> >
> >>On Wed, Dec 21, 2005 at 05:32:52PM +1100, Peter Williams wrote:
> >>
> >>>Trond Myklebust wrote:
> >>
> >>
> >>[...]
> >>
> >>>>Sorry. That theory is just plain wrong. ALL of those case _ARE_
> >>>>interactive sleeps.
> >>>
> >>>
> >>>It's not a theory.  It's a result of observing a -j 16 build with the 
> >>>sources on an NFS mounted file system with top with and without the 
> >>>patches and comparing that with the same builds with the sources on a 
> >>>local file system.  Without the patches the tasks in the kernel build 
> >>>all get the same dynamic priority as the X server and other 
> >>>interactive programs when the sources are on an NFS mounted file 
> >>>system.  With the patches they generally have dynamic priorities 
> >>>between 6 to 10 higher than the X server and other interactive programs.
> >>>
> >>
> >>A process waiting for NFS data looses cpu time, which is spent on 
> >>running something else.  Therefore, it gains some priority so it won't be
> >>forever behind when it wakes up.  Same as for any other io waiting.
> >
> >
> >That's more or less independent of this issue as the distribution of CPU 
> >to tasks is largely determined by the time slice mechanism and the 
> >dynamic priority is primarily about latency.  (This distinction is a 
> >little distorted by the fact that, under some circumstances, 
> >"interactive" tasks don't get moved to the expired list at the end of 
> >their time slice but this usually won't matter as genuine interactive 
> >tasks aren't generally CPU hogs.)  In other words, the issue that you 
> >raised is largely solved by the time tasks spend on the active queue 
> >before moving to the expired queue rather than the order in which they 
> >run when on the active queue.
> >
> >This problem is all about those tasks getting an inappropriate boost to 
> >improve their latency because they are mistakenly believed to be 
> >interactive.
> 
> One of the unfortunate side effects of this is that it can effect 
> scheduler fairness because if these tasks get sufficient bonus points 
> the TASK_INTERACTIVE() macro will return true for them and they will be 
> rescheduled on the active queue instead of the expired queue at the end 
> of the time slice (provided EXPIRED_STARVING()) doesn't prevent this). 
> This will have an adverse effect on scheduling fairness.
> 
> The ideal design of the scheduler would be for the fairness mechanism 
> and the interactive responsiveness mechanism to be independent but this 
> is not the case due to the fact that requeueing interactive tasks on the 
> expired array could add unacceptably to their latency.  As I said above 
> this slight divergence from the ideal of perfect independence shouldn't 
> matter as genuine interactive processes aren't very CPU intensive.
> 
> In summary, inappropriate identification of CPU intensive tasks as 
> interactive has two bad effects: 1) responsiveness problems for genuine 
> interactive tasks due to the extra competition at their dynamic priority 
> and 2) a degradation of scheduling fairness; not just one.
> 
> For an example of the effect of inappropriate identification of CPU hogs 
> as interactive tasks see the thread "[SCHED] Totally WRONG priority 
> calculation with specific test-case (since 2.6.10-bk12)" in this list.

And another real-life example of the issue you describe above.

>From marcelo.tosatti@cyclades.com Fri Dec  2 18:51:59 2005
Date: Fri, 2 Dec 2005 18:51:59 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <piggin@cyberone.com.au>
Cc: Regina Kodato <regina.kodato@cyclades.com>,
	Wanda Rosalino <wanda.rosalino@cyclades.com>,
	Edson Seabra <edson.seabra@cyclades.com>
Subject: scheduler starvation with v2.6.11 on embedded PPC appliance


We are experiencing what seems to be a scheduler starvation issue on our
application, running v2.6.11. The same load works as expected on v2.4.

We would like to know if v2.6.14 could possibly fix this problem.

Hardware is a PowerPC 8xx at 48Mhz (embedded SoC) with 128MB RAM,
handling remote access to its own 48 serial ports running at 9600bps
each (8N1, HW flow control).

Access to the ports is performed via SSH (one sshd instance for each
port), and there are two different configurations:

1) slim socket mode: Each SSH process is responsible for handling IO to
its own serial port.

2) buffering mode: Where a single process handles IO on the 48 tty's,
copying data to a shared memory region and signalling the respective ssh
daemon with SIGIO once a certain amount of data is ready.

The test transfers a 78k file via each serial port (total = 48*78k =
3.7MB) from an x86 Linux box, usually taking:

78110 bytes after 81 seconds, 964 cps (+-9640 bps).

Time varies from 77 sec upto 85 sec.

Problem description:

Using slim socket mode, where each SSH process handles IO to its own
port, the scheduler starves a certain number of processes, causing their
connections to timeout.

Further investigation with schedstats allowed us to notice that
"wait_ticks" is much higher using this mode.

Follows the output of "latency" and "vmstat 2" with buffering mode (low
wait_ticks, high number of context switches):

913 (cy_buffering) 25(25) 1077(1077) 843(843) 0.03 1.28
1166 (sshd) 220(220) 143(143) 1276(1276) 0.17 0.11
913 (cy_buffering) 36(11) 1078(1) 952(109) 0.10 0.01
1166 (sshd) 231(11) 191(48) 1883(607) 0.02 0.08
913 (cy_buffering) 242(206) 1131(53) 3200(2248) 0.09 0.02
1166 (sshd) 294(63) 383(192) 2523(640) 0.10 0.30
913 (cy_buffering) 440(198) 1172(41) 5637(2437) 0.08 0.02
1166 (sshd) 353(59) 574(191) 3160(637) 0.09 0.30
913 (cy_buffering) 644(204) 1199(27) 7918(2281) 0.09 0.01
1166 (sshd) 372(19) 678(104) 3771(611) 0.03 0.17
913 (cy_buffering) 644(0) 1201(2) 7978(60) 0.00 0.03
1166 (sshd) 372(0) 681(3) 4372(601) 0.00 0.00

procs                      memory      swap          io     system         cpu
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy wa id
 0  0      0 159752  51200   9960    0    0     0     0   23  1171  1 11  0 88
 0  0      0 159752  51200   9960    0    0     0     0   10  1111  0  5  0 94
 1  0      0 159752  51200   9964    0    0     2     0  311  1226 35 55  0 10
 1  0      0 159752  51200   9964    0    0     0     0  934  1718 50 50  0  0
 1  0      0 159752  51200   9964    0    0     0     0  874  1519 52 48  0  0
11  0      0 159752  51200   9964    0    0     0     0  800  1358 47 53  0  0
 7  0      0 159752  51200   9964    0    0     0     0  527  1235 44 56  0  0
 1  0      0 159752  51200   9964    0    0     0     0  301  1144 47 53  0  0
 1  0      0 159752  51200   9964    0    0     0     0  363  1241 43 57  0  0
 2  0      0 159752  51200   9964    0    0     0     1  428  1194 45 55  0  0
 1  0      0 159752  51200   9964    0    0     0     0  428  1141 42 58  0  0
 1  0      0 159752  51200   9964    0    0     0     0  433  1255 44 56  0  0
 2  0      0 159752  51200   9964    0    0     0     0  444  1067 46 54  0  0
 1  0      0 159752  51200   9964    0    0     0     0  465  1071 55 45  0  0
 1  0      0 159752  51200   9964    0    0     0     0  510  1101 42 58  0  0
 1  0      0 159752  51200   9964    0    0     0     0  409  1082 47 53  0  0
 1  0      0 159752  51200   9964    0    0     0     0  401  1075 40 60  0  0
 1  0      0 159752  51200   9964    0    0     0     0  409  1081 44 56  0  0


And with slim socket mode (very high wait_ticks, low number of context
switches):

1200 (sshd) 382(0) 3891(0) 1879(30) 0.00 0.00
1216 (sshd) 479(0) 7216(0) 2387(30) 0.00 0.00
1241 (sshd) 802(0) 6869(2) 4069(31) 0.00 0.06
1276 (sshd) 499(2) 8807(42) 3204(34) 0.06 1.24
1301 (sshd) 601(2) 8319(38) 2752(32) 0.06 1.19

1200 (sshd) 388(6) 4184(293) 1909(30) 0.20 9.77
1216 (sshd) 487(8) 7516(300) 2413(26) 0.31 11.54
1241 (sshd) 866(64) 7575(706) 4427(358) 0.18 1.97
1276 (sshd) 656(157) 9824(1017) 3756(552) 0.28 1.84
1301 (sshd) 610(9) 8422(103) 2761(9) 1.00 11.44

1200 (sshd) 415(27) 7132(2948) 1982(73) 0.37 40.38
1216 (sshd) 511(24) 10537(3021) 2496(83) 0.29 36.40
1241 (sshd) 943(77) 8537(962) 4875(448) 0.17 2.15
1276 (sshd) 776(120) 10892(1068) 4336(580) 0.21 1.84
1301 (sshd) 620(10) 11034(2612) 2771(10) 1.00 261.20

procs                      memory      swap          io     system         cpu
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy wa id
 5  0      0 159816  51200   9916    0    0     0     0   18   113  0  1  0 99
 0  0      0 159816  51200   9916    0    0     0     0   19   112  0  2  0 98
 0  0      0 159816  51200   9916    0    0     0     0  166   176  1  6  0 93
37  0      0 159880  51200   9916    0    0     0     0 2857  1219 46 50  0  4
38  0      0 159880  51200   9916    0    0     0     0 2662  1059 58 42  0  0
33  0      0 159880  51200   9916    0    0     0     0 1058   496 72 28  0  0
33  0      0 159880  51200   9916    0    0     0     0 1593   743 70 30  0  0
33  0      0 159880  51200   9916    0    0     0     0 1519   706 71 29  0  0
34  0      0 159880  51200   9916    0    0     0     0 1073   520 74 26  0  0
35  0      0 159880  51200   9916    0    0     0     0 1047   493 67 33  0  0
49  0      0 159880  51200   9916    0    0     0     0 1130   543 70 30  0  0
34  0      0 159880  51200   9916    0    0     0     0 1239   612 70 30  0  0
46  0      0 159880  51200   9916    0    0     0     0 1427   737 69 31  0  0
34  0      0 159880  51200   9916    0    0     0     0  835   423 73 27  0  0
36  0      0 159880  51200   9916    0    0     0     1 1036   414 69 31  0  0
37  0      0 159880  51200   9916    0    0     0     0  917   379 73 27  0  0
44  0      0 159880  51200   9916    0    0     0     0 3401  1311 65 35  0  0

Another noticeable difference on schedstat output is that slim mode
causes the scheduler to switch the active/expired queues 4 times during
the total run, while buffering mode switches the queues 38 times.

Attached you can find schedstats-buffering.txt and schedstats-slim.txt.

On v2.4.17 both modes work fine, with a high context-switch number.

We suspected that the TASK_INTERACTIVE() logic in kernel/sched.c would
be moving some processes directly to the active list, thus starving some
others. So we set the nice value of all 48 processes to "nice +19" to
disable TASK_INTERACTIVE() and the starvation is gone. However with +19
it becomes impossible to use the box interactively while the test runs,
which is the case with the default "0" nice value.

Are there significant changes between v2.6.11 -> v2.6.14 aimed at fixing
this problem?

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="schedstats-slim.txt"


00:00:00--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


        390          schedule()
          0(  0.00%) switched active and expired queues
        285( 73.08%) used existing active queue


        284          try_to_wake_up()
        284(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.02/0.01      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:01--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


        448          schedule()
          0(  0.00%) switched active and expired queues
        323( 72.10%) used existing active queue


        322          try_to_wake_up()
        322(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.01/0.00      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:01--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       1944          schedule()
          0(  0.00%) switched active and expired queues
       1744( 89.71%) used existing active queue


       3695          try_to_wake_up()
       3695(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.16/1.44      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:02--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       3526          schedule()
          0(  0.00%) switched active and expired queues
       3526(100.00%) used existing active queue


       9211          try_to_wake_up()
       9211(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.25/4.49      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:03--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       2356          schedule()
          0(  0.00%) switched active and expired queues
       2356(100.00%) used existing active queue


       4498          try_to_wake_up()
       4498(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.25/1.90      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:03--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       2541          schedule()
          0(  0.00%) switched active and expired queues
       2541(100.00%) used existing active queue


       4905          try_to_wake_up()
       4905(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.26/2.25      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:04--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       2340          schedule()
          0(  0.00%) switched active and expired queues
       2340(100.00%) used existing active queue


       4520          try_to_wake_up()
       4520(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.26/2.15      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:05--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       2206          schedule()
          0(  0.00%) switched active and expired queues
       2206(100.00%) used existing active queue


       4278          try_to_wake_up()
       4278(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.26/2.05      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:05--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       1968          schedule()
          0(  0.00%) switched active and expired queues
       1968(100.00%) used existing active queue


       4513          try_to_wake_up()
       4513(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.26/33.56     avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:06--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       2338          schedule()
          1(  0.04%) switched active and expired queues
       2337( 99.96%) used existing active queue


       5741          try_to_wake_up()
       5741(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.26/7.76      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:06--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       2598          schedule()
          0(  0.00%) switched active and expired queues
       2598(100.00%) used existing active queue


       6888          try_to_wake_up()
       6888(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.27/2.48      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:07--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       2643          schedule()
          0(  0.00%) switched active and expired queues
       2643(100.00%) used existing active queue


       7118          try_to_wake_up()
       7118(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.27/1.79      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:08--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       2825          schedule()
          0(  0.00%) switched active and expired queues
       2825(100.00%) used existing active queue


       7474          try_to_wake_up()
       7474(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.27/2.93      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:09--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       2618          schedule()
          0(  0.00%) switched active and expired queues
       2618(100.00%) used existing active queue


       6914          try_to_wake_up()
       6914(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.27/2.41      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:10--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       3365          schedule()
          1(  0.03%) switched active and expired queues
       3364( 99.97%) used existing active queue


       8379          try_to_wake_up()
       8379(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.27/10.09     avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:10--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       2920          schedule()
          1(  0.03%) switched active and expired queues
       2919( 99.97%) used existing active queue


       4522          try_to_wake_up()
       4522(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.24/3.51      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:11--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       2256          schedule()
          0(  0.00%) switched active and expired queues
       2256(100.00%) used existing active queue


       3469          try_to_wake_up()
       3469(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.24/4.55      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:11--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       2280          schedule()
          1(  0.04%) switched active and expired queues
       2279( 99.96%) used existing active queue


       3480          try_to_wake_up()
       3480(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.24/3.45      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="schedstats-buffering.txt"


00:00:00--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5495          schedule()
          0(  0.00%) switched active and expired queues
       5007( 91.12%) used existing active queue


       4952          try_to_wake_up()
       4952(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.00/0.04      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:01--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5617          schedule()
          0(  0.00%) switched active and expired queues
       5112( 91.01%) used existing active queue


       5056          try_to_wake_up()
       5056(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.01/0.00      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:01--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5963          schedule()
          2(  0.03%) switched active and expired queues
       5816( 97.53%) used existing active queue


       6660          try_to_wake_up()
       6660(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.06/0.11      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:02--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       6482          schedule()
          2(  0.03%) switched active and expired queues
       6480( 99.97%) used existing active queue


       9882          try_to_wake_up()
       9882(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.09/0.33      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:02--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5517          schedule()
          1(  0.02%) switched active and expired queues
       5516( 99.98%) used existing active queue


       8904          try_to_wake_up()
       8904(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.10/0.50      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:03--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       6183          schedule()
          2(  0.03%) switched active and expired queues
       6181( 99.97%) used existing active queue


      10045          try_to_wake_up()
      10045(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.10/0.55      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:03--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5366          schedule()
          1(  0.02%) switched active and expired queues
       5365( 99.98%) used existing active queue


       8628          try_to_wake_up()
       8628(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.10/0.52      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:04--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5447          schedule()
          4(  0.07%) switched active and expired queues
       5443( 99.93%) used existing active queue


       8767          try_to_wake_up()
       8767(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.09/0.47      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:04--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5391          schedule()
          1(  0.02%) switched active and expired queues
       5390( 99.98%) used existing active queue


       8719          try_to_wake_up()
       8719(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.10/0.50      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:05--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5499          schedule()
          2(  0.04%) switched active and expired queues
       5497( 99.96%) used existing active queue


       8925          try_to_wake_up()
       8925(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.09/0.45      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:05--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5419          schedule()
          4(  0.07%) switched active and expired queues
       5415( 99.93%) used existing active queue


       8747          try_to_wake_up()
       8747(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.09/0.45      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:06--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5471          schedule()
          2(  0.04%) switched active and expired queues
       5469( 99.96%) used existing active queue


       8832          try_to_wake_up()
       8832(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.09/0.43      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:06--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5449          schedule()
          2(  0.04%) switched active and expired queues
       5447( 99.96%) used existing active queue


       8765          try_to_wake_up()
       8765(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.09/0.44      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:07--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5491          schedule()
          2(  0.04%) switched active and expired queues
       5489( 99.96%) used existing active queue


       8859          try_to_wake_up()
       8859(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.09/0.42      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:07--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5449          schedule()
          4(  0.07%) switched active and expired queues
       5445( 99.93%) used existing active queue


       8761          try_to_wake_up()
       8761(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.09/0.43      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:08--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5470          schedule()
          1(  0.02%) switched active and expired queues
       5469( 99.98%) used existing active queue


       8893          try_to_wake_up()
       8893(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.10/0.44      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:08--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5421          schedule()
          3(  0.06%) switched active and expired queues
       5418( 99.94%) used existing active queue


       8740          try_to_wake_up()
       8740(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.09/0.48      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:09--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5488          schedule()
          2(  0.04%) switched active and expired queues
       5486( 99.96%) used existing active queue


       8744          try_to_wake_up()
       8744(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.09/0.41      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:09--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5745          schedule()
          3(  0.05%) switched active and expired queues
       5450( 94.87%) used existing active queue


       5672          try_to_wake_up()
       5672(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.04/0.06      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:10--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5478          schedule()
          0(  0.00%) switched active and expired queues
       4974( 90.80%) used existing active queue


       4962          try_to_wake_up()
       4962(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.00/0.02      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


00:00:10--------------------------------------------------------------
          0          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
          0(  0.00%) found both queues empty on current cpu
          0(  0.00%) found neither queue empty on current cpu


       5478          schedule()
          0(  0.00%) switched active and expired queues
       4970( 90.73%) used existing active queue


       4963          try_to_wake_up()
       4963(100.00%) task already running, or killed
          0(  0.00%) successfully moved a task to waking cpu
          0(  0.00%) task started on previous cpu

          0(  0.00%) tried to move a task because of possible affinity
          0(  0.00%) tried to move a task to improve load balancing


          0          wake_up_forked_thread()
          0(  0.00%) successfully moved a task


          0          pull_task()
          0(  0.00%) moved when newly idle
          0(  0.00%) moved while idle
          0(  0.00%) moved while busy
          0(  0.00%) moved from active_load_balance()

          0          active_load_balance()
          0          sched_balance_exec()
          0          sched_migrate_task()

      0.00/0.00      avg runtime/latency over all cpus (ms)

          0          load_balance()
          0(  0.00%) called while idle
          0(  0.00%) called while busy
          0(  0.00%) called when newly idle

          0          sched_balance_exec() tried to push a task


--FCuugMFkClbJLl1L--
