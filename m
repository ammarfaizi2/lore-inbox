Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVGXH3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVGXH3h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 03:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVGXH3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 03:29:37 -0400
Received: from ms004msg.fastwebnet.it ([213.140.2.58]:44185 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261314AbVGXH3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 03:29:35 -0400
Date: Sun, 24 Jul 2005 09:28:07 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Lack of Documentation about SA_RESTART...
Message-ID: <20050724092807.31f1e3c5@localhost>
In-Reply-To: <Pine.LNX.4.58.0507231723270.6074@g5.osdl.org>
References: <20050711123237.787dfcde@localhost>
	<20050711143427.GC14529@thunk.org>
	<Pine.LNX.4.58.0507231723270.6074@g5.osdl.org>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2005 17:30:42 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> > According to the Single Unix Specification V3, all functions that
> > return EINTR are supposed to restart if a process receives a signal
> > where signal handler has been installed with the SA_RESTART flag.  
> 
> That can't be right.


SUV3 is really lacking about it:


sigaction()
"SA_RESTART
    [XSI] [Option Start] This flag affects the behavior of interruptible
functions; that is, those specified to fail with errno set to [EINTR].
If set, and a function specified as interruptible is interrupted by this
signal, the function shall restart and shall not fail with [EINTR]
unless otherwise specified. If the flag is not set, interruptible
functions interrupted by this signal shall fail with errno set to
[EINTR]."


Note the "unless otherwise specified"... but then SA_RESTART is only
mentioned for:


select/pselect
	"[XSI] [Option Start] If SA_RESTART has been set for the interrupting
	signal, it is implementation-defined whether the function restarts or
	returns with [EINTR]."


and for other few signal handling functions like bsd_signal(),
siginterrupt(), signal()... but just to say what SA_RESTART means.



Then, reading xrat/xsh_chap02.html:

"Signal Effects on Other Functions

The most common behavior of an interrupted function after a
signal-catching function returns is for the interrupted function to give
an [EINTR] error unless the SA_RESTART flag is in effect for the signal.
However, there are a number of specific exceptions, including sleep()
and certain situations with read() and write().

The historical implementations of many functions defined by IEEE Std
1003.1-2001 are not interruptible, but delay delivery of signals
generated during their execution until after they complete. This is
never a problem for functions that are guaranteed to complete in a short
(imperceptible to a human) period of time. It is normally those
functions that can suspend a process indefinitely or for long periods of
time (for example, wait(), pause(), sigsuspend(), sleep(), or read()/
write() on a slow device like a terminal) that are interruptible. This
permits applications to respond to interactive signals or to set
timeouts on calls to most such functions with alarm(). Therefore,
implementations should generally make such functions (including ones
defined as extensions) interruptible.

Functions not mentioned explicitly as interruptible may be so on some
implementations, possibly as an extension where the function gives an
[EINTR] error. There are several functions (for example, getpid(),
getuid()) that are specified as never returning an error, which can thus
never be extended in this way.

If a signal-catching function returns while the SA_RESTART flag is in
effect, an interrupted function is restarted at the point it was
interrupted. Conforming applications cannot make assumptions about the
internal behavior of interrupted functions, even if the functions are
async-signal-safe. For example, suppose the read() function is
interrupted with SA_RESTART in effect, the signal-catching function
closes the file descriptor being read from and returns, and the read()
function is then restarted; in this case the application cannot assume
that the read() function will give an [EBADF] error, since read() might
have checked the file descriptor for validity before being interrupted."



FreeBSD doc (man page of sigaction) is much better:
http://www.gsp.com/cgi-bin/man.cgi?section=2&topic=sigaction

"If a signal is caught during the system calls listed below, the call
may be forced to terminate with the error  EINTR, the call may return
with a data transfer shorter than requested, or the call may be
restarted. Restart of pending calls is requested by setting the 
SA_RESTART bit in  sa_flags. The affected system calls include open(2),
read(2), write(2), sendto(2), recvfrom(2), sendmsg(2) and recvmsg(2) on
a communications channel or a slow device (such as a terminal, but not a
regular file) and during a wait(2) or ioctl(2). However, calls that have
already committed are not restarted, but instead return a partial
success (for example, a short read count)."


Finally, in Linux other syscalls can be restarted... like connect(), for
example.

 -- 
	Paolo Ornati
	Linux 2.6.13-rc3 on x86_64
