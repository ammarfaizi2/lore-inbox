Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVAYWpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVAYWpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVAYWn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:43:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61605 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262200AbVAYWmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:42:52 -0500
Date: Tue, 25 Jan 2005 22:42:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050125224247.GA29849@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Andrew Morton <akpm@osdl.org>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050125125323.GA19055@infradead.org> <1106662284.5257.53.camel@uganda> <20050125142356.GA20206@infradead.org> <1106666690.5257.97.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106666690.5257.97.camel@uganda>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Zeroing can be found easily - the whole structure is NULL pointer, 
> and will always panic if accessed(from running superio code), 
> but redzoning is only happen on borders,
> and can catch writes over the boards, which is rarely in this case.

As I mentioned the redzoning was a brainfar on my side.  Slab debug
code memsets all code with an easily recognizable pattern (which 0 is _NOT_).

So this is totally useless, please don't do it - as all major subsystems
don't do it either.

> Each superio chip is registered with superio core without any devices.
> Each logical device is registered with superio core without any superio
> chip.
> 
> Then core checks if some chip is found in some superio device, and
> links 
> it to appropriate device.
> So if board has several superio chips(like soekris board) and several
> logical devices in it, then we only have 2 superio small drivers, and
> several 
> logical device drivers, but not
> number_of_superio_chips*number_of_logical_devices drivers.

That's how just about any bus driver works so far.

Now somewhere else in the thread I read the a single logical device
might belong to multiple superio devices.  Which is kinda odd, but in
that case it's indeed needed.

So please add a big comment explaining that properperty because it
is extemly uncommon, and make 'ptr' in the chain structure typed
instead of void *

> Yes, and it is better than removing module whose structures are in use.
> SuperIO core is asynchronous in it's nature, one can use logical device 
> through superio core and remove it's module on other CPU, above loop
> will
> wait untill all reference counters are dropped.

General rule is: increment module reference count while the hardware
is actually in use, and let device structures be allocated by the
bus core so drivers can be freed with them still allocated.  That's
how the driver model and thus about every other subsystem works.

