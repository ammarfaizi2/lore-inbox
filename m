Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSKRM32>; Mon, 18 Nov 2002 07:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSKRM32>; Mon, 18 Nov 2002 07:29:28 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:46726 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261836AbSKRM30>;
	Mon, 18 Nov 2002 07:29:26 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Paul E. Erkkila" <pee@erkkila.org>
Date: Mon, 18 Nov 2002 13:36:17 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.48 Compilation Failure
Cc: agoddard@purdue.edu, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <7DC6CEB56DB@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -Nru a/fs/devfs/base.c b/fs/devfs/base.c
> --- a/fs/devfs/base.c   Mon Nov 18 06:20:34 2002
> +++ b/fs/devfs/base.c   Mon Nov 18 06:20:34 2002
> @@ -2509,9 +2509,9 @@
>      de->mode = inode->i_mode;
>      de->inode.uid = inode->i_uid;
>      de->inode.gid = inode->i_gid;
> -    de->inode.atime = inode->i_atime.tv_sec;
> -    de->inode.mtime = inode->i_mtime.tv_sec;
> -    de->inode.ctime = inode->i_ctime.tv_sec;
> +    de->inode.atime.tv_sec = inode->i_atime.tv_sec;
> +    de->inode.mtime.tv_sec = inode->i_mtime.tv_sec;
> +    de->inode.ctime.tv_sec = inode->i_ctime.tv_sec;

No, just do
        de->inode.xtime = inode->i_xtime;
gcc will copy whole structure automatically. Otherwise
uninitialized tv_nsec can contain value > 999999999us and it
is not legal.

> -    inode->i_atime.tv_sec = de->inode.atime;
> -    inode->i_mtime.tv_sec = de->inode.mtime;
> -    inode->i_ctime.tv_sec = de->inode.ctime;
> +    inode->i_atime.tv_sec = de->inode.atime.tv_sec;
> +    inode->i_mtime.tv_sec = de->inode.mtime.tv_sec;
> +    inode->i_ctime.tv_sec = de->inode.ctime.tv_sec;
>      inode->i_atime.tv_nsec = 0;
>      inode->i_mtime.tv_nsec = 0;
>      inode->i_ctime.tv_nsec = 0;

And here other way around. Just do
       inode->i_xtime = de->inode.xtime;
and remove assigning of zero to tv_nsec.

Although there is question, why devfs cannot use inode directly.
Due to memory consumption?
                                                    Thanks,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                               
