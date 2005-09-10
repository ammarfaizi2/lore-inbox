Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVIJQB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVIJQB1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 12:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVIJQB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 12:01:27 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:3763 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750798AbVIJQB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 12:01:26 -0400
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
	(end devices)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: ltuikov@yahoo.com
Cc: Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050910024454.20602.qmail@web51613.mail.yahoo.com>
References: <20050910024454.20602.qmail@web51613.mail.yahoo.com>
Content-Type: text/plain
Date: Sat, 10 Sep 2005 11:01:21 -0500
Message-Id: <1126368081.4813.46.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-09 at 19:44 -0700, Luben Tuikov wrote:
> > this one completely duplicates the
> > mid-layer infrastructure for handling devices with Logical Units.
> 
> No, it does *not*.  James, you have _stop_ spreading FUD, relying
> that other people have not read the SCSI Core code.

We have an infrastructure in the mid-layer for doing report lun scans.
You have a parallel one in your code.  In my book, that's duplication.

> See here:
>     SCSI Core has *no representation* of a SCSI Device with a
> SCSI Target Port.

A scsi target is represented by struct scsi_target.

> I've _clearly_ outlined that in the comments of the code,
> which you _conveniently_ did _not_ cut and paste here.
> 
> I've been asking for a generic SCSI Target representation for
> the last 5 years, which you conventiently skip to mention.
> Or shall we search linux-scsi archives?
> 
> As to duplication: NOT!
> 
> Why?
> 
> Look at scsi_scan_target() declaration:
> 
> void scsi_scan_target(struct device *parent, unsigned int channel,
> 		      unsigned int id, unsigned int lun, int rescan);
> 
> Channel, id, lun, rescan?  WTF?

So you want to rehash that argument again.

Either you can do what others like FC currently do:

http://marc.theaimsgroup.com/?l=linux-scsi&m=110546207223304

Or you can follow the recipe you were given for making the mid-layer use
arbitrary identifiers for the target

http://marc.theaimsgroup.com/?l=linux-scsi&m=112487476527470

Simply writing your own because you don't like the former and the
latter's too much work isn't acceptable.

> Do you see any of this in the proprely implemented LU discovery
> code in the SAS discovery code I submitted?

Yes, of course, I did notice the W_LUN support which we could do with in
scsi_report_lun_scan() if you'd care to play nicely with others.

> I asked for pure SCSI device with Target port implementation of
> scsi_target and _you_ rejected it about 4 years ago.  Shall I search
> for this message in the linux-scsi archives?

You can ask for all the features you want ... however, unless you can
persuade someone else to do the implementation, you get to write the
code yourself...

> > > + * REPORT LUNS is mandatory.  If a device doesn't support it,
> > > + * it is broken and you should return it.  Nevertheless, we
> > > + * assume (optimistically) that the link hasn't been severed and
> > > + * that maybe we can get to the device anyhow.
> > 
> > That's a surprisingly optimistic statement from someone who claims to
> > have worked in SCSI for so long.  We have a huge list of heuristics for
> 
> Ouch!  Getting into the personal arena now, are we?
> 
> James, how old are the blacklisted devices you talk of?
> 
> How old are SAS devices? 
> 
> > devices that violate the standards in one way or another.  We already
> > have a flag for a SCSI3 device that doesn't respond correctly to
> > REPORT_LUNS ... and we have a few other reports of potentially more
> > suspect devices.
> 
> Are those devices SAS?
> 
> Again, stop spreading FUD and talking as you know what you're talking about.
> 
> "few other reports of potentially more suspect devices" -- is such
> a broad and vague statement that it isn't worth much.
> 
> First are those SAS devices.
> 
> Second, SAS devices being very recent have their firmware written
> to latest specs, and advertised as SPC-3 and SAM-3.

We have boatloads of devices that claim SCSI-n or SPC-n compliance then
fail in various ways.  That's what the list in scsi_devinfo.c is all
about.  I'm sure the manufacturers of those devices didn't intentionally
set out to violate the specs; however, what they actually released does.
I'm sure that SAS vendors will start out with the best of intentions
too ...

> > Now, if you did this properly and used the mid-layer infrastructure you
> > wouldn't have to worry about any of this.
> > 
> > > +static int sas_do_lu_discovery(struct domain_device *dev)
> > 
> > Please just handle targets ... scanning beyond targets is best handled
> > in generic code.
> 
> I agree.
> 
> But that generic code you talk about is complete *crap* and needs
> rewriting.  When that generic code, can handle "SCSI device with
> a Target port" then I'd love to off load that to SCSI Core.
> 
> In fact initially I _really_ tried to offload that to SCSI Core,
> but it didn't quite work, then I wrote LU discovery.  Just run it on
> real hardware.

The practise of allowing Vendors to duplicate code just because they
didn't like what's in the generic subsystem or because it lacks a
feature they need hasn't been acceptable for a long time now.  Either
use what we have or fix it to do what you want.

James


