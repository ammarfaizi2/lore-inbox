Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262890AbVAFQMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbVAFQMT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVAFQMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:12:15 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:55988 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262890AbVAFQL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:11:57 -0500
Date: Thu, 6 Jan 2005 10:08:44 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE 0/4][RFC] Genetic Algorithm Library
Message-ID: <20050106100844.53a762a0@localhost>
Organization: LTC
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm pleased to announce a new in-kernel library to do kernel tuning
using a genetic algorithm.  

This library provides hooks for kernel components to take advantage of a
genetic algorithm.  There are patches to hook the different schedulers
included.

The basic flow of the genetic algorithm is as follows:

1.) Start w/ a broad list of initial tunable values (each set of
	tunables is called a child) 
2.) Let each child run for a timeslice. 
3.) Once the timeslice is up, calculate the fitness of the child (how
well performed).
4.) Run the next child in the list.
5.) Once all the children have run, compare the fitnesses of each child
	and throw away the bottom-half performers. 
6.) Create new children to take the place of the bottom-half performers
	using the tunables from the top-half performers.
7.) Mutate a set number of children to keep variance.
8.) Goto step 2.

Over time the tunables should converge toward the optimal settings for
that workload.  If the workload changes, the tunables should converge to
the new optimal settings (this is part of the reason for mutation). 
This algorithm is used extensively in AI.

Using these patches, there are small gains (1-3%) in Unixbench &
SpecJBB.  I am hoping a scheduler guru will able to rework them to give
higher gains.

The main area that could use reworking is the fitness calculation.  The
problem is that the kernel is looking more at the micro of what's going
on, instead of the macro.  I am thinking of moving the fitness
calculation to outside the kernel.

However, I would advocate keeping the number of layers needed to communicate
between the genetic library and the hooked component down in order to
keep it as lightweight as possible.

The patches are based on 2.6.9 and still a little rough, but here is the
descriptions:

[1/4 genetic-lib]: This is the base patch for the genetic algorithm. 
	It's based against 2.6.9.

[2/4 genetic-io-sched]: The base patch for the IO schedulers to use the
	genetic library.

[3/4 genetic-as-sched]: A genetic-lib hooked anticipatory IO scheduler.

[4/4 genetic-zaphod-cpu-sched]: A hooked zaphod CPU scheduler.  Depends
	on the zaphod-v6 patch.

Please send comments,
Jake Moilanen
