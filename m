Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWALA52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWALA52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWALA52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:57:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:37072 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964910AbWALA51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:57:27 -0500
Date: Wed, 11 Jan 2006 16:57:10 -0800
From: Greg KH <greg@kroah.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
Message-ID: <20060112005710.GA2936@kroah.com>
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com> <43C5A199.1080708@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C5A199.1080708@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 07:23:53PM -0500, Mike D. Day wrote:
> Greg KH wrote:
> 
> >Why is xen special from the rest of the kernel in regards to adding
> >files to sysfs?  What does your infrastructure add that is not currently
> >already present for everyone to use today?
> 
> I think it comes down to simplification for non-driver code, which is 
> admittedly not the mainstream use model for sysfs.

/sys/module/ is a pretty "mainstream use model for sysfs", right?

> >Why is the xen version any different from any other module or driver
> >version in the kernel? (hint, use the interface that is availble for
> >this already...)
> 
> The module version? Xen is not a module nor a driver, so that interface 
> doesn't quite serve the purpose.

Then it doesn't need a separate version, as it is the same as the main
kernel version, right?  Just because your code is out-of-the-tree right
now, doesn't mean it will be that way forever (although based on the
lack of patches to alieve this, it might be...)

> True, one could create a "Xen module" that talks to Xen the
> hypervisor, but then the version interface would provide the version
> of the xen module, not the version of the xen hypervisor.

Huh?  You can't just throw a "MODULE_VERSION()", and a module_init()
somewhere into the xen code to get this to happen?  Then all of your
configurable paramaters show up automagically.

> /sys/xen/version may not be the best example for this discussion. What
> is important is that this attribute is obtained from Xen using a
> hypercall. Sysfs works great to prove the xen version and other
> similar xen attributes to userspace.

Like what?  Specifics please.

> >You have access to the current tree as well as we do to be able to
> >answer this question :)
> 
> Right. Dumb question.
> 
> >You don't have to create a driver subsystem to be able to add stuff to
> >sysfs, what makes you think that?
> 
> Sorry, you are right. But you do need to have s struct dev or use 
> kobjects. What I want is an interface to create sysfs files using a path 
> as a parameter, rather than a struct kobject.

So you want to divorce the relationship in sysfs between directories and
kobjects?  That's a valid proposal, but just don't do it as a xen
specific thing please, that's being selfish.

> >did you look at debugfs?  
> 
> yes

And what is wrong with it?

> >configfs?
> 
> no. configfs may be a better choice. I would still want a higher-level 
> kernel interface similar to what is in the patch, as explained below. 
> But I think sysfs may be more appropriate because attributes show up 
> automatically without a user-space action being taken.

Fair enough.

> >What is wrong with the current kobject/sysfs/driver model interface that
> >made you want to create this extra code?
> 
> Nothing is wrong, but I want a higher-level interface, to be able to 
> create files and directories using a path, and to allow a code that is 
> not associated with a device to create sysfs files by specifying a path. 
> e.g., create(path, mode, ...).

See my comment above about this.

But I think you will fail in this, as we want to keep a very strict
heirachy in sysfs, as userspace relies on this.  See the previous
proposal from Pat Mochel to try to do this (in the lkml archives) for
the problems when he tried to do so.

> Currently in xeno-linux there are several files under /proc/xen. These 
> are created by different areas of the xeno-linux kernel. In xeno-linux 
> today there is a single higher-level routine that each of these 
> different areas uses to create its own file under /proc/xen. In other 
> words, I think there should be a unifying element to the interface 
> because the callers are not organized within a single module.

Ok, but again, that's no different than anything else in the kernel,
right?

> Mike (hoping he doesn't end up on linux kernel monkey log)

Well, you posted a patch in the wrong coding style, in a format that can
not be applied due to a broken email client setup, tried to do all of
the work in your own subsection of an external kernel tree that seems to
strongly avoid getting merged into mainline, ignored the existing kernel
interfaces, and didn't cc: the subsystem maintainer.  Sounds like it
might be worth mentioning, don't you think?  :)

thanks,

greg k-h
