Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUCWGX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 01:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUCWGXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 01:23:55 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:2067 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id S262058AbUCWGXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 01:23:44 -0500
Date: Mon, 22 Mar 2004 23:23:36 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
Message-ID: <2128160000.1080023015@aslan.btc.adaptec.com>
In-Reply-To: <16479.50592.944904.708098@notabene.cse.unsw.edu.au>
References: <760890000.1079727553@aslan.btc.adaptec.com> <16479.50592.944904.708098@notabene.cse.unsw.edu.au>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> o Any successful solution will have to have "meta-data modules" for
>>   active arrays "core resident" in order to be robust.  This

...

> I agree.
> 'Linear' and 'raid0' arrays don't really need metadata support in the
> kernel as their metadata is essentially read-only.
> There are interesting applications for raid1 without metadata, but I
> think that for all raid personalities where metadata might need to be
> updated in an error condition to preserve data integrity, the kernel
> should know enough about the metadata to perform that update.
> 
> It would be nice to keep the in-kernel knowledge to a minimum, though
> some metadata formats probably make that hard.

Can you further explain why you want to limit the kernel's knowledge
and where you would separate the roles between kernel and userland?

In reviewing one of our typical metadata modules, perhaps 80% of the code
is generic meta-data record parsing and state conversion logic that would
have to be retained in the kernel to perform "minimal meta-data updates".
Some high portion of this 80% (less the portion that builds the in-kernel
data structures to manipulate and update meta-data) would also need to be
replicated into a user-land utility for any type of separation of labor to
be possible.  The remaining 20% of the kernel code deals with validation of
user meta-data creation requests.  This code is relatively small since
it leverages all of the other routines that are already required for
the operational requirements of the module.

Splitting the roles bring up some important issues:

1) Code duplication.

Depending on the complexity of the meta-data format being supported,
the amount of code duplication between userland and kernel modules
may be quite large.  Any time code is duplicated, the solution is
prone to getting out of sync - bugs are fixed in one copy of the code
but not another.

2) Solution Complexity

Two entities understand how to read and manipulate the meta-data.
Policies and APIs must be created to ensure that only one entity
is performing operations on the meta-data at a time.  This is true
even if one entity is primarily a read-only "client".  For example,
a meta-data module may defer meta-data updates in some instances
(e.g. rebuild checkpointing) until the meta-data is closed (writing
the checkpoint sooner doesn't make sense considering that you should
restart your scrub, rebuild or verify if the system is not safely
shutdown).  How does the userland client get the most up-to-date
information?  This is just one of the problems in this area.

3) Size

Due to code duplication, the total solution will be larger in
code size.

What benefits of operating in userland outweigh these issues?

>> o It is desirable for arrays to auto-assemble based on recorded
>>   meta-data.  This includes the ability to have a user hot-insert
>>   a "cold spare", have the system recognize it as a spare (based
>>   on the meta-data resident on it) and activate it if necessary to
>>   restore a degraded array.
> 
> Certainly.  It doesn't follow that the auto-assembly has to happen
> within the kernel.  Having it all done in user-space makes it much
> easier to control/configure.
> 
> I think the best way to describe my attitude to auto-assembly is that
> it could be needs-driven rather than availability-driven.
> 
> needs-driven means: if the user asks to access an array that doesn't
>   exist, then try to find the bits and assemble it.
> availability driven means: find all the devices that could be part of
>   an array, and combine as many of them as possible together into
>   arrays.
> 
> Currently filesystems are needs-driven.  At boot time, only to root
> filesystem, which has been identified somehow, gets mounted. 
> Then the init scripts mount any others that are needed.
> We don't have any hunting around for filesystem superblocks and
> mounting the filesystems just in case they are needed.

Are filesystems the correct analogy?  Consider that a user's attempt
to mount a filesystem by label requires that all of the "block devices"
that might contain that filesystem be enumerated automatically by
the system.  In this respect, the system is treating an MD device in
exactly the same way as a SCSI or IDE disk.  The array must be exported
to the system on an "availability basis" in order for the "needs-driven"
features of the system to behave as expected.

> Currently partitions are (sufficiently) needs-driven.  It is true that
> any partitionable devices has it's partitions presented.  However the
> existence of partitions does not affect access to the whole device at
> all.  Only once the partitions are claimed is the whole-device
> blocked. 

This seems a slight digression from your earlier argument.  Is your
concern that the arrays are auto-enumerated, or that the act of enumerating
them prevents the component devices from being accessed (due to bd_clam)?

> Providing that auto-assembly of arrays works the same way (needs
> driven), I am happy for arrays to auto-assemble.
> I happen to think this most easily done in user-space.

I don't know how to reconcile a needs based approach with system
features that require arrays to be exported as soon as they are
detected.

> With DDF format metadata, there is a concept of 'imported' arrays,
> which basically means arrays from some other controller that have been
> attached to the current controller.
> 
> Part of my desire for needs-driven assembly is that I don't want to
> inadvertently assemble 'imported' arrays.
> A DDF controller has NVRAM or a hardcoded serial number to help avoid
> this.  A generic Linux machine doesn't.
> 
> I could possibly be happy with auto-assembly where a kernel parameter
> of DDF=xx.yy.zz was taken to mean that we "need" to assemble all DDF
> arrays that have a controler-id (or whatever it is) of xx.yy.zz.
> 
> This is probably simple enough to live entirely in the kernel.

The concept of "importing" an array doesn't really make sense in
the case of MD's DDF.  To fully take advantage of features like
a controller BIOS's ability to natively boot an array, the disks
for that domain must remain in that controller's domain.  Determining
the domain to assign to new arrays will require input from the user
since there is limited topology information available to MD.  The
user will also have the ability to assign newly created  arrays to
the "MD Domain" which is not tied to any particular controller domain.

...

> But back to your original post:  I suspect there is lots of valuable
> stuff in your emd patch, but as you have probably gathered, big
> patches are not the way we work around here, and with good reason.
> 
> If you would like to identify isolated pieces of functionality, create
> patches to implement them, and submit them for review I will be quite
> happy to review them and, when appropriate, forward them to
> Andrew/Linus.
> I suggest you start with less controversial changes and work your way
> forward.

One suggestion that was recently raised was to present these changes
in the form of an alternate "EMD" driver to avoid any potential
breakage of the existing MD.  Do you have any opinion on this?

--
Justin

