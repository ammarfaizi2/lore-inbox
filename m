Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbUK3QzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbUK3QzD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbUK3QzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:55:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12193 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262193AbUK3QxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:53:21 -0500
Date: Mon, 29 Nov 2004 19:31:57 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: George Anzinger <george@mvista.com>
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nanosleep interrupted by ignored signals
Message-ID: <20041129213157.GA6894@dmt.cyclades>
References: <20041124213521.GJ2460@waste.org> <41A54731.2040607@mvista.com> <20041125030627.GK2460@waste.org> <20041125080953.GB15315@logos.cnet> <41AB7FFC.1010705@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AB7FFC.1010705@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 12:01:00PM -0800, George Anzinger wrote:
> Marcelo Tosatti wrote:
> >On Wed, Nov 24, 2004 at 07:06:27PM -0800, Matt Mackall wrote:
> >
> >>On Wed, Nov 24, 2004 at 06:45:05PM -0800, George Anzinger wrote:
> >>
> >>>Matt Mackall wrote:
> >>>
> >>>>Take the following trivial program:
> >>>>
> >>>>#include <unistd.h>
> >>>>
> >>>>int main(void)
> >>>>{
> >>>>	sleep(10);
> >>>>	return 0;
> >>>>}
> >>>>
> >>>>Run it in an xterm. Note that resizing the xterm has no effect on the
> >>>>process. Now do the same with strace:
> >>>>
> >>>>brk(0x80495bc)                          = 0x80495bc
> >>>>brk(0x804a000)                          = 0x804a000
> >>>>rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
> >>>>rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
> >>>>rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> >>>>nanosleep({10, 0}, 0xbffff548)          = -1 EINTR (Interrupted system
> >>>>call)
> >>>>--- SIGWINCH (Window changed) ---
> >>>>_exit(0)                                = ?
> >>>>
> >>>>In short, nanosleep is getting interrupted by signals that are
> >>>>supposedly ignored when a process is being praced. This appears to be
> >>>>a long-standing bug.
> >>>>
> >>>>It also appears to be a long-known bug. I found some old discussion of 
> >>>>this
> >>>>problem here but no sign of any resolution:
> >>>>
> >>>>http://www.ussg.iu.edu/hypermail/linux/kernel/0108.1/1448.html
> >>>>
> >>>>What's the current thinking on this?
> >>>
> >>>This should have been resolved with the 2.6 changes, in particular, the 
> >>>restart code.  What kernel are you using?
> >>
> >>Indeed it is. Forgot I still had 2.4 on the box in question, didn't
> >>notice the restart bit when comparing the 2.6 code against the thread
> >>above. Mea culpa.
> >
> >
> >George, 
> >
> >Is it worth/necessary to fix this bug in v2.4 ?
> >
> >Quoting yourself
> >
> >"This is an issue for debugging also (same ptrace...). The fix is to fix
> >nano_sleep to match the standard which says it should only return on a
> >signal if the signal is delivered to the program (i.e. not on internal
> >"do nothing" signals). Signal in the kernel returns 1 if it calls the
> >task and 0 otherwise, thus nano sleep might be changed as follows: "
> >
> Hmm,  wise fellow, that :)  We (MontaVista) have back ported this fix to 
> our kernels as part of the HRT patch, and, in fact, it is in the latest 
> (albeit somewhat out of date) HRT patch on sourceforge.  The main issue is 
> that it requires changes in arch level code and so requires a cooperative 
> effort (in that most folks only have one or two archs to check it out on).
> 
> My take on this is that this has been in the kernel since nanosleep() was 
> put in and so, for a mature kernel, it is not really important to change 
> it.  Now if you want to back port POSIX clocks and timers (i.e. 
> clock_nanosleep()) I would argue that you should back port this change as 
> part of that effort.

Not really a good idea IMO - lets live with the bug. If it was easy to fix it,
then it would be interesting, but since it is not...

Thanks for your input.
