Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWCHPau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWCHPau (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 10:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWCHPau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 10:30:50 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:51652 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751013AbWCHPas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 10:30:48 -0500
Date: Wed, 8 Mar 2006 10:30:47 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-usb-devel@lists.sourceforge.net>,
       Linus Torvalds <torvalds@osdl.org>, <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: Fw: Re: oops in choose_configuration()
In-Reply-To: <20060308013101.GB24739@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0603080947270.5220-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2006, Greg KH wrote:

> > As is usual with this particular manifestation, we died here:
> > 
> > 		if (i == 0 && desc->bInterfaceClass == USB_CLASS_COMM
> > 
> > 
> > (gdb) p sizeof(struct usb_interface_descriptor)
> > $3 = 9
> > (gdb) p sizeof(struct usb_host_config)
> > $4 = 280
> > (gdb) p sizeof(struct usb_interface_cache)
> > $5 = 8
> > (gdb) p sizeof(struct usb_host_interface)
> > $6 = 28
> > (gdb) offsetof usb_interface_descriptor bInterfaceClass
> > 5 0x5
> > 
> > And that's quite different.  `struct usb_interface_cache' is only 8 bytes,
> > and the scribble is (as far as we know), not at offset zero.  Unless there
> > are a large number of `usb_host_interface's in `struct
> > usb_interface_cache's variable-sized array, we're not using the size-512
> > slab here.
> > 
> > <looks at choose_configuration()>
> > 
> > 		struct usb_interface_descriptor	*desc =
> > 				&c->intf_cache[0]->altsetting->desc;
> > 
> > Seems funny.
> > 
> > struct usb_interface_cache {
> > 	unsigned num_altsetting;	/* number of alternate settings */
> > 	struct kref ref;		/* reference counter */
> > 
> > 	/* variable-length array of alternate settings for this interface,
> > 	 * stored in no particular order */
> > 	struct usb_host_interface altsetting[0];
> > };
> > 
> > A clearer way of coding that assignment would have been
> > 
> > 		struct usb_interface_descriptor	*desc =
> > 				&c->intf_cache[0]->altsetting[0].desc;
> 
> Agreed.

The C language doesn't make it easy to express the difference between a
pointer, an array, and a pointer to an array, especially when following
a series of links like this one.  I wasn't sure which way of writing it
was best... but if you want to change it, that's fine with me.

> > a) How come we're only considering the zeroth slot in that array in here?
> 
> We start out with the first interface setting, as we always know we have
> one of them as per the USB spec (I think, anyone from linux-usb-devel
> want to verify this?)

In this case it wouldn't make any difference, since all the altsettings
for a particular interface are supposed to have the same bInterfaceClass,
bInterfaceSubClass, and bInterfaceProtocol.  Although I don't think the
USB spec actually says this anywhere, it would be pretty strange if they
didn't.

The bMaxPower value could be different for different altsettings. I
suppose the code could go through and check all the altsettings... but the
routine and the heuristics it implements are already complicated enough.  
Remember, none of this is critical code.  It's a form of kernel policy 
that has been separated out into its own subroutine, as you can see from 
the routine's name.

> > b) How do we know that there's actually anything _there_?  The length of
> >    that variable-sized array doesn't seem to have been stored anywhere
> >    obvious by usb_parse_configuration() and choose_configuration() doesn't
> >    check.  What happens if the length was zero?
> 
> I don't think it is allowed to be, as all USB devices have to have at
> least 1 interface.

The code in usb_parse_configuration() guarantees that the number of
entries in the altsettings array is at least 1, because it sets nalts[n]
to 1 initially and never decreases it.  The whole idea of an interface
without altsettings makes no sense, bacause interfaces come into being
when an interface descriptor (which contains an altsetting index) is
parsed.

The number of entries in the variable-sized array isn't actually stored 
anywhere.  Instead, the code in usb_parse_interface() uses struct 
usb_interface_cache's num_altsetting member to count the number of entries 
in the array that actually get used, which might be less than the number 
that were allocated if the device's descriptors are screwy.

> > drivers/usb/core/config.c hasn't changed since October.  If it was this
> > easy, we'd have hit it before now.
> > 
> > Greg, who knows this code?  Can we triple-check it please?
> 
> I'll walk through it again, it's some nasty crap, I agree.  Time to dig
> out the USB spec...
> 
> Anyone else on linux-usb-devel want to verify it too?

I wrote it originally, and unless someone has changed something while I 
wasn't looking it should still be okay.  If anybody feels like going 
through it in detail... please do; more eyeballs never hurt.  I'm always 
available to answer questions about the code.

Also, as has been mentioned, this stuff has been working perfectly for
quite a while so far as we know.  It seems striking that many of the oops
events Andrew experienced appear to be connected to the uevent stuff in
sysfs, whereas some of the oops reports had no apparent connection with
usb_choose_configuration.  Maybe what's going on involves lots of small
memory allocations in both the USB code and the sysfs code, all around the
same size (hence from the same arenas) and all happening at the same time
(when a new device is discovered).

Perhaps it might help to add some diagnostic stuff to
usb_choose_configuration(), triggered by something like this:

	(((unsigned long) desc) & 0xffffff00) == 0x44535900

When that happens, you could print out the values of all the relevant 
pointers in the definition of desc.  Also print out the surrounding values 
in memory to see what got overwritten and what the new contents are.

Alan Stern

