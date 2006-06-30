Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWF3BO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWF3BO5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 21:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWF3BO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 21:14:57 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:51618 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751379AbWF3BO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 21:14:56 -0400
Message-ID: <44A47B0D.7020308@garzik.org>
Date: Thu, 29 Jun 2006 21:14:53 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Proposal and plan for ext2/3 future development work
References: <E1Fvjsh-0008Uw-85@candygram.thunk.org>
In-Reply-To: <E1Fvjsh-0008Uw-85@candygram.thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> To address these issues, after discussing the matter amongst ourselves,
> the ext2/3 developers would like to propose the following path forward.

Overall...  ACK from me.  Thanks for listening.


> 2) Bug fixes to fix 32-bit cleanliness issues, security/oops problems
> will go into fs/ext3, but all new development work will go into fs/ext4.
> There is some question about whether relatively low risk features such
> as slimming the extX in-core memory structure, and delayed allocation
> for ext3, which have no format impacts, should go into fs/ext3, or
> whether such enhancement should only benefit fs/ext4 users.  This is a
> cost/benefit tradeoff for which the guidance of the LKML community about
> whether the loss in code stability is worth the improvements to current
> ext3 users, given the existence of the development branch.  

Agreed overall, though specifically for delayed allocation I think 
that's an ext4 thing:

* First off, I'm a big fan of delalloc, and (like extents) definitely 
want to see the feature implemented
* Delayed allocation, properly done, requires careful interaction with 
VM writeback (memory pressure or normal writeout), and may require some 
minor changes to generic code in fs/* and mm/*
* Delayed allocation changes I/O ordering, and may require some retuning 
for workloads to remain optimal
* Delayed allocation changes data layout on disk.  HOPEFULLY for the 
better, but we won't know that until its been hammered a bit in the field.

So while I agree it has no format impacts, I also think it has a 
non-trivial -- and currently unknown -- impact on stable systems.

Also for the reasons listed, I think ext4 would be a far superior 
testbed for delalloc.


> In addition, we are assuming that various "low risk" changes that do
> involve format changes, such as support for higher resolution
> timestamps, will _not_ get integrated into the fs/ext3 codebase, and
> that people who want these features will have to use the
> stable/development fs/ext4 codebase.

ACK


> 3) The ext4 code base will continue to mount older ext3 filesystems,
> as this is necessary to ensure a future smooth upgrade path from ext3
> to ext4 users.  In addition, once a feature is added to the ext3dev
> filesystem, a huge amount of effort will be made to provide continuing
> support for the filesystem format enhancements going forward, just as
> we do with the syscall ABI.  (Emergencies might happen if we make a
> major mistake and paint ourselves into a corner; but just as with
> changes to the kernel/userspace ABI, if there is some question about
> whether or not a particular filesystem format can be supported going
> forward indefinitely, we will not push changes into the mainline
> kernel until we are can be confident on this point.)

ACK


> 4) At some point, probably in 6-9 months when we are satisified with the
> set of features that have been added to fs/ext4, and confident that the
> filesystem format has stablized, we will submit a patch which causes the
> fs/ext4 code to register itself as the ext4 filesystem.  The
> implementation may still require some shakedown before we are all
> confident that it is as stable as ext3 is today.  At that point, perhaps
> 12-18 months out, we may request that the code in fs/ext3/*.c be deleted
> and that fs/ext4 register itself as supporting the ext3 filesystem as
> well.

I continue to have a concern that it will become tougher over time to 
support all these features in the same codebase...  so consider this a 
reluctant "ACK" for this last paragraph.  :)

	Jeff


