Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbSJBRuL>; Wed, 2 Oct 2002 13:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbSJBRuL>; Wed, 2 Oct 2002 13:50:11 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:61094 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261600AbSJBRuK> convert rfc822-to-8bit; Wed, 2 Oct 2002 13:50:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [RFC] Simple NUMA scheduler patch
Date: Wed, 2 Oct 2002 19:54:39 +0200
User-Agent: KMail/1.4.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209050905180.8086-100000@localhost.localdomain> <1033516540.1209.144.camel@dyn9-47-17-164.beaverton.ibm.com>
In-Reply-To: <1033516540.1209.144.camel@dyn9-47-17-164.beaverton.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210021954.39358.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Wednesday 02 October 2002 01:55, Michael Hohnbaum wrote:
> Attached is a patch which provides a rudimentary NUMA scheduler.
> This patch basically does two things:
>
> * at exec() it finds the least loaded CPU to assign a task to;
> * at load_balance() (find_busiest_queue() actually) it favors
>   cpus on the same node for taking tasks from.

it's a start. But I'm afraid a full solution will need much more code
(which is one of the problems with my NUMA scheduler patch).

The ideas behind your patch are:
1. Do initial load balancing, choose the least loaded CPU at the
beginning of exec().
2. Favor own node for stealing if any CPU on the own node is >25%
more loaded. Otherwise steal from another CPU if that one is >100%
more loaded.

1. is fine but should ideally aim for equal load among nodes. In
the current form I believe that the original load balancer does the
job right after fork() (which must have happened before exec()). As
you changed the original load balancer, you really need this initial
balancing.

2. is ok as it makes it harder to change the node. But again, you don't
aim at equally balanced nodes. And: if the task gets away from the node
on which it got its memory, it has no reason to ever come back to it.

For a final solution I believe that we will need targets like:
(a) equally balance nodes
(b) return tasks to the nodes where their memory is
(c) make nodes "sticky" for tasks which have their memory on them,
"repulsive" for other tasks.
But for a first attempt to get the scheduler more NUMA aware all this
might be just too much.

With simple benchmarks you will most probably beat the plain O(1)
scheduler on NUMA if you implement (a) in just 1. and 2. as your node
is already somewhat "sticky". In complicated benchmarks (like a kernel
compile ;-) it could already be too difficult to understand when the
load balancer did what and why...

It would be nice to see some numbers.

Best regards,
Erich

