Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268269AbUHQPDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268269AbUHQPDz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUHQPDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:03:55 -0400
Received: from the-village.bc.nu ([81.2.110.252]:25576 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268269AbUHQPDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:03:50 -0400
Subject: Re: Merge I2O patches from -mm
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Christoph Hellwig <hch@infradead.org>, Warren Togami <wtogami@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <412208A6.7020104@shadowconnect.com>
References: <411F37CC.3020909@redhat.com>
	 <20040817125303.A21238@infradead.org>  <412208A6.7020104@shadowconnect.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092751257.22793.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 17 Aug 2004 15:00:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-17 at 14:31, Markus Lidel wrote:
> > Now to i2o_scsi:
> >  - the logic of "demand-allocating" Scsi_Hosts looks rather bad to me,
> >    life would be much simpler with a Scsi_Host per i2o device.
> 
> But wouldn't it be a waste of resources to allocate a Scsi_Host 
> structure for every I2O device? Note that the i2o_scsi "sees" all disks 
> even if they are in a RAID array, so in most cases there are at least 3 
> Scsi_Host adapters...

Christoph the "I2O" device is a communication processor. You need to
preserve the real scsi busses in order to get sane results from scsi
tools. If EH is implemented you'll need this to do controlled resets
(although this gets quite umm 'interesting' if using i2o_block also)

You've got

	I2O comms processor
		Multiple scsi busses
			Multiple drives
		Block driver providing abstract volumes

Sometimes (as with other raid) bypassing the block driver is faster.

> >  - the completely lack of SCSI EH in this driver scares me, does the firmware
> >    really handle all EH?
> 
> The i2o_scsi driver is not used to access the disks, it is only for 
> monitoring. The i2o_block driver handles disk access. So if you reset 

(not always - the FC920 is way faster using i2o_scsi for the disk I/O)

> the SCSI channel in the i2o_scsi driver, commands which are transfered 
> by the i2o_block driver will be aborted (this is the reason, why the I2O 
> subsystem didn't work for users, which compiled in i2o_scsi and 
> i2o_block into the kernel)...

All error timeout handling is done by the controller. It does really
need minimal EH handlers simply to reissue failed timed out commands.


