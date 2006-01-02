Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWABTpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWABTpE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 14:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWABTpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 14:45:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22153 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750982AbWABTpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 14:45:01 -0500
Date: Mon, 2 Jan 2006 11:41:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jakub Jelinek <jakub@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Krzysztof Halasa <khc@pm.waw.pl>,
       mingo@elte.hu, bunk@stusta.de, arjan@infradead.org,
       tim@physik3.uni-rostock.de, davej@redhat.com,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
In-Reply-To: <20060102191720.GI22293@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.64.0601021130300.3668@g5.osdl.org>
References: <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
 <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
 <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org>
 <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu>
 <m3ek3qcvwt.fsf@defiant.localdomain> <20060102110341.03636720.akpm@osdl.org>
 <20060102191720.GI22293@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Jan 2006, Jakub Jelinek wrote:
> 
> Where does this certainity come from?  gcc-3.x (as well as 2.x) each had
> its own heuristics which functions should be inlined and which should not.
> inline keyword has always been a hint.

NO IT HAS NOT.

This is total revisionist history by gcc people. It did not use to be a 
hint. If you asked for inlining, you got it unless there was some 
technical reason why gcc couldn't inline it (ie recursive inlining, and 
trampolines and some other issues). End of story. 

So don't fall for the "hint" argument. It's simply not true.

At some point during gcc-3.1, gcc people changed it to be a hint, and did 
so very badly indeed, where functions that really needed inlining (because 
constant propagation made them go away) were not inlined any more. As a 
result, we do

	#define inline   inline __attribute__((always_inline))

in <linux/compiler-gcc3.h> exactly because gcc-3.1 broke so badly.

And nobody sane will argue that we would _ever_ not do that. gcc-3 was 
just too broken. Some architectures (sparc64, MIPS, s390) ended up trying 
to tune the inlining limits by hand (usually making them effectively 
infinitely large), but the basic rule was that gcc-3 inlining was just not 
working.

It may have improved in later gcc-3 versions, and apparently it's getting 
better in gcc-4. And that's the only thing we're discussing: whether to 
let gcc _4_ finally make some inlining decisions.

And people are nervous about it, exactly because the gcc people have 
historically just changed what "inline" means, with little regard for 
real-life code that uses it. And then they have this revisionist agenda, 
trying to change history and claiming that it's always been "just a hint". 
Despite the fact that the gcc manual itself very much said otherwise (I'm 
sure the manuals have been changed too).

		Linus
