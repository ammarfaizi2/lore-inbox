Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263038AbVBCQGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbVBCQGt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 11:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbVBCQGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 11:06:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60078 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263038AbVBCQGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:06:25 -0500
Date: Thu, 3 Feb 2005 17:06:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Ian Godin <Ian.Godin@lowrydigital.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Drive performance bottleneck
Message-ID: <20050203160623.GA20696@suse.de>
References: <c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02 2005, Ian Godin wrote:
> 
>   I am trying to get very fast disk drive performance and I am seeing 
> some interesting bottlenecks.  We are trying to get 800 MB/sec or more 
> (yes, that is megabytes per second).  We are currently using 
> PCI-Express with a 16 drive raid card (SATA drives).  We have achieved 
> that speed, but only through the SG (SCSI generic) driver.  This is 
> running the stock 2.6.10 kernel.  And the device is not mounted as a 
> file system.  I also set the read ahead size on the device to 16KB 
> (which speeds things up a lot):
> 
> blockdev --setra 16834 /dev/sdb
> 
> So here are the results:
> 
> $ time dd if=/dev/sdb of=/dev/null bs=64k count=1000000
> 1000000+0 records in
> 1000000+0 records out
> 0.27user 86.19system 2:40.68elapsed 53%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (0major+177minor)pagefaults 0swaps
> 
> 64k * 1000000 / 160.68 = 398.3 MB/sec
> 
> Using sg_dd just to make sure it works the same:
> 
> $ time sg_dd if=/dev/sdb of=/dev/null bs=64k count=1000000
> 1000000+0 records in
> 1000000+0 records out
> 0.05user 144.27system 2:41.55elapsed 89%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (17major+5375minor)pagefaults 0swaps
> 
>   Pretty much the same speed.  Now using the SG device (sg1 is tied to 
> sdb):
> 
> $ time sg_dd if=/dev/sg1 of=/dev/null bs=64k count=1000000
> Reducing read to 16 blocks per loop
> 1000000+0 records in
> 1000000+0 records out
> 0.22user 66.21system 1:10.23elapsed 94%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (0major+2327minor)pagefaults 0swaps
> 
> 64k * 1000000 / 70.23 = 911.3 MB/sec
> 
>   Now that's more like the speeds we expected.  I understand that the 
> SG device uses direct I/O and/or mmap memory from the kernel.  What I 
> cannot believe is that there is that much overhead in going through the 
> page buffer/cache system in Linux.

It's not going through the page cache that is the problem, it's the
copying to user space. Have you tried using O_DIRECT? What kind of
speeds are you getting with that?

-- 
Jens Axboe

