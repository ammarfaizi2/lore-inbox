Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263790AbTDIUnC (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 16:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTDIUnB (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 16:43:01 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:34061 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S263790AbTDIUnA (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 16:43:00 -0400
Date: Wed, 9 Apr 2003 22:54:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: James Bottomley <James.Bottomley@steeleye.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <1049913637.1993.73.camel@mulgrave>
Message-ID: <Pine.LNX.4.44.0304092202570.5042-100000@serv>
References: <1049913637.1993.73.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9 Apr 2003, James Bottomley wrote:

> > Let's try it with a real example:
> > I have two onboard SCSI channels, the first one is for external
> devices 
> > and the second for internal devices.
> 
> There seems to be some confusion here.  As I understand it, you're
> advocating a completely dynamic device space (both major and minor), but
> the concrete examples you post come from devices that do dynamic minors
> only.

These examples were intended to show problems of the current dynamic and 
static numbering. I use examples like these to evaluate how a new 
numbering scheme helps to manage devices.

> As far as SCSI goes, in the current 8/8 device scheme, we occupy 16
> different majors for sd already, but this only gives us room for 256
> discs and we had to compromise and only have 16 partitions on each (as
> opposed to the 64 that IDE has).  Even if you expand this (as there are
> patches to do), we get into trouble because we only have 256 sg nodes,
> etc.
> 
> Expanding the size of the kernel dev_t will allow us to occupy only one
> major,  for each SCSI device type, supply far more discs and still move
> to a 64 partition model.

Why do we need majors at all? There is no perfect way to partition the 
device number, it will always be some compromise. This partitioning 
creates more problems than it solves.
Simply start allocating from 0x10000 and you can have (2^32-2^16)/partnr 
block devices.
The sg nodes problem is also easy to solve, but it requires the character 
device hash Andries removed.

> > I have to come back to the two questions I already asked earlier:
> > 1. How do we want to manage devices in the future?
> 
> Well, it's a legitimate question to ask, but not one anyone is required
> to answer.  The whole "taste" thing in the kernel is about making
> correct decisions without necessarily seeing the ultimate end points. 
> Enabling rather than dictating.  Nothing about an expanded kernel dev_t
> precludes more dynamism in major number allocation.

So let's "taste" a few ideas. I don't want any decision, I want to get a 
discussion started, which explores some of the possibilities, so that we 
have _some_ idea of what we need.

> However, there is already consideration of this issue, see for example:
> 
> http://www.linuxsymposium.org/2003/view_abstract.php?talk=94

I'd love to see this implemented and I would certainly like to help, but 
I'm mostly interested in the kernel side of this.
I haven't found much information about this, so it's difficult to comment 
on this.

> > 2. What compromises can we make for 2.6?
> 
> I think that's expand the kernel's device type but keep the current
> static major/static or dynamic minor.  It seems to me, at this late
> stage in the game, that this will cause the minimum disruption and
> require the minimum of code changes, while still allowing us to satisfy
> the enterprise device demands.  Pragmatically as well, we already have
> the patches for this, we don't for dynamic majors.

These "enterprise device demands" certainly shouldn't break existing 
setups? The patches I've seen from Andries so far do exactly this.
What I'm mostly trying to get out of this discussion is how this large 
dev_t will be used during 2.6, as this requires decisions now, I'd like 
to know and talk about the possible consequences.

In this mail 
http://marc.theaimsgroup.com/?l=linux-kernel&m=104928874409158&w=2
I demonstrated how new device numbers can be generated, without breaking 
backwards compatibility, it's quite trivial to complete this patch.

