Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269828AbUIDHvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269828AbUIDHvv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 03:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269829AbUIDHvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 03:51:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:31191 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269828AbUIDHvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 03:51:47 -0400
Date: Sat, 4 Sep 2004 02:54:33 +0200
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@ximian.com>
Cc: akpm@osdl.org, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040904005433.GA18229@kroah.com>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com> <20040831145643.08fdf612.akpm@osdl.org> <1093989513.4815.45.camel@betsy.boston.ximian.com> <20040831150645.4aa8fd27.akpm@osdl.org> <1093989924.4815.56.camel@betsy.boston.ximian.com> <20040902083407.GC3191@kroah.com> <1094142321.2284.12.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094142321.2284.12.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I'm at a conference, so email access is flaky at times...

On Thu, Sep 02, 2004 at 12:25:21PM -0400, Robert Love wrote:
> On Thu, 2004-09-02 at 10:34 +0200, Greg KH wrote:
> 
> > Why is the kset needed?  We can determine that from the kobject.
> > 
> > How about changing this to:
> > 	int send_kevent(struct kobject *kobj, struct attribute *attr);
> > which just tells userspace that a specific attribute needs to be read,
> > as something "important" has changed.
> > 
> > Will passing the attribute name be able to successfully handle the 
> > "enum kevent" and "signal" combinations?
> 
> We can drop the kset if you say we never need it.  Why do all the kobj
> get_path functions take a kset then?  That is what confused me.

Look at kobject_hotplug.  We can determine the kset assigned to a
kobject with the logic in that function.  Then we use the kset to get
the path and other good stuff that the hotplug call needs.

> We can also drop the "enum kevent" if we decide we don't want to take
> advantage of the multicasting of the netlink socket.  The enum defines
> what multicast group the netlink message is sent out in.  I actually
> have been talking to Kay about ditching it, and we are trying to figure
> out if we ever _need_ it.

Sounds fine to me.

> So that is 2 for 2.  But ...
> 
> I don't dig replacing the signal string with an attribute.  I think it
> will really limit what we can do - having the signal as a verb
> describing the event is really important.  We might also not always have
> an attribute.  Kay's points are all valid.
> 
> So what if we had
> 
> 	int send_kevent(struct kobject *kobj, const char *signal);
> 
> Which was a way of notifying user-space of a change of "signal" on the
> object "kobj" in sysfs.

Ok, I'll accept that, and I like it, it's simple, and yet powerful for
pretty much everything we'll need in the future.

In fact, I like that type of function so much, I wrote it a few years
ago:
	void kobject_hotplug(const char *action, struct kobject *kobj)

You fell right into my trap :)

So, we're back to the original issue.  Why is this kernel event system
different from the hotplug system?  I would argue there isn't one,
becides the transport, as you seem to want everything that we currently
provide in the current kobject_hotplug() call.

But transports are important, I agree.

How about you just add the ability to send hotplug calls across netlink?
Make it so the kobject_hotplug() function does both the exec() call, and
a netlink call (based on a config option for those people who like to
configure such stuff.)

That way, programs who want to listen to netlink messages to get hotplug
events do so, and so does programs who want to do the /etc/hotplug.d/
type of notification?

Oh, and attributes.  How about we just change kobject_hotplug() to be:
	int kobject_hotplug(const char *action, struct kobject *kobj, struct attribute *attr);
and if we set attr to be a valid pointer, we make the DEVPATH paramater
contain the attribute name at the end of it.

I'd be glad to accept a patch that implements this.

Look acceptable?

thanks,

greg k-h
