Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264513AbTIIVhj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbTIIVhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:37:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:25815 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264513AbTIIVh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:37:26 -0400
Date: Tue, 9 Sep 2003 14:43:56 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Jens Axboe <axboe@suse.de>, Pavel Machek <pavel@ucw.cz>,
       Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs
 explaining to you?
In-Reply-To: <1063138756.642.48.camel@gaston>
Message-ID: <Pine.LNX.4.44.0309091405020.695-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Patrick: As we discussed on IRC, the actual PM state constants you
> defined don't match the old "S" levels, thus this code in ide-disk
> suspend notifier:
> 
>                 if (rq->pm->pm_state == 4)
>  
> to avoid stopping the platter on  suspend-to-disk will not work.
> 
> Should I fix the above to use a PM_* constant or will you fix the
> constants ?

It should definitely be checking for a defined constant. 

However, I don't think we necessarily want to pass the system state we're 
entering to the drivers. It's per-driver policy to decide what device 
state to enter for each system state, which are orthogonal to the runtime 
device states that it could enter. 

For most devices, it's going to be 'off' (aka 3) for either suspend-to-ram 
or -disk. But, some devices will have varying or non-standard behavior. 
Like IDE drives or those few instances of ATI video devices on some power 
books that can only go into D2 instead of D3 on STR. 

To remedy this, I say we commit to the fact that it is the device state 
that's being passed down to the drivers. But, we get that state for each 
device from a field in the devices' power structures: 


struct dev_pm_info { 
	...
	u32	str_state;
	u32	std_state;
};

The bus will be able to set these on device registration, or the driver on 
binding. We can also expose them through sysfs to let userspace policy 
modify them. Otherwise they will default to the standard (3 aka 'off'). 

What do you think? 


	Pat

