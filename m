Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbUCYSCW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 13:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263511AbUCYSCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 13:02:22 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:7872 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263479AbUCYSBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 13:01:53 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
Date: Thu, 25 Mar 2004 12:00:35 -0600
User-Agent: KMail/1.6
Cc: Jeff Garzik <jgarzik@pobox.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-raid@vger.kernel.org
References: <760890000.1079727553@aslan.btc.adaptec.com> <16480.61927.863086.637055@notabene.cse.unsw.edu.au> <40624235.30108@pobox.com>
In-Reply-To: <40624235.30108@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403251200.35199.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 March 2004 8:21 pm, Jeff Garzik wrote:
> Neil Brown wrote:
> > Choice is good.  Competition is good.  I would not try to interfere
> > with you creating a new "emd" driver that didn't interfere with "md".
> > What Linus would think of it I really don't know.  It is certainly not
> > impossible that he would accept it.
>
> Agreed.
>
> Independent DM efforts have already started supporting MD raid0/1
> metadata from what I understand, though these efforts don't seem to post
> to linux-kernel or linux-raid much at all.  :/

I post on lkml.....occasionally. :)

I'm guessing you're referring to EVMS in that comment, since we have done 
*part* of what you just described. EVMS has always had a plugin to recognize 
MD devices, and has been using the MD driver for quite some time (along with 
using Device-Mapper for non-MD stuff). However, as of our most recent release 
(earlier this month), we switched to using Device-Mapper for MD RAID-linear 
and RAID-0 devices. Device-Mapper has always had a "linear" and a "striped" 
module (both required to support LVM volumes), and it was a rather trivial 
exercise to switch to activating these RAID devices using DM instead of MD.

This decision was not based on any real dislike of the MD driver, but rather 
for the benefits that are gained by using Device-Mapper. In particular, 
Device-Mapper provides the ability to change out the device mapping on the 
fly, by temporarily suspending I/O, changing the table, and resuming the I/O 
I'm sure many of you know this already. But I'm not sure everyone fully 
understands how powerful a feature this is. For instance, it means EVMS can 
now expand RAID-linear devices online. While that particular example may not 
sound all that exciting, if things like RAID-1 and RAID-5 were "ported" to 
Device-Mapper, this feature would then allow you to do stuff like add new 
"active" members to a RAID-1 online (think changing from 2-way mirror to 
3-way mirror). It would be possible to convert from RAID-0 to RAID-4 online 
simply by adding a new disk (assuming other limitations, e.g. a single 
stripe-zone). Unfortunately, these are things the MD driver can't do online, 
because you need to completely stop the MD device before making such changes 
(to prevent the kernel and user-space from trampling on the same metadata), 
and MD won't stop the device if it's open (i.e. if it's mounted or if you 
have other device (LVM) built on top of MD). Often times this means you need 
to boot to a rescue-CD to make these types of configuration changes.

As for not posting this information on lkml and/or linux-raid, I do apologize 
if this is something you would like to have been informed of. Most of the 
recent mentions of EVMS on this list seem to fall on deaf ears, so I've taken 
that to mean the folks on the list aren't terribly interested in EVMS 
developments. And since EVMS is a completely user-space tool and this 
decision didn't affect any kernel components, I didn't think it was really 
relevent to mention here. We usually discuss such things on 
evms-devel@lists.sf.net or dm-devel@redhat.com, but I'll be happy to 
cross-post to lkml more often if it's something that might be pertinent.

> > However I'm not sure that having three separate device-array systems
> > (dm, md, emd) is actually a good idea.  It would probably be really
> > good to unite md and dm somehow, but no-one seems really keen on
> > actually doing the work.
>
> I would be disappointed if all the work that has gone into the MD driver
> is simply obsoleted by new DM targets.  Particularly RAID 1/5/6.
>
> You pretty much echoed my sentiments exactly...  ideally md and dm can
> be bound much more tightly to each other.  For example, convert md's
> raid[0156].c into device mapper targets...  but indeed, nobody has
> stepped up to do that so far.

We're obviously pretty keen on seeing MD and Device-Mapper "merge" at some 
point in the future, primarily for some of the reasons I mentioned above. 
Obviously linear.c and raid0.c don't really need to be ported. DM provides 
equivalent functionality, the discovery/activation can be driven from 
user-space, and no in-kernel status updating is necessary (unlike RAID-1 and 
-5). And we've talked for a long time about wanting to port RAID-1 and RAID-5 
(and now RAID-6) to Device-Mapper targets, but we haven't started on any such 
work, or even had any significant discussions about *how* to do it. I can't 
imagine we would try this without at least involving Neil and other folks 
from linux-raid, since it would be nice to actually reuse as much of the 
existing MD code as possible (especially for RAID-5 and -6). I have no desire 
to try to rewrite those from scratch.

Device-Mapper does currently contain a mirroring module (still just in Joe's 
-udm tree), which has primarily been used to provide online-move 
functionality in LVM2 and EVMS. They've recently added support for persistent 
logs, so it's possible for a mirror to survive a reboot. Of course, MD RAID-1 
has some additional requirements for updating status in its superblock at 
runtime. I'd hope that in porting RAID-1 to DM, the core of the DM mirroring 
module could still be used, with the possibility of either adding 
MD-RAID-1-specific information to the persistent-log module, or simply as an 
additional log type.

So, if this is the direction everyone else would like to see MD and DM take, 
we'd be happy to help out.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
