Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262940AbVGHXGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbVGHXGh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 19:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbVGHXES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 19:04:18 -0400
Received: from opersys.com ([64.40.108.71]:42248 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262940AbVGHXCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 19:02:11 -0400
Message-ID: <42CF05BE.3070908@opersys.com>
Date: Fri, 08 Jul 2005 19:01:18 -0400
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
Subject: PREEMPT_RT and I-PIPE: the numbers, part 4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 4th run of our tests.

Here are the changes since last time:

- For some reason we can't explain yet, highmem was enabled throughout
all our previous runs, this despite our use of a .config provided by
Ingo verbatim. Somehow, through the cycles of "make oldconfig" it got
re-enabled somewhere. Nevertheless, as we suspected, disabling
highmem did not, by itself, fix all of the performance issues with
PREEMPT_RT. Instead, as the numbers below show, there have been some
key changes made to PREEMPT_RT that regardless of highmem have made it
much better. Attached is a file showing the differences between the
enabling and disabling of highmem for two different PREEMPT_RT kernels.

- The software versions being used were:
  2.6.12 - final
  RT-0.7.51-02
  I-pipe v0.7


System Load:
------------
The configuration is the same as before: 5 LMbench runs for each
setup. Again, LMbench running times provide but a general idea
of system performance. The actual results collected by LMbench are
more trustworthy.

LMbench running times:
+--------------------+-------+-------+-------+-------+-------+
| Kernel             | plain | IRQ   | ping  | IRQ & | IRQ & |
|                    |       | test  | flood | ping  |  hd   |
+====================+=======+=======+=======+=======+=======+
| Vanilla-2.6.12     | 152 s | 150 s | 188 s | 185 s | 239 s |
+====================+=======+=======+=======+=======+=======+
| with RT-V0.7.51-02 | 152 s | 153 s | 203 s | 201 s | 239 s |
+--------------------+-------+-------+-------+-------+-------+
| %                  |   ~   |  2.0  |  8.0  |  8.6  |   ~   |
+====================+=======+=======+=======+=======+=======+
| with Ipipe-0.7     | 149 s | 150 s | 193 s | 192 s | 236 s |
+--------------------+-------+-------+-------+-------+-------+
| %                  | -2.0  |   ~   |  2.7  |  3.8  | -1.3  |
+--------------------+-------+-------+-------+-------+-------+

"plain" run:

Measurements   |   Vanilla   |  preempt_rt    |   ipipe
---------------+-------------+----------------+-------------
fork           |      97us   |   91us (-6%)   |  101us (+4%)
open/close     |     2.8us   |  2.9us (+3%)   |  2.8us (~)
execve         |     348us   |  347us (~)     |  356us (+2%)
select 500fd   |    13.9us   | 17.1us (+23%)  | 13.9us (~)
mmap           |     776us   |  629us (-19%)  |  794us (+2%)
pipe           |     5.1us   |  5.1us (~)     |  5.4us (+6%)


"IRQ test" run:
Measurements   |   Vanilla   |  preempt_rt    |   ipipe
---------------+-------------+----------------+-------------
fork           |      98us   |   91us (-7%)   |  100us (+2%)
open/close     |     2.8us   |  2.8us (~)     |  2.8us (~)
execve         |     349us   |  349us (~)     |  359us (+3%)
select 500fd   |    13.9us   | 17.2us (+24%)  | 13.9us (~)
mmap           |     774us   |  630us (-19%)  |  792us (+2%)
pipe           |     5.0us   |  5.0us (~)     |  5.5us (+10%)


"ping flood" run:
Measurements   |   Vanilla   |  preempt_rt    |   ipipe
---------------+-------------+----------------+-------------
fork           |     152us   |  171us (+13%)  |  165us (+9%)
open/close     |     4.5us   |  4.8us (+7%)   |  4.8us (+7%)
execve         |     550us   |  663us (+21%)  |  601us (+9%)
select 500fd   |    20.9us   | 29.4us (+41%)  | 21.9us (+5%)
mmap           |    1140us   | 1122us (-2%)   | 1257us (+10%)
pipe           |     8.3us   |  9.4us (+13%)  | 10.2us (+23%)


"IRQ & ping" run:
Measurements   |   Vanilla   |  preempt_rt    |   ipipe
---------------+-------------+----------------+-------------
fork           |     150us   |  170us (+13%)  |  160us (+7%)
open/close     |     4.6us   |  5.3us (+15%)  |  4.8us (+4%)
execve         |     512us   |  629us (+23%)  |  610us (+19%)
select 500fd   |    20.9us   | 30.6us (+46%)  | 24.3us (+16%)
mmap           |    1128us   | 1083us (-4%)   | 1264us (+12%)
pipe           |     9.0us   |  9.6us (+7%)   |  9.6us (+7%)


"IRQ & hd" run:
Measurements   |   Vanilla   |  preempt_rt    |   ipipe
---------------+-------------+----------------+-------------
fork           |     101us   |   94us (-7%)   |  103us (+2%)
open/close     |     2.9us   |  2.9us (~)     |  3.0us (+3%)
execve         |     366us   |  370us (+1%)   |  372us (+2%)
select 500fd   |    14.3us   | 18.1us (+27%)  | 14.5us (+1%)
mmap           |     794us   |  654us (+18%)  |  822us (+4%)
pipe           |     6.3us   |  6.5us (+3%)   |  7.3us (+16%)


Let's get the easy one out of the way: the numbers for I-pipe have
remained fairly similar to our last run.

The numbers for PREEMPT_RT, however, have dramatically improved. All
the 50%+ overhead we saw earlier has now gone away completely. The
improvement is in fact nothing short of amazing. We were actually
so surprised that we went around looking for any mistakes we may
have done in our testing. We haven't found any though. So unless
someone comes out with another set of numbers showing differently,
we think that a warm round of applause should go to the PREEMPT_RT
folks. If nothing else, it gives us satisfaction to know that these
test rounds have helped make things better.


Interrupt response time:
------------------------
These numbers were collected very much the same way as before:
1,000,000 samples.

+--------------------+------------+------+-------+------+--------+
| Kernel             | sys load   | Aver | Max   | Min  | StdDev |
+====================+============+======+=======+======+========+
|                    | None       |  5.8 |  51.9 |  5.6 |  0.3   |
|                    | Ping       |  5.8 |  49.1 |  5.6 |  0.8   |
| Vanilla-2.6.12     | lm. + ping |  6.1 |  53.3 |  5.6 |  1.1   |
|                    | lmbench    |  6.1 |  77.9 |  5.6 |  0.8   |
|                    | lm. + hd   |  6.5 | 128.4 |  5.6 |  3.4   |
|                    | DoHell     |  6.8 | 555.6 |  5.6 |  7.2   |
+--------------------+------------+------+-------+------+--------+
|                    | None       |  5.7 |  48.9 |  5.6 |  0.2   |
|                    | Ping       |  7.0 |  62.0 |  5.6 |  1.5   |
| with RT-V0.7.51-02 | lm. + ping |  7.9 |  56.2 |  5.6 |  1.9   |
|                    | lmbench    |  7.3 |  56.1 |  5.6 |  1.4   |
|                    | lm. + hd   |  7.3 |  70.5 |  5.6 |  1.8   |
|                    | DoHell     |  7.4 |  54.6 |  5.6 |  1.4   |
+--------------------+------------+------+-------+------+--------+
|                    | None       |  7.2 |  47.6 |  5.7 |  1.9   |
|                    | Ping       |  7.3 |  48.9 |  5.7 |  0.4   |
| with Ipipe-0.7     | lm.+ ping  |  7.6 |  50.5 |  5.7 |  0.8   |
|                    | lmbench    |  7.5 |  50.5 |  5.7 |  0.9   |
|                    | lm. + hd   |  7.5 |  50.5 |  5.7 |  1.1   |
|                    | DoHell     |  7.6 |  50.5 |  5.7 |  0.7   |
+--------------------+------------+------+-------+------+--------+
Legend:
None           = nothing special
ping           = on host: "sudo ping -f $TARGET_IP_ADDR"
lm. + ping     = previous test and "make rerun" in lmbench-2.0.4/src/ on
target
lmbench        = "make rerun" in lmbench-2.0.4/src/ on target
lm. + hd       = previous test  with the following being done on the target:
                 "while [ true ]
                     do dd if=/dev/zero of=/tmp/dummy count=512 bs=1m
                  done"
DoHell         = See:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111947618802722&w=2

The results above match those found earlier.


Overall analysis:
-----------------

We certainly had no intention of doing a 4th round. But having discovered
the highmem problem, we decided to finally do one more. Fortunately,
Ingo had fixed a few things in the mean time, and the new results now
are that much more better for PREEMPT_RT.

We have yet to fully understand, however, exactly what was the problem
with PREEMPT_RT before .50-36. We know highmem wasn't all, as the attached
results show, so we went digging in the two releases just following
.50-35 as those were the ones mentioned by Ingo in reply to our 3rd
posting as having had siginificant improvements in terms of performance.

Between 50-35 and 50-36, we see a bunch of TLB fixes. Does this mean
that the TLB was getting overly thrashed in PREEMPT_RT previously?

Between 50-36 and 50-37 the changes are less straight-forward though.
We noticed that a few things were added like add/sub_preempt_count_ti(),
inc/dec_preempt_count_ti() and a couple of *_ti, but we couldn't figure
out what "ti" means. Also, instead of variables, some macros are being
used. For example, instances of "eip" have been replaced with "__EIP__".

Any explanation as to how these changes modified the results so
significantly, and the underlying problems that were fixed, would be
great.

Also, in order to evaluate things as even-handidly as possible, it would
be interesting to know of any general improvements, if any, that were
introduced in the PREEMPT_RT patches that would also be applicable to
vanilla Linux.

While it has improved greatly, it remains that PREEMPT_RT is generally
more sensitive to interrupt load than the I-pipe. Also, as in previous
runs, the I-pipe's response times tend to remain more stable and
generally lower than PREEMPT_RT's. Also, it remains that, as can be
seen by the many problems we've encountered, PREEMPT_RT is highly
kernel-config sensistive.

Again, we are happy that these testruns have motivated the fixing of
some performance problems in PREEMPT_RT, and we continue to encourage
interested parties to continue their efforts in making Linux more
suitable to real-time applications. One area of interest, as was
mentioned by Ingo in reply to our publication of our 3rd test results,
is scheduling latency. We have not studied this area in our tests,
but it is certainly relevant and we hope others will dig further in
this direction.

It remains that no test result can by itself be definitive, and at
this stage we strongly believe that others need to be involved in
continuous testing of real-time approaches. This is the only way any
significant advancement will be made. And as these past testruns
have shown, proponents of one approach or another can be very
sensitive to the publication of numbers showing their projects in
a bad light. Yet, whether good or bad, performance numbers are an
important part of any process that strives to achieve determinism.

Kristian Benoit
Karim Yaghmour
--
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || 1-866-677-4546
