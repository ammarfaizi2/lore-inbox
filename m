Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264799AbTFQSGd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 14:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264695AbTFQSGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 14:06:30 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:24329 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S264543AbTFQSGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 14:06:24 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: True number of device openers in 2.5
Date: Tue, 17 Jun 2003 22:18:49 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200306121937.53198.arvidjaar@mail.ru> <20030612163724.GL6754@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030612163724.GL6754@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306172218.49203.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 June 2003 20:37, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Thu, Jun 12, 2003 at 07:37:53PM +0400, Andrey Borzenkov wrote:
> > For single-partition devices it is just bd_openers but I am more
> > intersted in multi-partition case. Here I need to know about sum of opens
> > for all partitions including the whole device. It appears that for a
> > container bd_openers is incremented for every open of itself and for the
> > _first_ open of partition and bd_part_count is incremented for every
> > (including first) open of partition. So bdev->bd_contains->bd_openers +
> > bdev->bd_contains->bd_part_count really gives an access (number of opened
> > partitions but this is unknown otherwise).
>
> There is no way to get anything useful out of that.  _Any_ kernel code
> that relies on such counters to tell if there's somebody else who might've
> accessed the thing does not account for the fact that fork() and dup()
> do not go beyond the struct file.
>
> IOW, any place that does
> 	if (number of openers == 1)
> 		do something that breaks if IO is going on
> is FUBAR.  Variant with

Hmm ... this is exactly what EJECT ioctls for some removables do. ide-floppy 
and cdrom for sure. sd does not do it because it does not actually support 
atomic EJECT ioctl so far. I am not interested in anything more than that.

> 	if (number of openers == 0)
> 		block ->open()
> 		do something ...
> will work, but it means that we are not triggering it from ioctl() on that
> device.  And here we only care about zero/non-zero, so ->bd_openers on
> the entire disk will do just fine.

My concern is EJECT implemetation. So far EJECT was handled by individual 
drivers that used private usage counters to decide when drive was free. Now 
CDEJECT is moved into drivers/block/scsi_ioctl.c which means that at least 
for IDE and SCSI removables device driver is never entered here. I am looking 
for reliable method to detect busy device on block layer - and yes, the code 
is triggered from ioctl (mostly).

regards

-andrey
