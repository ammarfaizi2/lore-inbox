Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261672AbTCaOoH>; Mon, 31 Mar 2003 09:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261674AbTCaOoH>; Mon, 31 Mar 2003 09:44:07 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:54792 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S261672AbTCaOoD>;
	Mon, 31 Mar 2003 09:44:03 -0500
Date: Mon, 31 Mar 2003 16:55:19 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PTRACE_KILL doesn't (2.5.44 and others)
Message-ID: <20030331145519.GA12984@win.tue.nl>
References: <20030330205126.G7414@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030330205126.G7414@almesberger.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 30, 2003 at 08:51:26PM -0300, Werner Almesberger wrote:

> If the process being ptraced is running, PTRACE_KILL will have no
> effect. I've seen this in 2.5.44, and the code in 2.4.18 and 2.5.66
> seems to be equivalent.
> 
> According to the ptrace(2) man page (as of man-pages-1.56),
> PTRACE_KILL doesn't require the process to be stopped for this to
> work.
> 
> Who is right ?

First of all, it is dangerous to depend on subtle properties
of obscure calls like ptrace. Only the part that is common to
all Unix implementations of ptrace is somewhat reliable.

A random non-Linux man page says

-----
     The ptrace() function allows a parent process to control the
     execution  of  a  child  process. Its primary use is for the
     implementation of breakpoint debugging.  The  child  process
     behaves   normally   until   it  encounters  a  signal  (see
     signal(3HEAD)), at which time it enters a stopped state  and
     its  parent  is  notified via the wait(2) function. When the
     child is in the stopped state, its parent  can  examine  and
     modify its "core image" using ptrace(). Also, the parent can
     cause the child either to terminate or  continue,  with  the
     possibility of ignoring the signal that caused it to stop.
...
     8     This request causes the child to  terminate  with  the
           same consequences as exit(2).
-----

so, this suggests that ptrace only does something when the child
is stopped.

The Linux man page says

-----
       While being traced, the child will stop each time a signal
       is  delivered,  even if the signal is being ignored.  (The
       exception is SIGKILL, which has its  usual  effect.)   The
       parent  will  be  notified  at  its  next  wait(2) and may
       inspect and modify the child process while it is  stopped.
       The  parent  then causes the child to continue, optionally
       ignoring the delivered signal (or even delivering  a  dif-
       ferent signal instead).

       When  the parent is finished tracing, it can terminate the
       child with PTRACE_KILL or cause it to  continue  executing
       in a normal, untraced mode via PTRACE_DETACH.
-----

Here is is not completely clear whether the start of a new paragraph
means that PTRACE_KILL functions also when the child is not stopped.

For Linux, inspection of the kernel source suggests that the intention
of the author was to make PTRACE_KILL work also when the child is not
stopped, but indeed, as you say, it doesnt work that way.

Since it is not clear what the right behaviour is, it is not clear
whether there is something to fix. Maybe the man page could use an
additional sentence, or removal of whitespace.

Andries

