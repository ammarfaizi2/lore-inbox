Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVCWHUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVCWHUB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 02:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVCWHTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 02:19:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24470 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261197AbVCWHT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 02:19:26 -0500
Date: Wed, 23 Mar 2005 08:19:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 08/08] scsi: fix hot unplug sequence
Message-ID: <20050323071920.GJ24105@suse.de>
References: <20050323021335.960F95F8@htj.dyndns.org> <20050323021335.4682C732@htj.dyndns.org> <1111550882.5520.93.camel@mulgrave> <4240F5A9.80205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4240F5A9.80205@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23 2005, Tejun Heo wrote:
>  Hi,
> 
> James Bottomley wrote:
> >On Wed, 2005-03-23 at 11:14 +0900, Tejun Heo wrote:
> >
> >>	When hot-unplugging using scsi_remove_host() function (as usb
> >>	does), scsi_forget_host() used to be called before
> >>	scsi_host_cancel().  So, the device gets removed first without
> >>	request cleanup and scsi_host_cancel() never gets to call
> >>	scsi_device_cancel() on the removed devices.  This results in
> >>	premature completion of hot-unplugging process with active
> >>	requests left in queue, eventually leading to hang/offlined
> >>	device or oops when the active command times out.
> >>
> >>	This patch makes scsi_remove_host() call scsi_host_cancel()
> >>	first such that the host is first transited into cancel state
> >>	and all requests of all devices are killed, and then, the
> >>	devices are removed.  This patch fixes the oops in eh after
> >>	hot-unplugging bug.
> >
> >
> >This is actually simply reversing this patch:
> >
> >http://marc.theaimsgroup.com/?l=linux-scsi&m=109268755500248
> >
> >And all it does is give us the previous consequences back.
> >
> >The oops isn't in the eh it's in the usb-storage eh routine.
> 
>  Well, but it's because scsi midlayer calls back into usb-storage eh 
> after the detaching process is complete.
> 
> >However, the current host code does need fixing, but the fix is to move
> >it over to a proper state model rather than the current bit twiddling we
> >do.
> 
>  I agree & am working on it.  This patch was mainly to verify Jens' oops.

It is not the oops I am getting. When I get a few minutes today, I'll
reproduce with vanilla and post it here.

-- 
Jens Axboe

