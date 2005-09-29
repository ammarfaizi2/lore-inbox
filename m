Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVI2O1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVI2O1N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 10:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVI2O1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 10:27:13 -0400
Received: from emulex.emulex.com ([138.239.112.1]:2479 "EHLO emulex.emulex.com")
	by vger.kernel.org with ESMTP id S932164AbVI2O1L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 10:27:11 -0400
From: James.Smart@Emulex.Com
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: SATA suspend/resume (was Re: [PATCH] updated version of Jens' SATA suspend-to-ram patch)
Date: Thu, 29 Sep 2005 10:26:25 -0400
Message-ID: <9BB4DECD4CFE6D43AA8EA8D768ED51C21D7AC2@xbl3.ma.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SATA suspend/resume (was Re: [PATCH] updated version of Jens' SATA suspend-to-ram patch)
Thread-Index: AcXEzYVO8K96UQ5LTuC4G3i7hKmhpgAMwBvA
To: <hch@infradead.org>, <jgarzik@pobox.com>, <joshk@triplehelix.org>,
       <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>, <axboe@suse.de>, <torvalds@osdl.org>,
       <rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In other times when I implemented this....

You need to be careful on the power-up. Many JBODs share a single
"enclosure" and that enclosure has a limited power supply. If all
drives were spun up in parallel (and a drive may take 10-15seconds
to spin up), then they can overload the enclosure's power limit.
This issue, which normally occurs when an enclosure is first powered
on, was solved by injecting sequence delays based on either jumpers
or delays based on address/slot. But this won't help the software
suspend/resume.

There were not a lot of great answers on how to solve this as it usually
required knowledge of how the hardware was packaged. What we defaulted
to was limiting spin up to never concurrently start more than N drives
on a scsi bus. N defaulted to 1, but allowed the admin to tune it.

-- james s

> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org
> [mailto:linux-scsi-owner@vger.kernel.org]On Behalf Of 
> Christoph Hellwig
> Sent: Thursday, September 29, 2005 4:12 AM
> To: Christoph Hellwig; Jeff Garzik; Joshua Kwan;
> linux-kernel@vger.kernel.org; linux-ide@vger.kernel.org;
> linux-scsi@vger.kernel.org; axboe@suse.de; torvalds@osdl.org;
> randy_dunlap
> Subject: Re: SATA suspend/resume (was Re: [PATCH] updated version of
> Jens' SATA suspend-to-ram patch)
> 
> 
> On Thu, Sep 29, 2005 at 08:34:37AM +0100, Christoph Hellwig wrote:
> > is an ULDD operation, not an LLDD one, and this fits the 
> layering model
> > much better.  The only complaints here are cosmetics:
> > 
> >  - generic_scsi_suspend/generic_scsi_resume are misnamed, 
> they should
> >    probably be scsi_device_suspend/resume.
> >  - while we're at it they could probably move to 
> scsi_sysfs.c to keep
> >    them static in one file - they're just a tiny bit of glue anyway.
> >  - get rid of all the CONFIG_PM ifdefs - it just clutters 
> thing up far
> >    too much.
> 
> Actually one important thing is missing, that is a way to 
> avoid spinning
> down external disks.  As a start a sysfs-controlable flag 
> should do it,
> later we can add transport-specific ways to find out whether a device
> is external.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
