Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbTEOR6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 13:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264139AbTEOR6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 13:58:55 -0400
Received: from ida.rowland.org ([192.131.102.52]:31492 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264138AbTEOR6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 13:58:54 -0400
Date: Thu, 15 May 2003 14:11:44 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Paul Fulghum <paulkf@microgate.com>
cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, <johannes@erdfelt.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
In-Reply-To: <1053012368.2026.6.camel@diemos>
Message-ID: <Pine.LNX.4.44L0.0305151355290.1139-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 May 2003, Paul Fulghum wrote:

> I think I found the key to this whole problem:
> 
> Note:I mistakenly referred to the chipset as PIIX3
> in previous messages, in fact it is the PIIX4 (BX)
> 
> The PIIX4 errata states that false resume indications
> can be generated if CLK48 is active during an
> overcondition indication (OC[1..0]).
> 
> Sure enough, the USBPORTSC[12] registers constantly
> report a status of 0C80 which shows that both
> ports are showing overcurrent condition (which
> disables the associated port).
> 
> My guess is that HP deliberately tied the OC[1..0]
> inputs active to force the ports to a disabled state.
> 
> So checking for the case of both ports constantly
> in OC condition and disabled may be a reasonable
> way to either disable the controller altogether or 
> at least not do the wakeup/suspend shuffle.
> 
> Any comments?

That sounds like a believable explanation.  My copy of the generic UHCI
specification does not include the OC port status bits.  I'm guessing from
your mail they are either bit 10 or bit 11 of the PORTSC registers, can't
tell which.  Maybe they are an Intel-specific addition?  Or perhaps a more 
recent version of the spec has more information -- the one I've got is 1.1 
(March 1996).

Can you suggest a good way of detecting whether or not a controller is
part of a PIIX4 chipset, to indicate whether or not the OC bits are valid?  
Maybe the PCI vendor and product codes will have that information?  I'm
not sure it's safe to assume that any old host controller will have
meaningful values there; the spec just says "reserved" and doesn't
stipulate that they will always read as 0's.

Alan Stern

