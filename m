Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWH2K2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWH2K2u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 06:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWH2K2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 06:28:50 -0400
Received: from cantor2.suse.de ([195.135.220.15]:32905 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750806AbWH2K2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 06:28:49 -0400
From: Neil Brown <neilb@suse.de>
To: Nico Schottelius <nico-kernel20060829@schottelius.org>
Date: Tue, 29 Aug 2006 20:28:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17652.5845.249514.372844@cse.unsw.edu.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problem with md: Not rebuilding rai5
In-Reply-To: message from Nico Schottelius on Tuesday August 29
References: <20060829091205.GB21160@schottelius.org>
	<17652.2140.871672.919816@cse.unsw.edu.au>
	<20060829094014.GC21160@schottelius.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 29, nico-kernel20060829@schottelius.org wrote:
> Neil Brown [Tue, Aug 29, 2006 at 07:26:52PM +1000]:
> > On Tuesday August 29, nico-kernel20060829@schottelius.org wrote:
> > > Hello!
> > > 
> > > I created a degrated raid5 on top of md1 and hde1. Then moved the data
> > > from /dev/hdk to the mounted raid5, and then added hdk1 (repartitoned)
> > > to the array. The sync began, but after that hde1 was faulty.
> > 
> > So you created a raid5 containing one drive that was already faulty.
> > That is unfortunate!
> 
> And reported in the manpage of mdadm to be usable (simply specify "missing"
> as keyword).

That's not what I meant.
Creating a 3 drive raid5 with 2 working drives and one 'missing' drive
is fine.
Creating a 3 drive raid5 with one good drive, one faulty drive and one
missing drive is unfortunate.  But the doing anything with a faulty
drive is unfortunate.

> 
> > > I removed it, readded it, but now I've a raid5 with only one active
> > > disk (which should not be possible imho, a raid5 always needs 2 disks)
> > > AND what's even stranger for me, I've two spare disks.
> > 
> > If you have a raid5 with 2 working drives and one fails, how many
> > working drives do you expect to be left?  1.  So the raid is no longer
> > fully functional.
> 
> That is what I also thought. But there are some points that make me
> wonder:
>    a) why is hdk1 marked as spare? I added it this morning and the
>    rebuilt began. Though something happened (I do not know what)
>    and made hdk1 not beeing in the array. (dmesg output
>    is now available at
>    http://home.schottelius.org/~nico/linux/debug/raid/raid5.strange.dmesg)

You added hdk1 as a spare.  md noticed that the array was degraded and
a spare was available so it started recovery of the missing drive on
to the spare.  It remains as a 'spare' until recovery is complete.
Then it becomes a full member.

However recovery didn't complete due to a read error on hde.  So hdk1
is still a spare.
Then you removed and re-added hde1, so it was a spare too.  md didn't
try to reconstruct onto either spare as it didn't have enough working
drives to perform a reconstruction.

> 
>    b) what's the reason, linux does not mark md2 as faulty?
> 

This is no sense in which an array is marked faulty.  There is no
place to put the marking.
If you write to md2, it will fail.
If you read from md2, it might succeed or it might not, depending on
whether the data you try to read is stored on the working device or on
a failed device.

> > You might be able to read some data, but you want
> > able to write.
> > What did you expect to happen when hde1 failed?
> 
> I expected hdk1 and md1 to work.

However md hasn't completely the recovery onto hdk1, so there is
nothing that can be done.

> 
> > I suggest you:
> >   - recreate the array over md1 and hde1
> >   - copy the data back to hdk
> >   - stop the array
> >   - replace hde1
> >   - make the array.
> >   - read the entire array (dd > /dev/null) to make sure it is safe
> >   - copy data back from hdk
> 
> Will linux detect, that md1 and hde1 are from the same array
> and will it see which harddisk is xored with which one?

Linux won't detect anything.  But if you create the array in the same
way that you did before, with md1 and hde1, the data will still be
where it was.  And when you then read from the new md2, you will get
the data that was there before hde1 failed (as long as you don't read
from the block on hde1 that is faulty).

Good luck.

NeilBrown
