Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWFBBxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWFBBxe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 21:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWFBBxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 21:53:34 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:43881 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751079AbWFBBxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 21:53:34 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] USB devices fail unnecessarily on unpowered hubs
Date: Thu, 1 Jun 2006 18:53:30 -0700
User-Agent: KMail/1.7.1
Cc: David Liontooth <liontooth@cogweb.net>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel@vger.kernel.org
References: <20060601030140.172239b0.akpm@osdl.org> <20060601164327.GB29176@kroah.com> <447F8057.4000109@cogweb.net>
In-Reply-To: <447F8057.4000109@cogweb.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606011853.31277.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 June 2006 5:03 pm, David Liontooth wrote:
> 
> However, obeying the USB power rules is not an end in itself -- the
> relevant question is the minimum power the device requires to operate
> correctly and without damage.

We don't know the minimum, or much care about it since the minimum is
generally not what gets drawn.

We know the maximum, which is declared in the configuration descriptor.
And we don't know how much of that maximum a given device uses at any
given moment ... ergo, power budgeting assumes the worst case.


> The MaxPower value does not appear to be a reliable index of this. My
> USB stick has a MaxPower value of 178mA and works flawlessly off an
> unpowered hub.

So you're saying that four of those can work off the same hub?  Or
just that one of them can draw two ports' worth of current, because
of the fact that current-limiting is usually on the upstream link,
not individual downstream ones?  (If indeed there is current limiting
and/or overcurrent handling in that hub ...)  Try that experiment,
and put four on one hub ... now write critical data to all of them
at the same time.


> What are the reasons not to do this? What happens if a USB stick is
> underpowered to one unit? Nothing? Slower transmission? Data loss? Flash
> memory destruction? If it's just speed, it's a price well worth paying.

You mis-understand what's going on.  There's a power budget, and if
it gets exceeded then "overcurrent" conditions can happen ... leading
to errors, disconnection, data loss, and yes potentially even memory
destruction; those are all device-specific failure modes, which are
by definition out-of-spec.

The reason to enforce the power budget is that devices guarantee they'll
behave to spec if they can draw that much current.  And if they can't
draw enough current, all those rude failure modes happen.  Devices
enter brown-out modes if you're lucky, or maybe the hub will cleanly shut
things down before much nastiness happens.  The budget is analagous
to a circuit breaker; exceed it and things shut off, which is safer 
than most alternatives.


> This is a great opportunity for a small exercise in empathy, utilizing
> that little long-neglected mirror neuron.

Exactly.  Preventing random glitchey failure modes makes everyone's
experience a lot better.  It's the same reason to fix driver races;
they may not happen all that often, but when they do happen the
result can be disastrous.

- Dave

