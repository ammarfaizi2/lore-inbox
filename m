Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbSIWS32>; Mon, 23 Sep 2002 14:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261389AbSIWS32>; Mon, 23 Sep 2002 14:29:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:47757 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261386AbSIWS27>;
	Mon, 23 Sep 2002 14:28:59 -0400
Date: Mon, 23 Sep 2002 11:35:55 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: "Rhoads, Rob" <rob.rhoads@intel.com>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <hardeneddrivers-discuss@lists.sourceforge.net>,
       <cgl_discussion@lists.osdl.org>
Subject: Re: your mail
In-Reply-To: <20020921053214.GA26254@kroah.com>
Message-ID: <Pine.LNX.4.44.0209231000110.6409-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In general, I agree completely with what Greg says (as usual), but I do 
have a few additional comments.

> (I'll skip the intro, and feel good sections and get into the details
> that you lay out, starting in section 2)
> 
> Section 2:
> 2.1:
> 	- do NOT use /proc for driver info.  Use driverfs.
> 	- If you are using a kernel version that does not have driverfs,
> 	  put all /proc driver info under /proc/drivers, which is where
> 	  it belongs.

Actually, they mention using driverfs in Section 3: Instrumentation. I 
can't tell if this was around before, or this was just added. The date is 
the same (16 Aug), but there is no changelog information about the spec. 

I would suggest not using procfs at all, even if driverfs is not avaiable.  
If you're using 2.4, backport driverfs, or clone it for your own
filesystem. It's not dependent on the driver model at all, and has been
done at least once before (Greg's pcihpfs).

> Section 3:

> The Common Statistic Manager:

Please drop the term 'Manager' from your nomenclature. It is ambiguous, 
because of the context in which its generally used in. Windows uses the 
term for any collection of kernel or device data and/or kernel policy. 
It's not a bad term, but it fails to make a clear distinction between 
kernel space and user space, which we insist on. 

Only the mechanism for setting the policy should exist in the kernel, and
itself my be very intelligent. But, the policy itself should exist outside
of the kernel.


> 3.2.5.2:
> (I'm not condoning ANY of these functions or code, just trying to point out how
> you should, if they were to be in the kernel, done properly.)
> 	- do not use typedef
> 	- struct stat_info does not need *unit, as that is already
> 	  specified in the scale field, right?
> 	- the stat_value_t union is just a horrible abomination, don't
> 	  do that.

Please do not pass void *. You should only pass type-safe structures. If 
you cannot get that information, you should redesign the API. 

> 3.4 Event logging:
> 	- I'm not even going to touch this, sorry.

There are a lot of topics in this spec, most of which are irrelevant to 
actually hardening drivers. They may be features dependent on your APIs, 
but they are completely optional and may hinder acceptance of your primary 
objectives. 

Event logging is definitely one of them, esp. with a function like

evl_log_event_string(  
	ME_EVENT_BUCKET_EMPTY, 
	LOG_WARNING, 
	"Leaky bucket exception (bucket empty):\ 
	Bucket_Level <= Observed_Value - Last_Value\ 
	|%s=%s|%s=%s|%s=%s|%s=%s|%s=%s|%s=%s|%s=%s|%s=%s\ 
	|%s=%u|%s=%u|%s=%u|%s=%u|%s=%u|%s=%u|", 
	RMGT_FacilityIDAttrStr,         RMUUID, 
	RMGT_SubsystemIDAttrStr,    SUBSYSTEM_UUID, 
	RMGT_SubsystemNameAttrStr,  subsystem_name, 
	RMGT_ResourceIDAttrStr,         resource_id, 
	RMGT_ResourceNameAttrStr,   resource_name, 
	ME_MonitorIDAttrStr,        monitor_uuid,  
	ME_StatisticIDAttrStr,         statistic_id, 
	ME_StatisticNameAttrStr,    statistic_name,  
	ME_BucketSizeAttrStr,       bucketsz,  
	ME_FillValueAttrStr,            fillval, 
	ME_FillIntervalAttrStr,         fillint, 
	ME_BucketLevelAttrStr,      bucketlvl, 
	ME_ObservedValueAttrStr,    obsval, 
	ME_LastValueAttrStr,        lastval); 


> In summary, I think that a lot of people have spent a lot of time in
> creating this document, and the surrounding code that matches this
> document.  I really wish that a tiny bit of that effort had gone into
> contacting the Linux kernel development community, and asking to work
> with them on a project like this.  Due to that not happening, and by
> looking at the resultant spec and code, I'm really afraid the majority
> of that time and effort will have been wasted.

I completely agree. There is definitely good intention in some aspects of 
the spec, and definitely in the effort put forth to support this type of 
work. But, in order to gain the support of kernel developers, or even the 
blessing of a few, you should be working with them on the design from the 
beginnging.

Designing APIs is hard. Doing it well is very hard. I'm not claiming I've 
done a stellar job, but I have at least learned that. I've made a lot of 
poor design decisions, many of which are also evident in your code 
descriptions and examples. I can't tell you how many times I've rewritten 
things over and over and over because someone hated them (usually Linus or 
Greg).

There are people that are willing to help, as we are trying to do. But,
it's much easier if you do things gradually and get that help from the
beginning.

> What do I think can be salvaged?  Diagnostics are a good idea, and I
> think they fit into the driver model in 2.5 pretty well.  A lot of
> kernel janitoring work could be done by the CG team to clean up, and
> harden (by applying the things in section 2) the existing kernel
> drivers.  That effort alone would go a long way in helping the stability
> of Linux, and also introduce the CG developers into the kernel community
> as active, helping developers.  It would allow the CG developers to
> learn from the existing developers, as we must be doing something right
> for Linux to be working as well as it does :)

Which kernel are you targeting? I didn't see it in the spec, though I 
could have easily missed it. CGL is based on 2.4, so I would assume that. 
But, I would think the ideal choice would be to start in 2.5 and backport 
it to 2.4. 

If that's the case, how do you intend to work with the driver model? 
There will be quite a bit of code and interface duplication between
your code and the driver model. I can see ways to support many of the
things you want in a relatively easy manner, and not punish the common
user or developer; but the margin is to small to write the answer... ;)

Also, there are many projects in areas similar to what your doing: 
diganostics, HA, etc, etc. It would be nice to see some collaboration 
between the developers of those projects instead of having many disparate 
projects with similar goals. 


	-pat






