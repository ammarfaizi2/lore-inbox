Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJEnl>; Tue, 9 Jan 2001 23:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRAJEnb>; Tue, 9 Jan 2001 23:43:31 -0500
Received: from james.kalifornia.com ([208.179.0.2]:16699 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129431AbRAJEnV>; Tue, 9 Jan 2001 23:43:21 -0500
Message-ID: <3A5BE85D.3547E0FA@linux.com>
Date: Tue, 09 Jan 2001 20:43:09 -0800
From: David Ford <david@linux.com>
Reply-To: david+validemail@kalifornia.com
Organization: Talon Technology, Intl.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Marc Lehmann <pcg@goof.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org, vs@namesys.botik.ru
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE 
 Linux)
In-Reply-To: <75150000.979093424@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why not use the limits from <linux/limits.h> instead?

-d

Chris Mason wrote:

> On Wednesday, January 10, 2001 02:32:09 AM +0100 Marc Lehmann <pcg@goof.com> wrote:
>
> >>> EIP; c013f911 <filldir+20b/221>   <=====
> > Trace; c013f706 <filldir+0/221>
> > Trace; c0136e01 <reiserfs_getblk+2a/16d>
>
> The buffer reiserfs is sending to filldir is big enough for
> the huge file name, so I think the real fix should be done in VFSland.
>
> But, in the interest of providing a quick, obviously correct fix, this
> reiserfs only patch will refuse to create file names larger
> than 255 chars, and skip over any directory entries larger than
> 255 chars.
>
> --- linux/include/linux/reiserfs_fs.h.1 Tue Jan  9 21:56:18 2001
> +++ linux/include/linux/reiserfs_fs.h   Tue Jan  9 21:56:33 2001
> @@ -467,7 +467,7 @@
>  /* name by bh, ih and entry_num */
>  #define B_I_E_NAME(entry_num,bh,ih) ((char *)(bh->b_data + ih->ih_item_location + (B_I_DEH(bh,ih)+(entry_num))->deh_location))
>
> -#define REISERFS_MAX_NAME_LEN(block_size) (block_size - BLKH_SIZE - IH_SIZE - DEH_SIZE)        /* -SD_SIZE when entry will contain stat data */
> +#define REISERFS_MAX_NAME_LEN(block_size) 255
>
>  /* this structure is used for operations on directory entries. It is not a disk structure. */
>  /* When reiserfs_find_entry or search_by_entry_key find directory entry, they return filled reiserfs_dir_entry structure */
> --- linux/fs/reiserfs/dir.c.1   Tue Jan  9 22:06:06 2001
> +++ linux/fs/reiserfs/dir.c     Tue Jan  9 22:15:17 2001
> @@ -159,6 +159,10 @@
>                 d_name = B_I_DEH_ENTRY_FILE_NAME (bh, ih, deh);
>                 d_off = deh->deh_offset;
>                 d_ino = deh->deh_objectid;
> +               if (d_reclen > REISERFS_MAX_NAME_LEN(inode->i_sb->s_blocksize)){
> +                   /* it is too big to send back to VFS */
> +                   continue ;
> +               }
>                 if (d_reclen <= 32) {
>                     local_buf = small_buf ;
>                 } else {
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- ---NOTICE

-- fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
