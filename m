Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130889AbRBPSlK>; Fri, 16 Feb 2001 13:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130886AbRBPSlB>; Fri, 16 Feb 2001 13:41:01 -0500
Received: from saraksh.alkar.net ([195.248.191.65]:55818 "EHLO smtp3.alkar.net")
	by vger.kernel.org with ESMTP id <S130889AbRBPSku>;
	Fri, 16 Feb 2001 13:40:50 -0500
Message-ID: <3A8D738B.C0999C72@namesys.botik.ru>
Date: Fri, 16 Feb 2001 21:38:03 +0300
From: "Vladimir V. Saveliev" <vs@namesys.botik.ru>
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] [PATCH] reiserfs fix for null bytes in small files
In-Reply-To: <823240000.982335757@tiny>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Chris Mason wrote:

> Hello everyone,
>
> I think Alexander Zarochentcev and I have finally figured out
> cause for null bytes in small reiserfs files.  reiserfs stores
> parts of these files packed together in the tree, and the
> packed bytes can shift around as the tree is balanced.
>
> When converting from the packed bytes to a full block, the
> full block is inserted, and the packed bytes are removed.  If
> the packed bytes are split between two tree blocks, and then
> merged by a different process balancing the tree, the conversion
> code might remove too many bytes from the file.  This creates
> a hole in the file, which is why people see null bytes.
>
> If anyone wants more details, drop a line to me or the reiserfs
> list ;-)  This patch against 2.4.1 (will work on any 2.4.1ac or
> 2.4.2pre as well) should fix it, please try it on your
> non-production machines, we are still running it through tests
> here.
>

Just to make things clear:
reiserfs for 2.2 does not have this bug, so there is nothing to fix.

Thanks,
vs


>
> -chris
>
> --- linux/fs/reiserfs/tail_conversion.c.old     Thu Feb 15 13:16:47 2001
> +++ linux/fs/reiserfs/tail_conversion.c Thu Feb 15 13:10:23 2001
> @@ -92,7 +92,7 @@
>      /* Move bytes from the direct items to the new unformatted node
>         and delete them. */
>      while (1)  {
> -       int item_len, first_direct;
> +       int tail_size;
>
>         /* end_key.k_offset is set so, that we will always have found
>             last item of the file */
> @@ -103,13 +103,11 @@
>  #ifdef CONFIG_REISERFS_CHECK
>         if (!is_direct_le_ih (p_le_ih))
>             reiserfs_panic (sb, "vs-14055: direct2indirect: "
> -                           "direct item expected, found %h", p_le_ih);
> +                           "direct item expected(%k), found %h",
> +                               &end_key, p_le_ih);
>  #endif
> -       if ((le_ih_k_offset (p_le_ih) & (n_blk_size - 1)) == 1)
> -           first_direct = 1;
> -       else
> -           first_direct = 0;
> -       item_len = le16_to_cpu (p_le_ih->ih_item_len);
> +       tail_size = (le_ih_k_offset (p_le_ih) & (n_blk_size - 1))
> +           + ih_item_len(p_le_ih) - 1;
>
>         /* we only send the unbh pointer if the buffer is not up to date.
>         ** this avoids overwriting good data from writepage() with old data
> @@ -123,7 +121,7 @@
>         n_retval = reiserfs_delete_item (th, path, &end_key, inode,
>                                          up_to_date_bh) ;
>
> -       if (first_direct && item_len == n_retval)
> +       if (tail_size == n_retval)
>             // done: file does not have direct items anymore
>             break;
>

