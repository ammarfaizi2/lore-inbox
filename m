Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWJMBDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWJMBDN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 21:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWJMBDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 21:03:13 -0400
Received: from hera.cwi.nl ([192.16.191.8]:2478 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1751374AbWJMBDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 21:03:12 -0400
Date: Fri, 13 Oct 2006 03:02:59 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl,
       Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Why aren't partitions limited to fit within the device?
Message-ID: <20061013010259.GA3791@apps.cwi.nl>
References: <17710.54489.486265.487078@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17710.54489.486265.487078@cse.unsw.edu.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 09:50:49AM +1000, Neil Brown wrote:

> So:  Is there any good reason to not clip the partitions to fit
> within the device - and discard those that are completely beyond
> the end of the device??

Almost precisely this issue came up recently.
If I recall correctly at that time the idea was to discard
partitions that do not fit on the known disk. A bad idea.
Your idea is better, namely to clip partitions.
Still, there are a few reasons why one should be careful.

One is the existence of clipped disks. There are various ways of
making a disk appear smaller than it really is - there may be
a HPA or DCO or so, or just a capacity-limiting jumper.
This may mean that the kernel does not really know the size
of the disk. The jumper may cause IDENTIFY to return a small size
while actual I/O succeeds beyond that. Or, a SETMAX command is
needed to make all of a partition available. Etc.

One is the numbering of partitions. People are very unhappy
when something causes their partitions to be renumbered.
That is an argument against the discarding.

In the forensics situation you want to take a copy of a disk.
But often that is impractical - copying this 500GB disk takes too long,
or the scratch disk is not large enough, and the copy only holds the
initial part of a disk.
You do not want to discard such partial partitions - maybe clipping is OK,
although I would prefer to see precisely the same data on the copy as on
the original, except of course that actually accessing nonexistent data
returns an I/O error, but discarding would again cause renumbering. Bad.

[As an aside: for the past twelve years or so I have muttered once a year
 that it is bad that Linux does automatic probing for partitions.
 It will be mistaken every now and then.
 With some partition types there is a fairly large probability
 that random data is seen as a partition table.
 A correct system does not guess (unless asked to guess by the user).
 A correct system is set up in such a way that the boot parameters tell it
 1. the root disk, 2. the partition type of the root disk,
 3. the root partition, 4. the filesystem type of the root filesystem.
 Now the root disk can contain configuration data that causes the system
 to look at specified disks in specified ways, or to do default things.

 With a system that was set up correctly, your nonsense partitions
 would never have been found by the kernel, and I suppose mount by label
 would not have encountered any problems.]

Andries
