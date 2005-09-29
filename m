Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbVI2SZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVI2SZZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVI2SZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:25:24 -0400
Received: from magic.adaptec.com ([216.52.22.17]:50633 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932393AbVI2SZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:25:22 -0400
Message-ID: <433C3181.2080408@adaptec.com>
Date: Thu, 29 Sep 2005 14:25:05 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <ltuikov@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509281227570.19896-100000@master.linux-ide.org> <433B0374.4090100@adaptec.com> <20050928223542.GA12559@alpha.home.local> <433BFB1F.2020808@adaptec.com> <433BFEDB.6050505@pobox.com> <433C0D30.9050901@adaptec.com> <433C1C61.30506@pobox.com>
In-Reply-To: <433C1C61.30506@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2005 18:25:14.0872 (UTC) FILETIME=[22D32F80:01C5C523]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/29/05 12:54, Jeff Garzik wrote:
> Luben Tuikov wrote:
> 
>>of SAS.  THE REASON THEY WERE INTRODUCED INTO LINUX BY JB IS TO
>>ACCOMODATE MPT-based SOLUTIONS FROM TWIDDLING WITH IOCTLS!
> 
> 
> Wrong.  This shows you fundamentally don't understand transport classes 
> at all.
> 
> AFAIK, the first transport class was FC, for qla2xxx.
> 
> Read the code to see how FC avoids the SPI-centric scan -- an example of 
> transport independence.

And it shows that you do not understand SAM.

How do I know this: simple: JB's "transport attributes" have
NOTHING to do with SAM.

They break the layering architecture for one, and are
ATTRIBUTE EXPORTING FACILITY for another.

I understand that you want to preserve your friend's
bal^w^w^wpride but, lets face it:
  I do not try to shove my solution down JB's throat.

As I've said many times: they are different due to
the *technology they represent*, which differs in
implmentation, and they can coexist!

If you can say this statement:
  "The core problem is that a SAM-friendly path to SAS
   has already been chosen -- transport classes -- and
   your driver isn't following this path."

This means that you have NO CLUE ABOUT SAS or SAM!

I certainly hope that things would improve once you
start reading specs and talking to the engineers
who designed BCM8603.  (If you are still going to
write their driver for them.)

>>How do I know this: simple: JB's "transport attributes" have
>>NOTHING to do with SAM.
>>
>>They break the layering architecture for one, and are
>>ATTRIBUTE EXPORTING FACILITY for another.
> 
> 
> Transport class == transport layer.  Eventually this will sink in.
> 
> Transport class allows for complete transport independence, be it SAS, 
> FC, iSCSI, or other.

Nah -- all FUD.

See how you're talking general stuff.  See how I talk
specifics:

The host template was introduced to satisfy SPI only
LLDD which was everything available at that time and
SAM didn't exist yet.

Over time it was enlarged to accomodate others and
all LLDD implemented it and simulated SPI centric
view.

Now, you have a storage chip on a pci device which is
NOT a host template material.

I.e. the LLDD is a _PCI_ device driver, NOT SCSI!

It exports only a SAM section 5, 6 and 7 view of
the Service Delivery Subsystem and interconnect.

It does _not_ export anything "scsi host" like.

For this reason you _need_ a management layer
on top, but _below_ SCSI Core, since that management
layer is _transport_ specific _and_ SCSI Core
should be completely _unaware_ of the transport!

Then _this_ transport layer, presents things
to the SCSI Core as "scsi host" material.

Among the many, lets take for example this
member of the struct scsi_host_template
along with the comment:

	/*
	 * In many instances, especially where disconnect / reconnect are
	 * supported, our host also has an ID on the SCSI bus.  If this is
	 * the case, then it must be reserved.  Please set this_id to -1 if
	 * your setup is in single initiator mode, and the host lacks an
	 * ID.
	 */
	int this_id;

SPI-centric?

How about this from scsi_host:

	/*
	 * These three parameters can be used to allow for wide scsi,
	 * and for host adapters that support multiple busses
	 * The first two should be set to 1 more than the actual max id
	 * or lun (i.e. 8 for normal systems).
	 */
	unsigned int max_id;
	unsigned int max_lun;
	unsigned int max_channel;

And I can continue to give examples of this for as many lines
are in the header files of Linux SCSI.

Now Jeff will say: "Then submit patches to fix this."

> I'm merely stating I'm submitting patches to clean up SCSI core.  Others 
> have submitted far more patches than I.  And further patches to SCSI 

I've also submitted patches to improve SCSI Core.  Those improvements
came directly from my own mini-SCSI Core implementation of iSCSI Target.
For example, using the slab cache for scsi commands.

Thanks to Doug L, and Andi K, they made it in, if it had been left
to James Bottomley, they'd never be in.

Then I continued to post RFCs and various other suggestions, like
64 bit LUN, elimination of HCIL -- all shot down by your friends
in the community.

This was back when you had just started working on libata.

So please spare me the political sap -- I've tears in my eyes already.

> core are needed to properly integrate SAS as a transport completely 

Stop this FUD man -- it integrates right now:
http://linux.adaptec.com/sas/

> independent from SPI.  I'm going to be putting time and effort into 
> moving the SCSI core away from SPI, so that SAS can be properly integrated.

So you are going to give all currently existsing legacy LLDD
a heart attack?

Or are you going to create new functionality as I had
outlined here:
http://marc.theaimsgroup.com/?l=linux-scsi&m=112794008820004&w=2

You know, "struct scsi_domain_device", proper LU
scannint, etc.

> All I've seen from you is
> (a) complaints that the SCSI core is too SPI-centric

I've been wanting to change this since 2003.  I
even wrote an email that I wanted to completely
rewrite SCSI Core for 2.7 in 2003.  See this email.
http://marc.theaimsgroup.com/?l=linux-scsi&m=104508658212335&w=2

Sadly as most discussions in linux-scsi nothing materializes,
patches get dropped, etc, etc, et.

> (b) a solution that does nothing to fix this

But it gets you one step closed to it.  It merges _cleanly_,
people can use it get comfortable with it and eventually
things else where would improve as people get comfortable
with it.

> My goal is Linux.  Always has been.  I put quality of Linux code, and 
> giving features to Linux users, above all else.  Have been doing so 
> regardless of who employs me, for many years now.
> 
> Maybe one day I will be independently wealthy, be a completely 
> independent Linux maintainer, and then people will have to find

Jeff, if you think that if one day if you became independently
wealthy you'd be an independent Linux maintainer, or
do _any_ kind of work, you need to mature a bit more.
I _guarantee_ you that in 5 years you'd think differently.

Independently wealthy people start doing charity work
and then they use that to get into politics, in order
to obtain that which lacks from just having a ton of money:
power.

	Luben

 
> something other than Red Hat as the reason for why their code is 
> receiving criticism.
> 
> 
> 
>>I doubt you've ever been honest with me.*  The reason is that
>>you are trying to push down my throat JB's "transport classes",
>>all the while you're saying I'm supposed to change other people's
>>code?
> 
> 
> To get a fully SPI-independent SCSI core, we must change other people's 
> code.  That's the way Linux works.  We evolve the existing code.
> 
> 	Jeff
> 
> 
> 

