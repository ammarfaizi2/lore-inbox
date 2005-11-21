Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVKUV4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVKUV4y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVKUV4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:56:53 -0500
Received: from ns1.suse.de ([195.135.220.2]:8341 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751102AbVKUV4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:56:51 -0500
From: Neil Brown <neilb@suse.de>
To: Lars Roland <lroland@gmail.com>
Date: Tue, 22 Nov 2005 08:56:45 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17282.17053.19267.253430@cse.unsw.edu.au>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Poor Software RAID-0 performance with 2.6.14.2
In-Reply-To: message from Lars Roland on Monday November 21
References: <4ad99e050511211231o97d5d7fw59b44527dc25dcea@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 21, lroland@gmail.com wrote:
> I have created a stripe across two 500Gb disks located on separate IDE
> channels using:
> 
> mdadm -Cv /dev/md0 -c32 -n2 -l0 /dev/hdb /dev/hdd
> 
> the performance is awful on both kernel 2.6.12.5 and 2.6.14.2 (even
> with hdparm and blockdev tuning), both bonnie++ and hdparm (included
> below) shows a single disk operating faster than the stripe:
> 
> ----
> dkstorage01:~# hdparm -t /dev/md0
> /dev/md0:
>  Timing buffered disk reads:  182 MB in  3.01 seconds =  60.47 MB/sec
> 
> dkstorage02:~# hdparm -t /dev/hdc1
> /dev/hdc1:
> Timing buffered disk reads:  184 MB in  3.02 seconds =  60.93 MB/sec
> ----

Could you try hdparm tests on the two drives in parallel?
   hdparm -t /dev/hdb & hdparm -t /dev/hdd

It could be that the controller doesn't handle parallel traffic very
well.


> 
> I am aware of cpu overhead with software raid but such a degradation
> should not be the case with raid 0, especially not when the OS is
> located on a separate SCSI disk - the IDE disks should just be ready
> to work.

raid0 has essentially 0 cpu overhead.  It would be maybe a couple of
hundred instructions which would be lost in the noise.  It just
figures out which drive each request should go to, and directs it
there.


> 
> There have been some earlier reporting on this problem but they all
> seam to end more and less inconclusive (here is one
> http://kerneltrap.org/node/4745). Some people favors switching to
> dmraid with device mapper, is this the de facto standard today ?
> 

The kerneltrap reference is about raid5.
raid5 is implemented very differently to raid0.

It might be worth experimenting with different read-ahead values using
the 'blockdev' command.  Alternately use a larger chunk size.

I don't think there is a de facto standard.  Many people use md.  Many
use dm.  

NeilBrown
