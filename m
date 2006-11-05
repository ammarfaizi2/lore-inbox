Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161395AbWKER04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161395AbWKER04 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 12:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161401AbWKER04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 12:26:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28869 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161395AbWKER0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 12:26:55 -0500
Date: Sun, 5 Nov 2006 09:26:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Zachary Amsden <zach@vmware.com>, Benjamin LaHaise <bcrl@kvack.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
In-Reply-To: <200611051801.18277.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0611050920220.25218@g5.osdl.org>
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com> <200611050641.14724.ak@suse.de>
 <454D9A75.7010204@vmware.com> <200611051801.18277.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Nov 2006, Andi Kleen wrote:
> 
> > sti is expensive as well; iirc just as expensive on most processors as 
> > popf, 
> 
> On K8 STI is 4 cycles.

Your point being? On K8, popf was 12 cycles according to Zach. The 
conditional branch is going to be almost totally unpredictable, unless you 
inline it everywhere (it will be statically predictable in each individual 
location), but if you inline it, you'll be expanding a two-byte 
instruction sequence to something like 10 bytes with all the tests.

So you get a test, a unpredictable conditional jump, and the sti - and 
you'll end up with the cost being pretty much the same as the popf: only 
bigger and more complex.

That's a win, right?

> 99.9999% of all restore_flags just need STI.

Hell no. If you know it statically, you can already just do the 
"spin_lock_irq()"->"spin_unlock_irq()", and then you have the 
_unconditional_ sti.

The problem with that is that it's now a lot more fragile, ie you must 
know what the calling context was. We do do this, because it _is_ faster 
when it's unconditional, but you're optimizing all the wrong things.

Andi, one single bug is usually worth _months_ of peoples time and effort. 
How many CPU cycles is that? 

You need to learn that "stability and maintainability" is more important 
than trying to get a single cycle or two. Really. I'll do cycle tweaking 
too, but it needs to be something that is really obvious, or really 
important. 

			Linus
