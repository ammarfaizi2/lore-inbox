Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUGXPqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUGXPqa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 11:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUGXPq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 11:46:29 -0400
Received: from peabody.ximian.com ([130.57.169.10]:5527 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267499AbUGXPp5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 11:45:57 -0400
Subject: Re: [patch] kernel events layer
From: Robert Love <rml@ximian.com>
To: dsaxena@plexity.net
Cc: Michael Clark <michael@metaparadigm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040724150838.GA24765@plexity.net>
References: <1090604517.13415.0.camel@lucy>
	 <4101D14D.6090007@metaparadigm.com> <1090638881.2296.14.camel@localhost>
	 <20040724150838.GA24765@plexity.net>
Content-Type: text/plain
Date: Sat, 24 Jul 2004 11:45:53 -0400
Message-Id: <1090683953.2296.78.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-24 at 08:08 -0700, Deepak Saxena wrote:

> > No, we want to give an interface that matches the sort of provider URI
> > used by object systems such as CORBA, D-BUS, and DCOP.  We also do _not_
> > want to put policy in the kernel.
> 
> What if I don't want something as heavyweight as D-BUS to handle this
> for me and just want a simple parser that can tell me "this device
> has x event". The kernel simply is telling user space that there
> is an event and should not know/care how and by what it is handled.
> Saying CORBA, D-BUS, DCOP use this naming scheme so we whould too
> seems like policy to me. If I am a driver writer and I want to just 
> send some state change notification, I do not want to care about such 
> things. I want to be able to use a name that makes sense in the
> context of the kernel and using a kobject sounds good b/c then I really
> don't have to care about naming and will be less prone to errors
> from typos and such. Remember, the user space deamons are not the ones 
> that will actually call these functions. It is kernel code and the API
> needs to be easilly useable by kernel programers.

Not everything has a corresponding sysfs name, which really makes the
whole notion moot.

> > The easiest way to avoid that is simply to use a name similar to the
> > path name.
> 
> What is the path name of a device from the kernels point of view?
> Since device naming in /dev is left up to userland now, it has to
> be something else that the kernel is aware of.

I might not of been clear - path name of the file in the kernel source
tree.  So if you add an event to fs/open.c the path is
"/org/kernel/fs/open".  This is a pretty generic naming scheme that
ensures names will be unique within the kernel and will not conflict
with names outside the kernel (e.g. the global URI space of whatever is
used in user-space).

> > Passing the sysfs name would probably be a good potential argument to
> > the signal, though.  The temperature signal in the patch is just an
> > example.
> 
> That sounds good, but what about a radically different approach?
> 
> What we are fundamentally trying to do is notify user space that a 
> specific attribute of a specific object has had a state change. In your
> example, the object is the cpu, and the attribute is "temperature". Instead 
> of telling the user space daemon that the temperature is "high" (which is 
> an incredibly arbitrary string), we pass the object name and attribute name 
> to user space.  User space can then go read the appropriate sysfs file or take 
> whatever other action is required to determine what the state change actually 
> is.

Agreed.  Not passing the data and just passing a "change occurred" flag
is a good idea in many cases.  For example, for "new filesystem mounted"
I think it makes most sense to just send out a "new filesystem mounted"
signal and not include the data.  Let user-space rescan /proc/mtab in
response.

But we cannot do that for everything.

"high" is only an arbitrary string if it is not standardized.  If the
temperature event is defined to come from such and such an interface,
with such and such values, it is all very easy to use.  I mean, this is
how object systems work today.

> In the case of a file close, the object name is the file path and the 
> attribute could be the ctime, but it needs more thinking.  

This is where the sysfs naming scheme breaks down.  You now have two
different namespaces - kobjects and files on a filesystem.  We really
need something a lot simpler.  Let user-space map stuff around if we
want that.

> > > Question is does it make sense to use this infrastructure without sysfs
> > > as hald, etc require it. ie depends CONFIG_SYSFS
> > 
> > That sounds like policy to me.
> 
> How is this policy? We are simply saying this subsystem in the kernel
> depends on having this other subystem in the kernel. JFFS2 requires
> MTD to be configured since it is layered atop that subsystem.  I think
> this would be no different. 

It is policy because the question was saying "since A is usually used
with B in the context of foo, make A require B."  But
CONFIG_KERNEL_EVENTS does not require sysfs in any way.  Why force there
use together?

Best,

	Robert Love


