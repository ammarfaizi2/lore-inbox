Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbTLLL0s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 06:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264532AbTLLL0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 06:26:48 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:9347 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S264526AbTLLL0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 06:26:46 -0500
Date: Fri, 12 Dec 2003 11:26:36 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Message-ID: <20031212112636.GA12727@mail.shareable.org>
References: <20031208154256.GV19856@holomorphy.com> <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com> <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org> <20031209075619.GA1698@kroah.com> <1070960433.869.77.camel@nomade> <20031209090815.GA2681@kroah.com> <buoiskqfivq.fsf@mcspd15.ucom.lsi.nec.co.jp> <yw1xd6ayib3f.fsf@kth.se> <3FD5AB6C.3040008@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD5AB6C.3040008@aitel.hist.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> And if you want to run this way with udev, set it up so device nodes
> don't get deleted when the device unloads.  That way you keep
> device nodes for your driverless devices, and when you try to open
> them the kernel runs modprobe for you.  Devfs isn't needed for that
> afaik, it is only needed for modprobing devices that doesn't have
> a /dev entry yet.
> 
> Your /dev will contain nodes both for driven and non-driven
> devices, but not for devices you don't have at all.


If anyone wants to do this _properly_, this is what to do:

    1. Let hotplug+udev load modules and create devices as they do now.

    2. Keep track of when devices are used, and when they are not busy.
       We already have this, it's the module reference count.

    3. When a device has not been used in a while, convert it to an
       "inactive" state.  In this state, the hardware device is made
       quiescent and interrupt handlers are unregistered (perhaps
       temporarily; the interrupt might still be claimed, but the
       handler must not be called).

       The power management hooks should be involved, as this is an
       ideal opportunity to power down a device to a low-power or off
       state, just like during APM/ACPI suspend.

    4. Make module code pages _demand-pagable_ from the original place
       where the module was loaded when all devices using the module
       are in the inactive state.

       This forces the module file to be kept open, so demand paging
       may be optionally disabled allowing the underlying fs to be
       unmounted.


This will create all the correct device entries for hardware which is
permanent or plugged in whether used or not; it will remove device
entries for hardware which is unplugged; it will retain state
across device opens, and it will save memory.

The traditional problems with making module code swappable are that
swapping is not safe in critical sections like interrupt handlers, and
you never know which modules are needed for swapping.  The former is
solved by locking the code in RAM while the devices are active and
have registered interrupt handlers (or other callbacks).  The latter
is obviously likely with the IDE or filesystem modules, but what if
I'm swapping over a multi-route network where the backup link is
on-demand PPP over a software modem over my ALSA driven radio card?

That last problem is not solved in general by the current
/etc/modprobe.conf method of loading whole modules on demand.  However
any system which works with whole module demand loading, and several
more, will work automatically with demand-paged modules.

A demand-paged module retains a reference to the filesystem it is
mounted on, and it may be generally assumed that the filesystem will
stay accessible e.g. as a local disk, boot-time accessible NFS,
initramfs, or even an embedded ROM.

If the filesystem's underlying device or network is dependent on a
module, the mount reference will ensure that device cannot enter the
inactive state, so the situation of a module being paged out which is
needed to page it back in won't arise, except in the most contrived
situations such as modules being loaded over NFS over an on-demand
network link.  Even then, the failure case is well confined: the
kernel's attempt to make a device "active" will fail in userspace at
the point where it tried to open the device, configure the network
interface or whatever else would cause a module to be demand loaded.

Now that the kernel parses ELF module files itself, this idea is much
more feasible than it once was.

-- Jamie
