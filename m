Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbUK0BBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUK0BBT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbUKZXz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:55:27 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9413 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263115AbUKZTpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:45:04 -0500
Date: Thu, 25 Nov 2004 06:09:53 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Matt Mackall <mpm@selenic.com>
Cc: George Anzinger <george@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nanosleep interrupted by ignored signals
Message-ID: <20041125080953.GB15315@logos.cnet>
References: <20041124213521.GJ2460@waste.org> <41A54731.2040607@mvista.com> <20041125030627.GK2460@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125030627.GK2460@waste.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 07:06:27PM -0800, Matt Mackall wrote:
> On Wed, Nov 24, 2004 at 06:45:05PM -0800, George Anzinger wrote:
> > Matt Mackall wrote:
> > >Take the following trivial program:
> > >
> > >#include <unistd.h>
> > >
> > >int main(void)
> > >{
> > >	sleep(10);
> > >	return 0;
> > >}
> > >
> > >Run it in an xterm. Note that resizing the xterm has no effect on the
> > >process. Now do the same with strace:
> > >
> > >brk(0x80495bc)                          = 0x80495bc
> > >brk(0x804a000)                          = 0x804a000
> > >rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
> > >rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
> > >rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> > >nanosleep({10, 0}, 0xbffff548)          = -1 EINTR (Interrupted system
> > >call)
> > >--- SIGWINCH (Window changed) ---
> > >_exit(0)                                = ?
> > >
> > >In short, nanosleep is getting interrupted by signals that are
> > >supposedly ignored when a process is being praced. This appears to be
> > >a long-standing bug.
> > >
> > >It also appears to be a long-known bug. I found some old discussion of this
> > >problem here but no sign of any resolution:
> > >
> > >http://www.ussg.iu.edu/hypermail/linux/kernel/0108.1/1448.html
> > >
> > >What's the current thinking on this?
> > 
> > This should have been resolved with the 2.6 changes, in particular, the 
> > restart code.  What kernel are you using?
> 
> Indeed it is. Forgot I still had 2.4 on the box in question, didn't
> notice the restart bit when comparing the 2.6 code against the thread
> above. Mea culpa.

George, 

Is it worth/necessary to fix this bug in v2.4 ?

Quoting yourself

"This is an issue for debugging also (same ptrace...). The fix is to fix
nano_sleep to match the standard which says it should only return on a
signal if the signal is delivered to the program (i.e. not on internal
"do nothing" signals). Signal in the kernel returns 1 if it calls the
task and 0 otherwise, thus nano sleep might be changed as follows: "


