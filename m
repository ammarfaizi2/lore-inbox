Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316018AbSENTwM>; Tue, 14 May 2002 15:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316021AbSENTwL>; Tue, 14 May 2002 15:52:11 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:64958 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316018AbSENTwJ>; Tue, 14 May 2002 15:52:09 -0400
Date: Tue, 14 May 2002 12:49:16 -0700
From: "Kurtis D. Rader" <kdrader@us.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] IO wait accounting
Message-ID: <20020514124915.F21303@us.ibm.com>
In-Reply-To: <Pine.LNX.4.44L.0205082153010.32261-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-08 21:55:21, Rik van Riel wrote:
> I'm doubting whether or not to change these two issues and if
> they should be changed, how should they behave instead ?

On the topic of how this is defined by other UNIXes below I've included
a section from a technical note I wrote which explains how various sar(1)
statistics are derived for DYNIX/ptx. Since the DYNIX/ptx implementation
was derived from SysVR3 I suspect this is how many other UNIXes define it.
You may find this information useful in designing a Linux implementation of
this metric.

SAR -U: REPORT CPU UTILIZATION
------------------------------
    %usr  - percentage of time spent executing user code

    %sys  - percentage of time spent executing kernel code

    %wio  - percentage of time spent waiting for I/O to complete

    %idle - percentage of time spent in the idle loop

Separate user mode, system mode, and idle time counters are maintained for
each CPU and updated 100 times each second via the hardclock() interrupt
handler (see the v_time member of the vmmeter structure).  It is assumed
that the current state of the CPU was in effect for the entire preceding
interval.

Because "sar -u" assumes a uniprocessor configuration sadc(1) sums the
value of each counter across all CPUs then divides by the number of online
CPUs to normalize the values.  Thus the statistics for an interval will be
incorrect if the number of online CPUs changes.

Notice that %wio does not appear in the previous paragraph.  This is
because the %usr, %sys and %idle counters are maintained in the per engine
vmmeter structure while %wio is maintained in the global procstat structure
and is updated one hundred times a second by the todclock() interrupt
handler.

On each todclock() interrupt (100 times per second) the sum of the

    1) number of processes currently waiting on the swap in queue,
    2) number of processes waiting for a page to be brought into memory,
    3) number of processes waiting on filesystem I/O, and
    4) number or processes waiting on physical/raw I/O

is calculated.  The smaller of that value and the number of CPUs currently
idle is added to the procstat.ps_cpuwait counter (sar's %wio).  This means
that wait time is a subset of idle time.  To put it another way: if there
are 10 CPUs and only 1 was executing the idle loop at the last hardclock()
interrupt the idle percentage would be 10%.  If there was also one process
waiting for disk I/O to complete then %wio would be 10% (1 waiting process
over 10 online CPUs).  Sar would report %wio = 10 and %idle = 0.  If there
were no idle CPUs then %wio would be reported as 0 even though there was
one process waiting for I/O to complete.  If there were two processes
waiting for I/O to complete and 10 CPUs online the %wio would be 20% or the
number of idle CPUs divided by the number online; whichever is smaller.

Note that the calculation of wait time is performed asynchronously to the
collection of user/sys/idle time.  Furthermore, because of the way wait
time is calculated it may actually be larger than the idle time.  Sar(1)
deals with this by forcing the wait time to be less than or equal to the
idle time.  It then subtracts the wait time from the idle time.

The rationale for separating out I/O wait time is that since an I/O
operation may complete at any instant, and the process will be marked
runable and begin consuming CPU cycles, the CPUs should not really be
considered idle.  The %wio metric most definitely does not tell you
anything about how busy the disk subsystem is or whether the disks are
overloaded. It can indicate whether or not the workload is I/O bound.  Or,
to look at it another way, %wio is good for tracking how much busier the
CPUs would be if you could make the disk subsystem infinitely fast.
Finally, notice that this metric is reported by the sar(1) "-u" switch, not
the "-d" switch. Now that you understand what this metric indicates it
should be clear why that is.

-- 
Kurtis D. Rader, Systems Support Engineer    email: kdrader@us.ibm.com
IBM xSeries Integrated Technology Services   voice: +1 503-578-3714
15450 SW Koll Pkwy, MS RHE2-513              http://www.ibm.com
Beaverton, OR 97006-6063
