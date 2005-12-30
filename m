Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVL3Nxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVL3Nxq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 08:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVL3Nxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 08:53:46 -0500
Received: from 213-140-2-72.ip.fastwebnet.it ([213.140.2.72]:2508 "EHLO
	aa005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932091AbVL3Nxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 08:53:45 -0500
Date: Fri, 30 Dec 2005 14:52:21 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: [SCHED] wrong priority calc - SIMPLE test case
Message-ID: <20051230145221.301faa40@localhost>
In-Reply-To: <200512281027.00252.kernel@kolivas.org>
References: <20051227190918.65c2abac@localhost>
	<20051227224846.6edcff88@localhost>
	<200512281027.00252.kernel@kolivas.org>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WAS: [SCHED] Totally WRONG prority calculation with specific test-case
(since 2.6.10-bk12)
http://lkml.org/lkml/2005/12/27/114/index.html

On Wed, 28 Dec 2005 10:26:58 +1100
Con Kolivas <kernel@kolivas.org> wrote:

> The issue is that the scheduler interactivity estimator is a state machine and 
> can be fooled to some degree, and a cpu intensive task that just happens to 
> sleep a little bit gets significantly better priority than one that is fully 
> cpu bound all the time. Reverting that change is not a solution because it 
> can still be fooled by the same process sleeping lots for a few seconds or so 
> at startup and then changing to the cpu mostly-sleeping slightly behaviour. 
> This "fluctuating" behaviour is in my opinion worse which is why I removed 
> it.

Trying to find a "as simple as possible" test case for this problem
(that I consider a BUG in priority calculation) I've come up with this
very simple program:

------ sched_fooler.c -------------------------------
#include <stdlib.h>
#include <unistd.h>

static void burn_cpu(unsigned int x)
{
	static char buf[1024];
	int i;
	
	for (i=0; i < x; ++i)
		buf[i%sizeof(buf)] = (x-i)*3;
}

int main(int argc, char **argv)
{
	unsigned long burn;
	if (argc != 2)
		return 1;
	burn = (unsigned long)atoi(argv[1]);
	while(1) {
		burn_cpu(burn*1000);
		usleep(1);
	}
	return 0;
}
----------------------------------------------

paolo@tux ~/tmp/sched_fooler $ gcc sched_fooler.c
paolo@tux ~/tmp/sched_fooler $ ./a.out 5000

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5633 paolo     15   0  2392  320  252 S 77.7  0.1   0:18.84 a.out
 5225 root      15   0  169m  19m 2956 S  2.0  3.9   0:13.17 X
 5307 paolo     15   0  100m  22m  13m S  2.0  4.4   0:04.32 kicker


paolo@tux ~/tmp/sched_fooler $ ./a.out 10000

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5637 paolo     16   0  2396  320  252 R 87.4  0.1   0:13.38 a.out
 5312 paolo     16   0 86636  22m  15m R  0.1  4.5   0:02.02 konsole
    1 root      16   0  2552  560  468 S  0.0  0.1   0:00.71 init


If I only run 2 of these together the system becomes everything but
interactive ;)

./a.out 10000 & ./a.out 4000

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5714 paolo     15   0  2392  320  252 S 59.2  0.1   0:12.28 a.out
 5713 paolo     16   0  2396  320  252 S 37.1  0.1   0:07.63 a.out


DD TEST: the usual DD test (to read 128 MB from a non-cached file =
disk bounded) says everything, numbers with 2.6.15-rc7:

paolo@tux /mnt $ mount space/; time dd if=space/bigfile of=/dev/null bs=1M count=128; umount space/
128+0 records in
128+0 records out

real    0m4.052s
user    0m0.004s
sys     0m0.180s

START 2 OF THEM "./a.out 10000 & ./a.out 4000"

paolo@tux /mnt $ mount space/; time dd if=space/bigfile of=/dev/null bs=1M count=128; umount space/
128+0 records in
128+0 records out

real    2m4.578s
user    0m0.000s
sys     0m0.244s


This does't surprise me anymore, since DD gets priority 18 and these
two CPU eaters get 15/16.

As usual "nicksched" is NOT affected at all, IOW it gives to these CPU
eaters the priority that they deserve.

-- 
	Paolo Ornati
	Linux 2.6.15-rc7-g3603bc8d on x86_64
