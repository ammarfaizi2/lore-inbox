Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbSKYAX7>; Sun, 24 Nov 2002 19:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbSKYAW6>; Sun, 24 Nov 2002 19:22:58 -0500
Received: from dp.samba.org ([66.70.73.150]:1978 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262040AbSKYAWu>;
	Sun, 24 Nov 2002 19:22:50 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, perex@suse.cz
Subject: Re: [PATCH] Module alias and table support 
In-reply-to: Your message of "Wed, 20 Nov 2002 00:23:30 -0800."
             <20021120082330.GD22408@kroah.com> 
Date: Mon, 25 Nov 2002 10:34:16 +1100
Message-Id: <20021125003005.2AB4B2C0BF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021120082330.GD22408@kroah.com> you write:
> On Thu, Nov 14, 2002 at 12:19:51PM +1100, Rusty Russell wrote:
> > 	The idea that modules can contain a ".modalias" section of
> > strings which are aliases for the module.  Every module goes through a
> > "finishing" stage (scripts/modfinish) which looks for __module_table*
> > symbols and uses scripts/table2alias.c to add aliases such as
> > "usb:v0506p4601dl*dh*dc*dsc*dp*ic*isc*ip*" which hotplug can use to
> > probe for matching modules.
> 
> How are you going to be able to handle hex values in that string?  Or
> are you just going to rely on the fact that no valid hex value can be a
> identifier?  You might want to add a ':' or something between fields to
> make it easier to parse, unless you've already written a bash and C
> parser that I can use :)

Yes, good idea.  Of course, you shouldn't need to parse them, you just
need to create them, but clearer is better (I'd use , not : though).

> Hm, there goes my wonderful % decrease in size claims of diethotplug if
> we shink the original size of the module_table files...

Sorry.  I'll try to be less efficient in the future.

> We're already including other kernel header files, why not include usb.h
> too?  That way we don't have to remember to update the structures in two
> places.
> 
> > +        /* not matched against */
> > +        kernel_long     driver_info;
> 
> Or is it because of "kernel_long"?  I'm pretty sure this field is only
> used within the kernel, and userspace does not care at all about it.

It sucks to reproduce this, yes.  But you need to know the size of the
structure to grab it out of the object file.  At least this way it's
in the kernel source where we can change it.

> > +/* Looks like "usb:vNpNdlNdhNdcNdscNdpNicNiscNipN" */
> > +static int do_usb_table(void)
> > +{
> > +        struct usb_device_id id;
> > +        int r;
> > +        char alias[200];
> > +
> > +        while ((r = xread(STDIN_FILENO, &id, sizeof(id))) == sizeof(id)) {
> > +                TO_NATIVE(id.match_flags);
> > +                TO_NATIVE(id.idVendor);
> > +                TO_NATIVE(id.idProduct);
> > +                TO_NATIVE(id.bcdDevice_lo);
> > +                TO_NATIVE(id.bcdDevice_hi);
> > +
> > +                strcpy(alias, "usb:");
> > +                ADD(alias, "v", id.match_flags&USB_DEVICE_ID_MATCH_VENDOR,
> > +                    id.idVendor);
> 
> Why are you doing this "preprocessing" of the flags and the different
> fields?  If you do this, you mess with the logic of the current
> /sbin/hotplug tools a lot, as they expect to have to do this.

	The plan was that /sbin/hotplug will gather all the fields for
whatever device has been inserted and create the modprobe string, eg:

		system("modprobe usb:v0506p4601dl01dh01dc01dsc01dp01ic01isc01ip01");

	Which will simply match the alias such as:
		usb:v0506p4601dl*dh*dc*dsc*dp*ic*isc*ip*

> Also realize that if you do this, you can't generate the existing
> modules.*map files from the exported values.

	Hmm, I thought about enhancing this code to generate the .map
files as well (where it has all the information).  BTW, did I break
the current depmod map-generating code?

> In summary, I like the idea, and removing userspace knowledge of kernel
> structures is very nice.  Just a few tweaks are needed.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
