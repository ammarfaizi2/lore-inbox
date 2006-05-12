Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWELUh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWELUh7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 16:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWELUh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 16:37:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11021 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751336AbWELUh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 16:37:58 -0400
Date: Fri, 12 May 2006 21:37:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Erik Mouw <erik@harddisk-recovery.com>,
       Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
Message-ID: <20060512203749.GB17120@flint.arm.linux.org.uk>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Erik Mouw <erik@harddisk-recovery.com>,
	Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
	axboe@suse.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20060511151456.GD3755@harddisk-recovery.com> <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com> <20060512171632.GA29077@harddisk-recovery.com> <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org> <1147456038.3769.39.camel@mulgrave.il.steeleye.com> <1147460325.3769.46.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147460325.3769.46.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 01:58:45PM -0500, James Bottomley wrote:
> I suggest simply reversing this patch at the moment.  If Russell and
> Jens can tell me what they're trying to do I'll see if there's another
> way to do it.

When a MMC card is pulled, we remove the MMC device structure (which
is what the driverfs_dev points at.)  At this point, the MMC layer
*totally* forgets about the MMC device and deletes it.

Unfortunately, an uncounted reference is kept while the partition is
mounted by the gendisk layer, which when the partition is unmounted
via hotplug causes another hotplug event to be generated with respect
to this freed MMC device structure, and hence you get an oops.

Since the MMC layer has lost all knowledge of the device, the only
possible solution is as given in that patch.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
