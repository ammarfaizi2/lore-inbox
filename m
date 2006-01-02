Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWABTQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWABTQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 14:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWABTQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 14:16:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36484 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750969AbWABTQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 14:16:01 -0500
Date: Mon, 2 Jan 2006 11:12:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
In-Reply-To: <m3ek3qcvwt.fsf@defiant.localdomain>
Message-ID: <Pine.LNX.4.64.0601021105000.3668@g5.osdl.org>
References: <20051229224839.GA12247@elte.hu> <1135897092.2935.81.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
 <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
 <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
 <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org>
 <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu>
 <m3ek3qcvwt.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Jan 2006, Krzysztof Halasa wrote:
> 
> For example, I add "inline" for static functions which are only called
> from one place.

That's actually not a good practice. Two reasons:

 - debuggability goes way down. Oops reports give a much nicer call-chain 
   and better locality for uninlined code.

 - Gcc can suck at big functions with lots of local variables. A 
   function call can be _cheaper_ than trying to inline a function, 
   regardless of whether it's called once or many times. I've seen 
   functions that had several silly (and unnecessary) spills suddenly 
   become quite readable when they were separate functions.

   More importantly, the "inline" sticks around. Later on, the function is 
   used for some other place too, and the inline doesn't get removed.

The second "the inline sticks around" case is something that happens to 
helper functions too. They started out as trivial macros in a header file, 
but then they get converted to an inline function because they get more 
complex, and eventually it grows a new hook. Suddenly what used to 
generate two instructions generates ten instructions and a call, and would 
have been much better off being uninlined in a .c file.

So inlines that make sense at one point have a tendency to _not_ make 
sense a year or two later. 

I suspect we'd be best off removing almost all inlines, both from C files 
and headers. There are a few cases where inlining really helps: the 
function really ends up being just a few instructions, and it's really 
just a wrapper around a simpler calling convention or an inline assembly, 
or it's called with constant arguments that are better left off simplified 
at compile-time. Those are the cases where inlining really helps.

(Of course, then there's ia64. Which wants inlining just because..)

		Linus
