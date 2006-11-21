Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031200AbWKURDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031200AbWKURDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 12:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031226AbWKURDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 12:03:22 -0500
Received: from tomts16.bellnexxia.net ([209.226.175.4]:56319 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1031200AbWKURDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 12:03:20 -0500
Date: Tue, 21 Nov 2006 12:03:17 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       ltt-dev@shafik.org, mgreer@mvista.com, mlachwani@mvista.com
Subject: Re: LTTng do_page_fault vs handle_mm_fault instrumentation
Message-ID: <20061121170317.GA10250@Krystal>
References: <20061121160629.GA6944@Krystal> <4563289A.2000702@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <4563289A.2000702@ru.mvista.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 11:44:59 up 90 days, 13:52,  3 users,  load average: 0.41, 0.31, 0.32
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Sergei Shtylyov (sshtylyov@ru.mvista.com) wrote:
> Hello.
> 
> Mathieu Desnoyers wrote:
> 
> >I would like to discuss your suggestion of moving the do_page_fault
> >instrumentation to handle_mm_fault. On one side, it helps removing 
> >architecture
> >dependant instrumentation, but on the other hand :
> 
> >1- We cannot access the struct pt_regs in all cases (there may be an 
> >invalid
> >   current task struct).
> >2- We cannot distinguish between calls to handle_mm_fault from the page 
> >fault
> >   handler or from get_user_pages.
> >3- Some people complain about not having enough information about the 
> >cause of
> >   the page fault (see the forward below).
> >
> >So instead of staying between my users who ask for those feature and kernel
> >developers who wish to reduce the intrusiveness of instrumentation (which 
> >is a
> >nice goal : moving the syscall entry/exit instrumentation do 
> >do_syscall_trace
> >has helped simplifying the instrumentation), I prefer to open the 
> >discussion
> >about it.
> 
>    It seems I've missed the whole story behind this move.
>    For me, it was more a question of consistency: if we're trying to trace 
> all trap handlers, why not page fault one? So, I just wanted my old LTT 
> tracepoints back. :-)
> 

This topic brings the question about how near must be the instrumentation from
the hardware events.

We have to take into account that the tracer uses the hardware to trace :
mainly, it writes an event into vmalloc'd buffer, which will generate vmalloc
faults on some architectures. Therefore, reentrancy with the "hardware" events
becomes part of the problem. Because of this, we can't simply instrument the
page fault handler at the beginning and end, as it would end up doing
infinite recursive calls.

I see two trends : on one side, the developers and people interested into
measuring performance want instrumentation as close to the hardware events as
possible. Some wants to know the exact execution flow, including the error
conditions in the trap handlers. People doing performance measurements wants
to account correctly the amount of time spent in those handlers.

The other side is the kernel developer who does not want to clutter the code
with too much instrumentation.

Instrumentation around the handle_mm_fault handler call, inside do_page_fault,
looked to me as a good compromise : it can access the struct pt_regs, it will
never be called from either a vmalloc fault or an erroneous page fault caused by
the tracer itself (which of course, never happens, but who knows...). It won't,
however, give information about some error paths in the page fault handler,
mainly related to kernel faults. It is also a little farther from the page
fault handler "real" entry and exit points, but I consider it a minor impact
compared to the cost of entering the trap on currently existing architectures.
Note that I plan to create a "calibration" module someday so we could know how
much time to add to the duration of the page faults, knowing the time required
to enter in and return from the fault.

Mathieu

> >Ideas/comments are welcome.
> 
> >Regards,
> 
> >Mathieu
> 
> WBR, Sergei
> 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
