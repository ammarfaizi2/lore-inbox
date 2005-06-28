Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbVF1BEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbVF1BEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 21:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVF1BEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 21:04:31 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:63981 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262155AbVF1BDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 21:03:02 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: earny@net4u.de
Date: Tue, 28 Jun 2005 11:02:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17088.41384.864708.23860@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dirty md raid5 slab bio leak
In-Reply-To: message from Ernst Herzberg on Monday June 27
References: <200506272222.51993.list-lkml@net4u.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
X-CSE-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	note.orchestra.cse.unsw.EDU.AU
X-CSE-Spam-Level: 
X-CSE-Spam-Status: No, score=-4.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday June 27, list-lkml@net4u.de wrote:
> Moin.
> 
> The machine:
> 
> amd64, 2G mem, 4 SATA disks on SiI 3114 [SATALink/SATARaid] Serial ATA 
> Controller, configured as md raid5/raid1, using [cfq-scheduler], running 
> 2.6.12-rc6 (application postgresql)
> 
> The story:
> 
> This morning the machine was very slow, first check shows that the machine 
> swaps and all disk i/o are very slow.
> 
> Looking further slabtop shows
> 
>  Active / Total Objects (% used)    : 19821561 / 19828316 (100.0%)
>  Active / Total Slabs (% used)      : 369737 / 369739 (100.0%)
>  Active / Total Caches (% used)     : 80 / 120 (66.7%)
>  Active / Total Size (% used)       : 1415795.50K / 1416586.19K (99.9%)
>  Minimum / Average / Maximum Object : 0.02K / 0.07K / 128.00K
> 
>   OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> 9865575 9864690  99%    0.02K  43847      225    175388K biovec-1
> 9865254 9864654  99%    0.12K 318234       31   1272936K bio


raid5 never allocates from these slabs, so this cannot be a raid5
problem.
raid1 does, and you mention in the intro that raid1 might be involved,
but there are now more details...
Could you say a little bit more about your setup.. How are each of
raid1 and raid5 used.  Was there any error on a drive involved in raid1?

I just checked my test machine (running 2.6.12-rc3-mm3) and it had a
really large number of bio and biovec-1 in use too (and it's been
sitting fairly idle for several days).

I've quickly reviewed the raid1 code and I cannot see a bio leak
(though that doesn't mean there isn't one..)

If anyone else has a large 'bio' slab, please report the configuration
(kernel, is md in use, etc).

NeilBrown
