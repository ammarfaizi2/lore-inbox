Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265411AbTIFIYI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 04:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTIFIYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 04:24:08 -0400
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:4548
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S265411AbTIFIYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 04:24:03 -0400
To: Jan Hubicka <jh@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use -fno-unit-at-a-time if gcc supports it
References: <sqnW.3zE.13@gated-at.bofh.it> <sqHd.3Yj.1@gated-at.bofh.it> <srtA.53H.1@gated-at.bofh.it> <sFmW.78P.13@gated-at.bofh.it>
From: David Mosberger-Tang <David.Mosberger@acm.org>
Date: 06 Sep 2003 01:10:57 -0700
In-Reply-To: <sFmW.78P.13@gated-at.bofh.it>
Message-ID: <ugbrty49ri.fsf@panda.mostang.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For what it's worth, it was straight-forward to get the ia64 linux
kernel to compile & boot with the latest gcc snapshot.  I could make a
patch, if anyone cares, but it was mostly trival stuff: a small
cleanup in init_task.c and a few changes in init.h/compiler.h to use
"attribute ((used))".

Even the wait-channels seem to come out right, though I'm not sure
what's being done there is guaranteed to continue to work as the
compiler gets more aggressive...

	--david
--
Interested in learning more about IA-64 Linux?  Try http://www.lia64.org/book/

>>>>> On Sat, 06 Sep 2003 09:10:10 +0200, Jan Hubicka <jh@suse.cz> said:

  >> On Fri, 2003-09-05 at 11:17, Andreas Jaeger wrote:
  >> 
  >> 
  >> > Since unit-at-a-time has better inlining heuristics the better
  >> way is > to add the used attribute - but that takes some time.
  >> The short-term > solution would be to add the compiler flag,
  >> 
  >> Won't we get a linker error if a static symbol is used but
  >> optimized-away?  It shouldn't be hard to fix the n linker errors
  >> that crop up.

  Jan> Yes, you get linker error.  You may also run into
  Jan> misscompilation assuiming that function is static and it is
  Jan> both called by hand in asm and by function call and there is
  Jan> missing attribute used and asmlinkage definition.  In that case
  Jan> GCC would conclude to change into register calling convention
  Jan> on i386 breaking asm code.

  Jan> I would expect this to be rare as functions tends to be used
  Jan> either by assembly or by normal code but not by both.
  >>  And why are we using static symbols in inline assembly outside
  >> of the compilation scope?

  Jan> The toplevel asm statements are common source of this at least
  Jan> in glibc.  I didn't look much into the kernel sources.

  Jan> I would be very happy if someone did look on that.  It may be
  Jan> well possible that implementing tricks you do currently with
  Jan> toplevel asm staements would need further extensions in GCC now
  Jan> and it would be nice to know about that.

  Jan> For instance it used to be possible to force function to go
  Jan> into given section by changing the section by hand, but now you
  Jan> have to use section attribute (that is cleaner anyway)
  >>  Anyhow, if it generates an error, this isn't hard to fix.
  >> 
  >> Here is the start...
  >> 
  >> Robert Love
  >> 
  >> 
  >> --- linux-rml/include/linux/compiler.h Fri Sep 5 11:57:56 2003
  >> +++ linux/include/linux/compiler.h Fri Sep 5 12:02:02 2003 @@
  >> -74,6 +74,19 @@ #define __attribute_pure__ /* unimplemented */
  >> #endif
  >> 
  >> +/* + * As of gcc 3.2, we can mark a function as 'used' and gcc
  >> will assume that, + * even if it does not find a reference to it
  >> in any compilation unit.  We + * need this for gcc 3.4 and
  >> beyond, which can optimize on a program-wide + * scope, and not
  >> just one file at a time, to avoid static symbols being + *
  >> discarded.  + */ +#if (__GNUC__ == 3 && __GNUC_MINOR__ > 1) ||
  >> __GNUC__ > 3 +#define __attribute_used__ __attribute__((used))
  >> +#else +#define __attribute_used__ /* unimplemented */ +#endif +
  Jan> I believe there is little trick - attribute used works either
  Jan> for variables or functions.  Functions can be marked as used
  Jan> only for GCC 3.4+ if I am right, so you may need
  Jan> __attribute_used_function__ and __attribute_used_variable__
  Jan> macros for that.

  Jan> Honza
  >> /* This macro obfuscates arithmetic on a variable address so that
  >> gcc shouldn't recognize the original var, and make assumptions
  >> about it */ #define RELOC_HIDE(ptr, off) \
  >> 
  >> 
  Jan> - To unsubscribe from this list: send the line "unsubscribe
  Jan> linux-kernel" in the body of a message to
  Jan> majordomo@vger.kernel.org More majordomo info at
  Jan> http://vger.kernel.org/majordomo-info.html Please read the FAQ
  Jan> at http://www.tux.org/lkml/
