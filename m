Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVC2REV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVC2REV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 12:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVC2RC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 12:02:56 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:50137 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261243AbVC2RCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 12:02:10 -0500
Date: Tue, 29 Mar 2005 09:02:01 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Tejun Heo <htejun@gmail.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Jens Axboe <axboe@suse.de>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 07/08] scsi: remove bogus	{get|put}_device() calls
Message-ID: <20050329170201.GA6787@us.ibm.com>
References: <20050323021335.960F95F8@htj.dyndns.org> <20050323021335.0D9E25EE@htj.dyndns.org> <1111551355.5520.100.camel@mulgrave> <42413336.2010004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42413336.2010004@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 06:13:26PM +0900, Tejun Heo wrote:
>  Hi,
> 
> James Bottomley wrote:
> >On Wed, 2005-03-23 at 11:14 +0900, Tejun Heo wrote:
> >
> >>	So, basically, SCSI high-level object (scsi_disk) and
> >>	mid-level object (scsi_device) are reference counted by users,
> >>	not the requests they submit.  Reference count cannot go zero
> >>	with active users and users cannot access the object once the
> >>	reference count reaches zero.
> >
> >
> >Actually, no.  Unfortunately we still have some fire and forget APIs, so
> >the contention that we always have an open refcounted descriptor isn't
> >always true.

What API's, and what usage?

>  Yeap, you're right.  So, what we have is

>  * All high-level users have open access to the scsi high-level
>    object on issueing requests, but may close it before its requests
>    complete.

>  * All mid-layer users do get_device() before submitting requests,
>    but may put_device() before its requests complete.

Any LLDD's issuing requests should be doing a get/put around the request.

Any upper level drivers calling scsi_device_put() before a request
completes is likely a bug. sg has code in place to handle the
post-release/close completion of IO (IMO, a bad design).

Are any upper level drivers calling scsi_device_put() while they have
outstanding IO?

The scan code never calls upper level drivers probe functions via
device_add unless we are going to keep the scsi_device (well, there are
error paths in scsi_sysfs_add_sdev that look bad - we don't check the
result of scsi_sysfs_add_sdev). But for completeness, we could add
get/puts to the scan code.

As you pointed out, the current get_device() will never return NULL when
called via:

	get_device(&sdev->sdev_gendev)

The current code only narrows the window where problems might occur, I
don't see how it can completely avoid races with removal.

And the patch removes code from the mainline scsi IO paths.

-- Patrick Mansfield
