Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314834AbSDVWIv>; Mon, 22 Apr 2002 18:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSDVWIu>; Mon, 22 Apr 2002 18:08:50 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:2567 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S314834AbSDVWIt>; Mon, 22 Apr 2002 18:08:49 -0400
Message-ID: <3CC489CE.19A91699@zip.com.au>
Date: Mon, 22 Apr 2002 15:08:14 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: locking in sync_old_buffers
In-Reply-To: <3CC47A27.4000803@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> ...
> --- linux-2.5.8-clean/fs/buffer.c       Mon Apr 22 13:45:34 2002
> +++ linux/fs/buffer.c   Mon Apr 22 13:45:49 2002
> @@ -2612,10 +2612,8 @@
> 
>  static void sync_old_buffers(unsigned long dummy)
>  {
> -       lock_kernel();
>         sync_unlocked_inodes();
>         sync_supers();
> -       unlock_kernel();
> 
>         for (;;) {
>                 struct buffer_head *bh;

Al would know better than I, but...

If you're going to do this, then the BKL should be acquired
in fs/super.c:write_super(), so the per-fs ->write_super
functions do not see changed external locking rules.

Possibly, fs/inode.c:write_inode() needs the same treatment.
But Doc/filesystems/Locking says that lock_kernel() is not
held across ->write_inode so there should be no need to take
it on the kupdate path.

That's for 2.4.  For 2.5, we'd like sync_old_buffers to just
go away.   Do you have time to test
 http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.8/everything.patch.gz

-
