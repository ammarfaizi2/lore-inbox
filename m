Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266927AbUBEWFt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 17:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266943AbUBEWFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 17:05:49 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:5821 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S266927AbUBEWFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 17:05:40 -0500
Date: Thu, 5 Feb 2004 23:05:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bob Gill <gillb4@telusplanet.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.2 crazy mouse under heavy load
Message-ID: <20040205220536.GA14173@ucw.cz>
References: <1076014751.4682.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076014751.4682.22.camel@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 01:59:12PM -0700, Bob Gill wrote:
> The exception seems to be coming from
> linux-2.6.2/drivers/input/mouse/psmouse-base.c, specifically from
> 
> if (psmouse->state == PSMOUSE_ACTIVATED &&
>             psmouse->pktcnt && time_after(jiffies, psmouse->last +
> HZ/2)) {
>                 printk(KERN_WARNING "psmouse.c: %s at %s lost
> synchronization, throwing %d bytes away.\n",
>                        psmouse->name, psmouse->phys, psmouse->pktcnt);
>                 psmouse->pktcnt = 0;
>         }
> 
> 
> where (for me) HZ is 1804768000, and therefore HZ/2 is 902384000,  

This looks very wrong. HZ should be 1000 on a normal machine.
Maybe you were looking at jiffies?

> psmouse->pktcnt is 3, and (I assume) PSMOUSE_ACTIVATED is non-0 after
> boot.  I assume that pktcnt is fed by interrupt, and the problem then is
> that psmouse->last + HZ/2 blows past the jiffies value, causing the
> warning message to be issued.  When mouse service finally comes back,
> pktcnt is non-zero (and possibly whatever the maximum is that it will
> hold), and when it flushes, the mouse pointer goes nuts for a second. 
> The real problem then, is why does the sum of ps->last + HZ/2 grow to
> beyond the size of jiffies (or what is delaying the mouse service)?

Exactly. The if statement means "If no data arrived for more than half a
second, and we're in the middle of a packet, something is wrong - we
better should start from scratch."

The goal of that statement is to resynchronize the mouse data stream if
a byte is lost.

-----

There are two scenarios of this message appearing (assuming 4-byte
packets):

#1 Messages always appearing in pairs, and the sum being 4. This is a
delayed or lost interrupt. Since the driver polls the controller in
addition to servicing interrupts, if the controller has the byte,
regardless of whether an interrupt arrived, it'll be processed.

#2 Messages appearing single, with numbers from 1 to 3. This is a lost
byte. The controller either didn't receive the byte at all or something
very fishy happened.

> This is just a rough guesstimate of what is going on, but seems to fit
> the facts.   Cheers!
 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
