Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUAYTDG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUAYTDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:03:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:9156 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265141AbUAYTDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:03:03 -0500
Date: Sun, 25 Jan 2004 11:02:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
cc: Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
In-Reply-To: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.58.0401251054340.18932@home.osdl.org>
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Jan 2004, Alan Stern wrote:
> 
> Is there some reason why modules don't work like this?

There's a few:

 - pain. pain. pain.

 - doing proper refcounting of modules is _really_ really hard. The reason 
   is that proper refcounting is a "local" issue: you reference count a
   single data structure. It's basically impossible to make a "global" 
   reference count without jumping through hoops.

 - lack of testing. Unloading a module happens once in a blue moon, if 
   even then.

The proper thing to do (and what we _have_ done) is to say "unloading of 
modules is not supported". It's a debugging feature, and you literally 
shouldn't do it unless you are actively developing that module.

Sadly, some modules are broken. Old 16-bit PCMCIA in particular _depends_
on unloading modules, since the old PCMCIA layer doesn't do hotplug: it
literally thinks of module load/unload as the "plug/unplug" event.

But it basically boils down to: don't think of module unload as a "normal
event". It isn't. Getting it truly right is (a) too painful and (b) would
be too slow, so we're not even going to try.

(As an example of "too painful, too slow", think of something like a 
packet filter module. You'd literally have to increment the count in every 
part that gets a packet, and decrement the count at every point where it 
lets the packet go.  And since it would have to be SMP-safe, it would have 
to be a locked cycle, or we'd have to have per-CPU counters - at which 
point you now also have to worry about things like preemption and 
sleeping, which just means that it would be a _lot_ of very fragile code).

			Linus
