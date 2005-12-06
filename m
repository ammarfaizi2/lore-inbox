Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbVLFOai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbVLFOai (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 09:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVLFOai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 09:30:38 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:57813 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932589AbVLFOah
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 09:30:37 -0500
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Takashi Sato <sho@tnes.nec.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <000301c5fa62$8d1bb730$4168010a@bsd.tnes.nec.co.jp>
References: <000301c5fa62$8d1bb730$4168010a@bsd.tnes.nec.co.jp>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 08:30:34 -0600
Message-Id: <1133879435.8895.14.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 21:42 +0900, Takashi Sato wrote:
> I realized some 32-bit big-endian architectures such as sh and m68k
> have a padding before 32-bit st_blocks, though mips and ppc have
> 64-bit st_blocks.
> 
> - asm-sh
> #if defined(__BIG_ENDIAN__)
>         unsigned long   __pad4;         /* Future possible st_blocks hi bits */
>         unsigned long   st_blocks;      /* Number 512-byte blocks allocated. */
> #else /* Must be little */
>         unsigned long   st_blocks;      /* Number 512-byte blocks allocated. */
>         unsigned long   __pad4;         /* Future possible st_blocks hi bits */
> #endif
> 
> - asm-m68k
>         unsigned long   __pad4;         /* future possible st_blocks high bits */
>         unsigned long   st_blocks;      /* Number 512-byte blocks allocated. */
> 
> So I updated the patch.  Any feedback and comments are welcome.

I think it looks good.  The only issue I have is that I agree with
Andreas that i_blocks should be of type sector_t.  I find the case of
accessing very large files over nfs with CONFIG_LBD disabled to be very
unlikely.

> Signed-off-by: Takashi Sato <sho@tnes.nec.co.jp>
> Signed-off-by: ASANO Masahiro <masano@tnes.nec.co.jp>
> 
> diff -uprN -X linux-2.6.15-rc5.org/Documentation/dontdiff linux-2.6.15-rc5.org/include/asm-i386/stat.h
> linux-2.6.15-rc5-blocks/include/asm-i386/stat.h
> --- linux-2.6.15-rc5.org/include/asm-i386/stat.h	2005-10-28 09:02:08.000000000 +0900
> +++ linux-2.6.15-rc5-blocks/include/asm-i386/stat.h	2005-12-06 16:24:31.000000000 +0900
> @@ -58,8 +58,7 @@ struct stat64 {
>  	long long	st_size;
>  	unsigned long	st_blksize;
> 
> -	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
> -	unsigned long	__pad4;		/* future possible st_blocks high bits */
> +	unsigned long long	st_blocks;	/* Number 512-byte blocks allocated. */
> 
>  	unsigned long	st_atime;
>  	unsigned long	st_atime_nsec;
> diff -uprN -X linux-2.6.15-rc5.org/Documentation/dontdiff linux-2.6.15-rc5.org/include/asm-m68k/stat.h
> linux-2.6.15-rc5-blocks/include/asm-m68k/stat.h
> --- linux-2.6.15-rc5.org/include/asm-m68k/stat.h	2005-10-28 09:02:08.000000000 +0900
> +++ linux-2.6.15-rc5-blocks/include/asm-m68k/stat.h	2005-12-06 16:29:50.000000000 +0900
> @@ -60,8 +60,7 @@ struct stat64 {
>  	long long	st_size;
>  	unsigned long	st_blksize;
> 
> -	unsigned long	__pad4;		/* future possible st_blocks high bits */
> -	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
> +	unsigned long long	st_blocks;	/* Number 512-byte blocks allocated. */
> 
>  	unsigned long	st_atime;
>  	unsigned long	st_atime_nsec;
> diff -uprN -X linux-2.6.15-rc5.org/Documentation/dontdiff linux-2.6.15-rc5.org/include/asm-sh/stat.h
> linux-2.6.15-rc5-blocks/include/asm-sh/stat.h
> --- linux-2.6.15-rc5.org/include/asm-sh/stat.h	2005-10-28 09:02:08.000000000 +0900
> +++ linux-2.6.15-rc5-blocks/include/asm-sh/stat.h	2005-12-06 16:28:37.000000000 +0900
> @@ -60,13 +60,7 @@ struct stat64 {
>  	long long	st_size;
>  	unsigned long	st_blksize;
> 
> -#if defined(__BIG_ENDIAN__)
> -	unsigned long	__pad4;		/* Future possible st_blocks hi bits */
> -	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
> -#else /* Must be little */
> -	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
> -	unsigned long	__pad4;		/* Future possible st_blocks hi bits */
> -#endif
> +	unsigned long long	st_blocks;	/* Number 512-byte blocks allocated. */
> 
>  	unsigned long	st_atime;
>  	unsigned long	st_atime_nsec;
> diff -uprN -X linux-2.6.15-rc5.org/Documentation/dontdiff linux-2.6.15-rc5.org/include/linux/fs.h
> linux-2.6.15-rc5-blocks/include/linux/fs.h
> --- linux-2.6.15-rc5.org/include/linux/fs.h	2005-12-06 16:20:21.000000000 +0900
> +++ linux-2.6.15-rc5-blocks/include/linux/fs.h	2005-12-06 16:26:01.000000000 +0900
> @@ -450,7 +450,7 @@ struct inode {
>  	unsigned int		i_blkbits;
>  	unsigned long		i_blksize;
>  	unsigned long		i_version;
> -	unsigned long		i_blocks;
> +	unsigned long long	i_blocks;
>  	unsigned short          i_bytes;
>  	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
>  	struct semaphore	i_sem;
> diff -uprN -X linux-2.6.15-rc5.org/Documentation/dontdiff linux-2.6.15-rc5.org/include/linux/stat.h
> linux-2.6.15-rc5-blocks/include/linux/stat.h
> --- linux-2.6.15-rc5.org/include/linux/stat.h	2005-10-28 09:02:08.000000000 +0900
> +++ linux-2.6.15-rc5-blocks/include/linux/stat.h	2005-12-06 16:26:26.000000000 +0900
> @@ -69,7 +69,7 @@ struct kstat {
>  	struct timespec	mtime;
>  	struct timespec	ctime;
>  	unsigned long	blksize;
> -	unsigned long	blocks;
> +	unsigned long long	blocks;
>  };
> 
>  #endif
> 
> -- Takashi Sato
-- 
David Kleikamp
IBM Linux Technology Center

