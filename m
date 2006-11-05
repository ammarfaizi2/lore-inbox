Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161361AbWKERUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161361AbWKERUg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 12:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161415AbWKERUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 12:20:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48067 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161361AbWKERUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 12:20:35 -0500
Date: Sun, 5 Nov 2006 09:20:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Benjamin LaHaise <bcrl@kvack.org>, Zachary Amsden <zach@vmware.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
In-Reply-To: <200611051754.11982.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0611050914030.25218@g5.osdl.org>
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com> <200611050641.14724.ak@suse.de>
 <Pine.LNX.4.64.0611050808090.25218@g5.osdl.org> <200611051754.11982.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Nov 2006, Andi Kleen wrote:
> 
> > - mispredicted branches on a P4 are potentially worse than  
> > the popf cost.
> 
> They are far less than 48 cycles. The P4 is not _that_ bad in this
> area.

You wanna bet? Use the newer P4 cores. A branch mispredict is over 20 
cycles, and I bet the "sti" isn't cheap either.

In other words, I suspect the difference between "popfl" and "conditional 
jump over sti" is basically zero - exactly because the sti isn't exactly a 
no-op.

(Enabling interrupts is actually much more complex than you'd expect. 
Interrupt delivery in a HT core is not simple in itself, and "sti" in many 
ways is actually more complex than "popf", because it has the additional 
"single-cycle interrupt shadow", ie the interrupt isn't actually enabled 
after the sti, it's enabled after the _next_ instruction after the sti. So 
from a uarch standpoint, "popf" is actually somewhat simpler.)

Anyway, what both you and Chuck seem to be missing is that trying to save 
a couple of CPU cycles is NOT WORTH IT, if it makes the code harder and 
more fragile. The "save eflags over context switch" that we do now is 
_obvious_ code. That's worth a lot in itself. And the costs of context 
switching isn't actually a couple of cycles - the real costs are all 
elsewhere.

			Linus
