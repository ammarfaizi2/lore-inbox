Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbUKDRqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbUKDRqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbUKDRpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:45:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:26002 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262301AbUKDRnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:43:04 -0500
Date: Thu, 4 Nov 2004 09:42:45 -0800
From: Greg KH <greg@kroah.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Roland Dreier <roland@topspin.com>,
       Germano <germano.barreiro@cyclades.com>, Scott_Kilau@digi.com,
       linux-kernel@vger.kernel.org
Subject: Re: patch for sysfs in the cyclades driver
Message-ID: <20041104174245.GD16389@kroah.com>
References: <1099487348.1428.16.camel@tsthost> <20041104102505.GA8379@logos.cnet> <52fz3po8k2.fsf@topspin.com> <20041104142925.GB9431@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104142925.GB9431@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 12:29:25PM -0200, Marcelo Tosatti wrote:
> On Thu, Nov 04, 2004 at 08:58:21AM -0800, Roland Dreier wrote:
> >     Marcelo> The problem was class_simple only contains the "dev"
> >     Marcelo> attribute. You can't add other attributes to it.
> > 
> > I believe, based on the comment in class_simple.c:
> > 
> >   Any further sysfs files that might be required can be created using this pointer.
> > 
> > and the implementation in in drivers/scsi/st.c, that there's no
> > problem adding attributes to a device in a simple class.  You can just
> > use class_set_devdata() on your class_device to set whatever context
> > you need to get back to your internal structures, and then use
> > class_device_create_file() to add the attributes.
> > 
> > I assume this is OK (since there is already one in-kernel driver doing
> > it), but Greg, can you confirm that it's definitely OK for a driver to
> > use class_set_devdata() on a class_device from class_simple_device_add()?
> 
> Hi Roland,
> 
> Oh thanks, I didnt knew the existance of such possibily.
> 
> I once asked here on the list:
> 
> ---------
> 
> Hope this is not a FAQ.
> 
> I want to export some read-only attributes (statistics) from cyclades.c char
> driver to userspace via sysfs.
> 
> I can't figure out the right place to do it - I could create a class under
> /sys/class/cyclades for example, but that doesnt sound right since this
> is not a "class" of device, but a device itself.
> 
> Hooking the statistics into /sys/class/tty/ttyC$/ sounds reasonable, but
> its not possible it seems because "tty" is a class_simple class, which only implements
> the "dev" attribute.
> 
> ------ Greg answer was:
> 
> For a driver only attribute, you want them to show up in the place for
> the driver (like under /sys/bus/pci/driver/MY_FOO_DRIVER/).  To do that
> use the DRIVER_ATTR() and the driver_add_file() functions.  For
> examples, see the other drivers that use these functions.
> 
> 
> But I hope you are right - /sys/class/tty/tty$/ 
> sounds the correct place for those files - I thought a "class_tty" 
> class was required for new attributes. 

No, Roland is right, just use the class_device pointer you get back from
the core when a tty device is created.

Right now we aren't saving the pointer anywhere (see
tty_register_device() for where it is created.)  Just add that to the
proper tty_device structure, and you should be fine (yeah, it's going to
be a pain, and you will quickly see why I didn't do that in the first
place, but it is going to need to be changed eventually...)

Good luck,

greg k-h
