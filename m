Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310525AbSBRM4E>; Mon, 18 Feb 2002 07:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310526AbSBRMz4>; Mon, 18 Feb 2002 07:55:56 -0500
Received: from vaak.stack.nl ([131.155.140.140]:13583 "HELO mailhost.stack.nl")
	by vger.kernel.org with SMTP id <S310525AbSBRMzi>;
	Mon, 18 Feb 2002 07:55:38 -0500
Date: Mon, 18 Feb 2002 13:55:29 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.5-pre1: mounting NTFS partitions -t VFAT
In-Reply-To: <87aduamrbl.fsf@devron.myhome.or.jp>
Message-ID: <20020218134640.Y24227-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ogawa,

Your patch seems to fix it more or less, not the way it should be
fixed, imho.  Partitions other than FAT return bogus information, but
bogus is not always zero. Fortunately enough, one of those new if
statements returns an error, but this is a "works for me"
solution, not a decent one.

What lacks is a fingerprint detector, and iirc -long time ago- FAT has a
very easy to detect fingerprint.

I'll dig into FAT documentation tonight.

Jos

On Sat, 16 Feb 2002, OGAWA Hirofumi wrote:

> Sorry, my fault.
>
> The following patch should fix this bug. I'll submit it after test.
>
> --- fat_bug-2.5.5-pre1/fs/fat/inode.c.orig	Thu Feb 14 13:47:54 2002
> +++ fat_bug-2.5.5-pre1/fs/fat/inode.c	Sat Feb 16 05:06:58 2002
> @@ -624,6 +624,18 @@
>  	}
>
>  	b = (struct fat_boot_sector *) bh->b_data;
> +	if (!b->fats) {
> +		if (!silent)
> +			printk("FAT: bogus number of FAT structure\n");
> +		brelse(bh);
> +		goto out_invalid;
> +	}
> +	if (!b->reserved) {
> +		if (!silent)
> +			printk("FAT: bogus number of reserved sectors\n");
> +		brelse(bh);
> +		goto out_invalid;
> +	}
>  	if (!b->secs_track) {
>  		if (!silent)
>  			printk("FAT: bogus sectors-per-track value\n");
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

