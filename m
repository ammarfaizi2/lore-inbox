Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315335AbSEAIEE>; Wed, 1 May 2002 04:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315343AbSEAIED>; Wed, 1 May 2002 04:04:03 -0400
Received: from melancholia.rimspace.net ([210.23.138.19]:11793 "EHLO
	melancholia.danann.net") by vger.kernel.org with ESMTP
	id <S315335AbSEAIEC>; Wed, 1 May 2002 04:04:02 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing checks in exec_permission_light()
In-Reply-To: <Pine.GSO.4.21.0204302340340.10523-100000@weyl.math.psu.edu>
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Wed, 01 May 2002 18:03:56 +1000
Message-ID: <87elgwcn0z.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2002, Alexander Viro wrote:
> 	Missing checks added...
> 
> diff -urN C12-0/fs/namei.c C12-current/fs/namei.c
> --- C12-0/fs/namei.c	Tue Apr 30 20:23:38 2002
> +++ C12-current/fs/namei.c	Tue Apr 30 23:37:15 2002
> @@ -324,6 +324,12 @@
>  	if (mode & MAY_EXEC)
>  		return 0;
> 
> +	if ((inode->i_mode & S_IXUGO) && capable(CAP_DAC_OVERRIDE))
> +		return 0;
> +
> +	if (S_ISDIR(inode->i_mode) && capable(CAP_DAC_READ_SEARCH))
> +		return 0;
> +
>  	return -EACCES;
>  }

Looking at this it seems that it would explain the odd set of errors I
got reported during bootup under 2.5.12 -- a set of "permission denied"
errors from find(1) where, under 2.5.6, none had occurred.

These were on directories that are not owner by root, with the process
running as root.

I can look deeper into the problem, though, if you don't think that this
is the cause of it.

Regards,
        Daniel

-- 
It is easier to build strong children than to repair broken men.
        -- Frederick Douglas
