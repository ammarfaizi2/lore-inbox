Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130036AbRAKMlx>; Thu, 11 Jan 2001 07:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130497AbRAKMlg>; Thu, 11 Jan 2001 07:41:36 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:28427 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S130234AbRAKMl0>; Thu, 11 Jan 2001 07:41:26 -0500
Message-ID: <3A5D9394.8693C6D4@namesys.com>
Date: Thu, 11 Jan 2001 14:05:56 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Marc Lehmann <pcg@goof.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org, vs@namesys.botik.ru
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE 
 Linux)
In-Reply-To: <85470000.979094446@tiny>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> On Wednesday, January 10, 2001 02:32:09 AM +0100 Marc Lehmann <pcg@goof.com> wrote:
> >>> EIP; c013f911 <filldir+20b/221>   <=====
> > Trace; c013f706 <filldir+0/221>
> > Trace; c0136e01 <reiserfs_getblk+2a/16d>
> >
> 
> Here is a patch against our 2.4 code (3.6.25) that does the
> same as the patch posted for 3.5.29:
> 
> -chris
> 
> --- linux/include/linux/reiserfs_fs.h.1 Tue Jan  9 21:22:27 2001
> +++ linux/include/linux/reiserfs_fs.h   Tue Jan  9 21:22:55 2001
> @@ -926,8 +926,7 @@
>  //((block_size - BLKH_SIZE - IH_SIZE - DEH_SIZE * 2) / 2)
> 
>  // two entries per block (at least)
> -#define REISERFS_MAX_NAME_LEN(block_size) \
> -((block_size - BLKH_SIZE - IH_SIZE - DEH_SIZE))
> +#define REISERFS_MAX_NAME_LEN(block_size) 255
> 
> 
> 
> --- linux/fs/reiserfs/dir.c.1   Tue Jan  9 21:22:19 2001
> +++ linux/fs/reiserfs/dir.c     Tue Jan  9 21:21:02 2001
> @@ -142,6 +142,10 @@
>                 if (!d_name[d_reclen - 1])
>                     d_reclen = strlen (d_name);
> 
> +               if (d_reclen > REISERFS_MAX_NAME_LEN(inode->i_sb->s_blocksize)){
> +                   /* too big to send back to VFS */
> +                   continue ;
> +               }
>                 d_off = deh_offset (deh);
>                 filp->f_pos = d_off ;
>                 d_ino = deh_objectid (deh);


I think that in the short term, so as to make it easier to merge us into 2.4, it is reasonable to
restrict us to small names, so go ahead and merge this code into cvs if not done already.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
