Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVATWjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVATWjr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVATWjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:39:46 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:32934 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262192AbVATWjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:39:19 -0500
Date: Thu, 20 Jan 2005 16:39:16 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: anton@samba.org, akpm@osdl.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64: EEH Recovery
Message-ID: <20050120223916.GJ9140@austin.ibm.com>
References: <20050106192413.GK22274@austin.ibm.com> <20050117201415.GA11505@austin.ibm.com> <16877.63693.915740.385920@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16877.63693.915740.385920@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Jan 19, 2005 at 05:06:05PM +1100, Paul Mackerras was heard to remark:
> Linas Vepstas writes:
> 
> > p.s.  It was not clear to me if the EEH patch previously sent 
> > (6 January 2005, same subject line) will be wending its way into 
> > the main Torvalds kernel tree, or not.  I hadn't really gotten
> > confirmation one way or another.
> 
> I'm not really totally happy with it yet, on a number of fronts:
> 
> 1. You're adding more PCI-specific stuff to the device_node struct,
>    which I don't like.  I would prefer that the device_node tree
>    contains basically just what we get from OF, and that we have a
>    separate struct for storing ppc64-specific information for each PCI
>    device.  Fixing that is outside the scope of your patch, though.

I wrote this down on my to-do list.  Its the sort of thing that 
evaporates from my consciousness when other things come along,
but I'll give it a shot.  

> 2. I don't see why the device nodes for the PCI subtree being reset
>    would go away, and thus I don't see the need for your eeh_cfg_tree
>    struct.

Its not the reset, its the hot-plug remove.  The hot plug code assumes
that you are going to physically remove the device from the slot, so
it removes the device_node as part of the "unconfig".  

Of course, I found this out only after performing a null-pointer deref.
Note only does the node go away, but all of the various pointers it holds
are zeroed in the process.  

The cfg tree holds on to those pointers, so that I wouldn't have to
muck with the device_node removal code to do something tricky.

> 3. Is there a good reason why we can't use the assigned-addresses
>    property on the relevant device tree nodes to tell us what to set
>    the BARs to?

Yes, the reason is that after a reset, that property doesn't hold any 
decent data.   I discussed this with the firmware developers, and thier 
response was that it is the kernel's responsibility to compute 
(or save/restore) such values.  (Except for bridges, which they will do for us).

> 4. I think the 5 second sleep is quite bogus, and shows that we have
>    the flow of control wrong.  

:)  Yes, well, indeed it is.  Don't look at me, not my idea.

> In particular I think it should be a
>    userland write to a sysfs file that kicks off the restart process
>    rather than it just happening after 5 seconds.  Anyway, what
>    process or thread is executing that 5 second sleep?  Is it keventd
>    or something?

Its a workqueue.

> 5. AFAICS userland will get an unplug notification for the device, but
>    nothing to indicate that is due to an EEH slot isolation event.  I
>    think userland should be told about EEH events.

In principle, I'd agree. In practice, this would seem to require changes
or additions or enhancements to udev that I don't quite understand, as
well as potential changes to udev scripts.  Maybe I don't understand
sysfs sufficiently well.  I am very tempted to punt on this, and wait 
for the Intel-backed PCI-E code to get to this point, and then do whatever 
they're doing.

--linas
