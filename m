Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbQKHR1I>; Wed, 8 Nov 2000 12:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129113AbQKHR06>; Wed, 8 Nov 2000 12:26:58 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37897 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129111AbQKHR0v>; Wed, 8 Nov 2000 12:26:51 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Pentium 4 and 2.4/2.5
Date: 8 Nov 2000 09:26:41 -0800
Organization: Transmeta Corporation
Message-ID: <8uc2ch$g3u$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10011061940200.18160-100000@master.linux-ide.org> <E13t7dG-0007KT-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E13t7dG-0007KT-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>
>Be careful with the intel patches. The ones I've seen so far tried to call the
>cpu 'if86' breaking several tools that do cpu model checking off uname. They
>didnt fix the 2GHz CPU limit, they use 'rep nop' in the locks which is
>explicitly 'undefined behaviour' for non intel processors and they use the
>TSC without checking it had one.

"rep nop" is definitely not undefined behaviour except in some older
Intel manuals. 

Do you actually know of a CPU where it doesn't work? Every single
intel-compatible CPU I know of has the rep prefixes as no-ops if they
aren't used (lock -> ILL being a later, documented, addition), and the
way the prefixes work it almost has to be that way.

As prefixes they can't be part of the instruction, because you can
legally have other prefixes in between the rep and the real instruction,
which means that any sane implementation will just set a flag when it
sees the prefix, and an instruction that doesn't care will just ignore
the flag.  So you'd almost have to do _extra_ work to make "rep nop"
fail, even if it used to be specified as "undefined". 

Standard 2.4.x will definitely be using "rep nop" unless somebody can
show me a CPU where it doesn't work (and even then I probably won't care
unless that CPU is also SMP-capable).  It's documented by intel these
days, and it works on all CPU's I've ever heard of, and it even makes
sense to me (*).

(*) Well..  More sense than _some_ instruction set extensions I've seen. 
After all, "repeat no-op" for a longer delay sounds almost logical. 
Certainly better than that IV == 15 thing, ugh ;)

Also, at least part of the reason Intel removed the TSC check was that
Linux actually seems to get the extended CPU capability flags wrong,
overwriting the _real_ capability flags which in turn caused the TSC
check on Linux to simply not work.  Peter Anvin is working on fixing
this. I suspect that Linux-2.2 has the same problem.

There's a few other minor details that need to be fixed for Pentium 4
features (aka " not very well documented errata"), and I think I have
them all except for waiting for Peter to get the capabilities flag
handling right.

So I suspect that we'll have good support for Pentium IV soon enough.. 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
