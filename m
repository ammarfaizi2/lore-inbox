Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUGMWX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUGMWX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267182AbUGMWX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:23:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:12688 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267170AbUGMWW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:22:59 -0400
Date: Tue, 13 Jul 2004 15:25:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: paul@linuxaudiosystems.com, rlrevell@joe-job.com,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040713152532.6df4a163.akpm@osdl.org>
In-Reply-To: <20040713220103.GJ974@dualathlon.random>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	<200407130001.i6D01pkJ003489@localhost.localdomain>
	<20040712170844.6bd01712.akpm@osdl.org>
	<20040713162539.GD974@dualathlon.random>
	<20040713114829.705b9607.akpm@osdl.org>
	<20040713213847.GH974@dualathlon.random>
	<20040713145424.1217b67f.akpm@osdl.org>
	<20040713220103.GJ974@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> > Sleeping with local interrupts disabled is usually a bug, so we should
> > prefer to keep that check in might_sleep().
> 
> either it's _always_ a bug including for entry.S or sched_yield, or it's
> _never_ a bug. I don't understand the "usually".

If some code does:


	local_irq_disable();
	<fiddle with per-cpu stuff>
	kmalloc(GFP_KERNEL);
	<fiddle with per-cpu stuff>
	local_irq_enable();

or

	local_irq_disable();
	<fiddle with per-cpu stuff>
	function_which_calls_cond_resched();
	<fiddle with per-cpu stuff>
	local_irq_enable();

then we want might_sleep() to warn about the bug.

The fact that a couple of scheduler-internal fastpaths happen to know that
they can call schedule() with interrupts disabled is not relevant to this.
