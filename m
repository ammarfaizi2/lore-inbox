Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275041AbRJFOp6>; Sat, 6 Oct 2001 10:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275173AbRJFOps>; Sat, 6 Oct 2001 10:45:48 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:13134
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S275041AbRJFOp3>; Sat, 6 Oct 2001 10:45:29 -0400
Message-Id: <200110061445.f96Ej5S01591@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: paulus@samba.org
cc: "David S. Miller" <davem@redhat.com>, jes@sunsite.dk,
        James.Bottomley@HansenPartnership.com, linuxopinion@yahoo.com,
        linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address 
In-Reply-To: Message from Paul Mackerras <paulus@samba.org> 
   of "Sat, 06 Oct 2001 22:18:42 +1000." <15294.63138.941581.771248@cargo.ozlabs.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Oct 2001 09:45:05 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

paulus@samba.org said:
> I look at all the hash-table stuff in the usb-ohci driver and I think
> to myself about all the complexity that is there (and I haven't
> managed to convince myself yet that it is actually SMP-safe) and all
> the time wasted doing that stuff, when on probably 95% of the machines
> that use the usb-ohci driver, the hashing stuff is totally
> unnecessary.  I am talking about powermacs, which don't have an iommu,
> and where the reverse mapping is as simple as adding a constant.

> That was my second argument, which you didn't reply to - that doing
> the reverse mapping is very simple on some platforms, and so the right
> place to do reverse mapping is in the platform-aware code, not in the
> drivers.  On other platforms the reverse mapping is more complex, but
> the complexity is bounded by the complexity that is already there in
> drivers like the usb-ohci driver. 

This is precisely my point as well:  You've made all the drivers that must be 
able to do this type of mapping assume the worst case because we cannot now 
have any window into the iommu if there is one.

Worse still, every driver that needs this feature is doing it on its own, so 
the code for doing this in usb-ohci is different from the code in the 
sym53c8xx driver etc.  We're now duplicating this fairly subtle and complex 
code all over the driver base.

At the very least, providing an API to do this will get us away from all the 
error prone duplication.  And if it's going to be an API, it might as well be 
architecture specific and iommu aware so it functions in the simplest and 
fastest way.

davem@redhat.com said:
> The argument against it is that if you provide such an easy way out,
> people will just blindly transform bus_to_virt/virt_to_bus without
> considering more straightforward methods when they exist. 

> I can not even count on one hand how many people I've helped
> converting, who wanted a bus_to_virt() and when I showed them how to
> do it with information the device provided already they said "oh wow,
> I never would have thought of that".  That process won't happen as
> often with the suggested feature. 

I agree that some people are very prone to abusing the tools provided to them. 
 I cannot agree that this is a good reason not to provide the tools in the 
first place.  This is the type of argument usually heard from lawmakers and 
politicians.  The linux community is better than that:  we have a review 
process for new drivers.  We even have a bunch of people who trawl through the 
old code looking for mistakes and problems who would probably be more that 
willing to send in patches for abuse of this API.  Can we not educate the 
community (document the API properly) and rely on it to make the correct 
choices?

James Bottomley


