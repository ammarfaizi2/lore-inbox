Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUAYUVn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 15:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUAYUVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 15:21:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56212 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265212AbUAYUVl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 15:21:41 -0500
Date: Sun, 25 Jan 2004 20:21:37 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core
Message-ID: <20040125202136.GR21151@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org> <Pine.LNX.4.58.0401251054340.18932@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401251054340.18932@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 11:02:58AM -0800, Linus Torvalds wrote:
> The proper thing to do (and what we _have_ done) is to say "unloading of 
> modules is not supported". It's a debugging feature, and you literally 
> shouldn't do it unless you are actively developing that module.
> 
> Sadly, some modules are broken. Old 16-bit PCMCIA in particular _depends_
> on unloading modules, since the old PCMCIA layer doesn't do hotplug: it
> literally thinks of module load/unload as the "plug/unplug" event.
> 
> But it basically boils down to: don't think of module unload as a "normal
> event". It isn't. Getting it truly right is (a) too painful and (b) would
> be too slow, so we're not even going to try.
> 
> (As an example of "too painful, too slow", think of something like a 
> packet filter module. You'd literally have to increment the count in every 
> part that gets a packet, and decrement the count at every point where it 
> lets the packet go.  And since it would have to be SMP-safe, it would have 
> to be a locked cycle, or we'd have to have per-CPU counters - at which 
> point you now also have to worry about things like preemption and 
> sleeping, which just means that it would be a _lot_ of very fragile code).

Packet filter is hardly a normal module.  For absolute majority of modules
it's nowhere near that bad.

HOWEVER, module unload is not the real problem.  We have objects with
limited lifetimes.  Always had, always will.  Whether we remove pieces
of .text from the in-core kernel or not, we must be able to deal with
that.  Even if methods themselves are present, they won't do you any
good when data structures belonging to object are destroyed.

If that is handled right, rmmod is trivial for 99% of modules.  The
rest (including Rusty's stuff) can simply say "we can't be unloaded
at all" and be done with that.

Basically, "protect the module" is wrong - it should be "protect specific
object" and we need that anyway.  We already have that for the largest
class of modules - 300-odd netdev ones.  We have that for filesystems.
We have that for block devices.  We have infrastructure for doing that
to character devices, ttys and ldiscs.  Which leaves us with truly weird
stuff that doesn't work in such terms and yes, there your arguments
apply.

Frankly, I'm much more concerned about the stuff that _can't_ be disabled.
You can disable module unloading; hell, you can disable modules completely.
You can't disable ifdown(8).  Which currently means very bad things for
stuff in /proc/sys/net/ipv4/{conf,neigh}/*.  And all arguments re rmmod
deadlocks apply to that sort of situations...
