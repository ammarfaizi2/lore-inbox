Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVFELVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVFELVa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 07:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVFELVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 07:21:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:24027 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261387AbVFELVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 07:21:20 -0400
Date: Sun, 5 Jun 2005 13:21:19 +0200
From: Andi Kleen <ak@suse.de>
To: John Blackwood <john.blackwood@ccur.com>
Cc: linux-kernel@vger.kernel.org, roland@redhat.com, ak@suse.de, akpm@osdl.org,
       bugsy@ccur.com
Subject: Re: [PATCH] ptrace(2) single-stepping into signal handlers
Message-ID: <20050605112119.GU23831@wotan.suse.de>
References: <42A09190.8080703@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A09190.8080703@ccur.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 01:21:20PM -0400, John Blackwood wrote:
> 1. Make the default behavior that we single-step to the next instruction
>    in the main (non-signal handler) stream of execution, instead of
>    single-stepping into the user's signal handler.

I think it is better to not change the default behaviour. You risk
breaking programs and there are much more that use ptrace than just gdb.

> 
> 2. Add a new ptrace PTRACE_SETOPTIONS command flag,

I think it would be better to just define a new ptrace singlestep command
with the new semantics instead of adding options.

> - The ptraced process has a pending signal and
>   it stops to notify the debugger.
> 
> - The debugger then single-steps into the ptraced process's signal handler.
> 
> - On the next eventual continue (PTRACE_CONT) command, we run through the
>   signal handler, and we stop once again at the next instruction before
>   we changed our execution stream and single-stepped into the user's
>   signal handler.
> 
> - At this point, we can no longer continue the ptraced process
>   with a PTRACE_CONT command.  Instead, all ptrace(2) PTRACE_CONT calls
>   are treated as if we had made a ptrace(2) PTRACE_SINGLESTEP call.

Have you actually seen this in practice?
> 
> - We saved off the eflags (with the TF bit set) in setup_sigcontext()
>   before we single stepped into the user's signal handler.
> 
> - When we exit the user's signal handler via a PTRACE_CONT call,
>   we restore the original eflags value (with the TF bit set) in the
>   restore_sigcontext() routine.  However, at this point, the
>   PT_DTRACE flag is no longer set.
> 
> - Subsequent ptrace(2) PTRACE_CONT calls will call
>   clear_singlestep() to make sure that any single-step state is
>   cleared out before we continue the ptrace process.
> 
>   However, since the PT_DTRACE flag is not set, we do NOT clear
>   the TF bit in the eflags register stack location, and we
>   instead end up doing a single-step operation.
> 
>   Also, if we do a PTRACE_SINGLESTEP operation at this point, to
>   attempt to get out of this stuck state, the set_singlestep()
>   routine will not set the PT_DTRACE flag since the TF flag
>   is already set!

Sounds like a bug. Can you submit a change for that separately?

-Andi
