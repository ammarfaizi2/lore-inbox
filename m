Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFKN0>; Wed, 6 Dec 2000 05:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130000AbQLFKNR>; Wed, 6 Dec 2000 05:13:17 -0500
Received: from 213-123-74-204.btconnect.com ([213.123.74.204]:56836 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129183AbQLFKNJ>;
	Wed, 6 Dec 2000 05:13:09 -0500
Date: Wed, 6 Dec 2000 09:44:39 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch-2.4.0-test12-pre6] truncate(2) permissions
In-Reply-To: <Pine.LNX.4.21.0012060904550.1044-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0012060937170.1044-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000, Tigran Aivazian wrote:
> (correction to my previous message -- the immutable thing to return
EPERM
~~~~~

I meant EACCES. And I think Linux does the right thing but FreeBSD is
broken. The rationale is in the definition of EACCES and EPERM, taken from
SuSv2 (and why would you let it "be damned" if you just relied on it
yourself in your own patch? Though you used an old/obsolete version called
POSIX).

Let's look at the definitions:

[EACCES]
        Permission denied An attempt was made to access a file in a way
        forbidden by its file access permissions. 

[EPERM]
        Operation not permitted An attempt was made to perform an
        operation limited to processes with appropriate privileges or to
        the owner of a file or other resource. 

Now, in the case of truncating immutable files we are trying to violate
file access permissions _and_ there is no special privilege that we could
possess which would allow us to succeed in this case. So EPERM is not
right but EACCES is right. So, the current state of Linux is correct but
inefficient and the patch below is an optimization (+ Al Viro's fixes).

Regards,
Tigran



> is not just a good idea, it is imperative and Linux already does that --
> so we can drop that check from if() unconditionally, which is what the
> patch below does).
> 
> Tested under 2.4.0-test12-pre6.
> 
> Regards,
> Tigran
> 
> --- linux/fs/open.c	Thu Oct 26 16:11:21 2000
> +++ work/fs/open.c	Wed Dec  6 08:05:43 2000
> @@ -102,7 +102,12 @@
>  		goto out;
>  	inode = nd.dentry->d_inode;
>  
> -	error = -EACCES;
> +	/* For directories it's -EISDIR, for other non-regulars - -EINVAL */
> +	error = -EISDIR;
> +	if (S_ISDIR(inode->i_mode))
> +		goto dput_and_out;
> +
> +	error = -EINVAL;
>  	if (!S_ISREG(inode->i_mode))
>  		goto dput_and_out;
>  
> @@ -110,12 +115,8 @@
>  	if (error)
>  		goto dput_and_out;
>  
> -	error = -EROFS;
> -	if (IS_RDONLY(inode))
> -		goto dput_and_out;
> -
>  	error = -EPERM;
> -	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
> +	if (IS_APPEND(inode))
>  		goto dput_and_out;
>  
>  	/*
> @@ -163,7 +164,7 @@
>  		goto out;
>  	dentry = file->f_dentry;
>  	inode = dentry->d_inode;
> -	error = -EACCES;
> +	error = -EINVAL;
>  	if (!S_ISREG(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
>  		goto out_putf;
>  	error = -EPERM;
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
