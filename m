Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVCYAyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVCYAyu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 19:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVCYAxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:53:08 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:32410 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261341AbVCYAqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 19:46:09 -0500
Subject: Re: [PATCH scsi-misc-2.6 08/08] scsi: fix hot unplug sequence
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Tejun Heo <htejun@gmail.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050323152550.GB16149@suse.de>
References: <20050323021335.960F95F8@htj.dyndns.org>
	 <20050323021335.4682C732@htj.dyndns.org>
	 <1111550882.5520.93.camel@mulgrave> <4240F5A9.80205@gmail.com>
	 <20050323071920.GJ24105@suse.de> <1111591213.5441.19.camel@mulgrave>
	 <20050323152550.GB16149@suse.de>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 18:45:58 -0600
Message-Id: <1111711558.5612.52.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 16:25 +0100, Jens Axboe wrote:
> Let me guess, it is hanging in wait_for_completion()?

Yes, I have the trace now.  Why is curious.  This is the trace of the
failure:

Mar 24 18:40:34 localhost kernel: usb 4-2: USB disconnect, address 3
Mar 24 18:40:34 localhost kernel: sd 0:0:0:0: CMD c25c98b0 done, completing
Mar 24 18:40:34 localhost kernel:  0:0:0:0: cmd c25c98b0 returning
Mar 24 18:40:34 localhost kernel:  0:0:0:0: cmd c25c98b0 going out <6>Read Capacity (10) 25 00 00 00 00 00 00 00 00 00
Mar 24 18:40:34 localhost kernel: scsi0 (0:0): rejecting I/O to dead device (req c25c98b0)
Mar 24 18:40:34 localhost kernel: usb 4-2: new full speed USB device using uhci_hcd and address 4
Mar 24 18:40:34 localhost kernel: scsi1 : SCSI emulation for USB Mass Storage devices
Mar 24 18:40:34 localhost kernel:  1:0:0:0: cmd c1a1b4b0 going out <6>Inquiry 12 00 00 00 24 00

The problem occurs when the mid-layer rejects the I/O to the dead
device.  Here it returns BLKPREP_KILL to the prep function, but after
that we never get a completion back.

I'll dig around in ll_rw_blk.c to see if I can trace the problem, but
you know this code better than I do ...

James


