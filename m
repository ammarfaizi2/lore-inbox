Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275836AbRJBGc7>; Tue, 2 Oct 2001 02:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275838AbRJBGcu>; Tue, 2 Oct 2001 02:32:50 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:31249 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S275836AbRJBGcn>; Tue, 2 Oct 2001 02:32:43 -0400
Message-ID: <3BB95F9F.3029ACD@zip.com.au>
Date: Mon, 01 Oct 2001 23:33:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [BUG-2.4.10] deadlock in do_truncate() and shmem_getpage()
In-Reply-To: <vghy1sci.wl@nisaaru.dvs.cs.fujitsu.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tachino Nobuhiro wrote:
> 
> Hello,
> 
> I found a a deadlock bug in v2.4.10 due to invert locking order between
> inode->i_truncate_sem and inode->i_sem.
> Sequence is following.
> 
> do_truncate()
>         down(&inode->i_sem);
>         down_write(&inode->i_truncate_sem);
> 
> do_no_page()
>         down_read(&inode->i_truncate_sem);
> 
>         shmem_nopage();
>                 shmem_getpage();
>                         down(&inode->i_sem);
> 

i_truncate_sem is introduced in the ext3 patch - it's not in
the standard 2.4.10.

> Following patch works for me.
> 
> diff -r -u -N linux.org/fs/open.c linux/fs/open.c
> --- linux.org/fs/open.c Tue Oct  2 11:35:47 2001
> +++ linux/fs/open.c     Tue Oct  2 11:45:33 2001
> @@ -81,13 +81,13 @@
>         if (length < 0)
>                 return -EINVAL;
> 
> -       down(&inode->i_sem);
>         down_write(&inode->i_truncate_sem);
> +       down(&inode->i_sem);
>         newattrs.ia_size = length;
>         newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
>         error = notify_change(dentry, &newattrs);
> -       up_write(&inode->i_truncate_sem);
>         up(&inode->i_sem);
> +       up_write(&inode->i_truncate_sem);
>         return error;
>  }

Indeed.  That's been there for months!  Thanks.

-
