Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWERVNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWERVNX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 17:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWERVNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 17:13:23 -0400
Received: from lea.cs.unibo.it ([130.136.1.101]:43186 "EHLO lea.cs.unibo.it")
	by vger.kernel.org with ESMTP id S1751275AbWERVNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 17:13:22 -0400
Date: Thu, 18 May 2006 23:13:21 +0200
To: Andi Kleen <ak@suse.de>
Cc: osd@cs.unibo.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2-ptrace_multi
Message-ID: <20060518211321.GC6806@cs.unibo.it>
References: <20060518155337.GA17498@cs.unibo.it> <20060518155848.GC17498@cs.unibo.it> <p73sln72im3.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73sln72im3.fsf@bragg.suse.de>
User-Agent: Mutt/1.5.6+20040907i
From: renzo@cs.unibo.it (Renzo Davoli)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 10:17:08PM +0200, Andi Kleen wrote:
> > With PTRACE_MULTI option you can send multiple ptrace requests with a 
> > single system call: commonly a process that uses ptrace() needs
> > several PTRACE_PEEKDATA for getting some useful, even small pieces of data.
> > It is useful for these programs to run several ptrace
> > operations while limiting the number of context switches.
> 
> What context switches do you mean?  System calls? Linux is in general
> designed to have very cheap system calls and they shouldn't be more tha
> a few hundred cycles. 
Agree, but they are a few hundred cycles wasted.
This can be highly significative when you are working on a Virtual Machine
monitor.
In umview the monitor (umview process) and the process inside the VM
live in separate address spaces.
e.g. To virtualize a write you'd have to call PTRACE_PEEKDATA for each 
word of the buffer, very many hundreds cycles lost.
> > 
> > Debuggers and virtual machines (like User Mode Linux) and many other 
> > applications that are based on ptrace can get great 
> > performance improvements by PTRACE_MULTI: the number of system
> > calls (and context switches) decreases significantly.
> 
> You forgot to add numbers? 
They are obviously highly dependant on applications.

(test computer=tibook G4 1Ghz)
Umview+unreal test module/NO PTRACE_MULTI/NO PTRACE_SYSVM
$ time cp /unreal/usr/src/linux-source-2.6.16.tar.bz2 /tmp
real    0m22.626s
user    0m0.000s
sys     0m0.448s

Umview+unreal test module/NO_SYSVM  WITH PTRACE_MULTI
$ time cp /unreal/usr/src/linux-source-2.6.16.tar.bz2 /tmp
real    0m1.850s
user    0m0.008s
sys     0m0.384s

Umview+unreal test module/SYSVM+MULTI
$ time cp /unreal/usr/src/linux-source-2.6.16.tar.bz2 /tmp
real    0m1.261s
user    0m0.012s
sys     0m0.392s

This is a test on the cost of umview virtualization with no modules.
Umview alone/NO SYSVM/NO PTRACE_MULTI
$ time cp /usr/src/linux-source-2.6.16.tar.bz2 /tmp
real    0m1.595s
user    0m0.000s
sys     0m0.548s

Umview alone/NO SYSVM (with ptrace_multi)
$ time cp /usr/src/linux-source-2.6.16.tar.bz2 /tmp
real    0m1.587s
user    0m0.008s
sys     0m0.596s

Umview alone/With SYSVM (and ptrace_multi)
$ time cp /usr/src/linux-source-2.6.16.tar.bz2 /tmp
real    0m1.056s
user    0m0.008s
sys     0m0.496s

The same command on the Linux kernel (NO umview)
$ time cp /usr/src/linux-source-2.6.16.tar.bz2 /tmp
real    0m0.429s 
user    0m0.004s
sys     0m0.368s

This is a worst case run of umview as cp is absolutely IO bound (and
system call bound). The more computation a program has the more
efficient is the VM. The user mode VM costs in this case 2.5 times slowdown.

renzo
