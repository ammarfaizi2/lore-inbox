Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbUJYIdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbUJYIdd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUJYIa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:30:27 -0400
Received: from [211.58.254.17] ([211.58.254.17]:54165 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261692AbUJYI25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 04:28:57 -0400
Date: Mon, 25 Oct 2004 17:28:54 +0900
From: Tejun Heo <tj@home-tj.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mochel@osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] Per-device parameter support (13/16)
Message-ID: <20041025082854.GA22392@home-tj.org>
References: <20041023043138.GN3456@home-tj.org> <1098684490.8098.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098684490.8098.54.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 04:08:10PM +1000, Rusty Russell wrote:
> You need __attribute__((aligned(sizeof(void *))): see moduleparam.h.
> The padding between structures is arch-dependent (x86-64 found out the
> hard way when we changed kernel_param previously).  Not sure why you're
> using a separate section here anyway.

 As the defs array of struct device_paramset_def is assembled by
putting struct device_params continuosly, there shouldn't be any other
intervening data while defining the array.  So, the wrapping arguments
(struct kparam_array, struct kparam_flag) should stay out of line.
That's why they're put in different subsections.

> > +/* Bit flag */
> > +#define __DEVICE_PARAM_FLAG(Name, Field, Flag, Dfl, Inv, Perm, Desc)	\
> > +	param_check_uint(__devparam_data(Name),				\
> > +			 &(((__devparam_type *)0)->Field));		\
> > +	static struct kparam_flag __devparam_data(__param_flag_##Name)	\
> > +	__devparam_extra_section = { 0, Flag, Inv };			\
> > +	__DEVICE_PARAM_CALL_RANGED(Name, param_set_flag, param_get_flag,\
> > +		&__devparam_data(__param_flag_##Name),			\
> > +		sizeof(struct kparam_flag), 1, 0, Dfl, 0, Perm, Desc,	\
> > +		offsetof(struct kparam_flag, pflags),			\
> > +		offsetof(__devparam_type, Field), -1, -1)
> > +
> > +#define DEVICE_PARAM_FLAG(Name, Field, Flag, Dfl, Perm, Desc)		\
> > +	__DEVICE_PARAM_FLAG(Name, Field, Flag, Dfl, 0, Perm, Desc)
> 
> Haven't read closely, but why is FLAG special?

 Because flag requires wrapping struct kparam_flag structure.  As I've
explained in another mail, wrapping structures need to be copied and
fixed up before being used.  So, the sizeof and offsetof's.

> I think your macros might be better off always having the range, which
> would reduce the number of functions..  I like including the description
> in the macros: that's an improvement.
> 
> I always disliked the _NAMED versions (if it's a good name for users,
> it's usually a good name for the variable and vice versa), but you might
> want to consider always having it if that's the common case.

 Again, I just think it's better to be a bit rich in module/device
parameter handling and provide convenient interface as it can reduce
code in many places.  But that's me. :-)

 As this is the last mail of this series of replies, I want to add
some more stuff to discuss about.

 1. What do you think about merging bus_paramset_def, dev_paramset_def
and aux_paramset_defs into single paramset_defs array.  The only
functional difference is that, with the change, a driver should
explicitly specify the corresponding bus paramset_def and pass the
resulting paramset to the bus registration function explicitly if the
bus wants to accept its own paramset.

 I think it's better because it's simpler and more consistent, and it
gives drivers a chance to peek or mangle bus parameters as needed.

 2. What do you think about adding support for user-controllable
device - driver association?  We'll be able to tell the kernel to
'associate device A to driver B with these parameters'.  With proper
user-space programs we'll be able to have fine control over device
drivers.  Also, user-space tool will be able to set the kernel device
name as it likes from the start so discrepancies between kernel device
names and user-space device names can be removed (udev).

 What I was thinking was

- adding a sysctl variable which enables the feature and when it's
enabled the kernel stops automatically associating devices to matching
drivers.
- User space tool can write to a driver sysfs node (maybe named
attach) to attach a specific device to the driver.
- A device - driver association is represented by a child kobject of
the associated driver or device.
- Detaching can be done by deleting the file representing the
association.  Or writing to a detach sysfs file.

 As there's no kobject which represents device - driver association,
devparam currently makes a child kobject of the corresponding device
node itself (the params subdirectory).

 3. How about adding a mechanism to automatically add min, max and
default value to @Desc.  Though I'm not so sure about this one.

 Thanks a lot. :-)

-- 
tejun

