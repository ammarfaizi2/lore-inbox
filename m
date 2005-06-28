Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVF1NoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVF1NoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 09:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVF1NoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 09:44:16 -0400
Received: from Nazgul.esiway.net ([193.194.16.154]:33233 "EHLO
	Nazgul.esiway.net") by vger.kernel.org with ESMTP id S261460AbVF1NgG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 09:36:06 -0400
Subject: Re: Tracking down a memory leak
From: Marco Colombo <marco@esi.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050628040217.0132d9cc.akpm@osdl.org>
References: <1119263592.31049.19.camel@Frodo.esi>
	 <1119950283.26948.271.camel@Frodo.esi>
	 <20050628040217.0132d9cc.akpm@osdl.org>
Content-Type: text/plain
Organization: ESI srl
Date: Tue, 28 Jun 2005 15:38:26 +0200
Message-Id: <1119965906.26948.313.camel@Frodo.esi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 04:02 -0700, Andrew Morton wrote:
> Marco Colombo <marco@esi.it> wrote:
> >
> > Thanks to everybody who replied to me. Here's more data:
> > 
> >  sh-2.05b# sort -rn +1 /proc/slabinfo | head -5
> >  biovec-1          7502216 7502296     16  226    1 : tunables  120   60    0 : slabdata  33196  33196      0
> >  bio               7502216 7502262     96   41    1 : tunables  120   60    0 : slabdata 182982 182982      0
> 
> Are you using RAID?


Thanks Andrew,
yes I'm using RAID:

# cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [multipath]
md1 : active raid1 hdc7[1] hda7[0]
      524544 blocks [2/2] [UU]

md2 : active raid1 hdc8[1] hda8[0]
      524544 blocks [2/2] [UU]

md3 : active raid1 hdc9[1] hda9[0]
      3145856 blocks [2/2] [UU]

md4 : active raid1 hdc10[1] hda10[0]
      1048192 blocks [2/2] [UU]

md5 : active raid1 hdc11[1] hda11[0]
      2097024 blocks [2/2] [UU]

md6 : active raid1 hdc12[1] hda12[0]
      25961408 blocks [2/2] [UU]

md7 : active raid1 hdc13[1] hda13[0]
      25961408 blocks [2/2] [UU]

md0 : active raid1 hdc5[1] hda5[0]
      262400 blocks [2/2] [UU]

unused devices: <none>

This is a pretty standard configuration for me here, I use it almost
everywhere as a mean to protect data from simple disk failures (that are
way to common these days). I have at least 5-6 servers at hand, all with
disk mirroring. Some of them match the version exactly, and the hardware
is very similar, but there was only one host showing the leak. Two
things are different on the affected server:
- it uses the dc395x driver (only a DAT device is attached);
- it's a database (PostgreSQL) server (that is, with some shm usage).

The dc395x sometimes spits some error messages:
Jun 28 05:37:47 xxxx kernel: dc395x: Interrupt from DMA engine: 0x63!
Jun 28 05:37:47 xxxx kernel: dc395x: Ignoring DMA error (probably a bad
thing) ...

I have to live with those for now. They seem to be harmless. The same
messages occur with 2.6.12.1, but the bio leak is gone (or so it seems
after 1 day of uptime), I guess they may be unrelated (the dc395x driver
used to be my suspect #1).

> From: Neil Brown <neilb@cse.unsw.edu.au>
> 
> insert a missing bio_put when writing the md superblock.
> 
> Without this we have a steady growth in the "bio" slab.
> 
> Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/md/md.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff -puN drivers/md/md.c~md-bio-leak-fix drivers/md/md.c
> --- 25/drivers/md/md.c~md-bio-leak-fix	2005-06-27 22:29:13.000000000 -0700
> +++ 25-akpm/drivers/md/md.c	2005-06-27 22:29:13.000000000 -0700
> @@ -338,6 +338,7 @@ static int super_written(struct bio *bio
>  
>  	if (atomic_dec_and_test(&rdev->mddev->pending_writes))
>  		wake_up(&rdev->mddev->sb_wait);
> +	bio_put(bio);
>  	return 0;
>  }
>  

I'm sorry, but I'm missing something: I'm not able to locate that piece
of code in neither the (FC2) linux-2.6.10 tree nor the (unpatched)
linux-2.6.12.1 tree. There's no super_written() function at all, BTW.
The code looks completely different.

[...google digging...]

Is it related to this patch?

http://marc.theaimsgroup.com/?l=linux-raid&m=111155701929593&w=2

If so, I don't think I'm using it.
But the symptoms looks like the same.

Anyway, it seems solved in 2.6.12.1, so I'm not that worried. I'll wait
and see if after the upgrade to FC4 the problem is still there (with the
official FC4 kernel). I'll bring the issue to the Fedora lists, in case.
As far as I can see, the problem is already solved in mainstream. Thanks
again.

.TM.
-- 
      ____/  ____/   /
     /      /       /                   Marco Colombo
    ___/  ___  /   /                  Technical Manager
   /          /   /                      ESI s.r.l.
 _____/ _____/  _/                      Colombo@ESI.it

