Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVFTRSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVFTRSs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 13:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVFTRSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 13:18:48 -0400
Received: from opersys.com ([64.40.108.71]:43534 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261384AbVFTRRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 13:17:54 -0400
Subject: PREEMPT_RT vs I-PIPE: the numbers, part 2
From: Kristian Benoit <kbenoit@opersys.com>
To: linux-kernel@vger.kernel.org
Cc: paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       karim@opersys.com, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org, kbenoit@opersys.com
Content-Type: text/plain
Date: Mon, 20 Jun 2005 13:13:32 -0400
Message-Id: <1119287612.6863.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've finally been able to complete a second round of our tests.
Unfortunately, this has taken much longer than we ever anticipated.
Without going into too much detail, suffice it to say that we ran into
problems with each of our intended test configurations. Fortunately,
the results are that much more interesting and, we hope, more
accurately illustrate the performance of the approaches being
compared.

The setup is exactly the same as the one previously described. So if
you've missed our earlier posting, it'll probably be easier to go read
that one first for background info:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111846495403131&w=2

Of course we would have liked to post the complete packages and
configs that were used instead. Given the time spent on getting the
tests to work again with the new configs, we were unable to put
together a decent package though. Without further promising any
dates, we will make those available shortly.

Also, note that the versions of the approaches we were testing went
through significant changes between those versions we last used and
the versions published in the current testset.

For PREEMPT_RT, word from Ingo is that a lot of things were fixed
since the version we were using in our last tests. Hence, we used
a more recent version and relied on the .config provided to us
by Ingo. And indeed the numbers seem to confirm Ingo's analysis.
As we will see below, PREEMPT_RT behaves quite well.

For Adeos ... hmm Adeos? what's that ... I mean I-pipe ... well
that's the news about it isn't it. While we were working on
benchmarking his stuff, Philippe refactored the core component
of the Adeos patch in order to isolate the interrupt pipeline
therein implemented. Philippe's recent posting of these patches
should provide a better explanation than we can put here. But
basically, what we used and measured in Adeos is very much the
same thing we are doing with the I-pipe here. Though the version
posted Friday by Philippe to the LKML is more recent than the
one we used for our tests, it should be good enough for comparison.

Another change since the last test run is that in this case,
both setups are compared to the same kernel, 2.6.12-rc6. Needless
to say that we are much happier with comparing two approaches to
the same exact kernel version instead of trying to correlate
results from two different kernels.

In terms of changes to the tests, a few minor things have
changed. Most importantly, the hd test now correctly contains a
"bs=1m", and hence results in the creation of a 512MB file on
disk. Unlike the wishes we expressed earlier, we haven't integrated
additional tests to the ones we had already carried out. It was
enough work already to get a repeat of the same tests that
followed the recommendations of the proponents of each method.
Those tests that were mentioned remain relevant nonetheless,
especially hackbench and dbench.

So here are the results, and an attempted analysis. As was said
earlier, we don't believe any single test run will ever
definitively rule in favor or against either approach. Only
continued benchmarking will help steer discussions we hope in
the right direction.


Total system load:
------------------

Like last time, total system load is measured by LMbench's total
execution time under various system loads. Again, these are on
an average of 3 runs each, so the previous caveats still apply:
on such a few runs, the numbers should be read as a general
tendency with more definitive numbers requiring many more repeats.

LMbench running times:
+--------------------+-------+-------+-------+-------+-------+
| Kernel             | plain | IRQ   | ping  | IRQ & | IRQ & |
|                    |       | test  | flood | ping  |  hd   |
+====================+=======+=======+=======+=======+=======+
| Vanilla-2.6.12-rc6 | 175 s | 176 s | 185 s | 187 s | 246 s |
+====================+=======+=======+=======+=======+=======+
| with RT-V0.7.48-25 | 182 s | 184 s | 201 s | 202 s | 278 s |
+--------------------+-------+-------+-------+-------+-------+
| %                  |  4.0  |  4.5  |  8.6  |  8.0  | 13.0  |
+====================+=======+=======+=======+=======+=======+
| with Ipipe-0.4     | 176 s | 179 s | 189 s | 190 s | 260 s |
+--------------------+-------+-------+-------+-------+-------+
| %                  |  0.5  |  1.7  |  2.2  |  1.6  |  5.7  |
+--------------------+-------+-------+-------+-------+-------+

Legend:
plain          = Nothing special
IRQ test       = on logger: triggering target every 1ms
ping flood     = on host: "sudo ping -f $TARGET_IP_ADDR"
IRQ & ping     = combination of the previous two
IRQ & hd       = IRQ test with the following being done on the target:
                 "while [ true ]
                     do dd if=/dev/zero of=/tmp/dummy count=512 bs=1m
                  done"

In general, it seems that rc6 provides similar results as rc2 and
rc4 did in our earlier tests, so that's a good indication of the
validity of those numbers. The only number that is significantly
different is the IRQ & hd test, but that is easily explained by
the fact that in our earlier test we did not have the "bs=1m" in
the "dd" command. Hence, only a 512 bytes file was generated
instead of the intended 512MB.

For PREEMPT_RT the numbers are also similar to those we found last
time, which again helps confirm the tendency. However, as expected,
the HD test is significantly different, for the same reasons as
above (namely "bs=1m"). Without entering the world of speculation
too much, it should be fair to say that the overhead generally
observed in the various PREEMPT_RT runs in comparison to the
vanilla runs is likely due to the additions introduced by the
patch to some of the kernel's critical mechanisms.

For the Ipipe, the numbers are better than those observed for Adeos
in the last run for the light loads, but not as good for the heavy
loads. While the I-pipe's impact remains much lower than PREEMPT_RT,
as was the case for Adeos in the last test run, it is rather
difficult to compare both test results as the I-pipe is not exactly
Adeos. One important modification is that Adeos domains each ran
using a separate stack and Adeos switched to the appropriate stack
when switching domains. The current I-pipe has had this functionality
stripped from it and, for what we make of it, the interrupts are
handled on whatever stack exists at that time. It appears that this
had the advantage of reducing the size of the patch, but if the
I-pipe can be compared to Adeos, then it appears that removing this
functionality has reduced performance. It is also possible that the
slowdown may be due to subtle bugs introduced by the refactoring.
More testing would need to be carried out to better determine the
cause.

In general, it appears that I-pipe's impact on general system
performance is lower than PREEMPT_RT's.


Interrupt response time:
------------------------

Like last time, interrupt response time is measured by the delay it
takes for the target to respond to interrupts from the logger. Given
that somewhere between 500,000 and 650,000 interrupts are generated
by the logger for each test run, we believe that these results
illustrate fairly well the behavior of the measured approaches.

Time in micro-seconds:
+--------------------+------------+------+-------+------+--------+
| Kernel             | sys load   | Aver | Max   | Min  | StdDev |
+====================+============+======+=======+======+========+
|                    | None       | 13.9 |  55.5 | 13.4 |  0.4   |
|                    | Ping       | 14.0 |  57.9 | 13.3 |  0.4   |
| Vanilla-2.6.12-rc6 | lm. + ping | 14.3 | 171.6 | 13.4 |  1.0   |
|                    | lmbench    | 14.2 | 150.2 | 13.4 |  1.0   |
|                    | lm. + hd   | 14.7 | 191.7 | 13.3 |  4.0   |
+--------------------+------------+------+-------+------+--------+
|                    | None       | 13.9 |  53.1 | 13.4 |  0.4   |
|                    | Ping       | 14.4 |  56.2 | 13.4 |  0.9   |
| with RT-V0.7.48-25 | lm. + ping | 14.7 |  56.9 | 13.4 |  1.1   |
|                    | lmbench    | 14.3 |  57.0 | 13.4 |  0.7   |
|                    | lm. + hd   | 14.3 |  58.9 | 13.4 |  0.8   |
+--------------------+------------+------+-------+------+--------+
|                    | None       | 13.9 |  53.3 | 13.5 |  0.8   |
|                    | Ping       | 14.2 |  57.2 | 13.6 |  0.9   |
| with Ipipe-0.4     | lm.+ ping  | 14.5 |  56.5 | 13.5 |  0.9   |
|                    | lmbench    | 14.3 |  55.6 | 13.4 |  0.9   |
|                    | lm. + hd   | 14.4 |  55.5 | 13.4 |  0.9   |
+--------------------+------------+------+-------+------+--------+

Legend:
None           = nothing special
ping           = on host: "sudo ping -f $TARGET_IP_ADDR"
lm. + ping     = previous test and "make rerun" in lmbench-2.0.4/src/ on
target
lmbench        = "make rerun" in lmbench-2.0.4/src/ on target
lm. + hd       = previous test  with the following being done on the
target:
                 "while [ true ]
                     do dd if=/dev/zero of=/tmp/dummy count=512 bs=1m
                  done"

In last week's test run it may have seemed that there was a distinct
pattern for each setup and that average response times were slightly
different (give or take a microsecond here or there.) In the current
test run it appears that the average response time in all
configurations is identical, that the same can be said about the
minimum response times, and that vanilla clearly has much larger
maximum response times when compared to either real-time extension.

For PREEMPT_RT clearly the results are much better than last time.
Indeed it appears that, as Ingo predicted, a combination of the
proper configuration options and most recent additions gives
PREEMPT_RT important gains. In comparison to last week's results
all measures are lower: average response time, maximum response time,
minimum response time, and standard deviation. This is very good.
But that's not all. PREEMPT_RT also comes down virtually neck-to-
neck with the I-pipe (and the previous numbers from Adeos) in
terms of maximum interrupt response time. Certainly those backing
PREEMPT_RT, and others we hope, will find this quite positive.

The I-pipe, for its part, has yielded overall identical results to
Adeos' results from last week. In doing so, it confirms its claims
of inheriting Adeos' most important feature: the ability to obtain
deterministic interrupt response times.


Overall analysis:
-----------------

The guiding principal in carrying out those tests has been to help
us, and we hope others, understand the impact the proposed real-time
additions have on Linux. As such, these numbers are far from being
the entire story. They only provide additional hints to those
studying Linux's progression towards real-time responsiveness.

Clearly the approaches analyzed here take a different path to
their enabling of real-time in Linux. And while both are being
submitted by separate groups to the general Linux community, it
is important, as was made clear in earlier threads, to highlight
that these approaches can and have already been used together --
some have outright labeled them orthogonal. It follows that a
comparison between these approaches should not necessarily be used
for trying to determine a "winner".

Instead, we suggest that the above tests will likely be used to
better help those needing real-time responsiveness to decide which
approach is best for them. As can be expected, such choices are
often guided by compromise. We would have liked to offer some
general guidelines, but after thinking long and hard, we thought
it'd be best if those were laid out through the _constructive_
criticism of the community. Nonetheless, here are some general
_comments_ to start things off.

On the face of it, one would be tempted to conclude that if you
are looking for a lightweight mechanism for obtaining deterministic
interrupt response times, then the I-pipe seems to be a pretty safe
bet. After all, its impact on general system performance seems less
than that of PREEMPT_RT.

However, the I-pipe alone doesn't replace the functionality offered
by PREEMPT_RT, most importantly in regards to the rt scheduling of
user-space processes.

So at this point one would be tempted to conclude that if you're
looking for a fully integrated rt solution for Linux, PREEMPT_RT
would be the best candidate. After all it seems to provide as
good interrupt response times as I-pipe while providing rt
scheduling of user-space processes, albeit with a price on
general system performance.

But as was stated earlier in these rt threads -- then the argument
was made for Adeos, but it still applies for the I-pipe --, the
I-pipe is also an enabler for running an rt executive side-by-side
with Linux. With Fusion, for example, user-space processes can be
provided with rt scheduling and other services using the
transparent migration of service requests between Linux and the
RT-executive.

Again, as we said earlier, we do not believe that the approaches
are mutually exclusive. In fact, given that the I-pipe can be
easily integrated with PREEMPT_RT, it should be fairly simple to
obtain a single Linux tree that supports both for the PREEMPT_RT
approach and the I-pipe/Fusion approach.

IFF a choice must be made between both PREEMPT_RT and the I-pipe/
Fusion, then further tests would need to be carried out, in
particular with regards to scheduling latencies. Based on
guidance provided by previous discussion, however, such tests may
actually reveal that, as in this case, the actual choice depends on
a features vs. performance compromise.

Which brings us back to Paul's earlier summary: it appears that
there is not a single approach to solve all real-time problems
in Linux. Instead, it seems that a clever combination of many
approaches is the best way forward. In that regard, we hope that
the above tests will help guide this analysis in a fruitful
direction.

As usual, your feedback is appreciated.

Best regards,

Kristian Benoit
Karim Yaghmour
--
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || 1-866-677-4546




