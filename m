Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbULNTHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbULNTHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 14:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbULNTHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 14:07:44 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:52969 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261603AbULNTHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 14:07:40 -0500
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] cpu-timers: high-resolution CPU clocks for POSIX clock_* syscalls
References: <200412140355.iBE3t7KL008040@magilla.sf.frob.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 14 Dec 2004 20:07:39 +0100
In-Reply-To: <200412140355.iBE3t7KL008040@magilla.sf.frob.com.suse.lists.linux.kernel>
Message-ID: <p73zn0gzojo.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> writes:
>  
>  /*
> + * This is called on clock ticks and on context switches.
> + * Bank in p->sched_time the ns elapsed since the last tick or switch.
> + */
> +static void update_cpu_clock(task_t *p, runqueue_t *rq,
> +			     unsigned long long now)
> +{
> +	unsigned long long last = max(p->timestamp, rq->timestamp_last_tick);
> +	p->sched_time += now - last;
> +}

This will completely mess up the register allocation in schedule()
long long on i386 forces basically everything else out onto the stack
because it needs 4 aligned registers.

I suspect when you benchmark it it will become visibly slower.

In general it seems like a bad idea to polute the extremly critical
fast paths in schedule with support for such an obscure operation.
Is there really any real need for such a high resolution per process
timer anyways? I have my doubts about it, I would suspect most apps
are more interested in wall clock time.

I don't think this should be merged until a clear need from a useful
application is demonstrated for it.

-Andi

