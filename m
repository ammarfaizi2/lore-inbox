Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWBPI7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWBPI7p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 03:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWBPI7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 03:59:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751283AbWBPI7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 03:59:44 -0500
Date: Thu, 16 Feb 2006 00:58:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Cliff Wickman <cpw@sgi.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       george anzinger <george@mvista.com>
Subject: Re: [RFC] sys_setrlimit() in 2.6.16
Message-Id: <20060216005826.4afc87ae.akpm@osdl.org>
In-Reply-To: <20060214222417.GA8479@sgi.com>
References: <20060214222417.GA8479@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff Wickman <cpw@sgi.com> wrote:
>
> A test suite uncovered a possible bug in setrlimit(2), in 2.6.16-rc3.
> 
> A code that does
>         mylimits.rlim_cur = 0;
>         setrlimit(RLIMIT_CPU, &mylimits);
> does not set a cpu time limit.
> 
> No signal is sent to this code when its "limit" of 0 seconds expires.
> Whereas, under the 2.6.5 kernel (SuSE SLESS9) a signal was sent.
> 
> I don't see any obvious difference in sys_setrlimit() or
> set_process_cpu_timer() between 2.6.5 and 2.6.16.
> 
> Is this a correction, or a bug?
> 
> Is a cpu time limit of 0 supposed to limit a task to 0 seconds, or
> leave it unlimited?
> 

This has to be considered a bug.  The spec certainly implies that a limit
of zero should be honoured and, probably more importantly, that's how it
works in 2.4.

Problem is, the code in there all assumes that an it_prof_expires of zero
means "it was never set", and changing that (add a yes-it-has flag?) would
be less than trivial.

So I think the path of least resistance here is to just convert the
caller's zero seconds into one second.  That in fact gives the same
behaviour as 2.4: you get whacked after one second or more CPU time.

(This is not a final patch - that revolting expression in sys_setrlimit()
needs help first).


diff -puN kernel/sys.c~a kernel/sys.c
--- devel/kernel/sys.c~a	2006-02-16 00:42:49.000000000 -0800
+++ devel-akpm/kernel/sys.c	2006-02-16 00:45:10.000000000 -0800
@@ -1657,7 +1657,19 @@ asmlinkage long sys_setrlimit(unsigned i
 	    (cputime_eq(current->signal->it_prof_expires, cputime_zero) ||
 	     new_rlim.rlim_cur <= cputime_to_secs(
 		     current->signal->it_prof_expires))) {
-		cputime_t cputime = secs_to_cputime(new_rlim.rlim_cur);
+		unsigned long rlim_cur = new_rlim.rlim_cur;
+		cputime_t cputime;
+
+		if (rlim_cur == 0) {
+			/*
+			 * The caller is asking for an immediate RLIMIT_CPU
+			 * expiry.  But we use the zero value to mean "it was
+			 * never set".  So let's cheat and make it one second
+			 * instead
+			 */
+			rlim_cur = 1;
+		}
+		cputime = secs_to_cputime(rlim_cur);
 		read_lock(&tasklist_lock);
 		spin_lock_irq(&current->sighand->siglock);
 		set_process_cpu_timer(current, CPUCLOCK_PROF,
_

