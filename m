Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbRBAQ5C>; Thu, 1 Feb 2001 11:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129686AbRBAQ4w>; Thu, 1 Feb 2001 11:56:52 -0500
Received: from oxmail3.ox.ac.uk ([129.67.1.180]:65167 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S129136AbRBAQ4n>;
	Thu, 1 Feb 2001 11:56:43 -0500
Date: Thu, 1 Feb 2001 16:52:47 +0000
From: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
To: Chris Evans <chris@scary.beasts.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serious reproducible 2.4.x kernel hang
Message-ID: <20010201165247.D27009@sable.ox.ac.uk>
In-Reply-To: <20010201153000.C27009@sable.ox.ac.uk> <Pine.LNX.4.30.0102011556010.4030-100000@ferret.lmh.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0102011556010.4030-100000@ferret.lmh.ox.ac.uk>; from chris@scary.beasts.org on Thu, Feb 01, 2001 at 04:03:24PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Evans writes:
> 
> On Thu, 1 Feb 2001, Malcolm Beattie wrote:
> 
> > Mapping the addresses from whichever ScrollLock combination produced
> > the task list to symbols produces the call trace
> >  do_exit <- do_signal <- tcp_destroy_sock <- inet_ioctl <- signal_return
> >
> > The inet_ioctl is odd there--vsftpd doesn't explicitly call ioctl
> > anywhere at all and the next function before it in memory is
> > inet_shutdown which looks more believable. I have checked I'm looking
> 
> Probably, the empty SIGPIPE handler triggered. The response to this is a
> lot of shutdown() close() and finally an exit().
> 
> The trace you give above looks like the child process trace. I always see
> the parent process go nuts. The parent process is almost always blocking
> on read() of a unix dgram socket, which it shares with the child. The
> child does a shutdown() on this socket just before exit().

We've done some more detective work. I can reproduce the hang too
by quitting the ftp client abruptly (^Z and kill %1 in my case).
Inducing the hang while stracing the daemon shows a recv returning 0
as expected when the socket closes. The daemon then calls "die":

    die(const char* p_text)
    {
      /* Going down hard... */
    #ifdef DIE_DEBUG
      bug(p_text);
    #endif

and DIE_DEBUG is defined. bug() writes an error message and then does
three things:
    shutdown(2) on the sockets
    close(2) on the sockets
    abort()
the last of which libc implements as
    rt_sigprocmask(SIG_UNBLOCK, [SIGABRT])
    kill(getpid(), SIGABRT)

Here's the interesting thing: doing an exit(0) before the shutdowns
and abort gets rid of the hang. The only unusual and potentially
untested thing I could find about the program was that it uses
capset() and prctl(PR_SET_KEEPCAPS). However, replacing the
"retval = capset(...)" call with a dummy "retval = 0" doesn't get
rid of the hang. So it looks as though some combination of
shutdown(2) and SIGABRT is at fault. After the hang the kernel-side
stack trace is always either the one I gave above (and I *did*
write down the address for inet_ioctl correctly; it's definitely
not inet_shutdown) or else
  do_exit <- do_signal <- schedule <- syscall_trace <- signal_return
(with exactly the same addresses as above except for the differing
schedule and syscall_trace ones) which appeared after the hang while
vsftpd was being run under strace.

--Malcolm

-- 
Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Unix Systems Programmer
Oxford University Computing Services
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
