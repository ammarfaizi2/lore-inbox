Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269870AbRHDW7X>; Sat, 4 Aug 2001 18:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269871AbRHDW7N>; Sat, 4 Aug 2001 18:59:13 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:44287 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269870AbRHDW6y>;
	Sat, 4 Aug 2001 18:58:54 -0400
Date: Sat, 4 Aug 2001 18:59:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.7-ac4/ac5 dies due to double unlock
In-Reply-To: <20010804235627.C11632@ppc.vc.cvut.cz>
Message-ID: <Pine.GSO.4.21.0108041850360.10111-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Aug 2001, Petr Vandrovec wrote:

> Hi Alan,
>   double-unlock on sb_lock in try_to_sync_unused inodes when 
> try_to_sync_unused_list() returns 0... It is reliably
> triggered by xmms loading mp3 tags from vfat...
> 
>   Originally from 2.4.7-ac4, but still unfixed in -ac5.

Thanks for spotting. Hell knows where that break; had come from - in
namespaces-patch we do return; in that place and that what should've
been in the splitup that went into -ac. My apologies...

> diff -urdN linux/fs/inode.c linux/fs/inode.c
> --- linux/fs/inode.c	Sat Aug  4 00:02:18 2001
> +++ linux/fs/inode.c	Sat Aug  4 17:37:50 2001
> @@ -412,7 +412,7 @@
>  			continue;
>  		spin_unlock(&sb_lock);
>  		if (!try_to_sync_unused_list(&sb->s_dirty))
> -			break;
> +			return;
>  		spin_lock(&sb_lock);
>  	}
>  	spin_unlock(&sb_lock);

Yup. Alan, apply it, please.

