Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSJ2Rdd>; Tue, 29 Oct 2002 12:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262304AbSJ2Rdc>; Tue, 29 Oct 2002 12:33:32 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:10990 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262303AbSJ2Rdb>;
	Tue, 29 Oct 2002 12:33:31 -0500
Date: Tue, 29 Oct 2002 12:39:51 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dm update 2/3
In-Reply-To: <20021029171920.GB1779@fib011235813.fsnet.co.uk>
Message-ID: <Pine.GSO.4.21.0210291234160.9171-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Oct 2002, Joe Thornber wrote:

> -			   major(dev), minor(dev),
> +			   dm_major(hc->md), dm_minor(hc->md),
  
> -	param->dev = kdev_t_to_nr(dm_kdev(md));
> +	param->dev = MKDEV(dm_major(md), dm_minor(md));

> +int dm_major(struct mapped_device *md);
> +int dm_minor(struct mapped_device *md);

*blam*

Please, don't expose major/minor split.  devfs inisisting on separately
passed major/minor is bad enough, no need to compound that crap.

->major and ->first_minor are about to be glued into a single field
anyway and devfs_register() will either switch to dev_t or get wrapper
taking dev_t.

Please, just do dm_disk(dm) and for now use its ->major/->first_minor.

Another thing on cards is the list of block_device over given gendisk -
that kills a bunch of bogus bdget() uses, so the second instance will
disappear completely.

