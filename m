Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVCNSyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVCNSyT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVCNSyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:54:18 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:38765 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261663AbVCNSxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:53:21 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: Partial fix! - Was: Re: [BUG report] UML linux-2.6 latest BK doesn't compile
Date: Sun, 13 Mar 2005 21:06:34 +0100
User-Agent: KMail/1.7.2
Cc: Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       lkml <linux-kernel@vger.kernel.org>
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk> <200503072044.49206.blaisorblade@yahoo.it> <200503080010.j280ABbc005264@ccure.user-mode-linux.org>
In-Reply-To: <200503080010.j280ABbc005264@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503132106.35599.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I think I finally solved this problem.

A note for Jeff: I forgot to send this email and complained to you because you 
didn't answer... Sorry Jeff.

However, I explained what I say here to him in chat and we agreed on the fix.

I'm sending this anyway... and I'm attaching the correct fix we discussed.

On Tuesday 08 March 2005 01:10, Jeff Dike wrote:
> blaisorblade@yahoo.it said:
> > a) wrong because you say __GNUC_PATCHLEVEL__ > 4 rather than >=

> Correct, this is now fixed.

> > b) wrong because for he the link failed on __bb_init_func at the
> > beginning. So  in the case you need to export BOTH symbols.

> Incorrect, the link failure was caused by trying to export __bb_init_func,
> which makes a reference to it, which was subsequently not being resolved.
No, the link failure was when linking the first object together in the final 
file.

The symbol was referred to by the wrappers inserted by GCC for gprof / 
gcov, not by the symbol exporting.

Quoting Anton:
> Yes.  I finally found a way to get it to compile.  Compiling without TT
> mode and WITHOUT static build it still fails with the same problem
> (__bb_init_func problem I already reported).  But compiling without TT
> but WITH static build the __bb_init_func problem goes away but instead I
> get a __gcov_init missing symbol in my modules.

And it was fixed when linking statically, as you see (because the symbol is 
not defined in dynamic libraries - don't know if this is a bug of glibc, I 
hope not).

What was needed was the addition of another EXPORT_SYMBOL, but it couldn't be 
added for everybody because it causes the build to fail for old compilers 
which don't export the symbol.

And "old compilers" include normal gcc 3.3.4 (I verified this on my Gentoo 
system).

Also, maybe adding a dependency on static linking for GCOV is needed, maybe.

After some successful testing (maybe I didn't test all cases), however, 
something strange happened: the build started failing because now GCC 
requires the GCOV options (-fprofile-arcs -ftest-coverage) even during 
linking (because the gcov helper functions are now in a separate library). I 
said "strange" because the same build succeeded with gcc 3.3.4, and I didn't 
understand the difference at first.

This required two changes:
- excluding the profiling options from the mk_* utilities.
- adding the GCOV options to linking (this is even documented now). I've 
retested that this wasn't needed with gcc 3.3.4 (and I guess older ones).

Finally, I got an unresolved symbol on __bb_fork_func, and I wasn't able to 
solve this (is it maybe a bug in libc or whatever? I don't know).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


