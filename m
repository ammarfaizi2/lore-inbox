Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWBTAKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWBTAKA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWBTAKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:10:00 -0500
Received: from digitalimplant.org ([64.62.235.95]:60876 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932475AbWBTAJ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:09:59 -0500
Date: Sun, 19 Feb 2006 16:09:52 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@suse.cz>
cc: greg@kroah.com, "" <torvalds@osdl.org>, "" <akpm@osdl.org>,
       "" <linux-pm@osdl.org>, "" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH 5/5] [pci pm] Make pci_choose_state() use the
 real device state requested
In-Reply-To: <20060218155836.GF5658@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.50.0602191559310.8676-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171759190.30811-100000@monsoon.he.net>
 <20060218155836.GF5658@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 18 Feb 2006, Pavel Machek wrote:

> Hi!
>
> >  	case PM_EVENT_FREEZE:
> >  	case PM_EVENT_SUSPEND:
> > -		return PCI_D3hot;
> > +		if (msg.state && msg.state <= PCI_D3hot)
> > +			state = msg.state;
> > +		break;
> >  	default:
>
> Silently ignores wrong value passed-in by user. Not nice...

The value is bounded, so anything passed above PCI_D3hot is translated to
PCI_D3hot.

[ That's the best we can do since we can't report an error nicely because
the pci_choose_state() interface was poorly designed. The function must be
called by the drivers, and returns a pci_power_t. It is not expected to
fail, and the argument is usually passed unchecked to
pci_set_power_state().

It would have been much safer to have pci_device_suspend() in
drivers/pci/pci-driver.c call pci_choose_state() to translate the value.
That could easily verify the user input, and it could just pass the
translated state to the drivers, which would have been compatible with the
previous API and not required a change to every single PCI driver.. ]

Thanks,


	Pat

