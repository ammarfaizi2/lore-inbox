Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265668AbUF2HBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265668AbUF2HBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 03:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbUF2HBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 03:01:17 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:32729 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265672AbUF2HA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 03:00:56 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 29 Jun 2004 00:00:50 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mingo@redhat.com, cagney@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86 single-step (TF) vs system calls & traps
In-Reply-To: <200406290437.i5T4bYPI022901@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0406282146470.24039@bigblue.dev.mdolabs.com>
References: <200406290437.i5T4bYPI022901@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004, Roland McGrath wrote:

> > Davide's patch (which has been in -mm for 6-7 weeks) doesn't add
> > fastpath overhead.
> 
> I am also dubious about exactly what it does.  That patch seems a bizarre
> obfuscation of the code to me.  TIF_SINGLESTEP is really there to handle
> the lazy TF clearing for sysenter entry, and that's all.  I don't think
> that patch handles user-mode setting TF properly, unusual though that case
> is.  How does that patch interact with PT_TRACESYSGOOD?  It appears to me
> that PTRACE_SINGLESTEP will now generate a syscall trap instead of a
> single-step trap, which is an undesireable change in behavior I would say.
> 
> I don't really care about user-mode setting of TF before executing int
> $0x80.  If poeple have programs that use TF in user mode, they have never
> complained about the issue before.  For PTRACE_SINGLESTEP, Davide's
> approach of setting the kernel-work flag directly when PTRACE_SINGLESTEP
> sets TF in the user flags word is the obvious way to avoid the test in the
> fast path.  I am inclined to combine that approeach with what my patch
> does, i.e. just take out the system call fast-path test and set
> TIF_SINGLESTEP_TRAP in PTRACE_SINGLESTEP.  I think the way Davide's patch
> uses TIF_SINGLESTEP is pretty questionable.

Roland, I don't think (pretty sure actually ;) we can handle the case 
where TF is set from userspace and, at the same time, the user uses 
PTRACE_SINGLESTEP. The ptrace infrastructure uses the hw TF flag to work. 
The PTRACE_SINGLESTEP gives you the SYSGOOD behaviour, if you set it. And 
sends a SIGTRAP notification to the ptrace'ing parent process.


- Davide

