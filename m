Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbTBLC6U>; Tue, 11 Feb 2003 21:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbTBLC4S>; Tue, 11 Feb 2003 21:56:18 -0500
Received: from crack.them.org ([65.125.64.184]:28315 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S266116AbTBLCzw>;
	Tue, 11 Feb 2003 21:55:52 -0500
Date: Tue, 11 Feb 2003 22:05:27 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: another subtle signals issue
Message-ID: <20030212030527.GA15854@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org
References: <200302120206.h1C26sI19476@magilla.sf.frob.com> <Pine.LNX.4.44.0302111833120.2667-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302111833120.2667-100000@home.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 06:45:19PM -0800, Linus Torvalds wrote:
> 
> On Tue, 11 Feb 2003, Roland McGrath wrote:
> > 
> > I think sys_semop would be closer to right if it used ERESTARTSYS instead
> > of EINTR.
> 
> You probably mean ERESTARTSYSNOHAND.
> 
> There are lots of system calls that simply are not restartable. So 
> TIF_SIGPENDING in general should be set only if required, and not "because 
> it's easier".
> 
> > The reason I am concerned about this is that I think any case that is
> > broken by the lack of the optimization in the patch below must also be
> > broken vis a vis the semantics of stop signals and SIGCONT (when SIG_DFL,
> > SIG_IGN, or blocked).  POSIX says that when a process is stopped by
> > e.g. SIGSTOP, and then continued by SIGCONT, any functions that were in
> > progress at the time of stop are unaffected unless SIGCONT runs a handler.
> > That is, nobody returns EINTR because of the stop/continue.
> 
> This is what ERESTARTNOHAND does, but quite often if you get interrupted
> you have to return _partial_ results, which is quite inefficient and
> sometimes breaks programs (ie you get things like a read() from a pipe
> that returns a partial result because you resized the window, and a 
> SIGWINCH happened - and that is _bad_).
> 
> The old code tried rather hard to make signals that were truly ignored 
> (SIGSTOP/SIGCONT is not of that kind) be total non-events because of 
> things like this. 

For things with a timeout, shouldn't they be converted to use
ERESTART_RESTARTBLOCK?  The situation Roland is describing is just
about the same as the original problem with nanosleep.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
