Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUCZUpi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 15:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUCZUpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 15:45:38 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:6414 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S261221AbUCZUp0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 15:45:26 -0500
Date: Fri, 26 Mar 2004 13:45:02 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org
cc: Jeff Garzik <jgarzik@pobox.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-raid@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
Message-ID: <1644340000.1080333901@aslan.btc.adaptec.com>
In-Reply-To: <200403261315.20213.kevcorry@us.ibm.com>
References: <760890000.1079727553@aslan.btc.adaptec.com> <200403251200.35199.kevcorry@us.ibm.com> <40632804.1020101@pobox.com> <200403261315.20213.kevcorry@us.ibm.com>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> There is a certain amount of metadata that -must- be updated at runtime,
>> as you recognize.  Over and above what MD already cares about, DDF and
>> its cousins introduce more items along those lines:  event logs, bad
>> sector logs, controller-level metadata...  these are some of the areas I
>> think Justin/Scott are concerned about.
> 
> I'm sure these things could be accommodated within DM. Nothing in DM prevents 
> having some sort of in-kernel metadata knowledge. In fact, other DM modules 
> already do - dm-snapshot and the above mentioned dm-mirror both need to do 
> some amount of in-kernel status updating. But I see this as completely 
> separate from in-kernel device discovery (which we seem to agree is the wrong 
> direction). And IMO, well designed metadata will make this "split" very 
> obvious, so it's clear which parts of the metadata the kernel can use for 
> status, and which parts are purely for identification (which the kernel thus 
> ought to be able to ignore).

We don't have control over the meta-data formats being used by the industry.
Coming up with a solution that only works for "Linux Engineered Meta-data
formats" removes any possibility of supporting things like DDF, Adaptec
ASR, and a host of other meta-data formats that can be plugged into things
like EMD.  In the two cases we are supporting today with EMD, the records
required for doing discovery reside in the same sectors as those that need
to be updated at runtime from some "in-core" context.

> The main point I'm trying to get across here is that DM provides a simple yet 
> extensible kernel framework for a variety of storage management tasks, 
> including a lot more than just RAID. I think it would be a huge benefit for 
> the RAID drivers to make use of this framework to provide functionality 
> beyond what is currently available.

DM is a transform layer that has the ability to pause I/O while that
transform is updated from userland.  That's all it provides.  As such,
it is perfectly suited to some types of logical volume management
applications.  But that is as far as it goes.  It does not have any
support for doing "sync/resync/scrub" type operations or any generic
support for doing anything with meta-data.  In all of the examples you
have presented so far, you have not explained how this part of the equation
is handled.  Sure, adding a member to a RAID1 is trivial.  Just pause the
I/O, update the transform, and let it go.  Unfortunately, that new member
is not in sync with the rest.  The transform must be aware of this and only
trust the member below the sync mark.  How is this information communicated
to the transform?  Who updates the sync mark?  Who copies the data to the
new member while guaranteeing that an in-flight write does not occur to the
area being synced?  If you intend to add all of this to DM, then it is no
longer any "simpler" or more extensible than EMD.

Don't take my arguments the wrong way.  I believe that DM is useful
for what it was designed for: LVM.  It does not, however, provide the
machinery required for it to replace a generic RAID stack.  Could
you merge a RAID stack into DM.  Sure.  Its only software.  But for
it to be robust, the same types of operations MD/EMD perform in kernel
space will have to be done there too.

The simplicity of DM is part of why it is compelling.  My belief is that
merging RAID into DM will compromise this simplicity and divert DM from
what it was designed to do - provide LVM transforms.

As for RAID discovery, this is the trivial portion of RAID.  For an extra
10% or less of code in a meta-data module, you get RAID discovery.  You
also get a single point of access to the meta-data, avoid duplicated code,
and complex kernel/user interfaces.  There seems to be a consistent feeling
that it is worth compromising all of these benefits just to push this 10%
of the meta-data handling code out of the kernel (and inflate it by 5 or
6 X duplicating code already in the kernel).  Where are the benefits of
this userland approach?

--
Justin

