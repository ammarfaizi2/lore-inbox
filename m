Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUCIIFu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 03:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbUCIIFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 03:05:50 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:45510
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261628AbUCIIFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 03:05:46 -0500
Message-ID: <404D7AC3.9050207@redhat.com>
Date: Tue, 09 Mar 2004 00:05:23 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ppc/ppc64 and x86 vsyscalls
References: <1078708647.5698.196.camel@gaston>
In-Reply-To: <1078708647.5698.196.camel@gaston>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> However, the actual "form" of those is a bit difficult to decide on. The
> problem is that just exposing a .so like x86 does is difficult. There
> will be much more functions exposed (maybe around 20) and for each of
> them, about 1 to 4 or 5 variations depending on the CPU we are running
> on, but also depending on the current process beeing 32 or 64 bits.

This is no reason for not using the DSO form.  The userlevel code finds
the vDSO via the auxiliary vector.  By passing up different values for
32 and 64 bit processes you easily handle the last problem.

Many functions are no real issue either.  It not inefficient to use the
symbol table.

The only issue is that the vDSO should (IMO must) be position
independent.  You certainly want to map the same copy in each address
space.  This means the symbol table cannot contain addresses, only offsets.



> They are all very simple leaf functions though. The "easy" way would
> be to just have some kind of branch table code can "bal" to directly,
> that or an exception-like design, which every function at an 0xn00
> offset (with possible branch to some scratch space in the rare case

This means adding a multiplexer in the vDSO while the caller knows
exactly which function is wanted.  Sure, it's possible and quite easy to
implement.

If you want it more complicated you could do it as I suggested for x86.
 Add absolute symbols to the symbol table, have the libc use the dlsym()
equivalent to determine whether the symbol is defined.  If it is, it'll
return an offset which then can be used for the jump.  ppc64 function
descriptors can certainly be handled.

The results of the dlsym() calls would be cached so that it only happens
once for each symbol.  And since the soname of the vdso is known, one
doesn't even have to look in the global scope but instead directly in
the vdso's symbol table.

This all would definitely need changes in libc and ld.so.  But I guess
it'll work.


> where a given implementation may overflow). The kernel could esily
> "build" the pages based on which implementation is to be used on a
> given CPU & process context.

That's easily doable with a real DSO.



> However, the above makes things more difficult for userland, the big
> problem as I was told by Alan Modra will be the lack of CFI informations
> for stack unwinding on exceptions.

Why lack?  As a real DSO the vDSO can use the normal unwind info
handling userlevel DSOs use, too.  I do not see a reason which this
cannot work.  The unwind info for DSOs is position-independent so it
should work just fine.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
