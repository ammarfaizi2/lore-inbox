Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWEANvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWEANvf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 09:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWEANvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 09:51:35 -0400
Received: from nevyn.them.org ([66.93.172.17]:41922 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S932112AbWEANve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 09:51:34 -0400
Date: Mon, 1 May 2006 09:51:27 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Message-ID: <20060501135127.GA1276@nevyn.them.org>
Mail-Followup-To: Jeff Dike <jdike@addtoit.com>,
	Blaisorblade <blaisorblade@yahoo.it>,
	user-mode-linux-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Bodo Stroesser <bstroesser@fujitsu-siemens.com>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <200604261747.54660.blaisorblade@yahoo.it> <20060426154607.GA8628@ccure.user-mode-linux.org> <200604282228.46681.blaisorblade@yahoo.it> <20060429014956.GB9734@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060429014956.GB9734@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 09:49:56PM -0400, Jeff Dike wrote:
> On Fri, Apr 28, 2006 at 10:28:46PM +0200, Blaisorblade wrote:
> > Ok, this gives us a definite proposal, which I finally like:
> > 
> > * to exclude sys_tee:
> > 
> > bitmask = 0;
> > set_bit(__NR_tee, bitmask);
> > ptrace(PTRACE_SET_NOTRACE, bitmask);
> > 
> > * to trace only sys_tee:
> > 
> > bitmask = 0;
> > set_bit(__NR_tee, bitmask);
> > ptrace(PTRACE_SET_TRACEONLY, bitmask);
> 
> Yup, I like this.

I really recommend you not do this.  One (better) suggestion earlier
was:

struct {
  int bitmask_length;
  int flags;
  char bitmask[0];
};

The difference between this case and the sigprocmask example is that
the size of a sigset_t is very hard to change - it's a userspace ABI
break.  If you want to model it after sigprocmask, don't look at the
man page, which describes the POSIX function.  Look at the more recent
RT version of the syscall instead:

sys_rt_sigprocmask(int how, sigset_t __user *set, sigset_t __user *oset, size_t sigsetsize)

Suppose the kernel knows about 32 more syscalls than userspace.  It's
going to read extra bits out of the bitmask that userspace didn't
initialize!

Also, if you store the mask with the child process, it risks surprising
existing tracers: attach, set mask, detach, then the next time someone
attaches an old version of strace some syscalls will be "hidden".


-- 
Daniel Jacobowitz
CodeSourcery
