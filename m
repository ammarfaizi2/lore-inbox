Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbUKWCV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbUKWCV3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUKWCTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:19:30 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:63384 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S261226AbUKWCOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:14:38 -0500
Message-ID: <41A2AB86.E4324753@akamai.com>
Date: Mon, 22 Nov 2004 19:16:22 -0800
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace: locked accesss to ptrace last_siginfo
References: <200411200309.TAA20975@allur.sanmateo.akamai.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pmeda@akamai.com wrote:

> ptrace_setsiginfo/ptrace_getsiginfo need to do locked access
> to last_siginfo.  ptrace_notify()/ptrace_stop() sets the
> current->last_siginfo and sleeps on schedule(). It can be waked
> up by kill signal from signal_wake_up before debugger wakes it up.
> On return from schedule(), the current->last_siginfo is reset.

Roland's  TASK_TRACED state fixes invalidates this claim.  Too
early to report.  SIGKILLs are queued, and process is not wakedup.

example:
29015: ptrace PTRACE_TRACEME returned:0
State of tracee as seen by tracer:
State:  T (tracing stop)
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
Tracer:29014 ptrace(first PTRACE_CONT, 29015) returns 0
Tracer:29014 ptrace(second PTRACE_CONT, 29015) returns -1
ptrace PTRACE_CONT: No such process
Tracer:29014 got notifcation from tracee:29015, i.e. child:29015
Tracer:29014 ptrace(third PTRACE_CONT, 29015) returns 0
Tracer:29014 got notifcation from tracee:29015, i.e. child:29015

State of tracee before killing as seen by middleman:
State:  T (tracing stop)
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
29019: kill(29015, SIGCONT) returns 0
State of tracee after killing as seen by middleman:
State:  T (tracing stop)
SigPnd: 0000000000000000
ShdPnd: 0000000000020000
29019: kill(29015, SIGKILL) returns 0
State of tracee after killing as seen by middleman:
State:  T (tracing stop)
SigPnd: 0000000000000000
ShdPnd: 0000000000020100

29019: kill(29015, probe) returns 0
wait for 29019 ...returns 29019


Thanks,
Prasanna.

