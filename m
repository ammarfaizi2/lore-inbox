Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbSLIPeV>; Mon, 9 Dec 2002 10:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbSLIPeT>; Mon, 9 Dec 2002 10:34:19 -0500
Received: from crack.them.org ([65.125.64.184]:28823 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S265736AbSLIPeK>;
	Mon, 9 Dec 2002 10:34:10 -0500
Date: Mon, 9 Dec 2002 10:41:42 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: george anzinger <george@mvista.com>, Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
Message-ID: <20021209154142.GA22901@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	george anzinger <george@mvista.com>,
	Jim Houston <jim.houston@ccur.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
	"David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
	schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
References: <3DF06B15.1F6ECD5D@mvista.com> <Pine.LNX.4.44.0212060944030.23118-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212060944030.23118-100000@home.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 09:57:08AM -0800, Linus Torvalds wrote:
> 
> I just pushed my version of the system call restart code to the BK trees.
> It's losely based on Georges code, but subtly different. Also, I didn't
> actually update any actual system calls to use it, I just did the
> infrastructure.
> 
> Non-x86 architectures need to be updated to work with this: they need to
> update their thread structures, the additional do_signal() support in
> their signal.c, and add the actual system call itself somewhere. For x86,
> this was about 15 lines of changes.
> 
> The basic premise is very simple: if you want to restart a system call,
> you can do
> 
> 	restart = &current_thread()->restart_block;
> 	restart->fn = my_continuation_function;
> 	restart->arg0 = my_arg0_for_continuation;
> 	restart->arg1 = my_arg1_for_continuation;
> 	..
> 	return -ERESTARTSYS_RESTARTBLOCK;
> 
> which will cause the system call to either return -EINTR (if a signal
> handler was actually invoced) or for "benign" signals (SIGSTOP etc) it
> will end up restarting the system call at the continuation function (with
> the "restart" block as the argument).
> 
> We could extend this to allow restarting even over signal handlers, but
> that would have some re-entrancy issues (ie what happens if a signal
> handler itself wants to use a system call that may want restarting), so at
> least for now restarting is only done when no handler is invoced (*).
> 
> 			Linus
> 
> (*) The nesting case is by no means impossible to handle gracefully
> (adding a "restart even if handler is called" error number and returning
> -EINTR if nesting, for example), but I don't know of any system calls that
> would really want to try to restart anyway, so..

Well, here's something to consider.  This isn't entirely hypothetical;
there are test cases in GDB's regression suite that cover nearly this.

Suppose a process is sleeping for an hour.  The user wants to see what
another thread is doing, so he hits Control-C; the thread which happens
to be reported as 'current' is the one that was in nanosleep().  It
used to be that when he said continue, the nanosleep would return; now
hopefully it'll continue.  Great!  But this damnable user isn't done
yet.  He wants to look at one of his data structures.  He calls a
debugging print_foo() function from GDB.  He realizes he left a
sleep-for-a-minute nanosleep call in it and C-c's again.  Now we have
two interrupted nanosleep calls and the application will never see a
signal to interrupt either of them; he says "continue" twice and
expects to get back to his hour-long sleep.

Note that I'm not saying we _need_ to support this, mind :)  It's a
little pathological.

Another thing that annoys me slightly about this is that we mess with
the value in orig_eax etc.  Now a debugger would have to look at the
instruction stream to figure out what the syscall was that we're
stopped in, reliably.  Not a big deal.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
