Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTKVTCH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 14:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbTKVTCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 14:02:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:34007 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262683AbTKVTCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 14:02:03 -0500
Date: Sat, 22 Nov 2003 11:02:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Barlow <dan@telent.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86: SIGTRAP handling differences from 2.4 to 2.6
In-Reply-To: <87k75ss1eb.fsf@noetbook.telent.net>
Message-ID: <Pine.LNX.4.44.0311221044480.2379-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 22 Nov 2003, Daniel Barlow wrote:
> 
> There is a difference between 2.4 (tested in 2.4.23-rc2) and 2.6
> (tested in 2.6.0-pre9) in the handling of "int 3" inside a SIGTRAP 
> handler.

Indeed.

The basic change is basically:

 - some signals are "thread synchronous", ie the thread _cannot_ continue 
   without taking them. Basically, any instruction fault does this, 
   since just returning would generally cause the instruction to just be 
   done again, and cause the same fault.

 - the difference between 2.4.x and 2.6.x is that in 2.4.x such a 
   thread-synchronous instruction will just blow through being blocked. So 
   even if you block them, they'll still happen. In 2.6.x, trying to block 
   a thread-synchronous signal will just cause the process to be killed 
   with that signal ("it can't be delivered, it can't be ignored, let's 
   just tell the user")

The reason for the change is that the 2.4.x behaviour ends up hiding bugs, 
and can cause surprising deadlocks in threaded programs. The 2.6.x 
behaviour is "You did something fundamentally wrong, just _die_ now".

> I'm not sure what the correct answer is, if indeed it's specified.
> For contrast, in FreeBSD 5.1 I'm told that the signal handler runs to
> completion and only on exit is it called again.

This works because "int 3" and "into" is what Intel calls a "trap" as
opposed to a "fault", and as such we _could_ delay handling the signal and
just continue along - when the exception happens, the CPU has already
executed the instruction, and the exception will return to _after_ the
instruction.

However, Linux will refuse to do that because delaying the SIGTRAP is 
pointless: 
 - you'd get it at the wrong spot, making it pointless
 - the wrong thread could get it if you just consider it a normal signal.

So Linux considers both "int 3" and "into" to be thread-synchronous, even 
though they are trivially recoverable. Which means that we have two 
options, and two options only: punch through the fact that the signal is 
blocked, or just say "that's wrong", and kill it.

NOTE NOTE NOTE!! If you actually _want_ the 2.4.x behaviour of recursive
signal invocation, you should just tell the kernel so: use the SA_NODEFER
flag to sigaction() to tell the kernel that you don't want to defer
recursive signals.

In short, the 2.6.x behaviour is the right one. 2.4.x was a strange
violation of the signal blocking, and I consider the FreeBSD behaviour to
be just bizarre.

And with 2.6.x, if you actually _want_ recursive signal handlers, you can 
do so (fairly portably, I might add - putting the SA_NODEFER flag there 
should make everybody do the same thing, even *BSD).

			Linus

