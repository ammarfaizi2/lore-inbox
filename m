Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVASOoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVASOoa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 09:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVASOoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 09:44:30 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:52760 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261735AbVASOoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 09:44:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HeAkKexjPOYrFPiu45hbDkuBRcyCFULLuXbv9fXKn9Ste1sH84i8UeHGIBNiFai9Cu0GcERqRrGEW6BtstjDnxJgBXw47JlI12qTmplL873fTk4shxhkSR3b8RzxkauLkJDogAtrzDgNPv58Lm903lRG+IkKn4siJ2MFAlyC1O4=
Message-ID: <d120d500050119064461d21d80@mail.gmail.com>
Date: Wed, 19 Jan 2005 09:44:20 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] Remove input_call_hotplug
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <41EE6BA8.6020705@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41ED2457.1030109@suse.de>
	 <d120d50005011807566ee35b2b@mail.gmail.com> <41EE2F82.3080401@suse.de>
	 <d120d500050119060530b57cd7@mail.gmail.com> <41EE6BA8.6020705@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2005 15:16:08 +0100, Hannes Reinecke <hare@suse.de> wrote:
> Dmitry Torokhov wrote:
> > Hi Hannes,
> >
> > On Wed, 19 Jan 2005 10:59:30 +0100, Hannes Reinecke <hare@suse.de> wrote:
> >
> >>Dmitry Torokhov wrote:
> >>
> >>>But the real question is whether we really need class devices have
> >>>unique names or we could do with inputX thus leaving individual
> >>>drivers intact and only modifying the input core. As far as I
> >>>understand userspace should be concerned only with device
> >>>capabilities, not particular name, besides, it gets PRODUCT string
> >>>which has all needed data encoded.
> >>>
> >>
> >>Indeed. What about using 'phys' (with all '/' replaced by '-') as the
> >>class_id? This way we'll retain compability with /proc/bus/input/devices
> >>and do not have to touch every single driver.
> >>
> >
> >
> > I want to kill phys at some point - we have topology information
> > already present in sysfs in much better form. Can we have a new
> > hotplug variable HWDEV= which is kobject_path(input_dev->dev). If
> > input_dev is not set then we can just dump phys in it. And the class
> > id will still be inputX. Will this work?
> >  
> Sure. And we don't need a special HWDEV variable, as there is already a
> PHYSDEVPATH variable providing exactly this information.

Oh right! Even better.

> I'm not too happy about this 'inputX' thing (as this doesn't carry any
> information, whereas 'phys' gives you at least a rough guess what this
> device's about), but if phys is to go it would be the logical choice.
> 

The problem with encoding phys in class ID is the following: you have
to guarantee that the moment you destroy underlying hw device yur
input_device has to be gone too. Imagine you have input_device for
your PS/2 mouse and you decide to unload psmouse module. You also have
one of user processes holding any of the class device attributes open.
This causes input_device to be pinned into memory so when you load
psmouse module back again it will not be able to create new
input_device and mouse will be dead. With monotonicaly increasing
inputX name you will never have this issue.

You had a workaround for this problem with your original path but when
you fold it all in core you lost it.

-- 
Dmitry
