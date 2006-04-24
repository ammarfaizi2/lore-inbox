Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWDXWe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWDXWe0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWDXWe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:34:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11199 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751150AbWDXWeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:34:25 -0400
Date: Mon, 24 Apr 2006 15:34:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] irq: record edge-level setting
In-Reply-To: <20060424144155.7561fe8e@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0604241527060.3701@g5.osdl.org>
References: <20060424114105.113eecac@localhost.localdomain>
 <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org> <Pine.LNX.4.64.0604241203130.3701@g5.osdl.org>
 <1145908402.3116.63.camel@laptopd505.fenrus.org> <20060424201646.GA23517@devserv.devel.redhat.com>
 <1145911417.3116.69.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0604241354200.3701@g5.osdl.org>
 <20060424142243.519d61f1@localhost.localdomain> <1145915394.1635.57.camel@localhost.localdomain>
 <20060424144155.7561fe8e@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Apr 2006, Stephen Hemminger wrote:
> 
> Maybe that's why it never was done in the past, too much work and historical
> baggage.

It's messy. That whole ELCR register was mis-designed: you can change the 
edge/level detection with it, but since it _also_ changes the polarity of 
the signal, you can't actually do so from a sw angle, and it has to match 
the hardware. So you can't say "I want to treat this interrupt as level 
triggered", and just set the bit ;^/

To make matters worse, I wouldn't be in the least surprised if the ELCR 
register is totally ignored by many south-bridges for the internally 
generated interrupts (ie devices that are embedded in the SB), since the 
register really doesn't matter for them.

And it doesn't help that Intel mis-designed the edge-detection logic on 
the IO-APIC. On the old i8259, if you masked an interrupt and unmasked it, 
an active interrupt would always be seen as an edge, because the 
edge-detection was done _after_ masking. On the IO-APIC crap, the masking 
is done after edge-detection, so if you mask the APIC hardware level, and 
an edge happens, you'll never ever learn of it ever again.

I'm sure other system architectures have similar problems, but it's 
irritating.

			Linus
