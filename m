Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292256AbSBBJXa>; Sat, 2 Feb 2002 04:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292258AbSBBJXV>; Sat, 2 Feb 2002 04:23:21 -0500
Received: from turing.cs.hmc.edu ([134.173.42.99]:64963 "EHLO
	turing.cs.hmc.edu") by vger.kernel.org with ESMTP
	id <S292256AbSBBJXJ>; Sat, 2 Feb 2002 04:23:09 -0500
Date: Sat, 2 Feb 2002 01:27:05 -0800 (PST)
From: Nathan Field <nathan@cs.hmc.edu>
To: Daniel Jacobowitz <dan@debian.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Re: BUG: PTRACE_POKETEXT modifies memory in related
 processes
In-Reply-To: <20020202023940.A17031@nevyn.them.org>
Message-ID: <Pine.GSO.4.32.0202020024130.9858-100000@turing.cs.hmc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry then.  You didn't give any of this context in the original
> message.  Had you been using GDB - a reasonable assumption - my
> explanation would have been accurate.
	Thats okay, years ago I used to lurk on the lkml and I saw tons of
stupid questions. Had I seen my own message without knowing the background
I probably would have assumed the same things. The problem was when I
wrote it I didn't really have the context, I just knew the parent and
child were sharing the same memory space since. After I saw your response
I found out that it was almost impossible to get the problem to reproduce
under gdb. I was all set to write a mini-debugger to show the problem when
a friend suggested we just scan the kernel source.

> I've got the design mostly worked out to make GDB handle fork()
> better.  I just need to settle on a few details and find some time to
> finish it.
	Personally I'd love to offer to help you out, there are tons of
special cases that are really nasty to deal with that I could help you out
on. Unfortunatly I don't think my company would appreciate it, so all I
can really say is best of luck. It's a fun project, and it'll be
interesting to see how you do it. I've heard that strace can do it by
patching in an infinite loop after the syscall. I do it in a way that is
more arch indep, though only if you have a really capable debugger behind
you.

	Do you know if anyone has looked at improving the general
debugging interface? The solaris interface is just beautiful for things
like this. You can catch forks, vforks, exec's and so on without having to
do any crazy run-time modifications. It also works when you don't have
debugging symbols, which is my Achilles heel. If I can't tell where fork
is (think of a shell with a statically linked libc that's been stripped)
then I can't hope to catch it. Since many apps spawn shells which then
spawn other programs I'm just out of luck. Have you come up with a way to
work around this?

[snip silly part of patch]
> Why is this first half even necessary?  I don't see that it makes any
> difference.  Maybe I'm missing something.
	Oops, my mistake. That is a leftover from my first pass at fixing
the problem, and shouldn't be there. Sorry about that, I just submitted a
patch for what it took to get my system to work. I can take that out and
submit a new patch.

In fact, how about this:

--- ptrace.c.orig	Fri Feb  1 20:17:18 2002
+++ ptrace.c	Sat Feb  2 00:53:43 2002
@@ -173,6 +173,7 @@
 		put_page(page);
 		len -= bytes;
 		buf += bytes;
+		addr += bytes;
 	}
 	up_read(&mm->mmap_sem);
 	mmput(mm);

> That'll do it all right.  Might want to forward this patch (at least
> the latter bit) to Linus and Marcello to make sure they see it.
	Sure, I'm not a regular on the lkml, what email addresses should I
use to send the patches? Someone else suggested that I also send it to
Dave Jones, but I haven't been able to find an email address for Marcello
through google or in the one daily digest I've gotten so far.
	Dave Jones <davej@suse.de>
	Linus Torvalds <torvalds@transmeta.com>
The lkml FAQ at http://www.tux.ork/lkml seems to be a bit out of date on
this :)

	nathan

------------
Nathan Field  Root is not something to be shared with strangers.

"It is commonly the case with technologies that you can get the best
 insight about how they work by watching them fail."
        -- Neal Stephenson




