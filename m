Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUBSHrV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 02:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266395AbUBSHrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 02:47:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22707 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266555AbUBSHqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 02:46:13 -0500
Date: Thu, 19 Feb 2004 02:46:08 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: keventd_create_kthread 
In-Reply-To: <20040218231322.35EE92C05F@lists.samba.org>
Message-ID: <Pine.LNX.4.58.0402190205040.16515@devserv.devel.redhat.com>
References: <20040218231322.35EE92C05F@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Feb 2004, Rusty Russell wrote:

> That's not enough: it can set that and then get preemted.  It really
> want to return when the task is off the runqueue.  The original
> wait_task_inactive() does an incredible complicated and AFAICT useless
> dance wrt not locking and disabling preempt explicitly.  Ingo, how's
> this replacement?  (And who wrote this code?)

this is old code that morphed many times. Its main use was for exit.c's
purpose and in heavy clone/exit workloads it made quite a difference
whether the 'polling' for task exit was done under the runqueue lock or
not - hence the complexity. Task freeing is poll-free in 2.6 so
wait_task_inactive() doesnt get nearly as heavy use.

The current wait_task_inactive() code seems to be OK on x86.
Context-switching cannot be preempted. The goal of wait_task_inactive() is
to wait for the task to unschedule on a CPU. If that's due to preempt then
it's due to preempt.

i'd strongly advise against using wait_task_inactive() in
keventd_create_kthread() - it's _polling_. We must not do any polling like
that in any modern interface. Why does keventd_create_kthread() need
wait_task_inactive()?

	Ingo
