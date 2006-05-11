Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWEKXHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWEKXHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 19:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWEKXHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 19:07:55 -0400
Received: from iabervon.org ([66.92.72.58]:8977 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750825AbWEKXHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 19:07:54 -0400
Date: Thu, 11 May 2006 19:08:49 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
cc: Andrew Morton <akpm@osdl.org>, mikem@beardog.cca.cpqcorp.net,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] make kernel ignore bogus partitions
In-Reply-To: <20060511115117.GA870@apps.cwi.nl>
Message-ID: <Pine.LNX.4.64.0605111822320.6713@iabervon.org>
References: <20060503210055.GB31048@beardog.cca.cpqcorp.net>
 <20060509124138.43e4bac0.akpm@osdl.org> <20060509224848.GA29754@apps.cwi.nl>
 <20060511040014.66ea16fc.akpm@osdl.org> <20060511115117.GA870@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2006, Andries Brouwer wrote:

> The normal situation is that partitions are contained within
> the disk. In the normal situation the test is superfluous.
> 
> Suppose the test fails. Why might that be? There isn't really
> a good scenario where this is a mistake. In all the (rare) cases
> that I can imagine, it would make matters worse to reject the
> partition and make access impossible (or at least more difficult).
> 
> Case 1: The kernel is mistaken about the size of the disk.
> (There are commands to clip a disk to a certain capacity,
> there are jumpers to tell a disk that it should report a certain
> capacity etc. Usually this is because of BIOS bugs. In bad cases
> the machine will crash in the BIOS and hence fail to boot if
> the disk reports full capacity.)
> In such cases actually accessing the blocks of the partition
> may work fine, or may work fine after running an unclip utility.
> I wrote "setmax" some years ago precisely for this reason.

Perhaps the kernel should try reading beyond the ends of disks when it 
detects them, so that it can determine if there's actually available 
storage there, and automatically increase the size if there is? Or, at 
least, it could check whether the medium actually goes out to the point 
the partition table implies, and suppress the I/O error if the disk 
actually ends where it claims to.

> Case 2: There was a messy partition table (maybe just a rounding
> error) but the actual filesystem on the partition is contained
> in the physical disk. Now using the filesystem goes without problem.

I think I've seen cameras format SD cards like this. If I understand the 
situation correctly, it's a pain to mount them, because the kernel pokes 
around beyond the end of the medium trying to determine the filesystem 
type. In this case, wouldn't the right thing be to add the partition as 
ending at the end of the disk, rather than where it claims to?

> Case 3: Both partition and filesystem extend beyond the end of the disk.
> In forensic or debugging situations one often uses a copy of the start
> of a disk. Now access beyond the end gives an expected I/O error.

I think cropping the partition to the size of the copied area is fine 
here, too, and should generate I/O errors on the partition without errors 
on the underlying block device, so it will be more clear that the hardware 
is fine, but your filesystem has problems (i.e., part of it isn't 
included).

In any case, I don't think it makes sense to leave the partition and 
underlying device inconsistant, rather than correcting one or the other.

	-Daniel
*This .sig left intentionally blank*
