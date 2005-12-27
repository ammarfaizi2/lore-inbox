Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVL0R2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVL0R2F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 12:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVL0R2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 12:28:05 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:11349 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751131AbVL0R2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 12:28:03 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [PATCH] USB_BANDWIDTH documentation change
Date: Tue, 27 Dec 2005 08:57:34 -0800
User-Agent: KMail/1.7.1
Cc: Alan Stern <stern@rowland.harvard.edu>, Bodo Eggert <7eggert@gmx.de>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0512261731001.10595-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0512261731001.10595-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512270857.35505.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 December 2005 2:35 pm, Alan Stern wrote:
s.
> 
> CONFIG_USB_BANDWIDTH isn't _really_ needed.

I think it was there historically because the first implementations
didn't work correctly.  In fact, the model underlying that current
usb_check_bandwidth() call is incorrect ... reservations for periodic
bandwidth (isochronous and interrupt transfers) are per-endpoint,
not per-urb.


> What it does (or rather, what  
> it would do if it worked properly) is prevent the kernel from 
> overcommitting on USB bandwidth.

It's also completly ignored for

 - ohci-hcd, which never overcommits;
 - sl811-hcd, works just like ohci in that respect;
 - isp116x-hcd, ditto;
 - ehci-hcd, can't risk overcommit with transaction translators(*);

The only HCDs that use usb_check_bandwidth() are the CRIS HCD
(which, last I heard, neither built nor, after fixing build errors,
worked) and UHCI.  Which is why this patch is incorrect ...

The long term solution is to get rid of that CONFIG_ symbol and
the code backing it, and then have all the HCD properly reserve
periodic bandwidth, using a per-endpoint approach.

- Dave

(*) The issues folk have mentioned with bandwidth reservation for
    EHCI are more "full and low speed devcies can't use all the
    available transaction translator bandwidth" than anything else.
    As a rule high speed devices don't see such issues ... only the
    needing more complex scheduling models than usb_check_bandwidth
    supports, just to work -- in even simple scenarios.  Which is why
    EHCI never has/will use the code now protected by USB_BANDWIDTH.


