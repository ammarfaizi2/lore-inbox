Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVA2Rh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVA2Rh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 12:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVA2Rh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 12:37:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14754 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261151AbVA2RhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 12:37:19 -0500
Date: Sat, 29 Jan 2005 12:37:04 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Rik van Riel <riel@redhat.com>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
Message-ID: <20050129173704.GM11199@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20050127101322.GE9760@infradead.org> <41F92721.1030903@comcast.net> <1106848051.5624.110.camel@laptopd505.fenrus.org> <41F92D2B.4090302@comcast.net> <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org> <41F95F79.6080904@comcast.net> <1106862801.5624.145.camel@laptopd505.fenrus.org> <41F96C7D.9000506@comcast.net> <Pine.LNX.4.61.0501282147090.19494@chimarrao.boston.redhat.com> <41FB2DD2.1070405@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FB2DD2.1070405@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 01:31:46AM -0500, John Richard Moser wrote:
> Finally, although an NX stack is nice, you should probably take into
> account IBM's stack smash protector, ProPolice.  Any attack that can
> evade SSP reliably can evade an NX stack; but ProPolice protects from
> other overflows.  Now I'm sure RH is over there inventing something that
> detects buffer overflows at compile time and misses or warns about the
> ones it can't identify:
> 
> if (strlen(a) > 4)
>   a[5] = '\0';
> foo(a);
> 
> void foo(char *a) {
>    char b[5];
>    strcpy(b,a);
> }
> 
> This code is safe, but you can't tell from looking at foo().  You don't
> get a look at every other object being compiled against this one that
> may call foo() either.  So compile time buffer overflow detection is a
> best-effort at best.

If strlen(a) > 4 above, then -D_FORTIFY_SOURCE={1,2} compiled program
will be terminated in the strcpy call.  At compile time it computes
that the strcpy call can fill in at most 5 bytes and if it copies more,
then it terminates.

> ProPolice protects local variables with 0 overhead; passed arguments
> with a few instructions; and the return pointer and stack frame pointer
> with a couple instructions.  At runtime.  Want to impress me?  Actually
> deploy ProPolice instead of showing up 3 years from now waving around
> your own patch that you wrote that half-impliments half of it.  If you
> want "something better," it's GPL, so grab it and start hacking.

__builtin_object_size () checking/-D_FORTIFY_SOURCE=n changes are (partly)
orthogonal to ProPolice.  There are exploits prevented by
-D_FORTIFY_SOURCE={1,2} checking and not ProPolice and vice versa.
Things that the former protects and the latter does not are e.g.
some non-automatic buffer overflows or heap overflows, some format string
vulnerabilities and for automatic variables e.g. those that don't
overflow into another function's frame, but just overwrite other local
variables in the same function.  ProPolice on the other side will detect
stack overflows that overflow into another function's frame, even if they
aren't done through string operations (<string.h>, s*printf, gets, etc.)
or if the compiler can't figure out what certain arguments to these
functions points to (and where) at compile time.

The ideas in IBM's ProPolice changes are good and worth
implementing, but the current implementation is bad.

FYI, you can find some details about -D_FORTIFY_SOURCE=n in
http://gcc.gnu.org/ml/gcc-patches/2004-09/msg02055.html

	Jakub
