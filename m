Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWBCQNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWBCQNm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 11:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWBCQNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 11:13:42 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:5007 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1751059AbWBCQNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 11:13:41 -0500
Date: Fri, 3 Feb 2006 17:13:32 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Phillip Susi <psusi@cfl.rr.com>
cc: Bill Davidsen <davidsen@tmr.com>, Cynbe ru Taren <cynbe@muq.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
In-Reply-To: <43E379C2.2020607@cfl.rr.com>
Message-ID: <Pine.LNX.4.60.0602031654520.24081@kepler.fjfi.cvut.cz>
References: <E1EywcM-0004Oz-IE@laurel.muq.org> <20060117193913.GD3714@kvack.org>
 <Pine.LNX.4.60.0601172047560.25680@kepler.fjfi.cvut.cz> <43E26CB6.7030808@tmr.com>
 <Pine.LNX.4.60.0602030037520.18478@kepler.fjfi.cvut.cz> <43E379C2.2020607@cfl.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Phillip Susi wrote:

> Martin Drab wrote:
> > On Thu, 2 Feb 2006, Bill Davidsen wrote:
> > 
> > Just to state clearly in the first place. I've allready solved the problem
> > by low-level formatting the entire disk that this inconsistent array in
> > question was part of.
> > 
> > So now everything is back to normal. So unforunatelly I would not be able to
> > do any more tests on the device in the non-working state.
> > 
> > I mentioned this problem here now just to let you konw that there is such a
> > problematic Linux behviour (and IMO flawed) in such circumstances, and that
> > perhaps it may let you think of such situations when doing further
> > improvements and development in the design of the block device layer (or
> > wherever the problem may possibly come from).
> > 
> >   
> 
> It looks like the problem is in that controller card and its driver.  Was this
> a proprietary closed source driver?

No, it was the kernel's AACRAID driver (drivers/scsi/aacraid/*). And I've 
consulted that with Mark Salyzyn who told me that it is the problem of the 
upper layers which are only zero fault tollerant and that driver con do 
nothing about it.

So as I understand it, the RAID controller did signal some error with 
respect to the inconsistency of that particular array and the upper layers 
weren't probably able to distinguish the real condition and just 
interpreted it as an error and so refused to access the device 
alltogether. But understand that this is just my way of interpreting what 
I think might have happend without any knowledge of SCSI protocol or 
functionality of the SCSI or other related layers.

> Linux is perfectly happy to access the
> rest of the disk when some parts of it have gone bad; people do this all the
> time.  It looks like your raid controller decided to take the entire virtual
> disk that it presents to the kernel offline because it detected errors.

No, it wasn't offline. No such messages appeared in the kernel. And if it 
would have been offlie, the kernel/driver would certainly report that, as 
I've allready witnessed such a situation in the past (however for totally 
different reason).

> <snip>
> > The 0,0,0 is the /dev/sda. And even though this is now, after low-level
> > formatting of the previously inconsistent disc, the indications back then
> > were just the same. Which means every indication behaved as usual. Both
> > arrays were properly identified. But when I was accessing the inconsistent
> > one, i.e. /dev/sda, in any way (even just bytes, this has nothing to do with
> > any filesystems) the error messages mentioned above appeared. I'm not sure
> > what exactly was generating them, but I've CC'd Mark Salyzyn, maybe he can
> > explain more to it.  
> 
> How did you low level format the drive? 

The BIOS of the RAID controller has this option.

> These days disk manufacturers ship
> drives already low level formatted and end users can not perform a low level
> format. The last time I remember being able to low level format a drive was
> with MFM and RLL drives, prior to IDE.  My guess is what you actually did was
> simply write out zeros to every sector on the disk, which replaced the
> corrupted data in the effected sector with good data, rendering it repaired.

That may very well be true. I do not know what the Adaptec BIOS does under 
the "Low-Level Format" option. Maybe someone from Adaptec would know that. 
Mark?

> Usually drives will fail reads to bad sectors but when you write to that
> sector, it will write and read that sector to see if it is fine after being
> written again, or if the media is bad in which case it will remap the sector
> to a spare. 

No, I don't think this was the case of a physically bad sectors. I think 
it was just an inconsistency of the RAID controllers metadata (or 
something simillar) related to that particular array.

Martin
