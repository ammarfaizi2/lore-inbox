Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVB1UZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVB1UZG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 15:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVB1UZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 15:25:06 -0500
Received: from soundwarez.org ([217.160.171.123]:14235 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261710AbVB1UYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 15:24:51 -0500
Date: Mon, 28 Feb 2005 21:24:43 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: split kobject creation and hotplug event generation
Message-ID: <20050228202443.GA25248@vrfy.org>
References: <20050226055316.GA14317@vrfy.org> <20050228194642.GA21323@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228194642.GA21323@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 11:46:42AM -0800, Greg KH wrote:
> On Sat, Feb 26, 2005 at 06:53:16AM +0100, Kay Sievers wrote:
> > This splits the implicit generation of a hotplug events from
> > kobject_add() and kobject_del(), to give the user of of these
> > functions control over the time the event is created.
> > 
> > The kobject_register() and unregister functions still have the same
> > behavior and emit the events by themselves.
> > 
> > The class, block and device core is changed now to emit the hotplug
> > event _after_ the "dev" file, the "device" symlink and the default
> > attributes are created. This will save udev from spinning in a stat() loop
> > to wait for the files to appear, which is expensive if we have a lot of
> > concurrent events.
> 
> So, does this solve the issue that everyone has been complaining about
> for years with the hotplug event happening before the sysfs files are
> present?

I expect most of them, yes. It is not a guarantee, cause drivers can and will
create attributes at any time. :) But the most interesting default ones, that
people tend to expect at event time will be there _before_ the event happens.

To get this for the whole system and not only the class+block core, a few remainig
places that use kobject_register() need to be changed to use kobject_add(), but
that is a trivial change and nice too, cause it cleans up some error pathes, where
a device needs to be unregistered in the same function and it emits two completely
useless events for that.

> And if we add this, can we pretty much get rid of all of the
> wait_for_sysfs like logic in udev?

Yes, that was the motivation to do this. With all the hotplug env vars
we have now, we can throw out all the compiled-in lists and if some crazy
devices still need to wait, we can add something to udev's rule logic, that a
configured rule will wait for that file to show up.

Thanks,
Kay
