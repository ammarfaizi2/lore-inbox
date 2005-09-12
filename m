Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVILRxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVILRxA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVILRw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:52:59 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:30152 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751110AbVILRw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:52:58 -0400
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
	(end devices)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: ltuikov@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4325997D.3050103@adaptec.com>
References: <20050910024454.20602.qmail@web51613.mail.yahoo.com>
	 <1126368081.4813.46.camel@mulgrave>  <4325997D.3050103@adaptec.com>
Content-Type: text/plain
Date: Mon, 12 Sep 2005 12:52:45 -0500
Message-Id: <1126547565.4825.52.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-12 at 11:06 -0400, Luben Tuikov wrote:
> On 09/10/05 12:01, James Bottomley wrote:
> > On Fri, 2005-09-09 at 19:44 -0700, Luben Tuikov wrote:
> > 
> >>>this one completely duplicates the
> >>>mid-layer infrastructure for handling devices with Logical Units.
> >>
> >>No, it does *not*.  James, you have _stop_ spreading FUD, relying
> >>that other people have not read the SCSI Core code.
> > 
> > 
> > We have an infrastructure in the mid-layer for doing report lun scans.
> > You have a parallel one in your code.  In my book, that's duplication.
> 
> This infrastructure is broken.  Its interface is broken.  It is a horrible
> excuse of LUN scanning written initially to support a certain hardware.
> 
> LUN scanning is done a tad bit differently with a tad bit different
> interface.  Read the specs, study the code I submitted.
> 
> It is poinless for you to argue back just with a sentence and for
> me to reply back to you with *code*.
> 
> Again, unless you point out code, you're spreading FUD!
> 
> Here is excerpt from my previous message to the list:
> ---cut-start----
> Look at scsi_scan_target() declaration:
> 
> void scsi_scan_target(struct device *parent, unsigned int channel,
> 		      unsigned int id, unsigned int lun, int rescan);
> 
> Channel, id, lun, rescan?  WTF?
> 
> Do you see any of this in the proprely implemented LU discovery
> code in the SAS discovery code I submitted?

Well there is this in sas_discover.h:

struct scsi_core_mapping {
	int  channel;
	int  id;
};

struct LU {
[...]
	struct scsi_core_mapping map;


so if you use channel, id and scsilun_to_int() (or your SCSI_LUN
reimplementation of that) on your LUN structure, you have everything
necessary to interface to scsi_scan_target, yes.

You have to have this, otherwise you wouldn't be able to use
scsi_add_device in sas_scsi_host.c:sas_register_with_scsi().

Based on this it does look like your refusal to use scsi_scan_target is
based on ideological rather than technical objections.

It also looks like you have a bug in your id mapping code: you allocate
one id per lun, not per target, so you're going to run out pretty
quickly when you meet a device with actual logical units, since you hard
code max_ids to 128 in sas_port.c

James


