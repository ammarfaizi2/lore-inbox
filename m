Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbVCWEJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbVCWEJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 23:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVCWEIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 23:08:32 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:6887 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262760AbVCWEIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 23:08:07 -0500
Subject: Re: [PATCH scsi-misc-2.6 08/08] scsi: fix hot unplug sequence
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050323021335.4682C732@htj.dyndns.org>
References: <20050323021335.960F95F8@htj.dyndns.org>
	 <20050323021335.4682C732@htj.dyndns.org>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 22:08:02 -0600
Message-Id: <1111550882.5520.93.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 11:14 +0900, Tejun Heo wrote:
> 	When hot-unplugging using scsi_remove_host() function (as usb
> 	does), scsi_forget_host() used to be called before
> 	scsi_host_cancel().  So, the device gets removed first without
> 	request cleanup and scsi_host_cancel() never gets to call
> 	scsi_device_cancel() on the removed devices.  This results in
> 	premature completion of hot-unplugging process with active
> 	requests left in queue, eventually leading to hang/offlined
> 	device or oops when the active command times out.
> 
> 	This patch makes scsi_remove_host() call scsi_host_cancel()
> 	first such that the host is first transited into cancel state
> 	and all requests of all devices are killed, and then, the
> 	devices are removed.  This patch fixes the oops in eh after
> 	hot-unplugging bug.

This is actually simply reversing this patch:

http://marc.theaimsgroup.com/?l=linux-scsi&m=109268755500248

And all it does is give us the previous consequences back.

The oops isn't in the eh it's in the usb-storage eh routine.

However, the current host code does need fixing, but the fix is to move
it over to a proper state model rather than the current bit twiddling we
do.

James


