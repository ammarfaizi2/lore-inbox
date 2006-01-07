Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWAGBp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWAGBp0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 20:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWAGBp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 20:45:26 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:2229 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964810AbWAGBpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 20:45:25 -0500
Date: Fri, 6 Jan 2006 21:37:13 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [PATCH 4/9] UML - Better diagnostics for broken configs
Message-ID: <20060107023713.GA13285@ccure.user-mode-linux.org>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org> <20060105161436.GA4426@ccure.user-mode-linux.org> <Pine.LNX.4.61.0601052258350.27662@yvahk01.tjqt.qr> <200601061801.17497.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601061801.17497.rob@landley.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 06:01:13PM -0600, Rob Landley wrote:
> Unfortunately, stock kernels don't let you just discard a system call, so you
> have to pass _something_ on to the underlying OS before you can resume from 
> the ptrace.  But you can change all the information both on the way in and on
> the way out, so what UML did was it turned all system calls into "getpid", 
> which it then ignored the return value of in favor of doing its own system 
> call handling.  Stock kernels also don't allow one process to remap another 
> process's memory, which is kind of important in context switching and meant 
> that each process being traced had to be a separate PID on the host, because 
> the UML kernel couldn't remap that process's page tables.
> 
> Doing both of these things (a seperate host process for each UML process, and
> calling getpid() for all system calls), is what "Tracing Thread" mode did.  
> The UML kernel was one thread among several, and it was kinda slow.

The skas vs tt distinction is the address space part of this.  How we nullify
system calls is separate.  That's the PTRACE_SYSCALL vs PTRACE_SYSEMU (which
is now in mainline) thing.

> Then somebody got drunk and came up with something extremely clever that I'm 
> _still_ trying to get a clear explanation of, but they found out a way to run
> SKAS mode on an unmodified kernel by sacrificing a chicken or something, and 
> this became known as "SKAS0" mode.  

Hehe, that would be Blaisorblade - I've refrained from asking what he had
to sacrifice.

> It's not as fast as SKAS3 mode 
> (sacrificing chickens takes time), but it's faster than TT mode and a lot 
> less cluttered because you don't need a separate process on the host for each
> process running under User Mode Linux kernel. 

skas0 still requires one host process per UML process.  That's how it gets
host address spaces, which skas3 does using /proc/mm.  In this sense, skas0
is sort of a cross between tt and skas3 modes.

				Jeff
