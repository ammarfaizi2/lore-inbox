Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319319AbSIKTdI>; Wed, 11 Sep 2002 15:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319320AbSIKTdD>; Wed, 11 Sep 2002 15:33:03 -0400
Received: from host194.steeleye.com ([216.33.1.194]:13581 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S319319AbSIKTdA> convert rfc822-to-8bit; Wed, 11 Sep 2002 15:33:00 -0400
Message-Id: <200209111937.g8BJbfQ02442@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Lars Marowsky-Bree <lmb@suse.de>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ? 
In-Reply-To: Message from Lars Marowsky-Bree <lmb@suse.de> 
   of "Wed, 11 Sep 2002 21:17:01 +0200." <20020911191701.GE1212@marowsky-bree.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Wed, 11 Sep 2002 14:37:40 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lmb@suse.de said:
>  and if the device mapper could have the notion of "to what topology
> group does this device belong to", or even "distance metric (without
> going into further detail on what this is, as long as it is consistent
> to the physical layer) to the current CPU" (so that the shortest path
> in NUMA could be selected), that would be kinda cool ;-) And doesn't
> seem too intrusive.

I think I see driverfs as the solution here.  Topology is deduced by examining 
certain device and HBA parameters.  As long as these parameters can be exposed 
as nodes in the device directory for driverfs, a user level daemon map the 
topology and connect the paths at the top.  It should even be possible to 
weight the constructed multi-paths.

This solution appeals because the kernel doesn't have to dictate policy, all 
it needs to be told is what information it should be exposing and lets user 
level get on with policy determination (this is a mini version of why we 
shouldn't have network routing policy deduced and implemented by the kernel).

> But one of the issues with the md layer right now for example is the fact that
> an error on a backup path will only be noticed as soon as it actually tries to
> use it, even if the cpqfc (to name the culprit, worst code I've seen in a
> while) notices a link-down event. It isn't communicated anywhere, and how
> should it be?

I've been think about this separately.  FC in particular needs some type of 
event notification API (something like "I've just seen this disk" or "my loop 
just went down").  I'd like to leverage a mid-layer api into hot plug for some 
of this, but I don't have the details worked out.

> If the path was somehow exposed to user-space (as it is with md right now),
> the reprobing could even be done outside the kernel. This seems to make sense,
> because a potential extensive device-specific diagnostic doesn't have to be
> folded into it then.

The probing issue is an interesting one.  At least SCSI has the ability to 
probe with no IO (something like a TEST UNIT READY) and I assume other block 
devices have something similar.  Would it make sense to tie this to a single 
well known ioctl so that you can probe any device that supports it without 
having to send real I/O?

> The other features on my list - prioritizing paths, a useful, consistent user
> interface via driverfs/devfs/procfs  - are more or less policy I guess.

Mike Sullivan (of IBM) is working with Patrick Mochel on this.

James


