Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVA0JvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVA0JvK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 04:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVA0JvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 04:51:09 -0500
Received: from colin2.muc.de ([193.149.48.15]:45840 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262530AbVA0JvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 04:51:03 -0500
Date: 27 Jan 2005 10:51:02 +0100
Date: Thu, 27 Jan 2005 10:51:02 +0100
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org
Subject: Re: critical bugs in md raid5
Message-ID: <20050127095102.GA88779@muc.de>
References: <20050127035906.GA7025@schmorp.de> <m1vf9j4fsp.fsf@muc.de> <20050127063131.GA29574@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127063131.GA29574@schmorp.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I disagree. When not working in degraded mode, it's absolutely reasonable
> to e.g. use only the non-parity data. A crash with raid5 is in no way

Yep. But when you go into degraded mode during the crash recovery 
(before the RAID is fully synced again) you lose.

> different to a crash without raid5 then: either the old data is on the
> disk, the new data is on the disk, or you had some catastrophic disk event
> and no data is on the disk.

No, that's not how RAID-5 works. For its redundancy it requires
coordinated writes of full stripes (= bigger than fs block) over
multiple disks. When you crash in the middle of a write and you
lose a disk during crash recovery there is no way to fully
reconstruct all the data because the XOR data recovery requires
valid data on all disks.

The nasty part there is that it can affect completely unrelated
data too (on a traditional disk you normally only lose the data
that is currently being written) because of of the relationship
between stripes on different disks.

> 
> The case I reported was not a catastrophic failure: either the old or new
> data was on the disk, and the filesystem journaling (which is ext3) will
> take care of it. Even if the parity information is not in sync, either old or
> new data is on the disk.

But you lost a disk in the middle of recovery (any IO error is
a lost disk) 

> Indeed, but I think linux' behaviour is especially poor. For example, the
> renumbering of the devices or the strange rebuild-restart behaviour (which
> is definitely a bug) will make recovery unnecessarily complicated.

There were some suggestions in the past 
to be a bit nicer on read IO errors - often if a read fails and you rewrite 
the block from the reconstructed data the disk would allocate a new block
and then be error free again.

The problem is just that when there are user visible IO errors
on a modern disk something is very wrong and it will likely run quickly out 
of replacement blocks, and will eventually fail. That is why
Linux "forces" early replacement of the disk on any error - it is the
safest thing to do.


> > problem though (e.g. when file system metadata is affected)
> 
> Of course, but that's supposed to be worked around by using a journaling
> file system, right?

Nope, journaling is no magical fix for meta data corruption.

-Andi

