Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUEYHD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUEYHD0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 03:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUEYHD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 03:03:26 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:53214 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S264791AbUEYHDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 03:03:04 -0400
Date: Tue, 25 May 2004 09:03:02 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: lm240504@comcast.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Invisible threads in 2.6
Message-Id: <20040525090302.66ac23bf@phoebee>
In-Reply-To: <052520040221.14460.40B2AD9F00067A620000387C2200735834CBCFCACFCBCD0304@comcast.net>
References: <052520040221.14460.40B2AD9F00067A620000387C2200735834CBCFCACFCBCD0304@comcast.net>
X-Mailer: Sylpheed version 0.9.10claws62 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.2 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004 02:21:19 +0000
lm240504@comcast.net bubbled:

> I've been experimenting with process/thread accounting in 2.6.x,
> and found this strange situation: if the leader thread of a multi-threaded
> process terminates, the other threads become undetectable.  After the
> main thread becomes a zombie, /proc/<tgid>/task returns ENOENT on
> open.  If you happen to know the TID, you can access /proc/<tid>/* directly,
> but otherwise, there is no way to observe the remaining threads, as far as
> I can see.  Consider this program, for example:
> 
> #include <pthread.h>
> 
> void *run(void *arg)
> {
>         for(;;);
> }
> 
> int main()
> {
>         pthread_t t;
>         int i;
>         for (i = 0; i < 10; ++i)
>                 pthread_create(&t, NULL, run, NULL);
>         pthread_exit(NULL);
> }
> 
> When I run it, the system (predictably) goes to ~100% CPU utilization,
> but there seems to be no way to find out who is hogging the CPU with
> top(1), ps(1), or anything else.  All they can show is the main thread in
> zombie state, consuming 0% CPU.
> 
> I'm not sure how to fix this (the pid_alive() test seems to be there for a
> reason), but it doesn't seem right.  Any thoughts?

my kernel:
# cat /proc/version 
Linux version 2.6.6-rc3-mm2 (root@phoebee) (gcc version 3.3.2 20031218 (Gentoo
Linux 3.3.2-r5, propolice-3.3-7)) #6 Fri May 7 10:56:06 CEST 2004

I just compiled your example and ran it:
# ./thread_test 

# ps axw
...
12069 pts/175  S+     0:00 ./thread_test
12070 pts/175  S+     0:00 ./thread_test
12071 pts/175  R+     0:06 ./thread_test
12072 pts/175  R+     0:06 ./thread_test
12073 pts/175  R+     0:06 ./thread_test
12074 pts/175  R+     0:06 ./thread_test
12075 pts/175  R+     0:06 ./thread_test
12076 pts/175  R+     0:06 ./thread_test
12077 pts/175  R+     0:06 ./thread_test
12078 pts/175  R+     0:06 ./thread_test
12079 pts/175  R+     0:06 ./thread_test
12080 pts/175  R+     0:06 ./thread_test
...

# top
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND           
12072 root      25   0 83736  420 1380 R 12.1  0.1   0:16.94 thread_test       
12075 root      25   0 83736  420 1380 R 12.1  0.1   0:16.93 thread_test       
12073 root      25   0 83736  420 1380 R 11.0  0.1   0:16.92 thread_test       
12074 root      25   0 83736  420 1380 R 11.0  0.1   0:16.92 thread_test       
12076 root      25   0 83736  420 1380 R 11.0  0.1   0:16.82 thread_test       
12077 root      25   0 83736  420 1380 R 11.0  0.1   0:16.87 thread_test       
12078 root      25   0 83736  420 1380 R 11.0  0.1   0:16.84 thread_test       
12071 root      25   0 83736  420 1380 R  9.9  0.1   0:16.95 thread_test       
12079 root      25   0 83736  420 1380 R  7.7  0.1   0:16.80 thread_test       
...

On my -mm patched kernel I can see them.

Regards,
Martin
-- 
MyExcuse:
piezo-electric interference

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>
