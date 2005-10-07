Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbVJGHfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVJGHfO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 03:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVJGHfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 03:35:13 -0400
Received: from fmr14.intel.com ([192.55.52.68]:31645 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751317AbVJGHfL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 03:35:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC] add sysfs to dynamically control blk request tag maintenance
Date: Fri, 7 Oct 2005 00:35:04 -0700
Message-ID: <B05667366EE6204181EABE9C1B1C0EB5086AEC2E@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] add sysfs to dynamically control blk request tag maintenance
Thread-Index: AcXLD/Ae/lpiIb9ORSqmbv6aVG5rugAAHcDg
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Oct 2005 07:35:06.0409 (UTC) FILETIME=[A3461990:01C5CB11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote on Friday, October 07, 2005 12:24 AM
> I don't understand the need for this patch - the generic tagging is
only
> used if the SCSI LLD indicated it wanted it by issuing a
> scsi_activate_tcq(). So blk_queue_start_tag() is only called if the
LLD
> already did a scsi_activate_tcq(), and blk_queue_end_tag() is only
> called if the rq is block layer tagged. blk_queue_find_tag() is only
> used with direct use of scsi_find_tag(), a function that should (and
is)
> only usable by users of the generic tagging already.
> 

You beat me by a couple of minutes.  I was about to say that the culprit
is in the qla2x00 driver where it unnecessarily activated generic blk
tag queuing by calling scsi_activate_tcq() and it never uses tag.

> So please, a description of what problem you are trying to solve would
> be appreciated :-)

It starts out with scsi_end_request being a fairly hot function in the
execution profile, then I noticed blk_queue_start/end_tag() are being
called but no actual consumer of using the tag.  I'm trying to find a
way to avoid making these blk_queue_start/end_tag calls.  I got the
answer
now. The proper way is to fix it in the scsi LLDD.  Scratch this patch,
new patch to follow :-)

- Ken
