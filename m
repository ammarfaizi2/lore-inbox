Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbTJ1SSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 13:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTJ1SSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 13:18:37 -0500
Received: from mail.kroah.org ([65.200.24.183]:952 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264073AbTJ1SSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 13:18:12 -0500
Date: Tue, 28 Oct 2003 10:17:07 -0800
From: Greg KH <greg@kroah.com>
To: Mark Bellon <mbellon@mvista.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: ANNOUNCE: User-space System Device Enumeration (uSDE)
Message-ID: <20031028181707.GA7225@kroah.com>
References: <Pine.LNX.4.44.0310271343170.13116-100000@cherise> <3F9DA5A6.3020008@mvista.com> <20031027233934.GA3408@kroah.com> <3F9EABC1.9070009@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9EABC1.9070009@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 28, 2003 at 10:47:45AM -0700, Mark Bellon wrote:
> >What are your requirements, and why does udev not meet them?  Is there
> >some major disagreement between what udev does, and what you want to do?
> >If so, what?
> >
> The requirements were collected from the OSDL CGL requirements 
> specification version 1.0 and 1.1 ratified September 2002. They come 
> from extensive discussions with the OSDL members as part of the 
> definition of these requirements, expounding on them:

Wait, all the Carrier Grade Linux Requirement Definition Version 2.0 say
about "Persistent Device Naming" is the following:

	OSDL CGL specifies that carrier grade Linux shall provide
	functionality such that a device's identity shall be maintained
	when it is removed and reinstalled even if it is plugged into a
	different bus, slot, or adapter.  "Device identity" is the name
	of the device presented to user space, and this identity is
	assigned based on policies set by the administrator, e.g., based
	on location or hardware identification information.

Which is all well and good, as nameif satisfies this requirement :)

But for you to read more into this, is fine, just don't say that it is
required by the CGL spec.

> * The embracing of all device types with no specialization or limitation.

"all" is a wide range.  Do you mean you are handling ethernet devices in
uSDE?  Why when nameif is already in use by all distros today, and
satisfies almost everyone's needs.

udev does not handle network devices, because there is already
infrastructure to handle them just fine.

> * The ability to have total control over the handling a device via 
> external policy programs. Policy programs are invoked with a formal 
> command line and description of the event that caused there invocation.

Hm, like the "CALLOUT" function in udev?

> * The "service container" concept. A device is classified (or recognized 
> by a pattern match) and this raises an (queued) event which is caught by 
> a configurable "service container". The container is an ordered list of 
> handlers that process the device.

Ah, I love "design patterns" as much as the software engineer.  But can
you try to explain how this will help out any user?  It just seems to
make the code more complex and larger than it needs to be.

> * Event queuing and aggregation. Minimizing the number of program 
> invocations (fork/exec) is critical in embedded environments - small 
> processors.

Wait, you say above that you have to be able to call out to "external
policy programs".  Now you say that you never want to call fork/exec,
ever.  Which is it? 

And you all _keep_ saying this without ever providing any numbers to
back this up.  Linux has the fastest fork/exec than any other OS out
there right now.  Again, do you have REAL NUMBERS that show this is a
problem?  As I've found out in testing udev, devices are slow compared
to fork/exec.  My old, slow, and no memory 300Mhz laptop can _easily_
outrun the ability for the scsi core to create virtual devices.  So much
that I have to put sleep() calls in udev just to slow it down to wait
for the kernel to catch up.  Using real scsi devices is a piece of cake,
they take seconds to initialize.

I think you have found the same thing in your testing, or so you nodded
in agreement when I said this at the last CGL meeting.

> * Aggressive device enumeration. Multiple concurrent policy execution 
> and management.

"Aggressive"?  That's an odd use of an adjective :)
What does this really mean, in simple terms.

> * Device information persistence is a function of device policies, not 
> the enumeration framework.

What does this mean?

> There are many situation where persistence is not an issue at all or 
> only in specific cases (like disks). Why always pay for the memory/disk, 
> for persistence, when it is not (always) necessary?

What memory?  udev is only 45Kb, static, which I know is _quite_
different from uSDE, based on the number of shared libraries you use,
and build :)

Anyway, if you don't have a rule for a device, udev just uses the kernel
name, no harm or overhead there.  What is the real point here?

> * Transactional protection of multiple configuration files is necessary. 
> Multiple configuration files must often be modified in unison and 
> insurance is necessary that an accurate and correct set of data is used 
> when processing devices.

Ah, mom and apple pie.  I love those things too.  But what is the real
point?  Don't have multiple config files?  If that's a real problem,
then don't do that.  Or put your config into a database if again, it's a
real problem.  But I don't see the problem.  An admin changes the config
file, sends a SIGHUP to the daemon, which reloads the config file, and
everyone is happy.

Why should this be any different from what runs important programs
today, like your mail or web server?

> >udev has been out in the world since April, any reason for not helping
> >out with the existing project instead of going off and starting your
> >own?  It's not that I mind competing projects, it's just that I don't
> >see your reasoning as to why there needs to be two different ones.
> > 
> >
> The two packages take philosophically different approaches and arrive 
> with (largely) overlapping and some non-overlapping capabilities - after 
> all they are both trying to do "the same thing". The uSDE has strengths 
> and weaknesses just as udev or any program does. It is certainly 
> possible to discuss changes (and make patches) to udev to incorporate 
> the key issues addressed in the uSDE implementation.

Besides the refusal to handle network devices, I don't see any thing
that udev is lacking that uSDE has.  But I'm not too familar with uSDE,
being that it has only been released for a few days now.  If you could
point out anything that udev is lacking, I would be glad to help solve
that.

thanks,

greg k-h
