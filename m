Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265649AbUFXP1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUFXP1P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265633AbUFXP0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:26:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:46756 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265590AbUFXP0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:26:14 -0400
Date: Thu, 24 Jun 2004 08:25:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jakub Jelinek <jakub@redhat.com>
cc: Paul Jackson <pj@sgi.com>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: using gcc built-ins for bitops?
In-Reply-To: <20040624103657.GV21264@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0406240819300.1688@ppc970.osdl.org>
References: <20040624070936.GB30057@devserv.devel.redhat.com>
 <20040624023109.6213c1ce.pj@sgi.com> <20040624103657.GV21264@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Jun 2004, Jakub Jelinek wrote:
> > 
> > As to your primary question - is this worth doing - I don't have
> > an answer.
> 
> It is, for 2 reasons:
> 1) unlike __asm, GCC knows how to schedule the instructions in the builtins
> 2) GCC will handle stuff like ffz (16) at compile time rather than runtime

I'd argue that unless the gcc code can be shown to be clearly better, it 
is NOT worth doing.

Adding support for built-ins generates a noticeable maintenance burden, 
since we'll still have to support older gcc's and architectures where gcc 
does WORSE than we do. And quite frankly, I doubt you'll find any cases 
where gcc does any better in any measurable way.

In other words, the rule about gcc builtins should be:

 - use them only if they are old enough that the huge majority (possibly 
   all) of users get them. This is partly because gcc has frankly been 
   buggy, and often makes assumptions that simply may not be true for the 
   kernel (ie "it's ok to use library routines").

 - only use them if you can show a measurable improvement. Theoretical 
   arguments simply don't count. Theoretical arguments is why gcc-3.x is 
   a lot slower than 2.95 and is apparently still not generating
   appreciably better code for the kernel (and no, don't bother pointing
   me to spec runs, I just don't care. The kernel is what I care about).

So far, the only case where they have been worth it is likely the 
"memcpy()" stuff, and even there our previous macros were doing an almost 
equivalent job (but were arguably so ugly that it was worth making the 
change).

For something like ffs/popcount/etc, I do not see _any_ point to compiler 
support. There just aren't any kernel uses that make it worth it. Sounds 
like a total micro-optimization for some spec benchmark.

		Linus
