Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWFWE13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWFWE13 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 00:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWFWE13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 00:27:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:36045 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932209AbWFWE13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 00:27:29 -0400
Date: Thu, 22 Jun 2006 21:24:52 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Mattia Dongili <malattia@linux.it>, Jiri Slaby <jirislaby@gmail.com>,
       Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-pm@osdl.org, pavel@suse.cz
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
Message-ID: <20060623042452.GA23232@kroah.com>
References: <20060622202952.GA14135@kroah.com> <200606221624.03182.david-b@pacbell.net> <20060622235112.GA30484@kroah.com> <200606222034.44085.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606222034.44085.david-b@pacbell.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 08:34:43PM -0700, David Brownell wrote:
> On Thursday 22 June 2006 4:51 pm, Greg KH wrote:
> > > There was previously an invariant that the interfaces were marked
> > > as quiescent unless the interface (a) had a driver, and (b) that
> > > driver was not suspended.  Evidently that has been lost.  This patch
> > > may be insufficient; ISTR other places relying on that invariant.
> > > 
> > > And yes, we _should_ care about whether or not any interface is
> > > still active, until the pm core code starts to pay attention to
> > > the driver model tree at all times ... even outside of system-wide
> > > suspend transitions.  Today, the pm core code doesn't even use
> > > that tree directly, and all runtime state changes (like selective
> > > suspend with USB) completely bypass that pm tree.
> > 
> > Hm, ok, yes, we should care about interfaces, but we need some way to
> > only walk them, not anything else that might be attached to us...
> 
> Under what scenario could it possibly be legitimate to suspend a
> usb device -- or interface, or anything else -- with its children
> remaining active?  The ability to guarantee that could _never_ happen
> was one of the fundamental motivations for the driver model ...

I'm not disagreeing with that.  It's just that you are looping all
struct devices that are attached to a struct usb_device and assuming
that they are all of type struct usb_interface.  And that's not true
anymore, and should never have been assumed (which is probably my fault
way long ago when converting USB to the driver model.)

We probably need to keep our own list of interfaces if we want to
properly walk them now...

And we also need to be able to handle devices in the device tree that do
not have a suspend/resume function, or ones that are not attached to any
bus, without failing the suspend, as obviously they do not care or need
to worry about the whole issue.

thanks,

greg k-h
