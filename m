Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVDEU6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVDEU6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVDEU4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:56:43 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:51894 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S262023AbVDEUxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:53:45 -0400
X-ORBL: [69.107.61.180]
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] USB glitches after suspend on ppc
Date: Tue, 5 Apr 2005 13:53:36 -0700
User-Agent: KMail/1.7.1
Cc: Colin Leroy <colin@colino.net>, linux-kernel@vger.kernel.org,
       debian-powerpc@lists.debian.org
References: <20050405204449.5ab0cdea@jack.colino.net>
In-Reply-To: <20050405204449.5ab0cdea@jack.colino.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504051353.36788.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 April 2005 11:44 am, Colin Leroy wrote:
> Hi,
> 
> There are known issues with USB after suspend/resume (D3 hot) on
> powerpc.

Also known fixes to some of them, which haven't yet been merged.
I'll repost these as followups to this message, to linux-usb-devel
and CC Colin.  They're in the 2.6.12-rc2-mm1 patchset.

To my understanding, such issues have been around for some time
now, although recent kernels have tossed monkey wrenches into
several other cases that previously worked just fine.  (Ergo those
nyet-merged patches...)


> For example, plugging or unplugging devices during sleep 
> results in oopses at resume; and one time out of two, the USB ports are
> unpowered on resume (because the registers think they are, and
> linux doesn't repower them. but they're not).
> 
> Both of these issues have patches available, patches that can be found
> there for example:
> 
> http://colino.net/ibookg4/usb-ohci-fixes.patch
> http://colino.net/ibookg4/usb-ehci-power.patch
> 
> What kind of work on these is needed so that they get in?

Briefly, given 2.6.12-rc2 plus the patches mentioned above,
find out what else is needed.

 * The first of them is Paul's patch, and I never got a
   response to the questions I asked him about it.

     - 2.6.12-rc2 does have the fix to check for HC_STATE_QUIESCING,
       which should supplant the need for a new "suspending" quirk.

     - And the first of those patches waiting merge does update the
       handling of IRQs in the PCI-to-USB glue.

     - So the main change from that patch which is unresolved is
       moving the PMAC-specific stuff up from the OHCI code into
       into the the usb/core/hcd-pci code.  Presumably you could
       do that?  I assume that it really is needed at that layer,
       though it'll only relate to OHCI cells on Apple ASICs.

 * As for the second, that looks to be a hardware-specfic issue
   that just wouldn't reproduce with the controllers I was using
   for PM testing.  What I'll do is wrap up an equivalent fix with
   some related EHCI updates for power switching, post that, and
   ask you to verify that it works (probably simplest to do that
   with OHCI non-modular and not loaded).

How's that sound?

- Dave
