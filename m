Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbUCZTP7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 14:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264120AbUCZTP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 14:15:59 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:35214 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262294AbUCZTPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 14:15:53 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
Date: Fri, 26 Mar 2004 13:15:20 -0600
User-Agent: KMail/1.6
Cc: Jeff Garzik <jgarzik@pobox.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-raid@vger.kernel.org
References: <760890000.1079727553@aslan.btc.adaptec.com> <200403251200.35199.kevcorry@us.ibm.com> <40632804.1020101@pobox.com>
In-Reply-To: <40632804.1020101@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403261315.20213.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 March 2004 12:42 pm, Jeff Garzik wrote:
> > We're obviously pretty keen on seeing MD and Device-Mapper "merge" at
> > some point in the future, primarily for some of the reasons I mentioned
> > above. Obviously linear.c and raid0.c don't really need to be ported. DM
> > provides equivalent functionality, the discovery/activation can be driven
> > from user-space, and no in-kernel status updating is necessary (unlike
> > RAID-1 and -5). And we've talked for a long time about wanting to port
> > RAID-1 and RAID-5 (and now RAID-6) to Device-Mapper targets, but we
> > haven't started on any such work, or even had any significant discussions
> > about *how* to do it. I can't
>
> let's have that discussion :)

Great! Where do we begin? :)

> I'd like to focus on the "additional requirements" you mention, as I
> think that is a key area for consideration.
>
> There is a certain amount of metadata that -must- be updated at runtime,
> as you recognize.  Over and above what MD already cares about, DDF and
> its cousins introduce more items along those lines:  event logs, bad
> sector logs, controller-level metadata...  these are some of the areas I
> think Justin/Scott are concerned about.

I'm sure these things could be accomodated within DM. Nothing in DM prevents 
having some sort of in-kernel metadata knowledge. In fact, other DM modules 
already do - dm-snapshot and the above mentioned dm-mirror both need to do 
some amount of in-kernel status updating. But I see this as completely 
separate from in-kernel device discovery (which we seem to agree is the wrong 
direction). And IMO, well designed metadata will make this "split" very 
obvious, so it's clear which parts of the metadata the kernel can use for 
status, and which parts are purely for identification (which the kernel thus 
ought to be able to ignore).

The main point I'm trying to get across here is that DM provides a simple yet 
extensible kernel framework for a variety of storage management tasks, 
including a lot more than just RAID. I think it would be a huge benefit for 
the RAID drivers to make use of this framework to provide functionality 
beyond what is currently available.

> My take on things...  the configuration of RAID arrays got a lot more
> complex with DDF and "host RAID" in general.  Association of RAID arrays
> based on specific hardware controllers.  Silently building RAID0+1
> stacked arrays out of non-RAID block devices the kernel presents.

By this I assume you mean RAID devices that don't contain any type of on-disk 
metadata (e.g. MD superblocks). I don't see this as a huge hurdle. As long as 
the device drivers (SCIS, IDE, etc) export the necessary identification info 
through sysfs, user-space tools can contain the policies necessary to allow 
them to detect which disks belong together in a RAID device, and then tell 
the kernel to activate said RAID device. This sounds a lot like how 
Christophe Varoqui has been doing things in his new multipath tools.

> Failing over when one of the drives the kernel presents does not respond.
>
> All that just screams "do it in userland".
>
> OTOH, once the devices are up and running, kernel needs update some of
> that configuration itself.  Hot spare lists are an easy example, but any
> time the state of the overall RAID array changes, some host RAID
> formats, more closely tied to hardware than MD, may require
> configuration metadata changes when some hardware condition(s) change.

Certainly. Of course, I see things like adding and removing hot-spares and 
removing stale/faulty disks as something that can be driven from user-space. 
For example, for adding a new hot-spare, with DM it's as simple as loading a 
new mapping that contains the new disk, then telling DM to switch the device 
mapping (which implies a suspend/resume of I/O). And if necessary, such a 
user-space tool can be activated by hotplug events triggered by the insertion 
of a new disk into the system, making the process effectively transparent to 
the user.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
