Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWCLF4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWCLF4j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 00:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWCLF4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 00:56:39 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:32453 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S932071AbWCLF4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 00:56:38 -0500
Date: Sun, 12 Mar 2006 01:01:57 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Andrew Morton <akpm@osdl.org>, Pierre Ossman <drzeus-list@drzeus.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-ID: <20060312060156.GB14157@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Andrew Morton <akpm@osdl.org>,
	Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
References: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx> <20060301194532.GB25907@vrfy.org> <4406AF27.9040700@drzeus.cx> <20060302165816.GA13127@vrfy.org> <44082E14.5010201@drzeus.cx> <4412F53B.5010309@drzeus.cx> <20060311173847.23838981.akpm@osdl.org> <20060312042957.GA14157@neo.rr.com> <20060312050955.GA5676@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060312050955.GA5676@vrfy.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 06:09:55AM +0100, Kay Sievers wrote:
> 259-0000
> 
> On Sat, Mar 11, 2006 at 11:29:57PM -0500, Adam Belay wrote:
> > On Sat, Mar 11, 2006 at 05:38:47PM -0800, Andrew Morton wrote:
> > > Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> > > >
> > > >  Here is a patch for doing multi line modalias for PNP devices. This will
> > > >  break udev, so that needs to be updated first.
> > > > 
> > > >  I had a longer look at the card part and it seems that module aliases
> > > >  cannot be reliably used for it. Not without restructuring the system at
> > > >  least. The possible combinations explode when you notice that the driver
> > > >  ids needs to be just at subset of the card, without any ordering.
> > > > 
> > > >  If I got my calculations right, a PNP card would have to have roughly
> > > >  2^(2n) aliases, where n is the number of device ids. So right now, I
> > > >  lean towards only adding modalias support for the non-card part of the
> > > >  PNP layer.
> > > > 
> > > >  Andrew, do you want a fix for the patch in -mm or can you remove the
> > > >  part of it that modifies drivers/pnp/card.c by yourself?
> > > 
> > > I assume you mean that the drivers/pnp/card.c patch of
> > > pnp-modalias-sysfs-export.patch needs to be removed and this patch applies
> > > on top of the result.
> > > 
> > > But I don't want to break udev.
> > 
> > I think supporting multiple IDs per node is a reasonable expectation to
> > have from udev (even for subsystems beyond PnP).  Kay, would this be
> > difficult to add?
> 
> Udev does not care about $MODALIAS at all about the string, it just
> runs configured programs when a device is added. It's unlikely,
> that we will ever need/have a built-in MODALIAS handling in udev.
> Distros handle that all differently, most just do "modprobe $MODALIAS"
> with the device event.

Alright, so it would seem changing to multiple line MODALIAS values could be
potentially inconvenient for the current conventions.  Therefore, this sort of
change probably shouldn't be made for PnP.  However, I think pcmcia and acpi
will eventually have similar issues.

> 
> > However, I'm a little confused as to why we're exporting these "modalias"
> > strings from a kernel interface in the first place.  Wouldn't it be better
> > from an abstraction barrier standpoint to have userspace generate such
> > strings from information it gathered through bus-specific interfaces?
> 
> Well, the modalias match strings are native part of the kernel modules, so
> it is just convenient to have the kernel to create the modalias to match
> against these strings too. Userspace and modprobe usually doesn't care about
> the actual content of the strings, as both come from the kernel and just need
> to match each other. In theory, there is no need to keep userspace updated,
> if a new bus is added, or the format is changed, which is nice.

I appreciate the explanation.  I guess I've always favored a more
userspace-centric driver matching mechanism than our current system.  There
are some cases where multiple drivers exist and the user might want to select
a specific driver for each device instance, and I think we're very limited in
these situations because of the module level granularity of driver matching.

In any case, a native part of kernel modules is not necessarily also native to
the kernel itself.  In this case, as I understand it, modalias strings are a
sort of metadata embedded in the module binary that's not necessarily referenced
by the kernel.  A userspace script could rather easily read bus-specific vendor
and device ID components from sysfs and generate a string compatible with this
format.

Regards,
Adam
