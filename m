Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265693AbUGGXu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbUGGXu3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 19:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265695AbUGGXu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 19:50:29 -0400
Received: from mother.openwall.net ([195.42.179.200]:29333 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S265690AbUGGXuA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 19:50:00 -0400
Date: Thu, 8 Jul 2004 03:48:52 +0400
From: Solar Designer <solar@openwall.com>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: question about /proc/<PID>/mem in 2.4 (fwd)
Message-ID: <20040707234852.GA8297@openwall.com>
References: <Pine.LNX.4.44.0407071427010.2972-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407071427010.2972-100000@einstein.homenet>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 02:28:10PM +0100, Tigran Aivazian wrote:
> So, my questions (to Solar Designer) are:
> 
> 1. what exactly are the details of the setuid race Alan Cox is referring
> to above? I have 0 (zero) doubts in the validity of Alan's words and
> always trust him, but it doesn't imply that I always understand him, and
> so would appreciate a clarification.

The problem is the process the /proc/<PID>/mem of which you're reading
may be ptrace-detached and proceed into a SUID/SGID exec while you're
still inside mem_read().  This was the reason for my addition of the
may_ptrace_attach() function and its uses in mem_read() in 2.4.21-ow2
and 2.4.22.  Here's an excerpt from an e-mail I wrote at the time:

| Date: Sun, 6 Jul 2003 05:37:15 +0400
| From: Solar Designer <solar at openwall.com>
| To: Paul Starzetz <paul at starzetz.de>
| Cc: Alan Cox <alan at redhat.com>
| Subject: Re: [vendor-sec] Linux /proc sensitive information disclosure
| [...]
| ...reviewing mem_read() I see potential ways to bypass
| its additional checks.
| 
| MAY_PTRACE() is only checked once and I don't see anything which would
| prevent the task from being ptrace-detached and continuing with SUID
| exec as mem_read() proceeds with access_process_vm().
| 
| I'm not sure the use of self_exec_id is appropriate.  What if an fd
| for an opened mem entry is transferred (over Unix domain socket) into
| another process?  Shouldn't this be self_exec_id for the target task
| and not current anyway?
| 
| There may be reasons why the existing checks are sufficient (I just
| don't see them), but I'd feel more comfortable if mem_read() kept a
| lock on the task preventing it getting replaced on exec and/or if it
| re-checked permissions after the access_process_vm() but before the
| copy_to_user().

Re-checking permissions is what I had implemented.

> 2. are you sure that there is no way to fix the above race without
> preventing even the superuser access to /proc/<PID>/mem of 
> any process?

I think this is a different issue.  You seem to be complaining about
the older MAY_PTRACE() check, not about the added may_ptrace_attach()
check.  Alan has already pointed out a reason why the MAY_PTRACE()
check was needed:

| Consider what happens if your setuid app reads stdin
| 
| 	setuidapp < /proc/self/mem

> More specifically (to save you time re-reading this thread) I am referring 
> to the code in fs/proc/base.c:mem_read():
> 
>         if (!MAY_PTRACE(task) || !may_ptrace_attach(task))
>                 return -ESRCH;
> 
> and also the same check on return from access_process_vm(), which I 
> suggested to relax a little, by allowing CAP_SYS_PTRACE user (or 
> CAP_SYS_RAWIO perhaps?) to access /proc/<PID>/mem of any task without any 
> hindrance.

See Alan's example I've quoted above.  In this scenario, it would be
the program being attacked which will be checked for possession of the
capability... if it is SUID root, the attack will succeed.

As for the checks performed inside may_ptrace_attach(), they're
derived from ptrace itself and are due to numerous attacks which
otherwise were possible on ptrace.  /proc/<PID>/mem is very similar.

> Btw, the second check looks like an obvious race to me. I.e. if this
> condition can change between the check in the beginning of mem_read() and
> return from access_process_vm() then what is to stop it from changing just
> after this second check and return from mem_read()?

I don't understand the attack you're describing here.  If anything
changes after mem_read() has already returned, then it's not our
business: the process has obtained a copy of data it had legitimate
access to.

-- 
Alexander Peslyak <solar@openwall.com>
GPG key ID: B35D3598  fp: 6429 0D7E F130 C13E C929  6447 73C3 A290 B35D 3598
http://www.openwall.com - bringing security into open computing environments
