Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267501AbSLRWvl>; Wed, 18 Dec 2002 17:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267511AbSLRWvl>; Wed, 18 Dec 2002 17:51:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19723 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267501AbSLRWvk>; Wed, 18 Dec 2002 17:51:40 -0500
Date: Wed, 18 Dec 2002 14:57:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: "H. Peter Anvin" <hpa@transmeta.com>,
       Terje Eggestad <terje.eggestad@scali.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212181432470.1516-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212181448100.1516-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Btw, I'm pushing what looks like the "final" version of sysenter/sysexit 
for now. There may be bugs left, but all the known issues are resolved:

 - single-stepping over the system call now works. It doesn't actually see 
   all of the user-mode instructions, since the fast system call interface 
   does not lend itself well to restoring "TF" in eflags on return, but 
   the trampoline code saves and restores the flags, so you will be able 
   to step over the important bits.

   (ptrace also doesn't actually allow you to look at the instruction 
   contents in high memory, so gdb won't see the instructions in the
   user-mode fast system call trampoline even when it can single-step
   them, and I don't think I'll bother to fix it up).

 - NMI at the "wrong" time (just before first instruction in kernel 
   space) should now be a non-issue. The per-CPU SEP stack looks like a 
   real (nonpreemptable) process, and follows all the conventions needed 
   for "current_thread_info()" and friends. This behaviour is also 
   triggered by the single-step debug trap, so while I've obviously not 
   tested NMI behaviour, I _have_ tested the very same concept at that 
   exact point.

 - The APM problem was confirmed by Andrew to apparently be just a GDT 
   that was too small for the new layout.

This is in addition to the six-argument issues and the glibc address query
issues that were resolved yesterday.

			Linus

