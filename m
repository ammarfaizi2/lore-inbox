Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422658AbWGNR2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWGNR2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422666AbWGNR2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:28:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422658AbWGNR2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:28:48 -0400
Date: Fri, 14 Jul 2006 10:28:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove volatile from nmi.c
In-Reply-To: <Pine.LNX.4.64.0607140757080.5623@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0607141017520.5623@g5.osdl.org>
References: <1152882288.1883.30.camel@localhost.localdomain>
 <Pine.LNX.4.64.0607140757080.5623@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jul 2006, Linus Torvalds wrote:
> 
> Now, there is a "reason" we'd want "endflag" to either be volatile, or 
> have the "set_wmb()", and that is that the code is incorrect in the first 
> place. 

Btw, and this may just be me, but I personally don't much like the 
"set_wmb()" macro. I think it should be removed.

I don't think we actually use it anywhere, and the thing is, it's not 
really useful. It is basically _always_ equivalent to

	var = value;
	smp_wmb();

except I think some architectures could _in_theory_ make the assignment be 
a "store with release consistency". The only architecture where that might 
make sense that I can think of is Itanium, and even there the ia64 
set_wmb() macro doesn't actually do that.

Yeah, the

	endflag = 1;
	smp_wmb();

is a bit longer, but is actually easier to understand, I think.

I suspect "set_wmb()" was added just from an incorrect sense of 
consistency with "set_mb()" (which I don't particularly like either, but 
at least that one makes a difference on a real platform, ie on x86 that 
"set_mb()" ends up being implemented as a single "xchg" instruction).

			Linus
