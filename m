Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVCFB6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVCFB6X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 20:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVCFB6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 20:58:22 -0500
Received: from mta13.mail.adelphia.net ([68.168.78.44]:36499 "EHLO
	mta13.adelphia.net") by vger.kernel.org with ESMTP id S261289AbVCFB5r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 20:57:47 -0500
Message-ID: <422A639A.5090603@adelphia.net>
Date: Sat, 05 Mar 2005 20:57:46 -0500
From: Tom Horsley <tomhorsley@adelphia.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Tom Horsley <tomhorsley@adelphia.net>
Subject: ptrace and setuid problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, not a new security hole (exactly), more of a philosophy
question:

If I exec a setuid program under ptrace, I can read the image via
PEEKDATA requests. Could (or should) that be considered a security
hole?  Come to think of it, should any executable with no read
access (setuid or not) be debuggable where ptrace will be able to
peek at it even without read access?

Looking at most of the linux systems I've used, setuid program are
typically installed as execute only, not readable. The /proc files
are also readable only by the appropriate user, etc. Every attempt
seems to be made to prevent anyone from doing anything other than
just executing the program.  (This seems to have gotten more and
more draconian over time - at one time I couldn't readlink()
the exe file, but I could read the maps file and find the
executable name listed in there, thus digging up the exe name via
a backdoor.  In newer kernels I see I can't read the maps file
either, so as a debugger developer I'm reduced to digging through
the argv vector to try and deduce which program is running).

Wouldn't it make more sense to have setuid programs simply not be
ptraced?  Is there good cause to add a new even more draconian
restriction?  Perhaps put ptraced setuid programs in a special
state where no peek/poke stuff works (maybe all requests return
EPERM so the debugger can tell it has hit a setuid wall) and the
debugger has only two options: PTRACE_DETACH or PTRACE_KILL? If
detach was selected, the program could continue to execute as a
setuid program (since we know the debugger wasn't able to diddle
the program in any way, that should still be secure).

If a patch to implement this were to be generated, what would be
the odds of it being accepted? :-).

(I could try and watch any discussion this generates on the
archives, but probably best to CC me in any replies as I am not
subscribed to lkml).

Disclosure: My ulterior motive for bringing this up as a security
issue is to get the "detach and let run as setuid" feature to work
so I don't have to go to all the trouble of figuring out how to
patch the program to re-exec() itself so I can then detach and let
it run normally as a setuid program - which is what I really want
to happen in my debugger :-).

P.S. Sorry if this shows up twice, but I sent it originally about
three days ago and have yet to see it show up, so I'm trying
again from a different account.

