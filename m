Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbVF2Xus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbVF2Xus (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 19:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVF2Xty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 19:49:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:49097 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262752AbVF2Xsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 19:48:32 -0400
Date: Wed, 29 Jun 2005 16:49:01 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Kristian Benoit <kbenoit@opersys.com>
Cc: linux-kernel@vger.kernel.org, bhuey@lnxw.com, andrea@suse.de,
       tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, take 3
Message-ID: <20050629234901.GH1299@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42C320C4.9000302@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C320C4.9000302@opersys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 06:29:24PM -0400, Kristian Benoit wrote:
> This is the 3rd run of our tests.
> 
> Here are the changes since last time:
> 
> - Modified the IRQ latency measurement code on the logger to do a busy-
> wait on the target instead of responding to an interrupt triggered by
> the target's "reply". As Ingo had suggested, this very much replicates
> what lpptest.c does. In fact, we actually copied Ingo's loop.
> 
> - LMbench runs are now conducted 5 times instead of just 3.
> 
> - The software versions being used were:
>   2.6.12 - final
>   RT-V0.7.50-35
>   I-pipe v0.7

Excellent work, I very much appreciate the effort and the results!!!

						Thanx, Paul

> System load:
> ------------
> 
> As in the two first runs, total system load is measured by LMbench's
> execution time under various system loads. This time, however, each test
> was run 5 times instead of 3. While we would like to consider these
> tests to be generally more representative of general system behavior than
> previous published results, it remains that measuring the total running
> time of something like LMbench only gives a general idea of overall
> system overhead. In fact, looking at the raw results, we can note that
> the running times often vary quite a lot. For a more trustworthy
> measurement, one must look at the results found by LMbench.
> 
> Note that the total running time of all configurations under the
> "plain" and "IRQ test" loads has gone down significantly (by about
> 20 to 25 seconds). This is likely the result of an optimization within
> 2.6.12-final. Most of the other results for the other loads are,
> nevertheless, in the same range of values found previously, except the
> "IRQ & hd" results for PREEMPT_RT which show an improvement.
> 
> LMbench running times:
> +--------------------+-------+-------+-------+-------+-------+
> | Kernel             | plain | IRQ   | ping  | IRQ & | IRQ & |
> |                    |       | test  | flood | ping  |  hd   |
> +====================+=======+=======+=======+=======+=======+
> | Vanilla-2.6.12     | 150 s | 153 s | 183 s | 187 s | 242 s |
> +====================+=======+=======+=======+=======+=======+
> | with RT-V0.7.50-35 | 155 s | 155 s | 205 s | 206 s | 250 s |
> +--------------------+-------+-------+-------+-------+-------+
> | %                  |  3.3  |  1.3  | 12.0  | 10.2  |  3.3  |
> +====================+=======+=======+=======+=======+=======+
> | with Ipipe-0.7     | 153 s | 154 s | 193 s | 198 s | 259 s |
> +--------------------+-------+-------+-------+-------+-------+
> | %                  |  2.0  |  0.6  |  5.5  |  5.9  |  7.0  |
> +--------------------+-------+-------+-------+-------+-------+
> 
> Legend:
> plain          = Nothing special
> IRQ test       = on logger: triggering target every 1ms
> ping flood     = on host: "sudo ping -f $TARGET_IP_ADDR"
> IRQ & ping     = combination of the previous two
> IRQ & hd       = IRQ test with the following being done on the target:
>                  "while [ true ]
>                      do dd if=/dev/zero of=/tmp/dummy count=512 bs=1m
>                   done"
> 
> Looking at the LMbench output, which is clearly a more adequate
> benchmark, here are some highlights (this is averaged on 5 runs using
> lmbsum):
> 
> "plain" run:
> 
> Measurements   |   Vanilla   |  preemp_rt     |   ipipe
> ---------------+-------------+----------------+-------------
> fork           |      93us   |  157us (+69%)  |   95us (+2%)
> open/close     |     2.3us   |  3.7us (+43%)  |  2.4us (+4%)
> execve         |     351us   |  446us (+27%)  |  363us (+3%)
> select 500fd   |    12.7us   | 25.8us (+103%) | 12.8us (+1%)
> mmap           |     660us   | 2867us (+334%) |  677us (+3%)
> pipe           |     7.1us   | 11.6us (+63%)  |  7.4us (+4%)
> 
> 
> "IRQ test" run:
> Measurements   |   Vanilla   |  preemp_rt     |   ipipe
> ---------------+-------------+----------------+-------------
> fork           |      96us   |  158us (+65%)  |   97us (+1%)
> open/close     |     2.4us   |  3.7us (+54%)  |  2.4us (~)
> execve         |     355us   |  453us (+28%)  |  365us (+3%)
> select 500fd   |    12.8us   | 26.0us (+103%) | 12.8us (~%)
> mmap           |     662us   | 2893us (+337%) |  679us (+3%)
> pipe           |     7.1us   | 13.2us (+86%)  |  7.5us (+6%)
> 
> 
> "ping flood" run:
> Measurements   |   Vanilla   |  preemp_rt     |   ipipe
> ---------------+-------------+----------------+-------------
> fork           |     137us   |  288us (+110%) |  162us (+18%)
> open/close     |     3.9us   |  7.0us (+79%)  |  4.0us (+3%)
> execve         |     562us   |  865us (+54%)  |  657us (+17%)
> select 500fd   |    19.3us   | 47.4us (+146%) | 21.0us (+4%)
> mmap           |     987us   | 4921us (+399%) | 1056us (+7%)
> pipe           |    11.0us   | 23.7us (+115%) | 13.3us (+20%)
> 
> 
> "IRQ & ping" run:
> Measurements   |   Vanilla   |  preemp_rt     |   ipipe
> ---------------+-------------+----------------+-------------
> fork           |     143us   |  291us (+103%) |  163us (+14%)
> open/close     |     3.9us   |  7.1us (+82%)  |  4.0us (+3%)
> execve         |     567us   |  859us (+51%)  |  648us (+14%)
> select 500fd   |    19.6us   | 52.2us (+166%) | 21.4us (+9%)
> mmap           |     983us   | 5061us (+415%) | 1110us (+13%)
> pipe           |    12.2us   | 28.0us (+130%) | 12.7us (+4%)
> 
> 
> "IRQ & hd" run:
> Measurements   |   Vanilla   |  preemp_rt     |   ipipe
> ---------------+-------------+----------------+-------------
> fork           |      96us   |  164us (+71%)  |  100us (+4%)
> open/close     |     2.5us   |  3.8us (+52%)  |  2.5us (~)
> execve         |     373us   |  479us (+28%)  |  382us (+2%)
> select 500fd   |    13.3us   | 27.2us (+105%) | 13.4us (+1%)
> mmap           |     683us   | 3013us (+341%) |  712us (+4%)
> pipe           |     9.9us   | 23.0us (+132%) | 10.6us (+7%)
> 
> These results are consistent with those highlighted during the discussion
> following the publication of the last test run.
> 
> 
> Interrupt response time:
> ------------------------
> 
> Unlike the two first times, these times are measured using a busy-wait
> on the logger. Basically, we disable interrupts, fire the interrupt to
> the target, log the time, while(1) until the input on the parallel port
> changes, and then log the time again to obtain the response time. Each
> of these runs accumulates above 1,000,000 interrupt latency measurements.
> 
> We stand corrected as to the method that was used to collect interrupt
> latency measurements. Ingo's suggestion to disable all interrupts on
> the logger to collect the target's response does indeed mostly eliminate
> logger-side latencies. However, we've sporadically ran into situations
> where the logger locked-up, whereas it didn't before when we used to
> measure the response using another interrupt. This happened around 3 times
> in total over all of our test runs (and that's a lot of test runs), so
> it isn't systematic, but it did happen.
> 
> +--------------------+------------+------+-------+------+--------+
> | Kernel             | sys load   | Aver | Max   | Min  | StdDev |
> +====================+============+======+=======+======+========+
> |                    | None       |  5.7 |  51.8 |  5.6 |  0.3   |
> |                    | Ping       |  5.8 |  51.8 |  5.6 |  0.5   |
> | Vanilla-2.6.12     | lm. + ping |  6.2 |  83.5 |  5.6 |  1.0   |
> |                    | lmbench    |  6.0 |  57.6 |  5.6 |  0.9   |
> |                    | lm. + hd   |  6.5 | 177.4 |  5.6 |  4.1   |
> |                    | DoHell     |  6.9 | 525.4 |  5.6 |  5.2   |
> +--------------------+------------+------+-------+------+--------+
> |                    | None       |  5.7 |  47.5 |  5.7 |  0.2   |
> |                    | Ping       |  7.0 |  63.4 |  5.7 |  1.6   |
> | with RT-V0.7.50-35 | lm. + ping |  7.9 |  66.2 |  5.7 |  1.9   |
> |                    | lmbench    |  7.4 |  51.8 |  5.7 |  1.4   |
> |                    | lm. + hd   |  7.3 |  53.4 |  5.7 |  1.9   |
> |                    | DoHell     |  7.9 |  59.1 |  5.7 |  1.8   |
> +--------------------+------------+------+-------+------+--------+
> |                    | None       |  7.1 |  50.4 |  5.7 |  0.2   |
> |                    | Ping       |  7.3 |  47.6 |  5.7 |  0.4   |
> | with Ipipe-0.7     | lm.+ ping  |  7.7 |  50.4 |  5.7 |  0.8   |
> |                    | lmbench    |  7.5 |  50.5 |  5.7 |  0.7   |
> |                    | lm. + hd   |  7.5 |  51.8 |  5.7 |  0.7   |
> |                    | DoHell     |  7.6 |  50.5 |  5.7 |  0.7   |
> +--------------------+------------+------+-------+------+--------+
> 
> Legend:
> None           = nothing special
> ping           = on host: "sudo ping -f $TARGET_IP_ADDR"
> lm. + ping     = previous test and "make rerun" in lmbench-2.0.4/src/ on
> target
> lmbench        = "make rerun" in lmbench-2.0.4/src/ on target
> lm. + hd       = previous test  with the following being done on the target:
>                  "while [ true ]
>                      do dd if=/dev/zero of=/tmp/dummy count=512 bs=1m
>                   done"
> DoHell         = See:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111947618802722&w=2
> 
> We don't know whether we've hit the maximums Ingo alluded to, but we
> did integrate his dohell script and the only noticeable difference was
> with Linux where the maximum jumped to 525.4 micro-seconds. But that
> was with vanilla only. Neither PREEMPT_RT nor I-PIPE exhibited such
> maximums under the same load.
> 
> 
> Overall analysis:
> -----------------
> 
> We had not intended to redo a 3rd run so early, but we're happy we did
> given the doubts expressed by some on the LKML. And as we suspected, these
> new results very much corroborate what we had found earlier. As such, our
> conclusions remain mostly unchanged:
> 
> - Both approaches yield similar results in terms of interrupt response times.
> On most runs I-pipe seems to do slightly better on the maximums, but there
> are cases where PREEMPT_RT does better. The results obtained in this
> 3rd round do corroborate the average latency extrapolated from analyzing
> previous runs, but they contradict our earlier analysis of the true
> maximum delays. Instead, it was Paul McKenny that was right, the maximums
> are indeed around 50us. Also, Ingo was right in as far as we found a
> maximum for vanilla Linux that went all the way up to 525us. We stand
> corrected on both these issues. Nevertheless, the above results are
> consistent with previously published ones.
> 
> - In terms of system load, PREEMPT_RT is typically still higher in
> cost than I-pipe, as had been seen in the two previous runs. Please note
> that we've done our best to use the truly latest version of PREEMPT_RT
> available at this time. We actually did on purpose to finish all other
> tests before doing PREEMPT_RT runs in order to make sure we were using
> the latest possible release, as this was one of the main grievances
> expressed by those supporting PREEMPT_RT.
> 
> For a more complete discussion of our conclusions please see our previous
> test results publication:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111928813818151&w=2
> 
> Again, we hope these results will help those interested in enhancing Linux
> for use in real-time applications to better direct their efforts.
> 
> Kristian Benoit
> Karim Yaghmour
> --
> Pushing Embedded and Real-Time Linux Systems Beyond the Limits
> http://www.opersys.com || 1-866-677-4546
> 
