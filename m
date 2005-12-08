Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVLHW2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVLHW2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVLHW2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:28:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:50625 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932372AbVLHW2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:28:54 -0500
Date: Thu, 8 Dec 2005 14:26:18 -0800
From: Greg KH <gregkh@suse.de>
To: dtor_core@ameritech.net
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Driver bind/unbind and __devinit
Message-ID: <20051208222618.GA26295@suse.de>
References: <d120d5000512081314r6b574eb3jf5516ef5bc28730d@mail.gmail.com> <20051208215522.GA25925@suse.de> <d120d5000512081422r650815dewb174119b743e87c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000512081422r650815dewb174119b743e87c4@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 05:22:12PM -0500, Dmitry Torokhov wrote:
> On 12/8/05, Greg KH <gregkh@suse.de> wrote:
> > On Thu, Dec 08, 2005 at 04:14:58PM -0500, Dmitry Torokhov wrote:
> > > Hi,
> > >
> > > Many drivers have their probe routines declared as __devinit which is
> > > a no-op unless CONFIG_HOTPLUG is set. However driver's bind/unbind
> > > attributes are created unconditionally, as fas as I can see. Would not
> > > it cause an oops if someone tries to use these attributes with
> > > CONFIG_HOTPLUG=N? Am I missing something?
> >
> > You are missing the CONFIG_HOTPLUG checks around the functions that add
> > and check the device ids from these sysfs files.  If CONFIG_HOTPLUG is
> > not enabled, those files do not do anything.
> >
> 
> I am slow today... I don't see any dependencies on CONFIG_HOTPLUG in
> drivers/base... Or you talking about one particular subsystem that
> handles this correctly?

Ugh, very sorry about that, I was thinking of the USB and PCI new_id
stuff.  You are right.

Yes, bind happening after the __init data section is thrown away, if
CONFIG_HOTPLUG is not enabled would be a bad thing.  But unbind can
stay.  I'll go make up a patch for that.

> > > Also, unbind implementation does not seem safe - we check the driver
> > > before taking device's semaphore so we risk unbinding wrong driver (in
> > > the unlikely event that we manage to unbind and bind another driver in
> > > another thread).
> >
> > Do you have a suggestion as to how to fix this?
> >
> 
> I think we could take the semaphore before checking driver and then
> use __device_release_driver(). But we'd need to make it global or move
> bind/unbind code into drivers/base/dd.c

I don't have a problem moving the code if it makes it easier.  Have a
patch?  :)

thanks,

greg k-h
