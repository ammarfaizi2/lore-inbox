Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWJMBbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWJMBbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 21:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWJMBbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 21:31:53 -0400
Received: from mx1.suse.de ([195.135.220.2]:28598 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751446AbWJMBbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 21:31:52 -0400
From: Neil Brown <neilb@suse.de>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Date: Fri, 13 Oct 2006 11:31:45 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17710.60545.258810.216492@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Why aren't partitions limited to fit within the device?
In-Reply-To: message from Andries Brouwer on Friday October 13
References: <17710.54489.486265.487078@cse.unsw.edu.au>
	<20061013010259.GA3791@apps.cwi.nl>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday October 13, Andries.Brouwer@cwi.nl wrote:
> 
> One is the existence of clipped disks. There are various ways of
> making a disk appear smaller than it really is - there may be
> a HPA or DCO or so, or just a capacity-limiting jumper.
> This may mean that the kernel does not really know the size
> of the disk. The jumper may cause IDENTIFY to return a small size
> while actual I/O succeeds beyond that. Or, a SETMAX command is
> needed to make all of a partition available. Etc.

Yes..... but access to the whole device is clipped based on the
kernel's understanding of the size of the device, and allowing code
too by-pass that clipping by using a partition seems just *wrong*.
Presumably a very-privileged BLKSETSIZE64 would be the appropriate
thing for that sort of situation.
If a device claims to be smaller will the low-level driver actually
allow a request to a larger address at all???


> 
> One is the numbering of partitions. People are very unhappy
> when something causes their partitions to be renumbered.
> That is an argument against the discarding.

Valid comment.  My patch doesn't affect numbering.
Partitions that are beyond the end of the device are not enabled at
all, but that doesn't affect the numbering of later partitions.

> 
> In the forensics situation you want to take a copy of a disk.
> But often that is impractical - copying this 500GB disk takes too long,
> or the scratch disk is not large enough, and the copy only holds the
> initial part of a disk.
> You do not want to discard such partial partitions - maybe clipping is OK,
> although I would prefer to see precisely the same data on the copy as on
> the original, except of course that actually accessing nonexistent data
> returns an I/O error, but discarding would again cause renumbering. Bad.

So your main points seem to be:
  - removing access that people currently have is bad
  - causing partitions to be renumbered is bad.

I certainly agree.  Unless people actually do use partitions to bypass
the device-size check in generic_make_request, this patch doesn't do
either these bad things.

The only visible effect should be:

 - partitions that have no accessible blocks will no longer be able to
   be opened.
 - partitions that start in-range and end beyond range will appear
   smaller than they would have done.
 - reading the last block of a partition will no longer cause error
   messages that look like there are device errors.

All of these seem to be acceptable effects.  Do you agree?


> 
> [As an aside: for the past twelve years or so I have muttered once a year
>  that it is bad that Linux does automatic probing for partitions.
>  It will be mistaken every now and then.
>  With some partition types there is a fairly large probability
>  that random data is seen as a partition table.
>  A correct system does not guess (unless asked to guess by the user).
>  A correct system is set up in such a way that the boot parameters tell it
>  1. the root disk, 2. the partition type of the root disk,
>  3. the root partition, 4. the filesystem type of the root filesystem.
>  Now the root disk can contain configuration data that causes the system
>  to look at specified disks in specified ways, or to do default things.
> 
>  With a system that was set up correctly, your nonsense partitions
>  would never have been found by the kernel, and I suppose mount by label
>  would not have encountered any problems.]

I have substantial sympathy with your aside.  But people don't want to
have to configure things.  They just want it to "work".  I get this
with md/raid all the time.  "Just find all the arrays and assemble
them".  Like with partitions, that isn't always a well defined
operation.  But most of the time it is, and that is what people think
they want.
Ho hum.


Thanks for your input.

NeilBrown
