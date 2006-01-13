Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422922AbWAMUZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422922AbWAMUZN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422929AbWAMUZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:25:12 -0500
Received: from motgate8.mot.com ([129.188.136.8]:2767 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S1422922AbWAMUZK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:25:10 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] Proposed patch for Precise Process Accounting
Date: Fri, 13 Jan 2006 15:25:01 -0500
Message-ID: <2D25C6D9C1440E4E8228FC62AE2864989E7AF7@de01exm69.ds.mot.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Proposed patch for Precise Process Accounting
Thread-Index: AcYYf24LOfNA4Q7sQuaTKm7kG0FzYA==
From: "Smarduch Mario-CMS063" <CMS063@motorola.com>
To: <mingo@elte.hu>, <rml@tech9.net>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Robert -
    I'd like to get input from you and community at large on a patch
that
has been in production on 2.4 systems on Debian and Montavista
distros, and in high risk field environment. Below is a detailed man 
page of the proposed patch. The patch itself is currently only available

for 2.4 on IA64 and PPC, but it is getting ported to 2.6 over the next
couple months. In general this patch is hardened it has seen
allot of field time, and it has resolved quite a few
scheduling/performance
issues in the field and labs. The poject is registered on OSDL/CGL
although
not allot has been updated there with recent activity. The feature as
it stands currently is divided into 3-patches - (i) architecture
independent
which by itself provides useful data (ii) arch dependent adds support
for sys call, interrupt accounting (iii) arch dependent
with additional features. I'm interested if it has potential for
inclusion
into the kernel, i.e. from Linux performance/phylisophical stand point.
 
Please COPY me personally on responses. 
cms063@email.mot.com
 
Regards,
    mario smarduch
 
------------------------------------
 
Standards, Environments, and Macros                        PPA(5)

NAME
     ppa - Precise Process Accounting     

DESCRIPTION
     PPA collects process and system  execution  statistics.  All
     time  based statistics are gathered from explicit timestamp-
     ing within various kernel paths. This makes PPA  precise  in
     measuring  task  and  system CPU usage and is not subject to
     tick based sampling errors common on most  OSs.  Tick  based
     accounting  may  be  off significantly (20,30 or 50% or just
     make no sense) especially on todays processors  where  allot
     of  work  can  be  done  in one tick (i.e. 1ms). The primary
     goals of PPA are: (i)  measure  per  task  and  system  time
     precisly  (ii)  maintain  scheduling data to resolve complex
     scheduling issues (iii) base certain OS event expirations on
     PPA  accurate  accounting. PPA can be enabled system wide or
     per process. Accounting of idle task usage is turned  on  at
     all  times.   PPA  overhead  varies  on  the  workload for a
     SPECrate like  load  its  undetectable,  however  there  are
     cicumstances such as consecutive calls to light system calls
     (i.e. getpid()) where it may account for upto  7%  overhead.
     The  overhead also may slightly differ between CPU architec-
     tures, certain architectures provide  a  rich  register  set
     resulting  in  few memory access and fast exception process-
     ing. Or in other cases some architectures have higher  over-
     head  on  excptions  or  context  switchs, in such cases PPA
     measurements are less likely to impact performance.  PPA  is
     intended  to  execute  in  all  environments including field
     environments.  PPA attempts to disturb execution  as  little
     as possible, for example interrupts are never disabled, exe-
     cution has priority over accounting.

     PPA Overview
     -------------

     For user-time accumulation PPA timestamps the intervals that
     application transitions to user space, including signal han-
     dling.

     For system-time  accumulation  PPA  timestamps  system  call
     entry/return,  including  recursive  system calls within the
     kernel. In addition count of  system  calls  is  maintained.
     Currently PPA does not handley kernel entry via light system
     calls (i.e. sysenter, epc), usage for  such  calls  will  be
     accrued to user time.

     For  interrupt-time  accumulation  PPA  timestamps  external
     interrupt    entry/return   including   nested   interrupts.

     Exceptions (TLB inst/data, priv inst, i.e.) other then  sys-
     tem  calls  are  not  distinctly measured. Some architecture
     resolve faults in hardware, other architectures don't  main-
     tain  real  page tables - in such cases measurement overhead
     would be excessive. In general exceptions are  accounted  to
     mode  the  processor  was  executing  in  at the time of the
     exception.  On   some   architectures   certain   exceptions
     (Machine checks, mgmt) may not be visible to the OS and han-
     dled by firmware, these will go unreported by PPA. In  addi-
     tion count of interrupts is maintained.

     The Idle-time is accumulated at all times, interrupt time is
     subtracted.

     Although kernel threads run in system mode, absent of system
     calls  execution  is  lumped  into user time. Each execution
     mode is accrued per-cpu,  for  highly  dense  SMP  platforms
     (multi-core/hyper  threaded)  the  per-cpu accounting may be
     colapsed by factor N where N may be equal to total  CPUs  on
     the platform to conserve memory.

     In VMM (hypervisers)  environments  PPA  accounting  may  be
     inaccurate,  interrupts  are replayed for a host to catch up
     durring excessive  inactivity.  At  all  times  native  tick
     accounting is left unaltered.

     In addition to per task/thread execution PPA collects:

     reschedule count of occurances task continued to  run  after
     timelice expiration

     voluntary-schedule-out count of occurances task blocked

     involuntary-schedule-out  count  of  occurances   task   was
     preempted by higher priority task

     time-slice-expired count  of  occurances  tasks  time  slice
     expired and was replaced with another task

     scheduled-latency  accumulated  scheduling   latency   (from
     wakeup to execution) runq-latency accumulated time spent on 
     run queue

     context-switch accumulated time spent in context switch code

     All these are broken  out  by  CPU,  accumulated  times  are
     reported   in   micro-seconds  (PPA  depends  on  the  high-
     resolution patch). PPA uses native CPU  cycle  counters  for
     timestamping,  thus  proper  calibration on SMP platforms is
     important for  measurements  of  scheduling  latencies.  All
     other  measurements  are done on one CPU (current). CPUs may
     be collapsed from 1 down to N, where N is the number  of  OS
     visible  CPUs,  this  conserves  memory  on highly dense SMP
     platforms. All these stats are intended to acquire  insights
     to  solve  and  tune some complex scheduling and performance
     issues some examples are:

     o scheduling latencies issues - task/thread experiences
       excessive scheduling delays some probable causes that
       can be indentified from PPA are wrong scheduling class,
       inappropriatte priorities, excessive time slice, kernel
       preemption issues, excessive interrupts. Primary
       candidates are applications which have some soft rt
       bound response time (i.e. call processing)

     o SMP performance - probable causes cache coherency
       (i.e. false data sharing), binding vs. floating of
       tasks/interrupts, inappropriate interrupt binding.
       This data is especially useful in highly dense SMP
       systems, which are becoming common place with multi-core,
       hyper-threaded processor architectures or cc-NUMA
       that introduce the concept of local/remote memory and
       2-level cache coherency. (link list directory based
       protocol (SCI), home node directory based protocol
       (DASH, RapidIO GSM)).

     o excessive cpu - probable causes excessive context
       switching, too many system calls or sloppy kernel
       driver/code, poorly written user code

     There are several pseudo files that appear under /proc/<pid>

     ppa
     ---

     This is an ascii file - example output follows. All values are
lumped
     across all CPUs, 'rawppa' interface is preferred, requiring less
     formatting.

     KCI# cat /proc/5792/ppa
         All results in micro seconds ([v2.0]) 1300 cycles/usec 8 CPUs
active
               Usr            Sys           Int            Total
            108007           1054            54           109061
      Rescheds    Scho   Prmpt-Pri  Prmpt-Exp  Avg-Latency
             1      32           0          0       10.930
            Sys-Idle        Avg-Ctxt-Dur
         10366890334           0.730

     Usr - execution time accrued in user mode

     Sys - execution time accrued in system mode

     Int - execution time accrued in  interrupts  in  context  of
     current task

     Total - execution time accrued by the task,  interrupt  time
     is excluded


     Rescheds - count of occurances task got rescheduled

     Scho - count of occurances task gave up CPU voluntairly

     Prmpt-Pri - count of occurances task gave up CPU  -  due  to
     higher priority task

     Prmpt-Exp - count of occurances task gave up CPU due to time
     slice expire

     Avg-Latency - average scheduling latency from  wakeup  until
     execution

     Sys-Idle - system wide idle time

     Avg-Ctxt-Dur - average context switch duration

     rawppa
     ------

     provides per-cpu data for task/thread 'ppa' it also contains
     additional  stats.  Per each CPU the below 64 bit quantities
     are  maintained,   for   metrics   representing   time   the
     'ticks/usec'  value  in  /proc/1/pid  may be used to convert
     into micro-seconds. All  values  and  indexed  consecutavily
     within  each  per-CPU array. Number of CPUs (CPU scaling) is
     controllable.

     PPA_SCHEDACCUM - total time accumulated in native  ticks  on
     this CPU

     PPA_SCACCUM - total system time accumulated in native  ticks
     on this CPU

     PPA_INTACCUM - total interrupt time  accumulated  in  native
     ticks on this CPU

     PPA_RSCHEDCNT - number of times  task  got  rescheduled  and
     continued running on this CPU

     PPA_SCHEDOUTCNT - number of times  task  released  this  CPU
     voluntairly (blocked)

     PPA_PRMPTCTXTCNT - number of times task  released  this  CPU
     due to time slice expiration

     PPA_PRMPTPRICNT - number of times task released this CPU due
     to a higher pri task

     PPA_SCHLATACCUM - total time accumulated on the run-q  after
     a  task  was  woken  up  (i.e. scheduled to run) and context
     switched in on this CPU

     PPA_SYSCALLCNT - number of system calls on this CPU

     PPA_INTCNT - number of interrupts in tasks context  on  this
     CPU

     PPA_AVGCTXT - total time spent in  context  switch  code  on
     this CPU

     Implicitly the  per CPU user time executed  on  the  CPU  is
     PPA_SCHEDACCUM   -  PPA_SCACCUM.  Additionally  the  context
     switch count per CPU is PPA_SCHEDOUTCNT + PPA_PRMPTPRICNT  +
     PPA_PRMPTCTXCNT

     Following all the data above will  be  an  array  of  signal
     counts  sent to the task, the whole array being SIGRTMAX long
     and each entry 32 bits.

     Following the signal information will  be  a  64  bit  value
     which  contains the amount of time task spent on run-q ready
     to run (excluding PPA_SCHLATACCUM), in future releases  this
     maybe a per-cpu metric.

     Following optionally (based on settings) is an array of 7-64
     bit  elements.   Each  element  is  a counter for scheduling
     latencies encountered.


     The format of rawppa is shown below:


            PPA_SCHEDACCUM PPA_SCACCUM    ...    PPA_INTCNT
        CPU#___________________________________________________________
        ----|
          0 |       x           x           x           x
          1 |       x           x           x           x
          . |       x           x           x           x
          . |       x           x           x           x
          n |       x           x           x           x

          [time spent on run-q]

          [signal delivery count]
          [0]
          [1]
          [2]
           .
           .
           .
          [SIGRTMAX]
 
          [optional - scheduling delay distribution]
          [0] -         scheduling latency < 10uS
          [1] -  10us < scheduling latency < 100us
          [2] - 100us < scheduling latency <   1ms
          [3] -   1ms < scheduling latency <  10ms
          [4] -  10ms < scheduling latency < 100ms
          [5] - 100ms < scheduling latency <   1s
          [6] -   1s  < scheduling latency <  10s

     ppactl
     ------

     Accepts 4 values with same meaning as  '/proc/sys/kernel/ppa'
     below, except its only for this task.

     /proc/sys/kernel/ppa
     --------------------

     This file globally controls PPA operation it  accepts  three
     flags set to 0 or 1 these are explained below. Following the
     flags is a value that  controls CPU scaling, for example  on
     a  32-way  system a value of 4 will collapse accounting down
     to 8 CPUs. So accounting for CPUs 0-3 will be maintained  in
     array  0,  4-7  in array 1 and so on. Setting CPU scaling to
     number of CPUs visible to the OS (default)  will  result  in
     one  array,  grouping all CPUs activities. Values that don't
     divide evenly will result in disproportionate ratio  between
     OS  visible  CPUs  and number of arrays, the last array will
     track fewer CPUs (i.e.remainder). The number of  CPU  arrays
     is  determined by dividing all OS visible CPUs by last value
     in '/proc/<pid>/ppactl'

     The following are the control flags -

     flag 0 | 1 - if set to 0 then with exception of
         idle time accounting, disables all above
         mentioned accounting, and thus measurable
         PPA activity take place. System idle time
         accounting is maintained under global system
         accounting file /proc/rawsysppa discussed
         later. Otherwise if set to 1 then full PPA
         accounting is turned on. 

     flag 1 - turns on optional scheduling latency accounting,
         flag 0 must be set to 1

     flag 2 - enables PPA accounting for expiring -
         ITIMER_VIRTUAL, ITIMER_PROF, SIGXCPU. All these
         timers decrement with PPA precision. Native tick
         accounting continues to accrue and will resume
         if this flags is turned off, of course the
         precision will be lost. Flag 0 must be set
         to 1 for this flag to take effect.

     CPU scaling - setting this value to N will scale 'rawppa'
         per CPU reporting. The number of per CPU arrays will be
         'OS visible CPUs' / 'this CPU scaling value'. If this
         values does not evenly divide into number of OS visible
         CPUs then last array will track fewer CPUs

     rawsysppa
     ---------

     This file is located in /proc  filesystem,  the  format  and
     fields  are outlined below. For each OS visible CPU there is
     an array with the metrics listed below, each  is  a  64  bit
     value   in  native  ticks.  Again  ratio  from  usec/ticks  in
     /proc/1/ppa may be used to convert into usecs. CPU scaling does
     not take effect on on these metrics.

     Usrmode - time CPU spent executing in user mode

     Sysmode - time CPU spent executing in system mode

     Interrupts - time CPU spent  executing  external  interrupts
     (i.e. including timer tick)

     Idle - time CPU spent executing idle thread

     SyscallCnt - total number of system calls made on this CPU

     InterruptCnt - total number of interrupts  handled  by  this
     CPU

     TotalSoftirqTime - total softirq execution time on this CPU

     SoftirqCnt - count of all softirqs on this CPU

     HiPriTskltTime - total high priority tasklet softirq  execu-
     tion time on this CPU.

     HiPriTskltCnt - count of all high priority tasklets

     RegPriTskltTime - total regular priority  tasklet  execution
     time on this CPU

     RegPriTskltCnt - count of all regular priority  tasklets  on
     this CPU

     TmrTskltTime - total timer tasklet execution  time  on  this
     CPU

     TmrTskltCnt - count of all timer tasklets on this CPU

     NtwkTxTime - total Network transmit softirq  execution  time
     on this CPU

     NtwkTxCnt - count of all Network transmit softirqs  on  this
     CPU

     NtwkRxTime - total Network receive softirqs  execution  time
     on this CPU

     NtwkRxCnt - count of all Network receive  softirqs  on  this
     CPU

SEE ALSO
     proc(5), /proc/cpuinfo

