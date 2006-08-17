Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWHQJY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWHQJY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWHQJY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:24:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:56510 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964771AbWHQJY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:24:58 -0400
Subject: Re: PATCH: Multiprobe sanitizer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1155804060.15195.30.camel@localhost.localdomain>
References: <1155746538.24077.371.camel@localhost.localdomain>
	 <20060816222633.GA6829@kroah.com>
	 <1155774994.15195.12.camel@localhost.localdomain>
	 <1155797833.11312.160.camel@localhost.localdomain>
	 <1155804060.15195.30.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 11:24:35 +0200
Message-Id: <1155806676.11312.175.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 09:41 +0100, Alan Cox wrote:
> Ar Iau, 2006-08-17 am 08:57 +0200, ysgrifennodd Benjamin Herrenschmidt:
> > In fact, I'm all about making the problem worse by agressively
> > paralellilizing everything to get distros config mecanisms to catch up
> > and stop using the interface name (or use ifrename).
> 
> I'm so glad I don't have to depend on your code then because I have to
> actually deal with the real world not try to commit design suicide in
> pursuit in of elegance.

Heh, ok, I wasn't 100% serious there :) Though I still think it's a bit
sad to have to add that sort of "workarounds" all over the place to get
some kind of parallelism. At least disk is getting better on most
distros (with, iirc, the notable exception of debian (and maybe ubuntu)
which still defaults to not using labels).

> There are numerous cases where bus stability happens to matter because
> you cannot identify the different devices. The disk and ethernet cases
> are relatively managable (disk has some distribution issues with fstab
> etc on older setups). Things get nasty when you look at say sound or
> video.
> 
> A classic example would be a typical security system with four identical
> PCI video capture cards. There is no way other than PCI bus ordering to
> order them, and if you don't order them your system isn't useful as you
> do different processing on different camera streams.

There are ways. Using sysfs, you can match a given card to a given PCI
"location", in absence of any other way of identifying, it's still
better than relying on driver probe ordering imho.

My main point is if we don't find a way to get some incentive to get it
fixed, userland will probably not be fixed. Maybe your approach as a
"temporary measure" coupled with a kernel command line argument to force
full parallelism is the way to go...

> From a performance perspective the only one we really care about is
> probably disks. Even there we need some kind of ordering (or ability to
> order) so that we can handle unlabelled (eg new) volumes and md
> components.
> 
> Right now lvm/dm/md all depend on real disk names to be useful on large
> systems because the time to scan for labels is too high. On small
> systems some tools work ok although not all with labels.
> 
> Disk has another awkward problem too - power control and management.

I've been thinking about this problem in the past and one solution I
found was to have a concept of a "ID" string (sort-of an exension of the
current syfs busid, though a sysfs path would probably do the trick for
most devices) that allows to uniquely identify a device in the system
with good stability. Devices that can support some kind of serial
number / uuid would be able to override that with it to provide even
better stability. The idea is to provide the stablest possible
identifier for a device, slot ID being fairly unperfect but probably the
best one can do in absence of better.

Probe ordering is fragile and completely defeated with busses that are
already probed asynchronously (like USB or firewire), and things can
only get worse. Thus we need to look for generic solutions, the trick of
maintaining probe ordering will work around problems today but we'll
still hit the wall in an increasing number of cases in the future.

Ben.


