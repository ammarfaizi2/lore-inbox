Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267504AbUHPKAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267504AbUHPKAf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267506AbUHPKAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:00:35 -0400
Received: from ohm.divmod.com ([198.49.126.192]:16532 "HELO divmod.com")
	by vger.kernel.org with SMTP id S267504AbUHPKAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:00:32 -0400
Subject: inconsistency in thread/signal interaction in 2.6.5 and previous
	vs. 2.6.6 and later (possibly a bug?)
From: Glyph Lefkowitz <glyph@divmod.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Divmod, LLC
Date: Mon, 16 Aug 2004 06:01:05 -0400
Message-Id: <1092650465.3394.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Content-Transfer-Encoding: 7bit
x-divmod-processed: Mon, 16 Aug 2004 10:00:31 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kernel People,

Firstly, here is a brief example of some code that behaves very
differently on 2.6.5 and 2.6.6:

http://www.twistedmatrix.com/users/glyph/signal-bug.c

I have verified that it says "Completed" on kernel 2.6.5, 2.6.3 and
2.6.1, and says "Died" on 2.6.6, 2.6.7 and 2.6.8.1, so I am pretty sure
the difference is between 2.5.6 and 2.6.6.

As far as I understand it, kernel 2.6.5 would not deliver a signal to
anyone upon thread termination, but kernel 2.6.6 will deliver a SIGHUP
to the process's main thread, if the multi-threaded process's
controlling terminal is a pty.

This is most likely a muddled explanation, and it is certainly
incomplete.  Please read the code to see what I mean.  I am not the sort
of person who would normally be posting to the kernel mailing list, or
even writing code in C, for that matter.

I upgraded to the debian kernel 2.6.7 from 2.6.5; this had the
unfortunate side-effect of breaking Emacs integration with my unit
tests.  It also seems to cause certain problems with the Conch SSH
server ( http://www.twistedmatrix.com/products/conch ) but I believe
emacs has rather a larger installed base.

Before anyone else has to tell me - yes, I am well aware that I should
not be sticking my hand into the signals/threads interaction blender if
I can avoid it, but in this case I can't :-).

On 2.6.5 and previous, the unit tests would run correctly; they all
passed.  On 2.6.7, the tests would run correctly *on a terminal*, but
they would fail about halfway through if run in a 'M-x compile' buffer
in emacs.  Coincidentally, they would fail at about the point where one
of the tests spawned a few threads to test the thread-safety of an API,
then immediately shut them down as part of the test-cleanup.  Kaboom.

If it helps to know, asynchronous processes in emacs (e.g. M-x compile,
eshell) will get a SIGHUP if a thread terminates, but synchronous
processes (e.g. M-x shell-command, C-c C-c in a Python buffer) will not.
The critical difference between these *seems* to be the creation of a
PTY for a controlling terminal.

I am sorry I cannot accompany this with a patch to fix it.  I am curious
though, is this even a bug, or just a stricter reading of some POSIX
threading standard?

