Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbRAHTIn>; Mon, 8 Jan 2001 14:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130836AbRAHTI1>; Mon, 8 Jan 2001 14:08:27 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:11262 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129818AbRAHTIE>; Mon, 8 Jan 2001 14:08:04 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101081907.f08J7ev15806@webber.adilger.net>
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <Pine.GSO.4.21.0101081042490.4061-100000@weyl.math.psu.edu>
 "from Alexander Viro at Jan 8, 2001 10:47:41 am"
To: Alexander Viro <viro@math.psu.edu>
Date: Mon, 8 Jan 2001 12:07:40 -0700 (MST)
CC: Chris Mason <mason@suse.com>, Alan Cox <alan@redhat.com>,
        Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro writes:
> No, it doesn't. s/$/while(bh != head);/, indeed. Sorry about that -
> cut-and-waste when I did rediff to 2.4.0. Corrected patch follows:
> 
> diff -urN S0-AC4/fs/ext2/super.c S0-AC4-fixes/fs/ext2/super.c
> --- S0-AC4/fs/ext2/super.c	Mon Jan  8 08:46:18 2001
> +++ S0-AC4-fixes/fs/ext2/super.c	Mon Jan  8 08:35:16 2001
> @@ -380,6 +380,20 @@
>  }
>  
>  #define log2(n) ffz(~(n))
> + 
> +/*
> + * maximal file size.
> + */
> +static loff_t ext2_max_size(int bits)
> +{
> +	loff_t res = EXT2_NDIR_BLOCKS;
> +	res += 1LL << (bits-2);
> +	res += 1LL << (2*(bits-2));
> +	res += 1LL << (3*(bits-2));
> +	if (res > 1LL << 32)
> +		res = 1LL << 32;
> +	return res << bits;
> +}

Actually, this is wrong.  The ext2 inode limit is 2^32 512-byte sectors,
not 2^32 blocksize blocks.  Yes this is a wart and Ted wants to fix it, as
soon as we have something else important enough to require an incompatible
change to ext2.  As it is, we are limited to 2TB files for now, which is no
loss because we only support 2TB devices in 2.4 anyways.  When we change to
2^32 filesystem blocks, we will again be limited by indirect blocks, except
for 8kB block filesystems on Alpha/ia64 at 32TB.

+/*
+ * Maximal file size.  There is a direct, and {,double-,triple-}indirect
+ * block limit, and also a limit of (2^32 - 1) 512-byte sectors in i_blocks.
+ * We need to be 1 filesystem block less than the 2^32 sector limit.
+ */
+static loff_t ext2_max_size(int bits)
+{
+	loff_t res = EXT2_NDIR_BLOCKS;
+	res += 1LL << (bits-2);
+	res += 1LL << (2*(bits-2));
+	res += 1LL << (3*(bits-2));
+	res << bits;
+	if (res > (512LL << 32) - (1 << bits))
+		res = (512LL << 32) - (1 << bits);
+	return res;
+}

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
