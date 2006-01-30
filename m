Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWA3Wo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWA3Wo2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 17:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWA3Wo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 17:44:28 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34952 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030202AbWA3Wo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 17:44:27 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@sw.ru>, Jeff Dike <jdike@addtoit.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/3] pidhash: don't use zero pids
References: <43DDF323.4517C349@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 30 Jan 2006 15:43:04 -0700
In-Reply-To: <43DDF323.4517C349@tv-sign.ru> (Oleg Nesterov's message of
 "Mon, 30 Jan 2006 14:06:11 +0300")
Message-ID: <m1u0bl49s7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> daemonize() calls set_special_pids(1,1), while init and
> kernel threads spawned from init/main.c:init() run with
> 0,0 special pids. This patch changes INIT_SIGNALS() so
> that that they run with ->pgrp == ->session == 1 also.
>
> This patch relies on fact that swapper's pid == 1.

Looking more closely this appears to be a bug fix plain
and simple, and as the bug has existed for so long without
out anyone noticing it should not be a problem to fix it.

/sbin/init has been calling setsid() forever to ensure
it has a session and a process group of 1.  daemonize
using these ids and then being called before /sbin/init
called setsid, caused setsid to fail as the process group
already existed.

The only symptom I have noticed is that job control does
not work in 2.6 when you specify init=/bin/bash.   And I didn't
realized until I looked back at some older kernels that setsid
would have worked and they would not have had this problem.

If there ever was a reason we wanted to have processes that were
not part of process groups and sessions that reasons seems
lost in the mists of time and we can just forget about it.

/sbin/init does not test the return value of setsid() so
we should have no problems whatsoever.

Acked-by: Eric W. Biederman <ebiederm@xmission.com>

> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
>
> --- RC-1/include/linux/init_task.h~ZEROPID 2005-11-22 19:35:52.000000000 +0300
> +++ RC-1/include/linux/init_task.h	2006-01-30 15:12:46.000000000 +0300
> @@ -62,6 +62,8 @@
>  	.posix_timers	 = LIST_HEAD_INIT(sig.posix_timers),		\
>  	.cpu_timers	= INIT_CPU_TIMERS(sig.cpu_timers),		\
>  	.rlim		= INIT_RLIMITS,					\
> +	.pgrp		= 1,						\
> +	.session	= 1,						\
>  }
>  
>  #define INIT_SIGHAND(sighand) { \
