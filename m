Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbUC3NHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 08:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbUC3NHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 08:07:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36843 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263610AbUC3NHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 08:07:07 -0500
Date: Tue, 30 Mar 2004 15:07:01 +0200
From: Jens Axboe <axboe@suse.de>
To: Marc Bevand <bevand_m@epita.fr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040330130701.GV24370@suse.de>
References: <4066021A.20308@pobox.com> <40695FF6.3020401@epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40695FF6.3020401@epita.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30 2004, Marc Bevand wrote:
> Jeff Garzik wrote:
> >
> >[...]
> >With this simple patch, the max request size goes from 128K to 32MB... 
> >so you can imagine this will definitely help performance.  Throughput 
> >goes up.  Interrupts go down.  Fun for the whole family.
> >[...]
> 
> I have experienced a noticeable improvement concerning the CPU usage
> and disk throughput with this patch.
> 
> Benchmark specs:
> 
>  o read from only 1 disk (sda), or from 2 disks (sda+sdb), with
>    1 or 2 instances of "dd if=/dev/sd? of=/dev/null bs=100M".
>  o hardware: two Seagate 160GB SATA, on a Silicon Image 3114, on a
>    32-bit/33MHz PCI bus, 1GB RAM.
>  o software: kernel 2.6.5-rc2-bk6-libata2.
> 
> Benchmark datas:
> 
>     without the speed-up-sata patch       with the speed-up-sata patch
>     reading sda     reading sda+sdb     reading sda     reading sda+sdb
> bi      57000             92000             57000             97000
> in       1900              2400              1600              1800
> cs       1800              3300              1400              1700
> sy        11%               20%                9%               16%
> us         0%                0%                0%                0%
> 
> ("bi, in, cs, sy, us" have been reported by vmstat(8))
> 
> When reading only from sda, the speed-up-sata patch makes the number of
> interrupts/s drop from 1900 to 1600 (CPU usage: 11% to 9%). The throughput
> does not improve because 57000 blocks/s is the physical limit of the 
> hardisk.
> 
> When reading from both sda and sdb, the improvement is more visible: the
> number of interrupts/s goes from 2400 to 1800 (CPU usage: 20% to 16%). But
> in this case, the throughput improves from 92000 blocks/s to 97000 blocks/s.
> I think I am reaching the physical limit of the PCI bus (theoretically it
> would be 133 MB/s or 133000 blocks/s). When setting the PCI latency timer of
> the SiI3114 controller to 240 (was 64), I am able to reach 100000 blocks/s.

Good that somebody did some testing on this, thanks :-)

> As other people were complaining that the 32MB max request size might be too
> high, I did give a try to 1MB (by replacing "65534" by "2046" in the patch).
> There is no visible differences between 32MB and 1MB.

As suspected. BTW, you want to use 2048 there, not 2046. The 64K-2
(which could be 64K-1) is just due to ->max_sectors being an unsigned
short currently.

-- 
Jens Axboe

