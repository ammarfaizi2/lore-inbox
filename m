Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVDFRUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVDFRUj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 13:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVDFRUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 13:20:39 -0400
Received: from colino.net ([213.41.131.56]:41713 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262256AbVDFRUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 13:20:18 -0400
Date: Wed, 6 Apr 2005 19:20:07 +0200
From: Colin Leroy <colin@colino.net>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sf.net,
       debian-powerpc@lists.debian.org
Subject: Re: [linux-usb-devel] USB glitches after suspend on ppc
Message-ID: <20050406192007.7f71c61d@jack.colino.net>
In-Reply-To: <200504051353.36788.david-b@pacbell.net>
References: <20050405204449.5ab0cdea@jack.colino.net>
	<200504051353.36788.david-b@pacbell.net>
X-Mailer: Sylpheed-Claws 1.9.6cvs27 (GTK+ 2.6.4; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Apr 2005 at 13h04, David Brownell wrote:

Hi, 

> > There are known issues with USB after suspend/resume (D3 hot) on
> > powerpc.
> 
> Also known fixes to some of them, which haven't yet been merged.
> I'll repost these as followups to this message, to linux-usb-devel
> and CC Colin.  They're in the 2.6.12-rc2-mm1 patchset.
> 
> To my understanding, such issues have been around for some time
> now, although recent kernels have tossed monkey wrenches into
> several other cases that previously worked just fine.  (Ergo those
> nyet-merged patches...)
> 
> 
> > For example, plugging or unplugging devices during sleep 
> > results in oopses at resume; and one time out of two, the USB ports
> > are unpowered on resume (because the registers think they are, and
> > linux doesn't repower them. but they're not).
> > 
> > Both of these issues have patches available, patches that can be
> > found there for example:
> > 
> > http://colino.net/ibookg4/usb-ohci-fixes.patch
> > http://colino.net/ibookg4/usb-ehci-power.patch
> > 
> > What kind of work on these is needed so that they get in?
> 
> Briefly, given 2.6.12-rc2 plus the patches mentioned above,
> find out what else is needed.
> 
>  * The first of them is Paul's patch, and I never got a
>    response to the questions I asked him about it.
> 
>      - 2.6.12-rc2 does have the fix to check for HC_STATE_QUIESCING,
>        which should supplant the need for a new "suspending" quirk.
> 
>      - And the first of those patches waiting merge does update the
>        handling of IRQs in the PCI-to-USB glue.
> 
>      - So the main change from that patch which is unresolved is
>        moving the PMAC-specific stuff up from the OHCI code into
>        into the the usb/core/hcd-pci code.  Presumably you could
>        do that?  I assume that it really is needed at that layer,
>        though it'll only relate to OHCI cells on Apple ASICs.
> 
>  * As for the second, that looks to be a hardware-specfic issue
>    that just wouldn't reproduce with the controllers I was using
>    for PM testing.  What I'll do is wrap up an equivalent fix with
>    some related EHCI updates for power switching, post that, and
>    ask you to verify that it works (probably simplest to do that
>    with OHCI non-modular and not loaded).
> 
> How's that sound?

Nice :)

Ok, here are the results of my tests with 2.6.12-rc2 and the patches
you sent me applied:

- plug USB device, sleep, unplug USB device, resume: no more oops
- sleep, plug in USB device: no oops, but it wakes the laptop up for a
few seconds; then, it goes back to sleep. No oops on second resume. I
can live with that :)

- once out of two resumes, resume leaves the ports unpowered; so I still
need my usb-ehci-power.patch that re-powers ports unconditionnaly.


-- 
Colin
