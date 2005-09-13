Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932699AbVIMUBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbVIMUBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932698AbVIMUBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:01:14 -0400
Received: from magic.adaptec.com ([216.52.22.17]:11663 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932696AbVIMUBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:01:12 -0400
Message-ID: <43273001.3070309@adaptec.com>
Date: Tue, 13 Sep 2005 16:01:05 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: ltuikov@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <20050910024454.20602.qmail@web51613.mail.yahoo.com>	 <1126368081.4813.46.camel@mulgrave>  <4325997D.3050103@adaptec.com>	 <1126547565.4825.52.camel@mulgrave>  <4325E5AE.1080900@adaptec.com>	 <1126560191.4825.71.camel@mulgrave>  <4326CAC6.3050202@adaptec.com> <1126626858.4809.26.camel@mulgrave>
In-Reply-To: <1126626858.4809.26.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2005 20:01:11.0137 (UTC) FILETIME=[E3378510:01C5B89D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/05 11:54, James Bottomley wrote:
> On Tue, 2005-09-13 at 08:49 -0400, Luben Tuikov wrote:
> 
>>>>Channel and id are assigned _after_ the device has been scanned for
>>>>LUs.  So I cannot just call scsi_scan_target() and say: "here is
>>>>this SCSI Domain device, I know nothing about, other than
>>>>the fact that it has a Target port, scan it".
>>>
>>>In your code channel corresponds to an index in the ports array of the
>>>host adapter and hence is known before you do any logical unit scanning.
>>>Id is assigned from a bitmap in the port.  You could do that assignment
>>>in sas_discover_end_dev() then you could use scsi_scan_target() in place
>>>of sas_do_lu_discovery().  It would also mitigate your bug below since
>>>now your id is one to one on the end devices rather than the logical
>>>units of the end devices, so each port would support up to 128 end
>>>devices rather than 128 logical units.
>>
>>James, even Christoph understands this: no HCIL in SCSI Core is needed.
>>The whole problem is not what you *keep grinding about over and over above*,
>>but the fact that I have to _invent_ channel, id and emaciated LUN to give
>>to the broken, outdated and Parallel SCSI-centric SCSI Core.
>>
>>Christoph understand this, why cannot you?
>>
>>That bitmap was added in the last moment when I needed to register devices
>>with SCSI Core.  There is a lot of other problems which I've pointed out
>>int the scsi glue file, which do you not want to talk about or you do
>>not bring up.
> 
> 
> I think, therefore, I've made the point that you could have used
> scsi_scan_target() but chose not to for ideological rather than
> technical reasons.

I did try to use scsi_scan_target() but it was just tremendously
ugly, and I still had to generate HCIL, and it didn't work for some
unknown reason, and I didn't go on to investigate for reasons mentioned
below.

You know that SCSI Core is broken and outdated, you know that
HCIL needs to go, you know that this is just the right moment
and you still insist on your own.  This isn't a very good trait
for a maintainer.  I told you: you need to *listen* more than
you order things around.

> Writing code which duplicates existing mid-layer functionality is what
> I've been telling you all along isn't acceptable.  Use what exists to

I don't see any code duplication, as I already explained many
times in this and other threads.

> day and if it doesn't work quite right, fix it.  If you want to alter an
> interface, we need to evolve towards it keeping all the current users
> working.

You cannot do this because the current interface is _broken_ and you
cannot give heart-attack to all LLDD currently using it.  You should
know this, you're the maintaner.

What you need to do is start writing new functions to be used
by the SAS Transport Layer, which could be _universally_ used by
IEEE 1394, FC, USB, Infiniband, etc, where the is no such thing as HCIL.

So that they do not have to generate HCIL.

I mean, I keep repeating the same thing over and over again.  It is as
if I'm talking to a wall.

> Now, I can merge your transport class with Christoph's (or find someone
> else to do it for me) by converting it to use the existing mid-layer and
> transport class infrastructure (I think, actually, it will look rather
> nice after this and probably reduce in size by about 50%) but I'd much

No, it would _not_ reduce by about 50% -- stop spreading FUD!

sas_scsi_host.c -- the SAS<->SCSI glue is _only_ 991 lines including
comments and GPL license blurb at top.

SAS Transport Layer is 8030 lines total.  This means that if anything is
reduced it would be by less than 12%, (if you were to obliterate sas_scsi_host.c).

> rather that you did it.

Apparently you do not understand the difference between the
Open Transport and MPT.

Christoph does.  Please talk to him.  You may also want to talk
to Eric or someone else here who understands this.

> The unified transport class should be capable of supporting both the
> aic94xx SAS card using your existing domain device interface as well as
> the fusion SAS card, which is the whole goal of all of this in the first
> place.

No, this is *your agenda*, and it has _never_ been "in the first place".
Stop spreading FUD.  In the first place was SAS Support in the kernel as
I've posted specs to linux-scsi in April of this year and in 
July of this year before OLS to you and some other folks.

You cannot reconcile a technology whose sole existence is to *hide*
transport specifics (Fusion MPT) and *only export SCSI LUs* and technology
which exposes the transport in its bare minimum.

> So, do you want to do this work, or would you rather just be responsible
> for the aic94xx driver?

James, this is very rude and smacks full of incompetence.

Talk to Eric or their MPT engineers, or even Christoph to see and
understand the problem between MPT and Open Transport.  The two
technologies are a world apart.

Christoph has begun to understand things correctly by asking
what _can_ be shared if anyhing.

You cannot order things like this around, bridging two competing
companies.  You cannot order things like this around to have it
your way.  You cannot order people working for other companies
to do things.  This is very rude and incompetent, _and_ naive.

Notice that no other maintainer has this tone of voice.  The reason
is that they do not pretend to know everything.

You cannot order who's responsible for what.  They who wrote the code
have a say.

This is very rude of you.  I'm sorry I have to say this.

You don't seem to concentrate on technology discussions but quickly
start ordering people around -- very unbecoming for a maintainer,
who's also a CTO.

Documentation/ManagementStyle

	Luben

