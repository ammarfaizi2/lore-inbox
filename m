Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVIGAA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVIGAA6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 20:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVIGAA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 20:00:58 -0400
Received: from smtp.istop.com ([66.11.167.126]:13710 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751150AbVIGAA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 20:00:57 -0400
From: Daniel Phillips <phillips@istop.com>
To: Roland Dreier <rolandd@cisco.com>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Tue, 6 Sep 2005 20:04:01 -0400
User-Agent: KMail/1.8
Cc: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com> <200509061819.45567.phillips@istop.com> <52ll29q190.fsf@cisco.com>
In-Reply-To: <52ll29q190.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509062004.01535.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 September 2005 18:28, Roland Dreier wrote:
>     Daniel> There are only two stacks involved, the normal kernel
>     Daniel> stack and your new ndis stack.  You save ESP of the kernel
>     Daniel> stack at the base of the ndis stack.  When the Windows
>     Daniel> code calls your api, you get the ndis ESP, load the kernel
>     Daniel> ESP from the base of the ndis stack, push the ndis ESP so
>     Daniel> you can get back to the ndis code later, and continue on
>     Daniel> your merry way.
>
>     [...]
>
>     Daniel> You will allocate your own stack once on driver
>     Daniel> initialization.
>
> I'm not quite sure it's this trivial.  Obviously there are more than
> two stacks involved, since there is more than one kernel stack!  (One
> per task plus IRQ stacks)  This is more than just a theoretical
> problem.  It seems entirely possible that more than one task could
> be in the driver, and clearly they each need their own stack.

Semaphore :-)

Do you expect this to be heavily contended?  On a very quick run through the 
code, it seems you don't hold any spinlocks going into the driver from 
process context.  Interrupts... they better fit into a 4K stack or it's game 
over.  Preemption while on the ndis stack... you can always disable 
preemption in this region, but the semaphore should protect you.  Task killed 
while preempted... I dunno. 

> So it's going to be at least a little harder than allocating a single
> stack for NDIS use when the driver starts up.
>
> I personally like the idea raised elsewhere in this thread of running
> the Windows driver in userspace by proxying interrupts, PCI access,
> etc.  That seems more robust and probably allows some cool reverse
> engineering hacks.

I expect the userspace approach will be a lot more work and a lot more 
overhead too, but then again it sounds like loads of fun.

Regards,

Daniel
