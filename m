Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267204AbSLEDmd>; Wed, 4 Dec 2002 22:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267205AbSLEDmd>; Wed, 4 Dec 2002 22:42:33 -0500
Received: from air-2.osdl.org ([65.172.181.6]:50387 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267204AbSLEDmb>;
	Wed, 4 Dec 2002 22:42:31 -0500
Date: Wed, 4 Dec 2002 21:33:39 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Jeff Garzik <jgarzik@pobox.com>
cc: James Bottomley <James.Bottomley@steeleye.com>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BKPATCH] bus notifiers for the generic device model
In-Reply-To: <3DEE4C84.9000507@pobox.com>
Message-ID: <Pine.LNX.4.33.0212042114010.924-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I don't recall why the change was never done. Perhaps because of other 
> > distractions, or it seemed like it would be too much of a PITA to convert 
> > drivers to a two-step init sequence (though I think it could be done in a 
> > compatible manner).
> 
> 
> Possibly because of the "do it in open(2)" rule?
> 
> Ignoring the device model entirely, if a driver does a lot of 
> talking-to-the-hardware in its probe phase, I consider it buggy, in 2.4 
> or 2.5.
> 
> The network driver and chardev ones typically follow this rule quite 
> well... probe is simple, just registering interfaces with the kernel. 
> dev->open is where the driver should (and usually does) power-up the 
> hardware, [re-]initialize it, etc.
> 
> So each time you come upon a driver that wants dev->driver->start(), 
> look closely at the code and wonder why it can't perform the 
> dev->driver->start() code in its interface's dev->open member.


Oh, right. Sorry, I should have said 'init()' or 'setup()' rather than 
'start()'. 

In many drivers there are two discrete operations that happen in the 
probe() method: verifying the device can be claimed, and registering the 
interfaces. By breaking it into two calls, you can conceptually separate 
the actions. It would also give the bus a chance to intercept the call and 
perform whatever housekeeping it needed to do at that point, giving James 
what he wanted.

However, I don't see a great benefit of doing this, besides making it 
_blatantly_ obvious what each call is supposed to do. The driver can call 
the bus to perform housekeeping duties during the setup (probe()) period, 
and everything should be happy.

	-pat


