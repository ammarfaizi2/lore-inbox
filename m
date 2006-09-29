Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWI2U6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWI2U6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWI2U6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:58:38 -0400
Received: from mail.suse.de ([195.135.220.2]:58809 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750994AbWI2U6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:58:37 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-mm2
Date: Fri, 29 Sep 2006 22:58:24 +0200
User-Agent: KMail/1.9.3
Cc: Jim Cromie <jim.cromie@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609292236.15330.ak@suse.de> <20060929203227.GA5051@elte.hu>
In-Reply-To: <20060929203227.GA5051@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609292258.24546.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 September 2006 22:32, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > On Friday 29 September 2006 22:14, Ingo Molnar wrote:
> > > 
> > > * Andi Kleen <ak@suse.de> wrote:
> > > 
> > > > BTW I was planning to make LOCAL_APIC unconditional on i386 too like 
> > > > on x86-64.
> > > 
> > > please dont - embedded doesnt need it most of the time.
> > 
> > What do you mean with not need?  Local APIC is an infinitely better 
> > interface than PIC and faster. On embedded too this makes a lot of 
> > sense.
> 
> it's just not present or hardware-disabled.

The kernel won't use it then. Also on next years embedded systems
this will likely change.

> 
> > And a lot of modern systems don't even work anymore without APIC 
> > enabled because Windows uses it and the BIOS haven't been tested 
> > without it (e.g. you often find totally broken code paths in the AML 
> > for PIC mode)
> > 
> > The code size also isn't a good argument because the delta
> > isn't that big:
> > 
> >    text    data     bss     dec     hex filename
> > 3303894  694980  436420 4435294  43ad5e obj32-up/vmlinux
> > 3266532  665732  402372 4334636  42242c obj32-up-noapic/vmlinux
> > 
> > ~63K.
> 
> 63K???? You've got to be kidding. That's huge. That's ~10% of the 
> minconfig kernel. 

A large part of it is the ACPI support. Without that it's smaller:

   text    data     bss     dec     hex filename
2978333  640752  416100 4035185  3d9271 obj32-up-noacpi/vmlinux
2947808  612088  400292 3960188  3c6d7c obj32-up-noacpi-noapic/vmlinux

~30k

You might be able to do without ACPI on your embedded system.

> Even 1K would be bad. We did config hacks for half a K  
> win. 

<rant>

Sorry, but that's silly. I did some measurements and just tweaking a 
few dynamic allocation pigs saves you much more memory without 
uglifying the code. In fact in most configurations you can find dynamic 
users who need more than the complete kernel text - this means 
even if you got the kernel text down to 0 bytes you wouldn't save as 
much as simple tweaks in the dynamic pig.

I know it's easy to do size vmlinux and complain about bloat there, 
but that is really not where the real bloat is. Finding the 
real ones takes more effort of course.

And maintainability is much more important. Too many CONFIGs
just waste developer time and this one is particularly nasty
because it tends to break all the time.

And if you really want to make vmlinux smaller anyways you usually
get much better payoff by concentrating on inline functions than
uglifying the code with more CONFIGs. A few people did excellent
work on that recently and the kernel actually shrunk for most people, not
just some extreme config. But CONFIGs just 
cause everybody more work for usually very little payoff.

</rant>

-andi

