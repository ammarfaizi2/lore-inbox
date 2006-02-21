Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWBUX3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWBUX3V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWBUX3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:29:21 -0500
Received: from nevyn.them.org ([66.93.172.17]:21680 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1751209AbWBUX3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:29:20 -0500
Date: Tue, 21 Feb 2006 18:29:03 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Charles P. Wright" <cwright@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ptrace and threads
Message-ID: <20060221232903.GA3778@nevyn.them.org>
Mail-Followup-To: "Charles P. Wright" <cwright@cs.sunysb.edu>,
	linux-kernel@vger.kernel.org
References: <1140030841.10553.9.camel@polarbear.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140030841.10553.9.camel@polarbear.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 02:14:01PM -0500, Charles P. Wright wrote:
> Is there a proper, non-racy, way to hand a ptraced child off from one
> tracing process to another tracing process?
> 
> Specifically, I want to architect my tracing application such that each
> traced process is traced by a separate thread.
> 
> For non-threaded applications, I was adding CLONE_STOPPED to the
> clone(2) flags of the child.  This way, when the child process started
> up, it would be stopped and a new tracing thread could PTRACE_ATTACH to
> it before any system calls were executed.  Unfortunately, this method
> doesn't seem to work for threaded traced processes.  The reason is that
> the SIGSTOP may be delivered to the traced parent instead of the traced
> child, because signal handlers are shared.
> 
> My next thought was to add CLONE_PTRACE to the flags.  This way, the
> tracing process gets signaled via wait before the child begins to
> execute.  The problem now is that I need to the have a separate
> monitoring thread take control of the child.  I tried using
> ptrace(PTRACE_DETACH, ..., ..., SIGSTOP) in the original tracing process
> to stop the process after the fork, followed by a ptrace(PTRACE_ATTACH)
> in the new tracing process.  Again, the STOP signal doesn't seem to be
> reliably delivered (and the man page says you can't use SIGSTOP as an
> argument to PTRACE_CONT and that PTRACE_DETACH's semantics match those
> of PTRACE_CONT).

You didn't say what kernel version you're concerned with.  There have
definitely been fixes in this area in the last year.  If you're using a
current kernel and PTRACE_DETACH can't leave the thread stopped, please
let us know.  I'd have expected the CLONE_STOPPED approach to work too.

However, I also recall some trouble with having one thread running
ptraced while another thread is not ptraced, where SIGTRAP would be
delivered to the wrong thread.  So there may still be trouble.

-- 
Daniel Jacobowitz
CodeSourcery
