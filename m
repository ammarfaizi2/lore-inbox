Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVFLPWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVFLPWY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 11:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVFLPWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 11:22:24 -0400
Received: from mail1.kontent.de ([81.88.34.36]:37771 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261492AbVFLPWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 11:22:18 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Wakko Warner <wakko@animx.eu.org>
Subject: Re: Problem found: kaweth fails to work on 2.6.12-rc[456]
Date: Sun, 12 Jun 2005 17:22:09 +0200
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050612004136.GA8107@animx.eu.org> <200506120957.55214.oliver@neukum.org> <20050612130527.GB9401@animx.eu.org>
In-Reply-To: <20050612130527.GB9401@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506121722.09813.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 12. Juni 2005 15:05 schrieb Wakko Warner:
> Oliver Neukum wrote:
> > Am Sonntag, 12. Juni 2005 02:41 schrieb Wakko Warner:
> > > After doing some testing, I believe a patch that went into rc4 broke kaweth.
> > > The kaweth driver itself did not change from rc2 through rc6.
> > > 
> > > As a test, I reverted a patch that went into rc4 which modified
> > > net/core/link_watch.c.  Once I compiled the kernel, my netgear EA101 works
> > > again.
> > > 
> > > The above is not cut'n'paste.  There was 1 other addition (an include) that
> > > I removed from the patch inorder to revert it.  The patch above was applied
> > > to 2.6.12-rc6 using -Rp1.  This is why I believe that kaweth is broken. 
> > > With my limited understanding of the kernel, it would appear that kaweth
> > > doesn't support netif_carrier_ok properly.  
> > > Anyway, I found what caused it to break, but at this point, I do not have
> > > the required knowledge to do a proper fix.
> > 
> > static void int_callback(struct urb *u, struct pt_regs *regs)
> > is supposed to handle the link state. Maybe it fails in your case. Could you
> > add a printk to this callback to check linkstate?
> 
> I don't believe my case is very specific.  I've tested this on 4 different
> systems with totally different configs.  If it is at all specific, I believe
> it would be with the network adapter itself.  I don't have any other usb
> adapters that use kaweth.
> 
> Can you tell me where I need to add the printks?

In static void int_callback(struct urb *u, struct pt_regs *regs):

	/* we check the link state to report changes */
	if (kaweth->linkstate != (act_state = ( kaweth->intbuffer[STATE_OFFSET] | STATE_MASK) >> STATE_SHIFT)) {
<------- HERE please a printk for detecting a link state change
		if (!act_state)
			netif_carrier_on(kaweth->net);
		else
			netif_carrier_off(kaweth->net);

		kaweth->linkstate = act_state;
	}

<----------- HERE the value of linkstate is important
resubmit:
	kaweth_resubmit_int_urb(kaweth, GFP_ATOMIC);

	Regards
		Oliver
