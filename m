Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVA0Gbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVA0Gbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 01:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVA0Gbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 01:31:37 -0500
Received: from rain.plan9.de ([193.108.181.162]:57267 "EHLO rain.plan9.de")
	by vger.kernel.org with ESMTP id S262494AbVA0Gbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 01:31:33 -0500
Date: Thu, 27 Jan 2005 07:31:31 +0100
From: Marc Lehmann <linux-kernel@plan9.de>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: critical bugs in md raid5
Message-ID: <20050127063131.GA29574@schmorp.de>
Mail-Followup-To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <20050127035906.GA7025@schmorp.de> <m1vf9j4fsp.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vf9j4fsp.fsf@muc.de>
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
       Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 06:11:34AM +0100, Andi Kleen <ak@muc.de> wrote:
> Marc Lehmann <linux-kernel@plan9.de> writes:
> > The summary seems to be that the linux raid driver only protects your data
> > as long as all disks are fine and the machine never crashes.
> 
> "as long as the machine never crashes". That's correct. If you think
> about how RAID 5 works there is no way around it. When a write to 

I disagree. When not working in degraded mode, it's absolutely reasonable
to e.g. use only the non-parity data. A crash with raid5 is in no way
different to a crash without raid5 then: either the old data is on the
disk, the new data is on the disk, or you had some catastrophic disk event
and no data is on the disk.

The case I reported was not a catastrophic failure: either the old or new
data was on the disk, and the filesystem journaling (which is ext3) will
take care of it. Even if the parity information is not in sync, either old or
new data is on the disk.

> a single stripe is interrupted (machine crash) and you lose a disk
> during the recovery a lot of data (even unrelated to the data just written)
> is lost.

This is not what I described, in fact, I haven't lost any data, despite
having had a number of such problems (I did verify that afterwards, and
found no differences. Maybe this is luck, but it seems to happen in the
majority of cases, and I ahd a similar problem at least 5 or 6 times
because I didn't encounter the bug I reported).

> But that's nothing inherent in Linux RAID5. It's a generic problem.
> Pretty much all Software RAID5 implementations have it.

Indeed, but I think linux' behaviour is especially poor. For example, the
renumbering of the devices or the strange rebuild-restart behaviour (which
is definitely a bug) will make recovery unnecessarily complicated.

> RAID-1 helps a bit, because you either get the old or the new data,
> but not some corruption.

You don't get any magical corruption with RAID5 either... the data contents
will either be old, or new. The differnce is that you cannot trust parity.

> In practice even old data can be a big
> problem though (e.g. when file system metadata is affected)

Of course, but that's supposed to be worked around by using a journaling
file system, right?

> Morale: if you really care about your data backup very often and
> use RAID-1 or get an expensive hardware RAID with battery backup
> (all the cheap "hardware RAIDs" are equally useless for this) 

Yes, I am thinking of that for some time now, but always had a problem
because the affordable ones have low performance. But given linux'
effective slower-than-a-single-disk performance it shouldn't be hard to
beat nowadays.

There is, however, at least the resyncing with only 4 out of 5 disks, that
is doubtlessly a bug somewhere.

-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE
