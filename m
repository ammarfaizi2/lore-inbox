Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbUKEEpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbUKEEpv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 23:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbUKEEpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 23:45:51 -0500
Received: from [211.58.254.17] ([211.58.254.17]:2248 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262596AbUKEEpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 23:45:42 -0500
Date: Fri, 5 Nov 2004 13:45:37 +0900
From: Tejun Heo <tj@home-tj.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>, rusty@rustcorp.com.au
Subject: Re: [PATCH 2.6.10-rc1 4/4] driver-model: attach/detach sysfs node implemented
Message-ID: <20041105044536.GA25763@home-tj.org>
References: <20041104190619.76178.qmail@web81309.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104190619.76178.qmail@web81309.mail.yahoo.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello Dmitry.  Hello Greg.

On Thu, Nov 04, 2004 at 11:06:19AM -0800, Dmitry Torokhov wrote:
> What about connecting? I am pretty ignorant of USB inner workings
> but when I took a glance there seems to be a lot of preparations
> before device is ready to be probed...

 IMHO, it would be better to coerce whatever bus to follow common
driver-model synchronization/attach/detach rules and be able to do
straight-forward implementation of features in the core driver-model.
If the current driver-model isn't enough, the core code should be
expanded rather than doing bus-specific dances in individual buses.
But I don't really know about any bus other than PCI, so maybe I'm
being too naive.

> > problems (as long as it's not the hub driver from a hub device, we need
> > to never be able to disconnect those.)
> 
> Never say never ;) That was the first thing I did after playing with
> PCI devices when I tried doing what Tejun did.
> 
> If kernel advertises an userspace interface it will be used. I can see
> myself wanting to disconnect my hub and all its devices so my wireless
> explorer does not use batteries and I do not want to figure out what
> port it is connected to... Someone else will find another reason,
> I don't know.
> 
> I also think that even PCI should kill children devices behind a bridge
> if bridge driver is disconnected to manage resources in more strict way.
> But I think that would require notion of generic/specialized driver and
> require automatic rebinding of specialized driver over generic one so
> every PCI device has a driver attached to it.

 I think above can be cleanly solved by enforcing that no device can
be attached to a driver unless all its ancestors are attached to a
driver.  The check can be made easiliy inside the driver-model, and,
if needed, making dummy drivers for internal node devices which
orignally didn't need one shouldn't be difficult.  We can just return
-EBUSY for any attempts to detach an internal device which has
driver-attached children.  This way, recursing and all other chores
can be dumped to user-space where they belong.

 And regarding the duplicate works, my work on manual-attach was
primarily to show how dynamic device-driver binding can work with
devparam; also, Dmitry seems to understand the problem better than me.
So, I think I should back off on manualattach.  Dmitry, what do you
think about integrating devparam with your work?

 Thanks.

-- 
tejun

