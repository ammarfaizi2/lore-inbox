Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287502AbSAHA03>; Mon, 7 Jan 2002 19:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287499AbSAHA0Z>; Mon, 7 Jan 2002 19:26:25 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:24813 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S287516AbSAHAZN>;
	Mon, 7 Jan 2002 19:25:13 -0500
Date: Mon, 7 Jan 2002 16:25:10 -0800
Message-Id: <200201080025.QAA26731@napali.hpl.hp.com>
From: David Mosberger <davidm@hpl.hp.com>
To: linux-kernel@vger.kernel.org
cc: linux-ia64@linuxia64.org
Subject: can we make anonymous memory non-EXECUTABLE?
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-to: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The traditional intended behavior of Linux is that anonymous memory
has the EXECUTE permission turned on.  The reason I say "intended"
behavior is that there appears to be an old bug in the kernel in this
respect.  Specifically, the ELF data section is normally mapped with
READ+WRITE permission (no EXECUTE permission).  The initial break
value starts at the end of the bss segment and if that value does not
fall on a page boundary (usually it doesn't), it means that the first
few bytes allocated with sbrk() will NOT be EXECUTABLE.  Now, on x86
this doesn't matter, because READ permission implies RIGHT permission,
but on ia64 and any other architecture that has a separate EXECUTE
permission, this means that programs cannot rely on memory returned by
malloc() being executable.  There is obviously several ways to fix
this problem, but I'm wondering whether it's not time to just say NO
to turning on execute permission by default on anonymous memory.

I discussed this briefly with Linus and his comments are reproduced
below.  While I see Linus' points, I do think that turning off EXECUTE
permission on anonymous would improve the security in practice, if not
in theory.  But I'd be interested in other people's opinion.  Also, as
a practical matter, we currently have special hacks in the ia64 page
fault handler that are needed to work around performance problems that
arise from the fact that we map anonymous memory with EXECUTE rights
by default.  Those hacks avoid having to flush the cache for memory
that's mapped executable but never really executed.  So clearly there
are technical advantages to not turning on EXECUTE permission, even if
we ignore the security argument.

What I'm wondering: how do others feel about this issue?  Since x86
wont be affected by this, I'm especially interested in the opinion of
the maintainers of non-x86 platforms.

It seems to me that for portability reasons, dynamic code generators
should always do an mmap() call to ensure that the generated code is
executable.  If we can agree on this as the recommended practice, then
I don't see much of a problem with not turning on the EXECUTE right by
default.

Opinions?

	--david

--------------
Comments by Linus:

I would say that the BSS has to be mapped the same way brk() maps things.
They _are_ the same thing, after all - I consider "brk()" to be a system
call that just dynamically changes the BSS limits.

So I would say that we have a few options:

 - just explicitly make bss/brk() be non-executable, and tell Compaq that
   if they want to do dynamic code generation they should use an anonymous
   mapping with MAP_EXEC.

 - make both of them always be executable, and say "this is how x86 does
   it, security issues don't help", x86 is the Borg, and you _have_ been
   assimilated.

 - add a per-process flag (that gets copied at fork() and stays alive over
   exec()) that allows the system to decide between the two above
   dynamically on a process-per-process basis. We could default to the
   stricter thing, and people who aren't happy would just make a wrapper
   executable (no setuid needed) that sets the flag and executes whatever
   process it wants to run that needs to execute BSS.

Quite frankly, my personal preference is "We are the borg of x86" choice,
especially on ia64. The security issue with stack smashing etc is a
complete non-issue: if the program allows a buffer overrun it is insecure
whether EXEC is set or not.

But I suspect you should talk this over on ia64 lists and possibly people
like Alan &co. Feel free to quote this email.

			Linus
