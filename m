Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267066AbUBSIQq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 03:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267064AbUBSIQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 03:16:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11970 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267052AbUBSIQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 03:16:39 -0500
Date: Thu, 19 Feb 2004 03:16:33 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: keventd_create_kthread
In-Reply-To: <20040219001011.6245f163.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0402190310550.10411@devserv.devel.redhat.com>
References: <20040218231322.35EE92C05F@lists.samba.org>
 <Pine.LNX.4.58.0402190205040.16515@devserv.devel.redhat.com>
 <20040219001011.6245f163.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Feb 2004, Andrew Morton wrote:

> >  i'd strongly advise against using wait_task_inactive() in
> >  keventd_create_kthread() - it's _polling_. We must not do any polling like
> >  that in any modern interface. Why does keventd_create_kthread() need
> >  wait_task_inactive()?
> 
> The way it's designed, we _have_ to wait until the new kthread has gone
> to sleep, because we poke him again with wake_up_process().
> 
> However, if that wake_up_process() comes too early we'll just flip the
> new thread out of TASK_INTERUPTIBLE into TASK_RUNNING and the schedule()
> in kthread() will fall straight through.  So perhaps we can simply
> remove the wait_task_inactive()?

yep. There's almost never any good reason to use wait_task_inactive().

The only excusable special case is ptrace: there are some inherent
assumptions in the ptrace framework that need the task to unschedule at
least once before the parent can modify the user state. (eg. on x86 the
lazy FPU state and the fs/gs selectors need to be saved before the parent
can read/write them, plus changed debug registers need a real
context-switch to take effect, etc.)

	Ingo
