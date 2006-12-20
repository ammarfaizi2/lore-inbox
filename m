Return-Path: <linux-kernel-owner+w=401wt.eu-S965052AbWLTQwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWLTQwG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 11:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbWLTQwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 11:52:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:51814 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965052AbWLTQwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 11:52:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RGYkLCNp0J1zpMa6UqC6nNOd5QCmF1H8dcVebXGeqFU604+n0+LsI/n/yS/uw/eMcI1ktFddLV4t7jXHF71n3ewhtWwb0DHAv6qpHGxCqpjieI9mMmV1F/2+T/Q8tmUr0yA1dXoHaU7VVGGhuWAOdU4mBSfuR1Nm6YDYkaHxCsM=
Message-ID: <5157576d0612200852i68a3d455o494eccb9a5206dab@mail.gmail.com>
Date: Wed, 20 Dec 2006 19:52:00 +0300
From: "Tomasz Kvarsin" <kvarsin@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, "Tomasz Kvarsin" <kvarsin@gmail.com>,
       "Alexander Viro" <viro@zeniv.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] [PATCH] [RFC] garbage instead of zeroes in UFS
In-Reply-To: <20061220145412.GA11922@rain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5157576d0612200302j556694bfsfdc6cb0c37b054c@mail.gmail.com>
	 <5157576d0612200304n7123157vc47c3c7c1a645527@mail.gmail.com>
	 <20061220030955.bd3acdbc.akpm@osdl.org> <20061220145412.GA11922@rain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works for me. At least now I can not reproduce this bug.

On 12/20/06, Evgeniy Dushistov <dushistov@mail.ru> wrote:
> On Wed, Dec 20, 2006 at 03:09:55AM -0800, Andrew Morton wrote:
> > On Wed, 20 Dec 2006 14:04:06 +0300
> > "Tomasz Kvarsin" <kvarsin@gmail.com> wrote:
> >
> > > Forgot to say I use linux-2.6.20-rc1-mm1
> > >
> > > On 12/20/06, Tomasz Kvarsin <kvarsin@gmail.com> wrote:
> > > > I have some problems with write support of UFS.
> > > > Here is script which demonstrate problem:
> > > >
> > > > #create image
> > > > mkdir /tmp/ufs-expirements && cd /tmp/ufs-expirements/
> > > > for ((i=0; i<1024*1024*2; ++i)); do printf "z"; done > image
> > > >
> > > > #build ufs tools
> > > > wget 'http://heanet.dl.sourceforge.net/sourceforge/ufs-linux/ufs-tools-0.1.tar.bz2'
> > > > && tar xjf ufs-tools-0.1.tar.bz2 && cd ufs-tools-0.1
> > > > wget http://lkml.org/lkml/diff/2006/5/20/48/1 -O build.patch
> > > > patch -p1 < build.patch && make
> > > >
> > > > #create UFS file system on image
> > > > ./mkufs -O 1 -b 16384 -f 2048 ../image
> > > > cd .. && mkdir root
> > > > mount -t ufs image root -o loop,ufstype=44bsd
> > > > cd root/
> > > > touch a.txt
> > > > echo "END" > end.txt
> > > > dd if=./end.txt of=./a.txt bs=16384 seek=1
> > > >
> > > > and at the end content of "a.txt" not only  "END" and zeroes,
> > > > "a.txt" also contains "z".
> > > >
> > > > The real situation happened when I deleted big file,
> > > > and create new one with holes. This script just easy way to reproduce bug.
> > > >
> >
> > Does 2.6.20-rc1 have the same problem?
>
> Looks like this is the problem, which point Al Viro some time ago:
> when we allocate block(in this situation 16K) we mark as new
> only one fragment(in this situation 2K),
> I don't see _right_ way to do nullification of whole block,
> if use inode page cache, some pages may be outside of inode limits
> (inode size),
> and will be lost;
> if use blockdev page cache it is possible to zeroize real data,
> if later inode page cache will be used.
>
> The simpliest way, as can I see usage of block device page cache,
> but not only mark dirty, but also sync it during "nullification".
>
> Patch bellow properly handle Tomasz's test case for me(Tomasz can you try it?),
> but I am not sure is this _right_ solution.
> Any ideas?
>
> ---
>
> Index: linux-2.6.20-rc1-mm1/fs/ufs/inode.c
> ===================================================================
> --- linux-2.6.20-rc1-mm1.orig/fs/ufs/inode.c
> +++ linux-2.6.20-rc1-mm1/fs/ufs/inode.c
> @@ -156,36 +156,6 @@ out:
>         return ret;
>  }
>
> -static void ufs_clear_frag(struct inode *inode, struct buffer_head *bh)
> -{
> -       lock_buffer(bh);
> -       memset(bh->b_data, 0, inode->i_sb->s_blocksize);
> -       set_buffer_uptodate(bh);
> -       mark_buffer_dirty(bh);
> -       unlock_buffer(bh);
> -       if (IS_SYNC(inode))
> -               sync_dirty_buffer(bh);
> -}
> -
> -static struct buffer_head *
> -ufs_clear_frags(struct inode *inode, sector_t beg,
> -               unsigned int n, sector_t want)
> -{
> -       struct buffer_head *res = NULL, *bh;
> -       sector_t end = beg + n;
> -
> -       for (; beg < end; ++beg) {
> -               bh = sb_getblk(inode->i_sb, beg);
> -               ufs_clear_frag(inode, bh);
> -               if (want != beg)
> -                       brelse(bh);
> -               else
> -                       res = bh;
> -       }
> -       BUG_ON(!res);
> -       return res;
> -}
> -
>  /**
>   * ufs_inode_getfrag() - allocate new fragment(s)
>   * @inode - pointer to inode
> @@ -302,7 +272,7 @@ repeat:
>         }
>
>         if (!phys) {
> -               result = ufs_clear_frags(inode, tmp, required, tmp + blockoff);
> +               result = sb_getblk(sb, tmp + blockoff);
>         } else {
>                 *phys = tmp + blockoff;
>                 result = NULL;
> @@ -403,8 +373,7 @@ repeat:
>
>
>         if (!phys) {
> -               result = ufs_clear_frags(inode, tmp, uspi->s_fpb,
> -                                        tmp + blockoff);
> +               result = sb_getblk(sb, tmp + blockoff);
>         } else {
>                 *phys = tmp + blockoff;
>                 *new = 1;
> @@ -471,13 +440,13 @@ int ufs_getfrag_block(struct inode *inod
>  #define GET_INODE_DATABLOCK(x) \
>         ufs_inode_getfrag(inode, x, fragment, 1, &err, &phys, &new, bh_result->b_page)
>  #define GET_INODE_PTR(x) \
> -       ufs_inode_getfrag(inode, x, fragment, uspi->s_fpb, &err, NULL, NULL, bh_result->b_page)
> +       ufs_inode_getfrag(inode, x, fragment, uspi->s_fpb, &err, NULL, NULL, NULL)
>  #define GET_INDIRECT_DATABLOCK(x) \
>         ufs_inode_getblock(inode, bh, x, fragment,      \
> -                         &err, &phys, &new, bh_result->b_page);
> +                         &err, &phys, &new, bh_result->b_page)
>  #define GET_INDIRECT_PTR(x) \
>         ufs_inode_getblock(inode, bh, x, fragment,      \
> -                         &err, NULL, NULL, bh_result->b_page);
> +                         &err, NULL, NULL, NULL)
>
>         if (ptr < UFS_NDIR_FRAGMENT) {
>                 bh = GET_INODE_DATABLOCK(ptr);
> Index: linux-2.6.20-rc1-mm1/fs/ufs/balloc.c
> ===================================================================
> --- linux-2.6.20-rc1-mm1.orig/fs/ufs/balloc.c
> +++ linux-2.6.20-rc1-mm1/fs/ufs/balloc.c
> @@ -275,6 +275,25 @@ static void ufs_change_blocknr(struct in
>         UFSD("EXIT\n");
>  }
>
> +static void ufs_clear_frags(struct inode *inode, sector_t beg, unsigned int n,
> +                           int sync)
> +{
> +       struct buffer_head *bh;
> +       sector_t end = beg + n;
> +
> +       for (; beg < end; ++beg) {
> +               bh = sb_getblk(inode->i_sb, beg);
> +               lock_buffer(bh);
> +               memset(bh->b_data, 0, inode->i_sb->s_blocksize);
> +               set_buffer_uptodate(bh);
> +               mark_buffer_dirty(bh);
> +               unlock_buffer(bh);
> +               if (IS_SYNC(inode) || sync)
> +                       sync_dirty_buffer(bh);
> +               brelse(bh);
> +       }
> +}
> +
>  unsigned ufs_new_fragments(struct inode * inode, __fs32 * p, unsigned fragment,
>                            unsigned goal, unsigned count, int * err, struct page *locked_page)
>  {
> @@ -350,6 +369,8 @@ unsigned ufs_new_fragments(struct inode
>                         *p = cpu_to_fs32(sb, result);
>                         *err = 0;
>                         UFS_I(inode)->i_lastfrag = max_t(u32, UFS_I(inode)->i_lastfrag, fragment + count);
> +                       ufs_clear_frags(inode, result + oldcount, newcount - oldcount,
> +                                       locked_page != NULL);
>                 }
>                 unlock_super(sb);
>                 UFSD("EXIT, result %u\n", result);
> @@ -363,6 +384,8 @@ unsigned ufs_new_fragments(struct inode
>         if (result) {
>                 *err = 0;
>                 UFS_I(inode)->i_lastfrag = max_t(u32, UFS_I(inode)->i_lastfrag, fragment + count);
> +               ufs_clear_frags(inode, result + oldcount, newcount - oldcount,
> +                               locked_page != NULL);
>                 unlock_super(sb);
>                 UFSD("EXIT, result %u\n", result);
>                 return result;
> @@ -398,6 +421,8 @@ unsigned ufs_new_fragments(struct inode
>                 *p = cpu_to_fs32(sb, result);
>                 *err = 0;
>                 UFS_I(inode)->i_lastfrag = max_t(u32, UFS_I(inode)->i_lastfrag, fragment + count);
> +               ufs_clear_frags(inode, result + oldcount, newcount - oldcount,
> +                               locked_page != NULL);
>                 unlock_super(sb);
>                 if (newcount < request)
>                         ufs_free_fragments (inode, result + newcount, request - newcount);
>
>
> --
> /Evgeniy
>
>
