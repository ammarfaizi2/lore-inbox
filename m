Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751740AbWBWQuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbWBWQuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbWBWQuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:50:24 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48535 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751740AbWBWQuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:50:22 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:49:07 -0700
In-Reply-To: <m1k6bmhxze.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Thu, 23 Feb 2006 08:54:29 -0700")
Message-ID: <m1mzgidnr0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Holding a reference to a task_struct pins about 10K of low memory even
> after that task has exited.  Which seems to be at 1 or 2 orders of
> mangnitude more memory than any other data structure in the kernel.
> Not holding a reference to a task_struct and you risk problems with
> pid wrap around.
>
> Even worse because we allow session and process group leaders to exit
> there is no task_struct you can hold onto to prevent pid wrap around
> problems for those kinds of structures.
>
> The task_ref is an small intermediate data structure that other
> structures can point, that solves these problems.  A task_ref will
> always point at the first user of a pid value or contain a NULL
> pointer if there are no longer any users of that pid.

I forgot to note that there is a correctness dependence on an my
kill switch_exec_pids patch.  Without that task_refs will
stop being able to track a pid when we pass it on to
a new process in de_thread.

I built this patchset against Linus latest kernel and not -mm so I think
I may have one or two trivial conflicts with Olegs changes as
well.  In particular I have some changes to unhash_process() that Oleg
has removed, but simply removing that hunch should be all the resolution
that is needed.  Hopefully that won't be a problem..

Eric
