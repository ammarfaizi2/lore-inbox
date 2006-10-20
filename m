Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992504AbWJTFnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992504AbWJTFnQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 01:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992508AbWJTFnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 01:43:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:2241 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S2992504AbWJTFnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 01:43:15 -0400
Subject: Re: [PATCH] Add device addition/removal notifier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <20061020044454.GA8627@kroah.com>
References: <1161309350.10524.119.camel@localhost.localdomain>
	 <20061020032624.GA7620@kroah.com>
	 <1161318564.10524.131.camel@localhost.localdomain>
	 <20061020044454.GA8627@kroah.com>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 15:42:59 +1000
Message-Id: <1161322979.10524.143.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, as long as you all agree that this does change the behavior, it's
> fine with me :)

I should probably split the patch in two: One that does that behaviour
change (I already have an Acked-by: Len Brown for that one even :) and
one adding that notifier.

> Ok, then perhaps you just want a bus specific callback for the devices
> on that bus?  That would be much simpler and keep you from having to do
> that mess with the different tests of bus type.
>
> Actually, that's the only thing that really makes sense here, now that I
> think about it, the platform_notify doesn't really make any sense...

Well... people already use it and go check the bus types :)

Having a notifier queue per bus type is a bit harder though because bus
types are generally allocated statically and thus we would need to find
them all in the kernel to add a proper static initialisation for the
notifier queue... bus_register() is not a good spot to do it because
platform code might want to register for bus types before those bus
types have been registered (it's not always easy to find a place to
"hook" between a bus is registered and things get added to it).

In fact, the whole bus type thing is a mess :) We can't easily register
for bus types that are in modules. 

For example, if I want to use the notifier to catch USB devices in order
to, for example, link them to firmware nodes, I'm lost if the USB
subsystem is modular ... unless I use a global notifier and strcmp the
bus type name in there.

So at this point, I'd rather stay on a global notifier.

Ben.



