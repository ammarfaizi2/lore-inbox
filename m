Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbUAGTdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 14:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbUAGTdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 14:33:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:12676 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266278AbUAGTcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 14:32:06 -0500
Date: Wed, 7 Jan 2004 11:31:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
In-Reply-To: <20040107185656.GB31827@kroah.com>
Message-ID: <Pine.LNX.4.58.0401071123490.12602@home.osdl.org>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com>
 <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Jan 2004, Greg KH wrote:

> > But udev should probably also create all the sub-nodes if it doesn't 
> > already.
> 
> It doesn't, as I thought we could rely on the kernel partition support.

Indeed, we _can_ rely on the kernel partition support, but the subnodes 
are needed to get at those partitions.

Obviously, a "repartitioning hotplug event" can create the subnodes, but 
that will fail exactly because it wouldn't allow the user to just access 
the nodes.

> Hm, that would work, but what about a user program that just polls on
> the device, as the rest of this thread discusses?

I hate those "background CPU users". Have you looked at "ps" output after 
something like kscd has run, and does a CD check every second? It's 
_expensive_. It goes all the way down to the hardware, sends a request 
to the device.

Doing it every five minutes wouldn't be an issue, but doing it every five 
minutes would be absolutely _horrible_ from a user perspective standpoint. 
If you insert a smartmedia card in your cardreader, you expect to be able 
to access it pretty much immediately when you start typing. So a second or 
two of delay is fine, but even just five or ten seconds are already bad.

So the choice is:
 - probe every removable device once a second
 - pre-populate the device nodes, and when the user presses the icon that 
   says "mount", it will just do so. Immediately. No delay at all.

>				  As removable devices
> are not the "norm" it would seem a bit of overkill to create 16
> partitions for every block device, if they need them or not.

It might be acceptable to create even just the first one, since things
like cameras etc only ever generate a single partition. But the
inconsistency would drive me mad. I'd just do all of them.

NOTE! We do have an alternative: if we were to just make block device 
nodes support "readdir" and "lookup", you could just do

	open("/dev/sda/1" ...)

and it magically works right. I've wanted to do this for a long time, but 
every time I suggest allowing it, people scream.

			Linus
