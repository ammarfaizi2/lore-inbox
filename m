Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUAZQXD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 11:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUAZQXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 11:23:02 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:61968 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S264305AbUAZQW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 11:22:59 -0500
Date: Mon, 26 Jan 2004 17:22:41 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@osdl.org>
cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
In-Reply-To: <Pine.LNX.4.58.0401251054340.18932@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0401261435160.7855@serv>
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org>
 <Pine.LNX.4.58.0401251054340.18932@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 25 Jan 2004, Linus Torvalds wrote:

>  - doing proper refcounting of modules is _really_ really hard. The reason
>    is that proper refcounting is a "local" issue: you reference count a
>    single data structure. It's basically impossible to make a "global"
>    reference count without jumping through hoops.

IOW module reference counts are evil, no matter what you do it will always
add more overhead. I fully agree with Al, once we have proper per object
protection it's rather easy to build the module infrastructure on top of
it. I only want to add a bit what it means practically.
For example pci drivers currently do something like:

int init()
{
	if (pci_register_driver(drv) < 0)
		pci_unregister_driver(drv);
}

void exit()
{
	pci_unregister_driver(drv);
}

All this is done without a module count, this means that
pci_unregister_driver() cannot return before the last reference is gone.
For network devices this is not that much of a problem, as they can be
rather easily deconfigured automatically, but that's not that easy for
mounted block devices, so one has to be damned careful when to call the
exit function.
To prevent module unloading we usually added a reference to the module, so
the generic module code knows, when it's safe to unload the module. OTOH
with the driver object we can easily tell without any additional overhead
whether the driver is busy, we only have to find a way to tell that the
generic module code.
Technically there are a number of ways to do this, but practically we have
to decide which module unload semantics we want to have and how easy it
should be to upgrade the drivers to this.
We are now in the situation, where we should decide whether we want to
continue the status quo and module unloading stays a PITA or we fix it
properly once and for all, but that requires changing every single driver.
For a large number of drivers (all which Al mentioned) the updates should
be rather staightforward, the rest would simply be not unloadable, unless
they fix their interfaces.

bye, Roman
