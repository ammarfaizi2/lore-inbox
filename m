Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVFKEjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVFKEjp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 00:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVFKEji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 00:39:38 -0400
Received: from opersys.com ([64.40.108.71]:3345 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261257AbVFKEjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 00:39:20 -0400
Message-ID: <42AA6A6B.5040907@opersys.com>
Date: Sat, 11 Jun 2005 00:36:59 -0400
From: Kristian Benoit <kbenoit@opersys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.7.8) Gecko/20050515
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       karim@opersys.com, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org, kbenoit@opersys.com
Subject: PREEMPT_RT vs ADEOS: the numbers, part 1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the past few weeks, we've been conducting comparison tests between
PREEMPT_RT and the Adeos nanokernel. As was clear from previous discussion,
we've been open to be proven wrong regarding endorsement of either method.
Hence, this comparison was done in order to better understand the impact
of each method vis-a-vis vanilla Linux.

At this time, we are publishing the summary results of the various test
runs we've conducted. There is, of course, a lot of background information
that needs to be provided (.configs, scripts, drivers, etc.) We will be
making those available sometime early next week. In the mean time, the
following is meant as food-for-thought.

In our tests, we've used a set up with 3 machines. The two main systems
were Dell PowerEdge SC420 machines with a P4 2.8 (UP not SMP configured) with
FC3. One had 256 MB RAM and was the guinea pig (i.e. the machine controlling
the mechanical saw a.k.a. TARGET) The other, having 512 MB RAM, was used to
collect data regarding the guinea pig's responsiveness (a.k.a LOGGER.) The
third machine, an Apple PowerBook 5,6 G4 / 1GB, was used for a dual purpose.
First, it controlled both the target and the logger via ssh, and was also
used to ping flood the target. This 3rd system is known as the HOST.

Data was generated on all three systems:
TARGET: LMbench data
LOGGER: Interrupt response time
HOST: LMbench total running time

Both the host and the logger had a constant kernel configuration. The logger
was running an adeos-enabled kernel in order to trigger and deterministically
measure the responsiveness of the target. The host was running a plain
gentoo-based kernel. The target and the logger were rigged via their parallel
ports so that an output from the logger would trigger an interrupt on the
target who's response would itself trigger an interrupt on the logger.

In the various test runs, we've attempted to collect two sets of data. One
regarding LMbench's total running time for a given set up and the other
regarding the system's interrupt response time. Where appropriate, both tests
were conducted simultaneously. Otherwise, they were conducted in isolation.
The following tables should be self-explanatory.

For LMbench test runs, 3 passes were conducted and an average running time
was collected. Certainly, 3 passes is not as much as we'd like, but for the
immediate purposes, it provides a sufficiently corroborated data set for
analysis (as can be seen in the following tables.)

For the interrupt response time measurement, the logger generated between
500,000 to 650,000 interrupts and measured the target's response time. The
logger was not subject to any load whatsoever, except that imposed by the
logging driver (running in a prioritary Adeos domain, and hence being truly
hard-rt, a.k.a. "ruby" hard) and that of the user-space daemon committing the
data to storage. It could be argued that the use of Adeos imposes a penalty
to the measured response time. However, this penalty is imposed on all data
sets, and verification of its impact can be inferred by analyzing the adeos-to-
adeos set up provided below.

With no further ado, here are the results we've obtained. As we said above, we
will be making all related scripts, patches, and drivers available, so that
others may conduct their own tests.

Note that in the tests we've conducted, we've tried, in as much possible, to
use similar kernels. However, we were unable to find a recent Adeos and a
recent PREEMPT_RT patch which would both cleanly apply to a same recent kernel.
Hence, we've compared vanilla 2.6.12-rc2 with an adeos-patched one and a
2.6.12-rc4 with a PREEMPT_RT-patched one. As can be seen below, the runs of
the vanilla rc2 and rc4 yield very similar numbers, and can therefore
reasonably be considered equivalent.

LMbench running times:
+--------------------+--------+----------+------------+------------+----------+
| Kernel             | plain  | IRQ test | ping flood | IRQ & ping | IRQ & hd |
+====================+========+==========+============+============+==========+
| Vanilla-2.6.12-rc2 | 174  s | 175    s | 189      s | 193      s | 217    s |
+--------------------+--------+----------+------------+------------+----------+
| with Adeos-r10c3   | 180  s | 180    s | 185      s | 183      s | 211    s |
+--------------------+--------+----------+------------+------------+----------+
| %                  | +3.4   | +2.9     | -2.1       | -5.2       | -2.8     |
+====================+========+==========+============+============+==========+
| Vanilla-2.6.12-rc4 | 176  s | 177    s | 189      s | 191      s | 218    s |
+--------------------+--------+----------+------------+------------+----------+
| with RT-V0.7.47-08 | 184  s | 187    s | 206      s | 201      s | 225    s |
+--------------------+--------+----------+------------+------------+----------+
| %                  | +4.5   | +5.6     | +9.0       | +5.2       | +3.2     |
+--------------------+--------+----------+------------+------------+----------+

Legend:
plain          = Nothing special
IRQ test       = on logger: triggering target every 1ms
ping flood     = on host: "sudo ping -f $TARGET_IP_ADDR"
IRQ & ping     = combination of the previous two
IRQ & hd       = IRQ test with the following being done on the target:
                 "while [ true ]
                     do dd if=/dev/zero of=/tmp/dummy count=512
                  done"

In the following, interrupts are triggered by the logger at every 1ms. It would
be interesting to redo such tests with shorter trigger times. However, we
wanted to keep the logger as "off-the-shelf" as possible.

Interrupt response times (all in micro-seconds):
+--------------------+------------+------+-------+------+--------+
| Kernel             | sys load   | Aver | Max   | Min  | StdDev |
+====================+============+======+=======+======+========+
|                    | None       | 15.5 |  64.8 | 15.2 | 1.0    |
|                    | Ping       | 15.7 |  63.4 | 15.2 | 1.2    |
| Vanilla-2.6.12-rc2 | lm. + ping | 16.0 |  72.2 | 15.2 | 1.4    |
|                    | lmbench    | 15.8 |  65.6 | 15.2 | 1.1    |
|                    | lm. + hd   | 15.8 | 179.9 | 15.2 | 1.3    |
+--------------------+------------+------+-------+------+--------+
|                    | None       | 13.4 |  53.3 | 13.2 | 0.2    |
|                    | Ping       | 13.8 |  53.3 | 13.3 | 0.6    |
| with Adeos-r10c3   | lm.+ ping  | 13.9 |  21.8 | 13.2 | 0.7    |
|                    | lmbench    | 13.9 |  21.3 | 13.3 | 0.6    |
|                    | lm. + hd   | 13.9 |  53.2 | 13.2 | 0.5    |
+====================+============+======+=======+======+========+
|                    | None       | 15.2 |  64.2 | 15.2 | 0.5    |
|                    | Ping       | 15.6 |  63.0 | 15.2 | 0.9    |
| Vanilla-2.6.12-rc4 | lm. + ping | 16.0 | 170.5 | 16.0 | 1.4    |
|                    | lmbench    | 15.8 | 184.1 | 15.2 | 1.2    |
|                    | lm. + hd   | 15.8 |  67.1 | 15.0 | 1.1    |
+--------------------+------------+------+-------+------+--------+
|                    | None       | 15.5 | 73.8  | 15.2 | 1.2    |
|                    | Ping       | 17.1 | 79.8  | 15.2 | 2.3    |
| with RT-V0.7.47-08 | lm. + ping | 17.7 | 77.2  | 15.2 | 3.1    |
|                    | lmbench    | 17.1 | 80.0  | 15.3 | 2.3    |
|                    | lm. + hd   | 17.0 | 80.0  | 15.3 | 1.8    |
+--------------------+------------+------+-------+------+--------+

Legend:
None           = nothing special
ping           = on host: "sudo ping -f $TARGET_IP_ADDR"
lm. + ping     = previous test and "make rerun" in lmbench-2.0.4/src/ on target
lmbench        = "make rerun" in lmbench-2.0.4/src/ on target
lm. + hd       = previous test  with the following being done on the target:
                 "while [ true ]
                     do dd if=/dev/zero of=/tmp/dummy count=512
                  done"

Note: Adeos-r10c3 is a "combo" patch including both Adeos and PREEMPT_RT, though
PREEMPT_RT is disabled.

The above data has been provided as-is without any analysis for now. We will
provide such analysis when publishing the complete data sets and related
software. In the mean time, we hope such results will help further reflection.

Best regards and have fun !!!

Kristian Benoit
Karim Yaghmour
-- 
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || 1-866-677-4546


