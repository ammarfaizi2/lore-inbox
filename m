Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVAWHiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVAWHiG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 02:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVAWHiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 02:38:04 -0500
Received: from mail.joq.us ([67.65.12.105]:5046 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261241AbVAWHhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 02:37:25 -0500
To: Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	<87wtu6fho8.fsf@sulphur.joq.us>
From: "Jack O'Quin" <joq@io.com>
Date: Sun, 23 Jan 2005 01:38:48 -0600
In-Reply-To: <87wtu6fho8.fsf@sulphur.joq.us> (Jack O'Quin's message of "Fri,
 21 Jan 2005 18:09:43 -0600")
Message-ID: <87y8ekvblj.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin <joq@io.com> writes:
>
> I ran three sets of tests with three or more 5 minute runs for each
> case.  The results (log files and graphs) are in these directories...
>
>   1) sched-fifo -- as a baseline
>      http://www.joq.us/jack/benchmarks/sched-fifo
>
>   2) sched-iso -- Con's scheduler, no privileges
>      http://www.joq.us/jack/benchmarks/sched-iso
>
>   3) nice-20 -- Ingo's "nice --20" scheduler hack
>      http://www.joq.us/jack/benchmarks/nice-20

> I had some problems with the y2 graph axis (for XRUN and DELAY).  In
> most of the graphs it is unreadable.  In some it is inconsistent.  I
> hacked on the jack_test3_plot.sh script several times, trying to set
> readable values, mostly without success.  There is too much variation
> in those numbers.  So, be careful reading and comparing that
> information.  Some xruns look better or worse than they really are.

I fixed that problem in the script this way...

--- jack_test3_plot.sh~	Fri Jan 21 15:23:04 2005
+++ jack_test3_plot.sh	Sat Jan 22 21:21:58 2005
@@ -33,8 +33,8 @@
     set ylabel "CPU Load (%), CTX (x1000/sec)"
     set y2label "XRUN, DELAY (msecs)"
     set yrange [0:100]
-    set y2range [0:*]
-    set y2tics 0.2
+    set y2range [0:10]
+    set y2tics 2.0
     set terminal png transparent small size 640,320
     set output "${NAME}.png"
     plot \

Now it gives a consistent, readable range for the XRUN and DELAY data.
Anything over 10msec is "off the graph".  Successive graphs are easy
to compare visually.

I went back and regenerated yesterday's graphs from the original log
files with this change, so they're all consistent now for comparison
purposes.

> These tests were run without any other heavy demands on the system.  I
> want to try some with a compile running in the background.  But, I
> won't have time for that until tomorrow at the earliest.  So, I'll
> post these preliminary results now for your enjoyment.

I made more runs today with a compile of ardour running continuously
in the background.  These results were much more dramatic than
yesterday's lightly loaded system numbers.

My main conclusion is that on my system sched-fifo works almost
flawlessly, while neither nice-20 nor sched-iso hold up under load.

All the data are here...

  http://www.joq.us/jack/benchmarks/

in these six subdirectories...

  http://www.joq.us/jack/benchmarks/nice-20		   
  http://www.joq.us/jack/benchmarks/nice-20+compile	   
  http://www.joq.us/jack/benchmarks/sched-fifo	   
  http://www.joq.us/jack/benchmarks/sched-fifo+compile 
  http://www.joq.us/jack/benchmarks/sched-iso	   
  http://www.joq.us/jack/benchmarks/sched-iso+compile  

In many runs with both nice-20 and sched-iso, some of the test clients
failed to meet their deadlines and were evicted from the JACK graph.
This was particularly evident under load (see the nice-20+compile and
sched-iso+compile logs).  But, looking back at the logs from
yesterday, I see it also happened without the background compilation.
I didn't notice, because the effects were less obvious.  But, this may
explain the rather inconsistent results I noted at the time.

This run[1] shows a particularly dramatic example of this phenomenon.
Note the DSP load dropoff around second 140.  After that everything
runs fine because almost half of the clients were ejected.

  [1] http://www.joq.us/jack/benchmarks/nice-20+compile/jack_test3-2.6.11-rc1-q2-200501221908.png

There were *no* client failures in *any* of the sched-fifo runs.

So, I reluctantly conclude that neither of the new scheduler
prototypes performs adequately in its current form.  We should get
someone else to duplicate these results on a different machine, if
possible.

I'm wondering now if the lack of priority support in the two
prototypes might explain the problems I'm seeing.
-- 
  joq
