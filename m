Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263444AbSIUF1j>; Sat, 21 Sep 2002 01:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263460AbSIUF1j>; Sat, 21 Sep 2002 01:27:39 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:44301 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263444AbSIUF1h>;
	Sat, 21 Sep 2002 01:27:37 -0400
Date: Fri, 20 Sep 2002 22:32:15 -0700
From: Greg KH <greg@kroah.com>
To: "Rhoads, Rob" <rob.rhoads@intel.com>, linux-kernel@vger.kernel.org,
       hardeneddrivers-discuss@lists.sourceforge.net,
       cgl_discussion@lists.osdl.org
Message-ID: <20020921053214.GA26254@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cgl_discussion@lists.osdl.org, hardeneddrivers-discuss@lists.sourceforge.net
Cc: 
Bcc: 
Subject: 
Reply-To: 

hardeneddrivers-discuss@lists.sourceforge.net,
cgl_discussion@lists.osdl.org
Bcc: 
Subject: my review of the Device Driver Hardening Design Spec
Reply-To: 
In-Reply-To: <20020921014054.GA25665@kroah.com>

On Fri, Sep 20, 2002 at 06:40:54PM -0700, Greg KH wrote:
> Hi,
> 
> I've just started to read over the published spec, and will reserve
> comment on it, and the example code you've created after I'm done
> reading it.

Ok, here's some comments on the 0.5h release of the Device Driver
Hardening Design Specification:

(I'll skip the intro, and feel good sections and get into the details
that you lay out, starting in section 2)

Section 2:
2.1:
	- do NOT use /proc for driver info.  Use driverfs.
	- If you are using a kernel version that does not have driverfs,
	  put all /proc driver info under /proc/drivers, which is where
	  it belongs.
	- Only have 1 value per file, and no binary data in the files.
	- Do not put the "kernel version for which the driver was
	  compiled", as that _always_ much match the kernel version that
	  is running, so is redundant.

2.2:
	- do NOT use typedef

2.5.5:
	- you do not have to always check data returned from functions,
	  if you wrote the functions in the first place.  Redundant
	  checking of all data within the kernel, slows things down.
	  Sure, some checking is good, but do not say that it is a
	  requirement, or no one will want to use your driver.

The majority of section 2 is very nice, it's a good list of things that
drivers should do.


Section 3:

Wow, where to start...

The Common Statistic Manager:
	- why does this have to live in the kernel?  It should be in
	  userspace, grabbing all of the data from the /proc files you
	  just specified in section 2.1.
	  
POSIX event logging:
	- wow, not much I can say here, that hasn't already been said
	  before :(

Diagnostics:
	- now these are a good idea.  A common subsystem that drivers
	  can register what kind of diagnostics they can run on their
	  hardware, nice.

3.1.1:
	- UUIDs!!!???  You have got to be kidding.  Here, for the
	  benefit of those who have not read this, I'll quote:
	  	"Each subsystem, and each resource contained within each
		subsystem, needs to be uniquely identified.  In order to
		do this a hardened driver developer shall pre-assign a
		Universally Unique Identifier (UUID) as the Subsystem ID
		for each subsystem, and shall provide a means to assign
		a unique Resource ID string for each resource within a
		subsystem."
	
	 So for every resource, a string shall be associated with it.
	 But that means for most resources, the string will take up more
	 memory than the resource itself does.  Does that make sense?

	 It's also up to the driver to create these resource ids at
	 runtime and guarantee their uniqueness over the lifetime of the
	 kernel.  How in the world can you expect every driver author to
	 do this?  Any example code out there?

	 And what are these UUIDs going to be used for, ah, event
	 logging.  Enough said.

3.2 Statistics:
	You actually want every driver to support SNMP compliant
	statistics groups within themselves?  Why?  What a bloat of a
	kernel.

	All of this should be done (if at all) from userspace.
	

3.2.5.2:
(I'm not condoning ANY of these functions or code, just trying to point out how
you should, if they were to be in the kernel, done properly.)
	- do not use typedef
	- struct stat_info does not need *unit, as that is already
	  specified in the scale field, right?
	- the stat_value_t union is just a horrible abomination, don't
	  do that.

3.3 Diagnostics:
	- not a bad idea, but some work could be done on the
	  implementation.  Would fit in nicely with the device driver
	  model in 2.5.  For 2.4, it would be another subsystem a driver
	  would register with.

3.3.3.2:
	- no typedefs
	- run() is horrible, you are trying to fit all kinds of possible
	  diagnosis into one function callback.  Not a good idea.
	  Break the different kinds of callbacks out into different
	  functions.  That ensures type safety, right now you are just
	  creating another ioctl() type mess.

3.4 Event logging:
	- I'm not even going to touch this, sorry.

4: High Availability
	- are you all working with the existing HA group?

4.1:
	- um, what are you trying to say here.  This section is
	  pointless.  Yes we all think Hot Swap is a good idea, that's
	  why Linux currently supports it.

4.2:
	- RAID and ethernet bonding is nice. Again, Linux already has
	  projects and support for these things.  Why mention them?


The rest of this section is fine, and I welcome any test harnesses that
are created to do this kind of fault injection for driver testing.

5:
	- Here you back-pedal on everything you said up till now.  Let
	  me summarize what is said in these 3 paragraphs in 1 sentence:
	  	"Yes, all these things are well and good, but don't let
		them effect the currently great performance Linux has
		today."
	  Sorry, but you can't have it both ways.

5.1:
	- do NOT use #ifdef in the .c files.  Only in .h files.
	- why is CONFIG_DRIVER_HOTSWAP an option.  What does it do that
	  CONFIG_HOTPLUG does not do today?
	- actually, what do any of these CONFIG_ options do, and why
	  would someone not want the CONFIG_DRIVER_ROBUST to be always
	  enabled?


In summary, I think that a lot of people have spent a lot of time in
creating this document, and the surrounding code that matches this
document.  I really wish that a tiny bit of that effort had gone into
contacting the Linux kernel development community, and asking to work
with them on a project like this.  Due to that not happening, and by
looking at the resultant spec and code, I'm really afraid the majority
of that time and effort will have been wasted.

What do I think can be salvaged?  Diagnostics are a good idea, and I
think they fit into the driver model in 2.5 pretty well.  A lot of
kernel janitoring work could be done by the CG team to clean up, and
harden (by applying the things in section 2) the existing kernel
drivers.  That effort alone would go a long way in helping the stability
of Linux, and also introduce the CG developers into the kernel community
as active, helping developers.  It would allow the CG developers to
learn from the existing developers, as we must be doing something right
for Linux to be working as well as it does :)

Also, open specs for the hardware the CG members produce, to allow
existing kernel drivers to be enhanced (instead of having to be reverse
engineered), and new kernel drivers to be created, would also go a long
way in helping out both the CG's members and the entire Linux
community's cause of having a robust, stable kernel be achived easier.
Closed specs, and closed drivers do not help anyone.


thanks for reading this far,

greg k-h
