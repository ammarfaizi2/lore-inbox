Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265443AbTFMQf3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265444AbTFMQf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:35:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:20355 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265443AbTFMQfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:35:15 -0400
Date: Fri, 13 Jun 2003 09:50:44 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Steven Dake <sdake@mvista.com>
cc: Oliver Neukum <oliver@neukum.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
In-Reply-To: <3EE9F5C7.8070304@mvista.com>
Message-ID: <Pine.LNX.4.44.0306130942040.908-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >+static int sdeq_open (struct inode *inode, struct file *file)
> >+{
> >+	MOD_INC_USE_COUNT;
> >+
> >+	return 0;
> >+}
> >+
> >+static int sdeq_release (struct inode *inode, struct file *file)
> >+{
> >+	MOD_DEC_USE_COUNT;
> >+
> >+	return (0);
> >+}
> >
> >Wrong. release does not map to close()
> >
> >  
> >
> hmm not sure where I got that from i'll fix thanks.

You don't even need to modify the module refcount, since sdeq cannot even 
be built as a module. Also, return is a statement, not a function; you 
could at least be consistent. 

> For device enumeration, I see a daemon as necessary.  The main goal of 
> this work is to solve the out-of-order execution of sbin/hotplug and 
> improve performance of the system during device enumeration with 
> significant (200 disks, 4 partitions each) amounts of devices.  Boot 
> time with this scheme appears, in my rudimentary tests, to be faster on 
> the order of 1-2 seconds for bootup for the case of just 12 disks.  I 
> would imagine 200 disks (which I don't have a good way to test, as I 
> don't have 200 disks:) would provide better speed gains during bootup.  
> This compares greg's original udev to this patched udev binary.

This part I really don't get about your argument. 

For one, please back up your claim with the method that you used to test
and post some real numbers, showing real improvement. If you would like
more hardware to test on, we have an entire lab full of large systems
specifically for purposes like this. I don't know if we have a 200 disk
library, but you can see what you can get at:

	http://osdl.org/stp/


For another, you're preaching about availability, from I presume the 
carrier-grade camp, since Montavista has a CG distro, and you're involved 
in our own CGL working group. But, I have never heard of a carrier-grade 
system that used 12 disks, let alone 200. I fail to see how you're backing 
up your argument about the 1 second that you saving with a realistic 
example. 

But, I also don't think that the speed hit would increase linearly.

Besides, even if the system had access to 200+ disks, it's probably in a 
separate library, accessible to an/the entire cluster. It's likely also a 
commercial storage library, and not a linux system. 

Please, educate me and prove me wrong; I'm not opposed to new ways of 
thinking. 

> devfs is not appropriate as it does not allow for complex policy with 
> external attributes that the kernel is unaware of.  For an example, lets 
> take the situation where a policy must access a cluster-wide manager to 
> determine some information before it can make a policy decision.  For 
> that to occur, there must be sockets, and hopefully libc, which puts the 
> entire thing in user space.  Who would want to write policies in the 
> kernel?  uck.

Cluster-wide manager of policy? Fine, you can do that with /sbin/hotplug, 
too. But, I don't think network latency is going to help your boot time..


	-pat

