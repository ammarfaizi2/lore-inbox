Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVCZOtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVCZOtL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 09:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVCZOtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 09:49:11 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:15283 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262105AbVCZOtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 09:49:04 -0500
Subject: Re: [PATCH scsi-misc-2.6 08/08] scsi: fix hot unplug sequence
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0503260907450.19764@kai.makisara.local>
References: <20050323021335.960F95F8@htj.dyndns.org>
	 <20050323021335.4682C732@htj.dyndns.org>
	 <1111550882.5520.93.camel@mulgrave> <4240F5A9.80205@gmail.com>
	 <20050323071920.GJ24105@suse.de> <1111591213.5441.19.camel@mulgrave>
	 <20050323152550.GB16149@suse.de> <1111711558.5612.52.camel@mulgrave>
	 <20050325031511.GA22114@htj.dyndns.org> <1111726965.5612.62.camel@mulgrave>
	 <20050325053842.GA24499@htj.dyndns.org> <1111778388.5692.38.camel@mulgrave>
	 <Pine.LNX.4.61.0503260907450.19764@kai.makisara.local>
Content-Type: text/plain
Date: Sat, 26 Mar 2005 08:48:58 -0600
Message-Id: <1111848538.5711.11.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-26 at 09:27 +0200, Kai Makisara wrote:
> I fully agree that doing done() correctly _is_ a problem, especially when 
> the SCSI subsystem evolves and the high-level driver writers do not follow 
> the development closely enough.
> 
> One solution to these problems would be to let the drivers still use 
> scsi_do_req() and their own done() function, but create two 
> (three) helpers:
> - one to be called at the beginning of done(); it would do what needs to 
>   be done here but lets the driver to do some special things of its own if
>   necessary
> - one to be called to wait for the request to finish
> (- one to do scsi_ro_req() and the things necessary before these)

Yes.  The drivers that use it just need visiting with a big hammer.
However, our character ULDs (st and sg) use it because they try to
simulate fire and forget in the async write path (That's the only time
you actually don't wait on completion for scsi_do_req).

This comes about because the mid-layer is block oriented, so you can't
use any of the read/write machinery.  We could fix this by having a
generic character tap to a block queue for use in cases like SCSI where
the underlying driver uses block queues even if the actual device isn't
a block device.

Essentially, the character tap would simply submit a stream of reads and
writes through the block queue.  Then we could modify st and sg to use
an identical framework to the other ULDs ... you get a setup API and a
returning command API which are called for every I/O and the block layer
gets to handle the async/not-async pieces.

James


