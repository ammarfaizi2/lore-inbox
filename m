Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbUKEFRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbUKEFRi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 00:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbUKEFRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 00:17:37 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:41629 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262606AbUKEFRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 00:17:21 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.10-rc1 4/4] driver-model: attach/detach sysfs node implemented
Date: Fri, 5 Nov 2004 00:17:18 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>, rusty@rustcorp.com.au
References: <20041104190619.76178.qmail@web81309.mail.yahoo.com> <20041105044536.GA25763@home-tj.org>
In-Reply-To: <20041105044536.GA25763@home-tj.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411050017.18443.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 11:45 pm, Tejun Heo wrote:
>  Hello Dmitry.  Hello Greg.
> 
> On Thu, Nov 04, 2004 at 11:06:19AM -0800, Dmitry Torokhov wrote:
> > What about connecting? I am pretty ignorant of USB inner workings
> > but when I took a glance there seems to be a lot of preparations
> > before device is ready to be probed...
> 
>  IMHO, it would be better to coerce whatever bus to follow common
> driver-model synchronization/attach/detach rules and be able to do
> straight-forward implementation of features in the core driver-model.
> If the current driver-model isn't enough, the core code should be
> expanded rather than doing bus-specific dances in individual buses.
> But I don't really know about any bus other than PCI, so maybe I'm
> being too naive.
>

The main problem I guess is that driver model does not allow registering
or removal of child devices during driver->probe() on the same bus. So
every bus does it its own way. Plus most buses were around way before
driver model so their historical locking rules affect this as well.
Down the road, as the stuff gets cleaned we can have a shot of pulling
bus code into drivre core, but not yet I think.
 
> > > problems (as long as it's not the hub driver from a hub device, we need
> > > to never be able to disconnect those.)
> > 
> > Never say never ;) That was the first thing I did after playing with
> > PCI devices when I tried doing what Tejun did.
> > 
> > If kernel advertises an userspace interface it will be used. I can see
> > myself wanting to disconnect my hub and all its devices so my wireless
> > explorer does not use batteries and I do not want to figure out what
> > port it is connected to... Someone else will find another reason,
> > I don't know.
> > 
> > I also think that even PCI should kill children devices behind a bridge
> > if bridge driver is disconnected to manage resources in more strict way.
> > But I think that would require notion of generic/specialized driver and
> > require automatic rebinding of specialized driver over generic one so
> > every PCI device has a driver attached to it.
> 
>  I think above can be cleanly solved by enforcing that no device can
> be attached to a driver unless all its ancestors are attached to a
> driver.  The check can be made easiliy inside the driver-model, and,
> if needed, making dummy drivers for internal node devices which
> orignally didn't need one shouldn't be difficult.

Right now not all parent PCI devices have drivers. IIRC there were talks
about implementing generic bridge driver but then some bridges need special
handling and the concern was that generic driver would prevent binding of
a special driver.

> We can just return 
> -EBUSY for any attempts to detach an internal device which has
> driver-attached children.  This way, recursing and all other chores
> can be dumped to user-space where they belong.
> 

The system needs to handle situation when you physically yanking part of a
device tree and get rid of all devices, like in cases when you pull an USB
cable connected to a HUB with a mouse and a scanner and a pinter and whatever
else out there. We need to get rid of all these devices and I am not sure
that offloading this task to userspace is good idea. Especially if removal
happens when the box is suspended and at wakeup we have completely different
set of devices...

>  And regarding the duplicate works, my work on manual-attach was
> primarily to show how dynamic device-driver binding can work with
> devparam; also, Dmitry seems to understand the problem better than me.
> So, I think I should back off on manualattach.  Dmitry, what do you
> think about integrating devparam with your work?
>

I do not see why we shoudln't but first I need to persuade Greg to apply
my patches ;)
 
-- 
Dmitry
