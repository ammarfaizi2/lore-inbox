Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268149AbSIRU3k>; Wed, 18 Sep 2002 16:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268261AbSIRU3j>; Wed, 18 Sep 2002 16:29:39 -0400
Received: from holomorphy.com ([66.224.33.161]:28140 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268149AbSIRU3i>;
	Wed, 18 Sep 2002 16:29:38 -0400
Date: Wed, 18 Sep 2002 13:29:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918202914.GA3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andries Brouwer <aebr@win.tue.nl>, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20020918182818.GA14629@win.tue.nl> <Pine.LNX.4.44.0209182038400.26337-100000@localhost.localdomain> <20020918201134.GC14629@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020918201134.GC14629@win.tue.nl>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 09:00:37PM +0200, Ingo Molnar wrote:
>> If you think you can outrun this O(N^2) algorithm

On Wed, Sep 18, 2002 at 10:11:34PM +0200, Andries Brouwer wrote:
> Last month or so I already showed how to make it O(N log N).
> (Also without any new data structures.)
> But there is no hurry. The constant in your O(N^2) is very
> small, since in reality it is better than O(N^2 / pid_max).
> Really, now that pid_max is large, there is no problem with get_pid.

I've seen no change in behavior with large PID_MAX. Your argument based
on sparse spaces is not empirically demonstrable. What is empirically
demonstrable are my NMI oopses, the bug reports I've had sitting around
since before 2.5 opened that are still an issue, and Ingo's actual timings.


On Wed, Sep 18, 2002 at 10:11:34PM +0200, Andries Brouwer wrote:
> Much more interesting is thinking about for_each_task.
> In a number of places we search for all tasks with a certain property.
> It would be nice to arrange things in such a way that these
> are found in some efficient way so that not the entire task list
> is searched.

Um, the original name of this patch was -for_each_task, and that's
precisely what it was intended to do. Check the file creation times
(and filenames) of the patches in

ftp://ftp.kernel.org/pub/linux/kernel/people/wli/task_mgmt/

It furthermore had the more general intent of removing exhaustive
searches not using the for_each_task() macro, of which the hotly
debated get_pid() was an instance.

I never did quite finish it, which is why Ingo had to step in and give
it a big push.


On Wed, Sep 18, 2002 at 10:11:34PM +0200, Andries Brouwer wrote:
> For ordinary Unix semantics we need to be able to find all tasks
> with a given p->pgrp or p->session or p->pid or p->uid or p->tty.
> Some kernel routines come with a given pointer tsk and want p == tsk.
> Some places need p->mm or p->mm->context or CTX_HWBITS(p->mm->context)

It doesn't sound like you read the patch at all.


On Wed, Sep 18, 2002 at 10:11:34PM +0200, Andries Brouwer wrote:
> In procfs we have a very quadratic algorithm in proc_pid_readdir()/
> get_pid_list(). Not a potential hiccup after 2^30 processes that some
> may want to smoothe, but every single "ls /proc" or "ps".
> What shall we do with /proc for all these people with 10^5 processes?
> Andries

That is actually one of the easiest ways to take out one of my machines
while it's running 10K or so tasks, mentioned a bit ago in this thread.
It also renders performance monitoring of benchmarks, customer
workloads, etc. very difficult.


Bill
