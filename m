Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWALHLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWALHLH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 02:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWALHLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 02:11:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:34433 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751262AbWALHLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 02:11:06 -0500
Date: Wed, 11 Jan 2006 23:10:00 -0800
From: Greg KH <greg@kroah.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
Message-ID: <20060112071000.GA32418@kroah.com>
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com> <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com> <43C5B59C.8050908@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C5B59C.8050908@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 08:49:16PM -0500, Mike D. Day wrote:
> Greg KH wrote:
> 
> >>I think it comes down to simplification for non-driver code, which is 
> >>admittedly not the mainstream use model for sysfs.
> >
> >/sys/module/ is a pretty "mainstream use model for sysfs", right?
> 
> Yes, but xen is not a module. I believe /sys/xen/ is different than 
> /sys/module/, and provide some further reasoning below.

My point was that the module core code itself is a portion of the kernel
that uses sysfs that is a "non-driver" bit of code.  Thus proving that
you do not have to be a driver, or device, or bus, to use sysfs easily.

> >>The module version? Xen is not a module nor a driver, so that interface 
> >>doesn't quite serve the purpose.
> >
> >Then it doesn't need a separate version, as it is the same as the main
> >kernel version, right?  Just because your code is out-of-the-tree right
> 
> No. For example, I could run linux-2.6.x in a domain under xen 3.0.0. In 
> this case the xen version is 3.0.0, the linux version is 2.6.x. I could 
> run the very same kernel on xen 3.0.1, xen 3.1, and eventually xen 
> 4.x.x. The xen version exists outside of the linux kernel version, but 
> userspace will have good reasons to want to know the xen version (think 
> management tools).

Ok, thanks for explaining this better.  That makes more sense.

What other, specific sysfs files are you going to want to create?
What is the hierarchy going to look like?
What is the contents of the file going to look like?

> >So you want to divorce the relationship in sysfs between directories and
> >kobjects?  
> 
> Not quite, just hide the relationship for users of sysfs that have no 
> reason to know about it.

I think this is happening as you are trying to port your code that
currently uses /proc (and file names there) to use sysfs instead, right?
To do this correctly, you need to stop thinking about file names and
paths, and start thinking about the hierarchy and relationship between
the files, which will allow you to create a tree of kobjects easier.

If you answer the questions above, I think we can work to figure this
out.

> >>Currently in xeno-linux there are several files under /proc/xen. These 
> >>are created by different areas of the xeno-linux kernel. In xeno-linux 
> >>today there is a single higher-level routine that each of these 
> >>different areas uses to create its own file under /proc/xen. In other 
> >>words, I think there should be a unifying element to the interface 
> >>because the callers are not organized within a single module.
> >
> >Ok, but again, that's no different than anything else in the kernel,
> >right?
> 
> I think that it is different. The sysfs attributes are being created by 
> the kernel, not a driver or module. The attribute values themselves are 
> located in the xen hypervisor, which is totally outside of the kernel 
> and everything it controls.

Just because you have to make a hypervisor call to get the value of the
attribute behind a sysfs file, does not make it any different from
anything else we currently have in sysfs.  It just will make the race
conditions easier to hit in your code as I imagine you will be sleeping
in the show functions more often than other parts of the kernel :)

> >not be applied due to a broken email client setup, tried to do all of
> >the work in your own subsection of an external kernel tree that seems to
> 
> I worked within the xen project hoping that the code might get applied 
> there and later merged.

Well, for things like this, that interact with the rest of the kernel,
it's good to work with the kernel community too, as you are doing.  I'm
happy to see this start to happen, hopefully other portions of Xen will
start tricking out this way also (same thing happened a few weeks ago
with some USB stuff.)

> >strongly avoid getting merged into mainline, ignored the existing kernel
> >interfaces, 
> 
> No, I didn't ignore them. I may be mistaken, but I believe this is a 
> different use model.

I don't.  You are creating a generalized wrapper around a globally
available kernel subsystem.  Don't you think that others could want to
use it, or that it hasn't been created yet for some reason?

> Sorry, will make certain to cc: the maintainer in the future.

And also please fix your email client to post patches properly.  I guess
I should be happy you didn't try to post them using Notes :)

thanks,

greg k-h
