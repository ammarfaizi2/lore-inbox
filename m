Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267890AbSIRUGe>; Wed, 18 Sep 2002 16:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267995AbSIRUGe>; Wed, 18 Sep 2002 16:06:34 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:37614 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S267890AbSIRUGd>;
	Wed, 18 Sep 2002 16:06:33 -0400
Date: Wed, 18 Sep 2002 22:11:34 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918201134.GC14629@win.tue.nl>
References: <20020918182818.GA14629@win.tue.nl> <Pine.LNX.4.44.0209182038400.26337-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209182038400.26337-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 09:00:37PM +0200, Ingo Molnar wrote:

> If you think you can outrun this O(N^2) algorithm

Last month or so I already showed how to make it O(N log N).
(Also without any new data structures.)
But there is no hurry. The constant in your O(N^2) is very
small, since in reality it is better than O(N^2 / pid_max).

Really, now that pid_max is large, there is no problem with get_pid.

Much more interesting is thinking about for_each_task.

In a number of places we search for all tasks with a certain property.
It would be nice to arrange things in such a way that these
are found in some efficient way so that not the entire task list
is searched.

For ordinary Unix semantics we need to be able to find all tasks
with a given p->pgrp or p->session or p->pid or p->uid or p->tty.
Some kernel routines come with a given pointer tsk and want p == tsk.
Some places need p->mm or p->mm->context or CTX_HWBITS(p->mm->context)

In procfs we have a very quadratic algorithm in proc_pid_readdir()/
get_pid_list(). Not a potential hiccup after 2^30 processes that some
may want to smoothe, but every single "ls /proc" or "ps".
What shall we do with /proc for all these people with 10^5 processes?

Andries




