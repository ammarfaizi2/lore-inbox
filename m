Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275993AbSIVBeA>; Sat, 21 Sep 2002 21:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276004AbSIVBeA>; Sat, 21 Sep 2002 21:34:00 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:15745 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S275993AbSIVBd7>; Sat, 21 Sep 2002 21:33:59 -0400
Date: Sat, 21 Sep 2002 18:38:53 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020922013853.GA3290@gnuppy.monkey.org>
References: <20020920215029.GB1527@gnuppy.monkey.org> <Pine.LNX.4.44.0209210643210.2441-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209210643210.2441-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 06:48:40AM +0200, Ingo Molnar wrote:
> actually, in the previous mail i've outlined a sensible way to help
> safepoints in the kernel, for the case of the 1:1 model. I'd not call that
> 'not easily addressed' :-)
> 
> there's an even more advanced way to expose preempted user contexts in the
> 1:1 model: by putting most of the the register info (which is now dumped
> into the kernel stack) into a page that is also mapped into user-space.
> This too introduces (constant) syscall entry/exit overhead, but can be
> done if justified.

Maybe mmapping a special device into memory ? /proc/satanic_procID_666* ???

A method needs to be considered, definitely. Getting some Sun/Blackdown folks on
this thread wouldn't be bad either.

I'm not exactly sure what Solaris does in this case, so it might be worth
investigating it so that this is conceptually regular across various Unix variants
to a certain degree.

It's also essential to have the run states along with the ucontext to determine
the validity of ucontext backing the thread. Obviously, being blocked in the
kernel on a IO request isn't going to result in any thing useable GC. And that's
because libc library calls are external symbols and don't preserve registers
across calls.  

Also, permission to the PTRACE* interface shouldn't conflict with debuggers...
Complete multithreaded debugging is important of course. I would expect GDB to be
modified so that it can get and examine those register values and thread run
states too.

Uh, the JVM also has a habit of also checksumming the register contents over a window
of time to see if a thread is actively running through its internal debugging
facilities... It shouldn't have to lock or suspend thread execution to examine it.
Now that I think of it, syscall overlay technique isn't going work, since nothing
of interest to the GC is going to be present in the ucontext, so the above suggest
of exporting the ucontext at syscall points isn't going to work.

More to come...

bill

