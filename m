Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWFHHuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWFHHuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWFHHuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:50:18 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:61840 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964787AbWFHHuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:50:16 -0400
Message-ID: <4487D6B0.3080502@bigpond.net.au>
Date: Thu, 08 Jun 2006 17:50:08 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@openvz.org>, Srivatsa <vatsa@in.ibm.com>,
       CKRM <ckrm-tech@lists.sourceforge.net>,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 0/4] sched: Add CPU rate caps (improved)
References: <20060606023708.2801.24804.sendpatchset@heathwren.pw.nest> <448688B2.2030206@jp.fujitsu.com>
In-Reply-To: <448688B2.2030206@jp.fujitsu.com>
Content-Type: multipart/mixed;
 boundary="------------060408000302010500090303"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 8 Jun 2006 07:50:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060408000302010500090303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

MAEDA Naoaki wrote:
> 
> I tried to run kernbench with hard cap, and then it spent a very
> long time on "Cleaning souce tree..." phase. Because this phase
> is not CPU hog, my expectation is that it act as without cap.
> 
> That can be reproduced by just running "make clean" on top of a
> kernel source tree with hard cap.
> 
> % /usr/bin/time make clean
> 1.62user 0.29system 0:01.90elapsed 101%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (0major+68539minor)pagefaults 0swaps
> 
>   # Without cap, it returns almost immediately
> 
> % ~/withcap.sh  -C 900 /usr/bin/time make clean
> 1.61user 0.29system 1:26.17elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+68537minor)pagefaults 0swaps
> 
>   # With 90% hard cap, it takes about 1.5 minutes.
> 
> % ~/withcap.sh  -C 100 /usr/bin/time make clean
> 1.64user 0.34system 3:31.48elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+68538minor)pagefaults 0swaps
> 
>   # It became worse with 10% hard cap.
> 
> % ~/withcap.sh  -c 900 /usr/bin/time make clean
> 1.63user 0.28system 0:01.89elapsed 100%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (0major+68537minor)pagefaults 0swaps
> 
>   # It doesn't happen with soft cap.

This behaviour is caused by the "make clean" being a short lived CPU 
intensive task.  It was made worse by the facts that my simplifications 
to the sinbin duration calculation which assumed a constant CPU burst 
size based on the time slice and that exiting tasks could still have 
caps enforced.  (The simplification was done to avoid 64 bit divides.)

I've put in a more complex sinbin calculation (and don't think the 64 
bit divides will matter too much as they're on an infrequently travelled 
path.  Exiting tasks are now excluded from having caps enforced on the 
grounds that it's best for system performance to let them get out of the 
way as soon as possible.  A patch is attached and I would appreciate it 
if you could see if it improves the situation you are observing.

These changes don't completely get rid of the phenomenon but I think 
that it's less severe.  I've written a couple of scripts to test this 
behaviour using the wload program from:

<http://prdownloads.sourceforge.net/cpuse/simloads-0.1.1.tar.gz?download>

You run loop.sh with a single argument and it uses asps.sh.   What the 
test does is run a number (specified by the argument to loop.sh) of 
instances of wload in series and uses time to get the stats for the 
series to complete.  It does these for a number of different durations 
of wload running between 0.001 and 10.0 seconds.  Here's an example of 
an output from an uncapped run:

Peter[peterw@heathwren ~]$ ./loops.sh 1
-d=0.001: user = 0.01 system = 0.00 elapsed = 0.00 rate = 133%
-d=0.005: user = 0.01 system = 0.00 elapsed = 0.01 rate = 84%
-d=0.01: user = 0.02 system = 0.00 elapsed = 0.01 rate = 105%
-d=0.05: user = 0.06 system = 0.00 elapsed = 0.05 rate = 103%
-d=0.1: user = 0.10 system = 0.00 elapsed = 0.11 rate = 98%
-d=0.5: user = 0.50 system = 0.00 elapsed = 0.50 rate = 100%
-d=1.0: user = 1.00 system = 0.00 elapsed = 1.01 rate = 99%
-d=5.0: user = 5.00 system = 0.00 elapsed = 5.01 rate = 99%
-d=10.0: user = 10.00 system = 0.00 elapsed = 10.01 rate = 99%

and with a cap of 90%:

[peterw@heathwren ~]$ withcap -C 900 ./loops.sh 1
-d=0.001: user = 0.00 system = 0.00 elapsed = 0.01 rate = 53%
-d=0.005: user = 0.01 system = 0.00 elapsed = 0.02 rate = 61%
-d=0.01: user = 0.01 system = 0.00 elapsed = 0.03 rate = 66%
-d=0.05: user = 0.06 system = 0.00 elapsed = 0.07 rate = 85%
-d=0.1: user = 0.10 system = 0.00 elapsed = 0.11 rate = 91%
-d=0.5: user = 0.50 system = 0.00 elapsed = 0.56 rate = 90%
-d=1.0: user = 1.00 system = 0.00 elapsed = 1.11 rate = 90%
-d=5.0: user = 5.00 system = 0.00 elapsed = 5.54 rate = 90%
-d=10.0: user = 10.00 system = 0.00 elapsed = 11.14 rate = 89%

Notice how the tasks' usage rates get closer to the cap the longer the 
task runs and never exceeds the cap.  With smaller caps the effect is 
different e.g. for a 9% cap we get:

[peterw@heathwren ~]$ withcap -C 90 ./loops.sh 1
-d=0.001: user = 0.00 system = 0.00 elapsed = 0.01 rate = 109%
-d=0.005: user = 0.01 system = 0.00 elapsed = 0.02 rate = 59%
-d=0.01: user = 0.02 system = 0.00 elapsed = 0.05 rate = 35%
-d=0.05: user = 0.05 system = 0.00 elapsed = 0.14 rate = 42%
-d=0.1: user = 0.10 system = 0.00 elapsed = 0.25 rate = 43%
-d=0.5: user = 0.50 system = 0.00 elapsed = 1.87 rate = 27%
-d=1.0: user = 1.00 system = 0.00 elapsed = 5.37 rate = 18%
-d=5.0: user = 5.00 system = 0.00 elapsed = 48.61 rate = 10%
-d=10.0: user = 10.00 system = 0.00 elapsed = 102.22 rate = 9%

and short lived tasks are being under capped.

Bearing in mind that -d=0.01 is equivalent of a task running for just a 
single tick and that that's about the shortest cycle length we're likely 
to see for CPU intensive tasks (and then only when the capping 
enforcement kicks) I think it is unrealistic to expect much better for 
tasks with a life shorter than that.  Further it takes several cycles to 
gather reasonable statistics to base capping enforcement so I think that 
doing much better than this for short lived tasks is unrealistic.

You could also try using a smaller value for CAP_STATS_OFFSET as this 
will shorten the half life of the Kalman filters and make the capping 
react more quickly to changes in usage rates (which is what a task's 
starting is).  The downside is that it will be less smooth.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------060408000302010500090303
Content-Type: application/x-shellscript;
 name="loops.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="loops.sh"

IyEvYmluL3NoCgpuPTEwCgppZiBbICQjIC1lcSAxIF0KdGhlbgogICAgbj0kIwpmaQoKZm9y
IGkgaW4gMC4wMDEgMC4wMDUgMC4wMSAwLjA1IDAuMSAwLjUgMS4wIDUuMCAxMC4wCmRvCiAg
L3Vzci9iaW4vdGltZSAtZiAidXNlciA9ICVVIHN5c3RlbSA9ICVTIGVsYXBzZWQgPSAlZSBy
YXRlID0gJVAiIGFzcHMuc2ggJG4gJGkKZG9uZQo=
--------------060408000302010500090303
Content-Type: text/plain;
 name="short-lived-tasks-hard-cap-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="short-lived-tasks-hard-cap-fix"

---
 kernel/sched.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

Index: MM-2.6.17-rc5-mm3/kernel/sched.c
===================================================================
--- MM-2.6.17-rc5-mm3.orig/kernel/sched.c	2006-06-06 11:29:51.000000000 +1000
+++ MM-2.6.17-rc5-mm3/kernel/sched.c	2006-06-08 14:28:10.000000000 +1000
@@ -216,7 +216,8 @@ static void sinbin_release_fn(unsigned l
 #define cap_load_weight(p) \
 	(max((int)((min_cpu_rate_cap(p) * SCHED_LOAD_SCALE) / CPU_CAP_ONE), 1))
 #define safe_to_enforce_cap(p) \
-	(!((p)->mutexes_held || (p)->flags & (PF_FREEZE | PF_UIWAKE)))
+	(!((p)->mutexes_held || \
+	   (p)->flags & (PF_FREEZE | PF_UIWAKE | PF_EXITING)))
 #define safe_to_sinbin(p) (safe_to_enforce_cap(p) && !signal_pending(p))
 
 static void init_cpu_rate_caps(task_t *p)
@@ -1235,13 +1236,16 @@ static unsigned long reqd_sinbin_ticks(c
 	unsigned long long rhs = p->avg_cycle_length * p->cpu_rate_hard_cap;
 
 	if (lhs > rhs) {
-		unsigned long res;
-
-		res = static_prio_timeslice(p->static_prio);
-		res *= (CPU_CAP_ONE - p->cpu_rate_hard_cap);
-		res /= CPU_CAP_ONE;
+		lhs -= p->avg_cpu_per_cycle;
+		lhs >>= CAP_STATS_OFFSET;
+		/* have to do two divisions because there's no gaurantee
+		 * that p->cpu_rate_hard_cap * (1000000000 / HZ) would
+		 * not overflow a 32 bit unsigned integer
+		 */
+		(void)do_div(lhs, p->cpu_rate_hard_cap);
+		(void)do_div(lhs, (1000000000 / HZ));
 
-		return res ? : 1;
+		return lhs ? : 1;
 	}
 
 	return 0;

--------------060408000302010500090303
Content-Type: application/x-shellscript;
 name="asps.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="asps.sh"

IyEvYmluL3NoCgplY2hvIC1uZSAiLWQ9JDI6ICIKCmZvciAoKCBpPTA7IGkgPCAkMTsgaSsr
KSkKZG8KICB3bG9hZCAtbCAxIC1jICIkMiIgLUwgMQpkb25lIAo=
--------------060408000302010500090303--
