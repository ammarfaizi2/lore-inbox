Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965359AbWAGAB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965359AbWAGAB7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965360AbWAGAB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:01:59 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:37331
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S965359AbWAGAB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:01:59 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 4/9] UML - Better diagnostics for broken configs
Date: Fri, 6 Jan 2006 18:01:13 -0600
User-Agent: KMail/1.8
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Jeff Dike <jdike@addtoit.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org> <20060105161436.GA4426@ccure.user-mode-linux.org> <Pine.LNX.4.61.0601052258350.27662@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601052258350.27662@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601061801.17497.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 15:59, Jan Engelhardt wrote:
> config MODE_TT
>         bool "Tracing thread support"
>         default y
>         help
>         This option controls whether tracing thread support is compiled
>         into UML.  Normally, this should be set to Y.  If you intend to
>         use only skas mode (and the host has the skas patch applied to it),
>         then it is OK to say N here.
>
> Then I unfortunately do not quite understand what this is for.

User Mode Linux works a bit like gdb: it uses ptrace to intercept the system 
calls a process makes and handles them itself instead of allowing the 
underlying OS to do so.

Unfortunately, stock kernels don't let you just discard a system call, so you 
have to pass _something_ on to the underlying OS before you can resume from 
the ptrace.  But you can change all the information both on the way in and on 
the way out, so what UML did was it turned all system calls into "getpid", 
which it then ignored the return value of in favor of doing its own system 
call handling.  Stock kernels also don't allow one process to remap another 
process's memory, which is kind of important in context switching and meant 
that each process being traced had to be a separate PID on the host, because 
the UML kernel couldn't remap that process's page tables.

Doing both of these things (a seperate host process for each UML process, and 
calling getpid() for all system calls), is what "Tracing Thread" mode did.  
The UML kernel was one thread among several, and it was kinda slow.

Then the UML guys started patching the kernel, adding the ability to not pass 
on a system call (to eliminate the pointless calls to getpid() that just 
served to throw in a lot of context switches and slow everything down a 
suprising amount), and adding /proc/mm to let one process remap another's 
memory.  This was "SKAS" mode (Single Kernel Address Space), and was much 
faster but required a modified host kernel.  They went through a few 
iterations of this (different host patches) until they came up with the 
current version, "SKAS3".  (Of course if you're going to run a modified host 
kernel, you might as well just use XEN.)

Then somebody got drunk and came up with something extremely clever that I'm 
_still_ trying to get a clear explanation of, but they found out a way to run 
SKAS mode on an unmodified kernel by sacrificing a chicken or something, and 
this became known as "SKAS0" mode.  It's not as fast as SKAS3 mode 
(sacrificing chickens takes time), but it's faster than TT mode and a lot 
less cluttered because you don't need a separate process on the host for each 
process running under User Mode Linux kernel. 

Both TT and SKAS0 run on unmodified kernels.  I ignore SKAS3 entirely, because 
it doesn't.

SKAS0 works pretty well now, it's faster and less complicated than TT mode, 
and thus TT mode is mostly obsolete now.  If you compile UML and run SKAS, 
it'll auto-detect if your host kernel has the weird patches to support the 
extensions for SKAS3, and if not it'll run SKAS0.  TT mode is mostly an 
anachronism, except that they haven't made SKAS0 support SMP yet, so if you 
want to emulate SMP via UML you have no choice but to use TT mode (not that 
it necessarily works all that great there, since TT mode doesn't get much 
testing anymore).

> Jan Engelhardt

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
