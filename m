Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVARVaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVARVaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 16:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVARVaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 16:30:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:5027 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261437AbVARVaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 16:30:14 -0500
Date: Tue, 18 Jan 2005 13:30:02 -0800
From: Greg KH <greg@kroah.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pawlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/2] Remove input_call_hotplug
Message-ID: <20050118213002.GA17004@kroah.com>
References: <41ED23A3.5020404@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ED23A3.5020404@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 03:56:35PM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> the input subsystem is using call_usermodehelper directly, which breaks 
> all sorts of assertions especially when using udev.
> And it's definitely going to fail once someone is trying to use netlink 
> messages for hotplug event delivery.
> 
> To remedy this I've implemented a new sysfs class 'input_device' which 
> is a representation of 'struct input_dev'. So each device listed in 
> '/proc/bus/input/devices' gets a class device associated with it.
> And we'll get proper hotplug events for each input_device which can be 
> handled by udev accordingly.

Hm, why another input class?  We already have /sys/class/input, which we
get hotplug events for.  We also have the individual input device
hotplug events, which is what I think we really want here, right?

Hm, in looking at the code some more, I think just adding a struct
device to the struct input_device would work.  You will have to refactor
out the fact that there is a pointer to a struct device in there (that
will just become the parent pointer to the input_dev's struct device).
If you do that, you can also drop a few of the fields in struct
input_dev.

That would solve all of the userspace issues your patch causes (hotplug
events would come out with the same type as before) and finally the
input subsystem would be part of the driver model properly :)

But yes, it will take more work than your patch, sorry.

thanks,

greg k-h
