Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbTADUQX>; Sat, 4 Jan 2003 15:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbTADUQX>; Sat, 4 Jan 2003 15:16:23 -0500
Received: from air-2.osdl.org ([65.172.181.6]:16095 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261376AbTADUQT>;
	Sat, 4 Jan 2003 15:16:19 -0500
Date: Sat, 4 Jan 2003 13:45:10 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Matt Domsch <Matt_Domsch@Dell.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kobject_init() sets kobj->subsys wrong?
In-Reply-To: <Pine.LNX.4.44.0301041400570.17248-100000@humbolt.us.dell.com>
Message-ID: <Pine.LNX.4.33.0301041340001.998-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Matt.


On Sat, 4 Jan 2003, Matt Domsch wrote:

> > Your recent patch creating find_bus("scsi") always returns NULL.  I see
> > that's because bus_subsys.list is empty.
> 
> In kobject_add(), with kobj->subsys = NULL, this kobject (embedded inside 
> struct subsystem embedded inside struct bus_type) never gets added to 
> either it's parent's list, nor to the (NULL) subsystem's list.  It appears 
> that the object can be on either a parent's list or a subsystem's list, 
> but not both, by virtue of there being only one struct list_head entry in 
> struct kobject.

Actually, the objects are always placed on their subsystem's list, never 
their parent's. An object's parent is only used to determine the location 
to insert the object. This gives the subsystem the ability to maintain an 
ordered list of all objects registered with it, even when the objects 
compose an arbitrarily deep hierarchy. 

This is docuemented somewhere, but I'll be sure to add a comment to 
kobject_add() explaining this. 

> 1) in bus_register(), don't set bus->subsys.parent = &bus_subsys, instead 
> set bus->subsys.kobj.subsys = &bus_subsys.  I did this, and now find_bus() 
> works as expected, but now the busses created don't have parents unless 
> they're specified prior to calling bus_register(), so this doesn't seem 
> quite right.

This is correct. Also in kobject_add(), orphan objects are adopted by 
the subsystem they belong to. 

	-pat

