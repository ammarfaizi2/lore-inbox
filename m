Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVILVXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVILVXR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVILVXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:23:17 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:30410 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932095AbVILVXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:23:16 -0400
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
	(end devices)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: ltuikov@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4325E5AE.1080900@adaptec.com>
References: <20050910024454.20602.qmail@web51613.mail.yahoo.com>
	 <1126368081.4813.46.camel@mulgrave>  <4325997D.3050103@adaptec.com>
	 <1126547565.4825.52.camel@mulgrave>  <4325E5AE.1080900@adaptec.com>
Content-Type: text/plain
Date: Mon, 12 Sep 2005 16:23:10 -0500
Message-Id: <1126560191.4825.71.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-12 at 16:31 -0400, Luben Tuikov wrote:
> On 09/12/05 13:52, James Bottomley wrote:
> > Well there is this in sas_discover.h:
> > 
> > struct scsi_core_mapping {
> > 	int  channel;
> > 	int  id;
> > };
> > 
> > struct LU {
> > [...]
> > 	struct scsi_core_mapping map;
> > 
> > 
> > so if you use channel, id and scsilun_to_int() (or your SCSI_LUN
> > reimplementation of that) on your LUN structure, you have everything
> > necessary to interface to scsi_scan_target, yes.
> > 
> > You have to have this, otherwise you wouldn't be able to use
> > scsi_add_device in sas_scsi_host.c:sas_register_with_scsi().
> > 
> > Based on this it does look like your refusal to use scsi_scan_target is
> > based on ideological rather than technical objections.
> 
> Hmm, no.
> 
> Channel and id are assigned _after_ the device has been scanned for
> LUs.  So I cannot just call scsi_scan_target() and say: "here is
> this SCSI Domain device, I know nothing about, other than
> the fact that it has a Target port, scan it".

In your code channel corresponds to an index in the ports array of the
host adapter and hence is known before you do any logical unit scanning.
Id is assigned from a bitmap in the port.  You could do that assignment
in sas_discover_end_dev() then you could use scsi_scan_target() in place
of sas_do_lu_discovery().  It would also mitigate your bug below since
now your id is one to one on the end devices rather than the logical
units of the end devices, so each port would support up to 128 end
devices rather than 128 logical units.

> SCSI Core has no representation of a SCSI Target, it has
> an HCIL representation.
> 
> > It also looks like you have a bug in your id mapping code: you allocate
> > one id per lun, not per target, so you're going to run out pretty
> > quickly when you meet a device with actual logical units, since you hard
> > code max_ids to 128 in sas_port.c
> 
> Yes, this is a bit more involved (on a larger scale than per port).
> The hard coding is intentional.
> 
> Ideally, I'd not have to generate Channel and Id to accomodate
> SCSI Core's ancient SPI centric code.
> 
> Then I'd not need max_ids and/or the bitmap.

James


