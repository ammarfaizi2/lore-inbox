Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWAALjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWAALjc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 06:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWAALjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 06:39:32 -0500
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]:53172 "EHLO
	aa003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751323AbWAALjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 06:39:31 -0500
Date: Sun, 1 Jan 2006 12:39:02 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Mike Galbraith <efault@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Message-ID: <20060101123902.27a10798@localhost>
In-Reply-To: <5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
References: <5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
	<200512281027.00252.kernel@kolivas.org>
	<20051227190918.65c2abac@localhost>
	<20051227224846.6edcff88@localhost>
	<200512281027.00252.kernel@kolivas.org>
	<5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
	<5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2005 17:37:11 +0100
Mike Galbraith <efault@gmx.de> wrote:

> Strange.  Using the exact same arguments, I do see some odd bouncing up to 
> high priorities, but they spend the vast majority of their time down at 25.

Mmmm... to make it more easly reproducible I've enlarged the sleep time
(1 microsecond is likely to be rounded too much and give different
results on different hardware/kernel/config...).

Compile this _without_ optimizations and try again:

------------------------------------------------
#include <stdlib.h>
#include <unistd.h>

char buf[1024];

static void burn_cpu(unsigned int x)
{
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
	if (!burn)
		return;
	while(1) {
		burn_cpu(burn*1000);
		usleep(10000);
	}
	return 0;
}
-----------------------------------------


With "./a.out 3000" (and 2.6.15-rc7-rt1) I get this:

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5485 paolo     15   0  2396  320  252 R 62.7  0.1   0:09.77 a.out


Try different values: 1000, 2000, 3000 ... are you able to reproduce it
now?


If yes, try to start 2 of them with something like this:

"./a.out 3000 & ./a.out 3161"

so they are NOT syncronized and they use almost all the CPU time:

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5582 paolo     16   0  2396  320  252 S 45.7  0.1   0:05.52 a.out
 5583 paolo     15   0  2392  320  252 S 45.7  0.1   0:05.49 a.out

This is the bad situation I hate: some cpu-eaters that eat all the CPU
time BUT have a really good priority only because they sleeps a bit.

-- 
	Paolo Ornati
	Linux 2.6.15-rc7-rt1 on x86_64
