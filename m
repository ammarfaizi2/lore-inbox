Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVEILrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVEILrf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 07:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVEILrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 07:47:35 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:42409 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261267AbVEILrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 07:47:20 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [ck] Re: [PATCH] implement nice support across physical cpus on SMP
Date: Mon, 9 May 2005 21:47:05 +1000
User-Agent: KMail/1.8
Cc: Markus =?iso-8859-1?q?T=F6rnqvist?= <mjt@nysv.org>,
       linux-kernel@vger.kernel.org, AndrewMorton <akpm@osdl.org>,
       Carlos Carvalho <carlos@fisica.ufpr.br>
References: <20050509112446.GZ1399@nysv.org>
In-Reply-To: <20050509112446.GZ1399@nysv.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_620fCH2PJk0sKdZ"
Message-Id: <200505092147.06384.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_620fCH2PJk0sKdZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, 9 May 2005 21:24, Markus T=F6rnqvist wrote:
> I beg to differ with Mr. Carvalho's assesment with this patch;
> it works like a charm, and then some.
>
> The rest of the message is just my analysis of the situation
> ran on a Dell PowerEdge 2850, dual hyperthread Xeon EM64Ts, with
> Debian Pure64 Sarge installed.

Thanks for feedback.

>   PID USER      PR  NI  VIRT  SHR S %CPU %MEM    TIME+  #C COMMAND
>  3917 mjt       26   0  5660  936 R 99.9  0.0   3:37.61  0 load_base.sh
>  3918 mjt       25   0  5660  936 R 99.9  0.0   3:37.60  3 load_base.sh
>  3916 mjt       26   0  5660  936 R 52.7  0.0   2:02.37  2 load_base.sh
>  3919 mjt       39  19  5660  936 R  7.0  0.0   0:13.80  1 load_base.sh
>  3920 mjt       39  19  5660  936 R  3.0  0.0   0:06.05  2 load_base.sh
>
> top - 11:09:24 up 15:30,  2 users,  load average: 4.99, 3.55, 1.63
>   PID USER      PR  NI  VIRT  SHR S %CPU %MEM    TIME+  #C COMMAND
>  3917 mjt       25   0  5660  936 R 99.6  0.0   6:11.35  0 load_base.sh
>  3918 mjt       24   0  5660  936 R 99.6  0.0   6:11.34  3 load_base.sh
>  3916 mjt       39   0  5660  936 R 65.7  0.0   3:28.95  2 load_base.sh
>  3919 mjt       39  19  5660  936 R  7.0  0.0   0:23.54  1 load_base.sh
>  3920 mjt       39  19  5660  936 R  3.0  0.0   0:10.33  2 load_base.sh

These runs don't look absolutely "ideal" as one nice 19 task is bound to cp=
u1=20
however since you're running hyperthreading it would seem the SMT nice code=
=20
is keeping that under check anyway (0:23 vs 6:11)

> top - 11:12:32 up 15:33,  2 users,  load average: 4.99, 4.22, 2.24
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND
>  3917 mjt       35   0  5660 1136  936 R 99.9  0.0   9:28.56  0
> load_base.sh 3918 mjt       34   0  5660 1136  936 R 99.5  0.0   9:28.54 =
 3
> load_base.sh 3916 mjt       35   0  5660 1136  936 R 61.7  0.0   5:19.77 =
 2
> load_base.sh 3919 mjt       39  19  5660 1136  936 R  6.0  0.0   0:36.07 =
 1
> load_base.sh 3920 mjt       39  19  5660 1136  936 R  3.0  0.0   0:15.82 =
 2
> load_base.sh
>
> $ ./load.sh 7
> top - 11:13:49 up 15:35,  2 users,  load average: 5.17, 4.40, 2.45
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND
>  3952 mjt       29   0  5660 1140  936 R 99.9  0.0   0:33.53  2
> load_base.sh 3950 mjt       31   0  5660 1140  936 R 99.5  0.0   0:33.33 =
 1
> load_base.sh 3953 mjt       30   0  5660 1140  936 R 55.7  0.0   0:16.82 =
 3
> load_base.sh 3951 mjt       39   0  5660 1140  936 R 43.8  0.0   0:16.70 =
 3
> load_base.sh 3949 mjt       39   0  5660 1140  936 R 23.9  0.0   0:13.18 =
 0
> load_base.sh 3954 mjt       39  19  5660 1140  936 R  2.0  0.0   0:00.64 =
 0
> load_base.sh 3955 mjt       39  19  5660 1140  936 R  2.0  0.0   0:00.64 =
 0
> load_base.sh
>
> top - 11:14:53 up 15:36,  2 users,  load average: 6.38, 4.91, 2.76
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND
>  3950 mjt       23   0  5660 1140  936 R 99.9  0.0   1:39.67  1
> load_base.sh 3952 mjt       21   0  5660 1140  936 R 99.9  0.0   1:39.87 =
 2
> load_base.sh 3951 mjt       39   0  5660 1140  936 R 52.7  0.0   0:49.91 =
 3
> load_base.sh 3953 mjt       22   0  5660 1140  936 R 47.8  0.0   0:49.95 =
 3
> load_base.sh 3949 mjt       39   0  5660 1140  936 R 43.8  0.0   0:38.70 =
 0
> load_base.sh 3954 mjt       39  19  5660 1140  936 R  2.0  0.0   0:01.90 =
 0
> load_base.sh 3955 mjt       39  19  5660 1140  936 R  2.0  0.0   0:01.90 =
 0

These runs pretty much confirm what I found to happen. My test machine for=
=20
this was also 4x. I can't see how the code would behave differently on 2x.=
=20
Perhaps if I make the prio_bias multiplied instead of added to the cpu load=
=20
it will be less affected by SCHED_LOAD_SCALE. The attached patch was=20
confirmed during testing to also provide smp distribution according to nice=
=20
on 4x. Carlos I know your machine is in production so you testing may not b=
e=20
easy for you. Please try this on top if you have time.

Cheers,
Con

=2D--
This patch alters the effect priority bias has on busy rebalancing by=20
multiplying the cpu load by the total priority instead of adding it.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

--Boundary-00=_620fCH2PJk0sKdZ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="alter_prio_bias.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="alter_prio_bias.diff"

Index: linux-2.6.11-smpnice/kernel/sched.c
===================================================================
--- linux-2.6.11-smpnice.orig/kernel/sched.c	2005-05-07 23:25:15.000000000 +1000
+++ linux-2.6.11-smpnice/kernel/sched.c	2005-05-09 21:42:02.000000000 +1000
@@ -953,8 +953,8 @@ static inline unsigned long source_load(
 		 * If we are balancing busy runqueues the load is biased by
 		 * priority to create 'nice' support across cpus.
 		 */
-		cpu_load += rq->prio_bias;
-		load_now += rq->prio_bias;
+		cpu_load *= rq->prio_bias;
+		load_now *= rq->prio_bias;
 	}
 	return min(cpu_load, load_now);
 }
@@ -969,8 +969,8 @@ static inline unsigned long target_load(
 		load_now = rq->nr_running * SCHED_LOAD_SCALE;
 
 	if (idle == NOT_IDLE) {
-		cpu_load += rq->prio_bias;
-		load_now += rq->prio_bias;
+		cpu_load *= rq->prio_bias;
+		load_now *= rq->prio_bias;
 	}
 	return max(cpu_load, load_now);
 }

--Boundary-00=_620fCH2PJk0sKdZ--
