Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130245AbQLMJNl>; Wed, 13 Dec 2000 04:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130155AbQLMJNU>; Wed, 13 Dec 2000 04:13:20 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:20416 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129747AbQLMJNC>;
	Wed, 13 Dec 2000 04:13:02 -0500
Date: Wed, 13 Dec 2000 03:42:34 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Ext2 development mailing list <ext2-devel@lists.sourceforge.net>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.2.18 ext2 large file bug?
In-Reply-To: <200012130814.eBD8ELc10852@webber.adilger.net>
Message-ID: <Pine.GSO.4.21.0012130324410.3177-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Andreas Dilger wrote:

> Hello,
> while looking at the COMPAT flag patches I made, I noticed the following
> in the ext2/ext3 code.  I believe that this bug is fixed in 2.4, but it
> also needs to be fixed in 2.2.  Basically, we are checking for an ext2
> large file, which would be a file > 2GB on systems that don't support
> such.  However, we are checking for a file > 8GB which is clearly wrong.
> The ext3 version of the patch is also attached.
 
> Cheers, Andreas
> ==========================================================================
> --- linux-2.2.18pre27-TL/fs/ext2/file.c.orig	Mon Dec 11 22:43:17 2000
> +++ linux-2.2.18pre27-TL/fs/ext2/file.c	Wed Dec 13 00:13:00 2000
> @@ -208,7 +208,7 @@
>  			if (!count)
>  				return -EFBIG;
>  		}
> -		if (((pos + count) >> 31) &&
> +		if (((pos + count) >> 33) &&

	(x>>33) is the same as (x / (1LL<<33)). I.e. _with_ your change it
becomes "file >= 8Gb", instead of the current (correct) "file >= 2Gb".

							Cheers,
								Al
PS: Guys, 'fess up, who had written the following line?
                for (i = 0, ino = SYSV_ROOT_INO+1, block = sb->sv_firstinodezone, j = SYSV_ROOT_INO ; i < sb->sv_fic_size && block < sb->sv_firstdatazone ; block++, j = 0) {
And yes, that's one line. fs/sysv/ialloc.c...

-- 
Exercise 1-3. Read this code aloud:
? if ((falloc(SMRHSHSCRTCH, S_IFEXT|0644, MAXRODDHSH)) < 0)
?     ...
								K&P

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
