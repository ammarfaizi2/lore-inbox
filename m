Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283581AbRK3Jqi>; Fri, 30 Nov 2001 04:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283583AbRK3Jq2>; Fri, 30 Nov 2001 04:46:28 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:17159 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S283581AbRK3JqT>; Fri, 30 Nov 2001 04:46:19 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] smarter atime updates
In-Reply-To: <3C072279.D346CD09@zip.com.au>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 30 Nov 2001 18:45:29 +0900
In-Reply-To: <3C072279.D346CD09@zip.com.au>
Message-ID: <87n1144mo6.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton <akpm@zip.com.au> writes:

> mark_inode_dirty() is quite expensive for journalling filesystems,
> and we're calling it a lot more than we need to.
> 
> --- linux-2.4.17-pre1/fs/inode.c	Mon Nov 26 11:52:07 2001
> +++ linux-akpm/fs/inode.c	Thu Nov 29 21:53:02 2001
> @@ -1187,6 +1187,8 @@ void __init inode_init(unsigned long mem
>   
>  void update_atime (struct inode *inode)
>  {
> +	if (inode->i_atime == CURRENT_TIME)
> +		return;
>  	if ( IS_NOATIME (inode) ) return;
>  	if ( IS_NODIRATIME (inode) && S_ISDIR (inode->i_mode) ) return;
>  	if ( IS_RDONLY (inode) ) return;

in include/linux/fs.h:

#define UPDATE_ATIME(inode)			\
do {						\
	if ((inode)->i_atime != CURRENT_TIME)	\
		update_atime (inode);		\
} while (0)

How about this macro? (add likely()?)
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
