Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVATNue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVATNue (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 08:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVATNue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 08:50:34 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:53341 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262090AbVATNuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 08:50:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Js5y6Vo4d5T7xYjkavVueTHTl7LfCNBxEf2HavYxhj/urOywo0ZbGt2Mhh/h2imh+zSkCSey5G2NUCfECl9MP4F/3qQJkYZSbOudE9dxKyH6Wu+UhmGOloqJPVr40/BwZ7Syws8+dqcIeTWuEgdT6pZQJOLgdIkZUkrIVBrVkTk=
Message-ID: <d120d500050120055026b5d854@mail.gmail.com>
Date: Thu, 20 Jan 2005 08:50:24 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] remove input_call_hotplug (Take#2)
Cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <41EF640D.60102@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41EE651E.1060201@suse.de> <20050119214249.GC4151@kroah.com>
	 <41EF640D.60102@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2005 08:55:57 +0100, Hannes Reinecke <hare@suse.de> wrote:
> Greg KH wrote:
> > On Wed, Jan 19, 2005 at 02:48:14PM +0100, Hannes Reinecke wrote:
> >
> >>Hi Dmitry,
> >>
> >>attached is the reworked patch for removing the call to
> >>call_usermodehelper from input.c
> >>I've used the 'phys' attribute to generate the device names, this way we
> >>don't need to touch all drivers and the patch itself is nice and small.
> >
> >
> > The main problem of this is the input_dev structures are created
> > statically, right?  Because of this, the release function really doesn't
> > work out correctly I think....
> > 
> That depends on the driver. input_dev is in general a static entry in
> the driver-dependend structure, which in turn may be statically or
> dynamically allocated (depending on whether the driver allows for more
> than one instance of the device to be connected).
> Would dynamic allocation be of any help here?

The concern is the following: you are using class_simple and
class_device structure is embedded into input_dev structure. When you
unregister input_dev class_simple_release will attempt to kfree()
memory occupied by class_device which is bad because it was never
kalloc()ated.

For now, if you continue using class_simple (which is I believe right
solution for now, we have issues with lifetime rules there and it will
take time to resolve everything), you need to dynamically allocate
class_device for input_dev (change cdev to *cdev).

-- 
Dmitry
