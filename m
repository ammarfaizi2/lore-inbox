Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263837AbUDPVhO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUDPVgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:36:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:62365 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263829AbUDPVd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:33:29 -0400
Date: Fri, 16 Apr 2004 14:35:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: manfred@colorfullife.com, drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: message queue limits
Message-Id: <20040416143538.04b4cd13.akpm@osdl.org>
In-Reply-To: <20040416140613.GA2253@logos.cnet>
References: <407A2DAC.3080802@redhat.com>
	<20040415141846.GE2085@logos.cnet>
	<407EB08D.4010607@colorfullife.com>
	<20040416140613.GA2253@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> This should be working, but for some reason rlim[RLIMIT_MSGQUEUE].rlim_cur of
> all tasks is 0, remembering it sets init_tasks's value at ipc/mqueue.c's __init function:
> 
> 	init_task.rlim[RLIMIT_MSGQUEUE].rlim_cur = 64;
> 	init_task.rlim[RLIMIT_MSGQUEUE].rlim_max = 64;

init_task is the task_struct for process 0, "swapper".  But by the time we
run the initcalls, process 1 ("init") is up and running.

So by the time you execute these assignments, you're changing the limits on
a process which will never again create any children.

It's a bit hacky, but you could do

	BUG_ON(current->pid != 1);
	current->rlim[RLIMIT_MSGQUEUE].rlim_cur = 64;

but longer-term these initialisations should be moved into
include/asm-foo/reousrce.h:INIT_RLIMITS
