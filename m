Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUGXPIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUGXPIx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 11:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268665AbUGXPIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 11:08:53 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:18311 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264260AbUGXPIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 11:08:50 -0400
Date: Sat, 24 Jul 2004 08:08:38 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Robert Love <rml@ximian.com>
Cc: Michael Clark <michael@metaparadigm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040724150838.GA24765@plexity.net>
Reply-To: dsaxena@plexity.net
References: <1090604517.13415.0.camel@lucy> <4101D14D.6090007@metaparadigm.com> <1090638881.2296.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090638881.2296.14.camel@localhost>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 23 2004, at 23:14, Robert Love was caught saying:
> On Sat, 2004-07-24 at 11:02 +0800, Michael Clark wrote:
> 
> > Should there be some sharing with the device naming of sysfs or are
> > will we introduce a new one? ie sysfs uses:
> >
> > devices/system/cpu/cpu0/<blah>
> >
> > Would it be a better way to have a version that takes struct kobject
> > to enforce consistency in the device naming scheme. This also means
> > userspace would automatically know where to look in /sys if futher
> > info was needed.
> 
> No, we want to give an interface that matches the sort of provider URI
> used by object systems such as CORBA, D-BUS, and DCOP.  We also do _not_
> want to put policy in the kernel.

What if I don't want something as heavyweight as D-BUS to handle this
for me and just want a simple parser that can tell me "this device
has x event". The kernel simply is telling user space that there
is an event and should not know/care how and by what it is handled.
Saying CORBA, D-BUS, DCOP use this naming scheme so we whould too
seems like policy to me. If I am a driver writer and I want to just 
send some state change notification, I do not want to care about such 
things. I want to be able to use a name that makes sense in the
context of the kernel and using a kobject sounds good b/c then I really
don't have to care about naming and will be less prone to errors
from typos and such. Remember, the user space deamons are not the ones 
that will actually call these functions. It is kernel code and the API
needs to be easilly useable by kernel programers.

> The easiest way to avoid that is simply to use a name similar to the
> path name.

What is the path name of a device from the kernels point of view?
Since device naming in /dev is left up to userland now, it has to
be something else that the kernel is aware of.

> Passing the sysfs name would probably be a good potential argument to
> the signal, though.  The temperature signal in the patch is just an
> example.

That sounds good, but what about a radically different approach?

What we are fundamentally trying to do is notify user space that a 
specific attribute of a specific object has had a state change. In your
example, the object is the cpu, and the attribute is "temperature". Instead 
of telling the user space daemon that the temperature is "high" (which is 
an incredibly arbitrary string), we pass the object name and attribute name 
to user space.  User space can then go read the appropriate sysfs file or take 
whatever other action is required to determine what the state change actually 
is.  In the case of a file close, the object name is the file path and the 
attribute could be the ctime, but it needs more thinking.  

> > Question is does it make sense to use this infrastructure without sysfs
> > as hald, etc require it. ie depends CONFIG_SYSFS
> 
> That sounds like policy to me.

How is this policy? We are simply saying this subsystem in the kernel
depends on having this other subystem in the kernel. JFFS2 requires
MTD to be configured since it is layered atop that subsystem.  I think
this would be no different. 

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
