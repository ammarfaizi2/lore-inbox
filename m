Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVBBMSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVBBMSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 07:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVBBMSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 07:18:53 -0500
Received: from gizmo03bw.bigpond.com ([144.140.70.13]:11430 "HELO
	gizmo03bw.bigpond.com") by vger.kernel.org with SMTP
	id S262365AbVBBMSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 07:18:40 -0500
From: pageexec@freemail.hu
To: linux-kernel@vger.kernel.org
Date: Wed, 02 Feb 2005 22:18:27 +1000
MIME-Version: 1.0
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Reply-to: pageexec@freemail.hu
CC: Arjan van de Ven <arjan@infradead.org>, Peter Busser <busser@m-privacy.de>,
       "Theodore Ts'o" <tytso@mit.edu>
Message-ID: <420151B3.27974.D9F79C@localhost>
References: <200501311015.20964.arjan@infradead.org> <200501311357.59630.busser
In-Reply-To: <20050202001549.GA17689@thunk.org>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Umm, so exactly how many applications use multithreading (or otherwise
> trigger the GLIBC mprotect call), and how many applications use nested
> functions (which is not ANSI C compliant, and as a result, very rare)?

i think you're missing the whole point of paxtest. it's not about what
glibc et al. do or don't do. it's about what an exploit can do (by
virtue of forcing the exploited application to do something). if your
line of thinking was correct, then why didn't you also object to the
fact that the paxtest applications overflow their own stack/heap/etc?
or that they put 'shellcode' onto the stack/heap/etc and invoke it by
abusing a memory corrupting bug? surely no sane real-life application
does any of this.

so once again, let me explain what paxtest does. it tests PaX for its
claims. since PaX claims to be an intrusion prevention system, paxtest
tries to simulate said intrusions (in particular, we're talking about
exploiting memory corruption bugs). the stress is on 'simulate'. none
of the paxtest applications are full blown exploits. nor do they need
to be. knowing what PaX does (or claims to do), it's very easy to design
and write small applications that perform the core steps of an exploit
that may be able to break the protection mechanisms. i.e., any 'real'
exploit would eventually have to perform these core steps, so by ensuring
that they don't work (at least when the PaX claims stand) we can ensure
that no real life exploit would work either.

now let's get back to mprotect(), nested functions, etc. when an exploit
writer knows that the only barrier that prevents him from executing his
shellcode is a circumventible memory protection, then guess what, he'll
first try to circumvent said memory protection then execute his shellcode
as usual. since memory protection is controlled by mmap/mmprotect, his
goal will be to somehow force the exploited application to end up calling
these functions to get an executable region holding his shellcode.

your concerns would be valid if this was impossible to achieve by an
exploit, sadly, you'd be wrong too, it's possible to force an exploited
application to call something like dl_make_stack_executable() and then
execute the shellcode. there're many ways of doing this, the simplest
(in terms of lines of code) was chosen for paxtest. or put another way,
would you still argue that the use of the nested function trampoline
is sabotage whereas an exploit forcing a call to dl_make_stack_executable()
isn't? because the two achieve the exact same thing, they open up the
address space (or part of it, depending on the intrusion prevention
system) for shellcode execution.

one thing that paxtest didn't get right in the 'kiddie' mode is that
it still ran with an executable stack, that was not the intention but
rather an oversight, it'll be fixed in the next release. still, this
shouldn't leave you with a warm and fuzzy feeling about the security
of intrusion prevention systems that 'pass' the 'kiddie' mode but fail
the 'blackhat' mode, in the real life out there, only the latter matters
(if for no other reason, then for natural evolution/adaptation of
exploit writers).

