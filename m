Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUCYSmm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 13:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbUCYSmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 13:42:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56511 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263523AbUCYSm0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 13:42:26 -0500
Message-ID: <40632804.1020101@pobox.com>
Date: Thu, 25 Mar 2004 13:42:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kevin Corry <kevcorry@us.ibm.com>
CC: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-raid@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
References: <760890000.1079727553@aslan.btc.adaptec.com> <16480.61927.863086.637055@notabene.cse.unsw.edu.au> <40624235.30108@pobox.com> <200403251200.35199.kevcorry@us.ibm.com>
In-Reply-To: <200403251200.35199.kevcorry@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry wrote:
> I'm guessing you're referring to EVMS in that comment, since we have done 
> *part* of what you just described. EVMS has always had a plugin to recognize 
> MD devices, and has been using the MD driver for quite some time (along with 
> using Device-Mapper for non-MD stuff). However, as of our most recent release 
> (earlier this month), we switched to using Device-Mapper for MD RAID-linear 
> and RAID-0 devices. Device-Mapper has always had a "linear" and a "striped" 
> module (both required to support LVM volumes), and it was a rather trivial 
> exercise to switch to activating these RAID devices using DM instead of MD.

nod


> This decision was not based on any real dislike of the MD driver, but rather 
> for the benefits that are gained by using Device-Mapper. In particular, 
> Device-Mapper provides the ability to change out the device mapping on the 
> fly, by temporarily suspending I/O, changing the table, and resuming the I/O 
> I'm sure many of you know this already. But I'm not sure everyone fully 
> understands how powerful a feature this is. For instance, it means EVMS can 
> now expand RAID-linear devices online. While that particular example may not 
[...]

Sounds interesting but is mainly an implementation detail for the 
purposes of this discussion...

Some of this emd may want to use, for example.


> As for not posting this information on lkml and/or linux-raid, I do apologize 
> if this is something you would like to have been informed of. Most of the 
> recent mentions of EVMS on this list seem to fall on deaf ears, so I've taken 
> that to mean the folks on the list aren't terribly interested in EVMS 
> developments. And since EVMS is a completely user-space tool and this 
> decision didn't affect any kernel components, I didn't think it was really 
> relevent to mention here. We usually discuss such things on 
> evms-devel@lists.sf.net or dm-devel@redhat.com, but I'll be happy to 
> cross-post to lkml more often if it's something that might be pertinent.

Understandable...  for the stuff that impacts MD some mention of the 
work, on occasion, to linux-raid and/or linux-kernel would be useful.

I'm mainly looking at it from a standpoint of making sure that all the 
various RAID efforts are not independent of each other.


> We're obviously pretty keen on seeing MD and Device-Mapper "merge" at some 
> point in the future, primarily for some of the reasons I mentioned above. 
> Obviously linear.c and raid0.c don't really need to be ported. DM provides 
> equivalent functionality, the discovery/activation can be driven from 
> user-space, and no in-kernel status updating is necessary (unlike RAID-1 and 
> -5). And we've talked for a long time about wanting to port RAID-1 and RAID-5 
> (and now RAID-6) to Device-Mapper targets, but we haven't started on any such 
> work, or even had any significant discussions about *how* to do it. I can't 

let's have that discussion :)

> imagine we would try this without at least involving Neil and other folks 
> from linux-raid, since it would be nice to actually reuse as much of the 
> existing MD code as possible (especially for RAID-5 and -6). I have no desire 
> to try to rewrite those from scratch.

<cheers>


> Device-Mapper does currently contain a mirroring module (still just in Joe's 
> -udm tree), which has primarily been used to provide online-move 
> functionality in LVM2 and EVMS. They've recently added support for persistent 
> logs, so it's possible for a mirror to survive a reboot. Of course, MD RAID-1 
> has some additional requirements for updating status in its superblock at 
> runtime. I'd hope that in porting RAID-1 to DM, the core of the DM mirroring 
> module could still be used, with the possibility of either adding 
> MD-RAID-1-specific information to the persistent-log module, or simply as an 
> additional log type.

WRT specific implementation, I would hope for the reverse -- that the 
existing, known, well-tested MD raid1 code would be used.  But perhaps 
that's a naive impression...  Folks with more knowledge of the 
implementation can make that call better than I.


I'd like to focus on the "additional requirements" you mention, as I 
think that is a key area for consideration.

There is a certain amount of metadata that -must- be updated at runtime, 
as you recognize.  Over and above what MD already cares about, DDF and 
its cousins introduce more items along those lines:  event logs, bad 
sector logs, controller-level metadata...  these are some of the areas I 
think Justin/Scott are concerned about.

My take on things...  the configuration of RAID arrays got a lot more 
complex with DDF and "host RAID" in general.  Association of RAID arrays 
based on specific hardware controllers.  Silently building RAID0+1 
stacked arrays out of non-RAID block devices the kernel presents. 
Failing over when one of the drives the kernel presents does not respond.

All that just screams "do it in userland".

OTOH, once the devices are up and running, kernel needs update some of 
that configuration itself.  Hot spare lists are an easy example, but any 
time the state of the overall RAID array changes, some host RAID 
formats, more closely tied to hardware than MD, may require 
configuration metadata changes when some hardware condition(s) change.

I respectfully disagree with the EMD folks that a userland approach is 
impossible, given all the failure scenarios.  In a userland approach, 
there -will- be some duplicated metadata-management code between 
userland and the kernel.  But for configuration _above_ the 
single-raid-array level, I think that's best left to userspace.

There will certainly be a bit of intra-raid-array management code in the 
kernel, including configuration updating.  I agree to its necessity... 
but that doesn't mean that -all- configuration/autorun stuff needs to be 
in the kernel.

	Jeff



