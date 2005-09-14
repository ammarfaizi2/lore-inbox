Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbVINQQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbVINQQn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbVINQQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:16:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:63932 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030231AbVINQQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:16:42 -0400
Date: Wed, 14 Sep 2005 09:16:22 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@novell.com>
Cc: Mr Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] hdaps driver update.
Message-ID: <20050914161622.GA22875@kroah.com>
References: <1126713453.5738.7.camel@molly> <20050914160527.GA22352@kroah.com> <1126714175.5738.21.camel@molly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126714175.5738.21.camel@molly>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 12:09:35PM -0400, Robert Love wrote:
> On Wed, 2005-09-14 at 09:05 -0700, Greg KH wrote:
> 
> > Woah, no, this is not ok.  Please see my objections to this the zillion
> > other times people have tried to do this...
> > 
> > Why is this static?  Shouldn't it be dynamic and then your release would
> > be able to free the memory?
> 
> The release only happens on module unload, the device is not
> hotpluggable, and thus we'd gain the memory anyhow.
> 
> So it is static the way any other no-need-to-dynamically-create data
> structure would be.
> 
> No?

But you are reference counting a static object, right?  Which isn't the
nicest thing to have done.  Why not just dynamically create it?

> > >  static struct device_driver hdaps_driver = {
> > >  	.name = "hdaps",
> > >  	.bus = &platform_bus_type,
> > > -	.owner = THIS_MODULE,
> > >  	.probe = hdaps_probe,
> > >  	.resume = hdaps_resume
> > >  };
> > 
> > Why delete that?  You just lost your symlink in sysfs then :(
> 
> I don't follow.
> 
> Wouldn't we want to be removed from sysfs?

No, if you have that .owner field in your driver, you get a symlink in
sysfs that points from your driver to the module that controls it.  You
just removed that symlink, which is not what I think you wanted to have
happen :(

I also think you don't get the module reference counting for your
driver's and devices sysfs files but haven't looked deep enough to see
if this is true for your code or not.  Should be easy for you to test,
just open a sysfs file for your device and see if the module reference
is incremented or not.

thanks,

greg k-h
