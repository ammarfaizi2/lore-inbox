Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265752AbSLJKEw>; Tue, 10 Dec 2002 05:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266736AbSLJKEw>; Tue, 10 Dec 2002 05:04:52 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:14471 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S265752AbSLJKEv>; Tue, 10 Dec 2002 05:04:51 -0500
Date: Tue, 10 Dec 2002 10:12:34 +0000 (GMT)
From: Anton Altaparmakov <aia21@cantab.net>
To: Justin Pryzby <justinpryzby@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       pryzju01@gettysburg.edu
Subject: Re: [Linux-NTFS-Dev] [PATCH] 2.5.51 ntfs - GCC3
In-Reply-To: <20021210075152.GA12219@perseus.homeunix.net>
Message-ID: <Pine.SOL.3.96.1021210095357.6524A-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is completely wrong. Please do not apply.

On Tue, 10 Dec 2002, Justin Pryzby wrote:
> What was going on with 2.96<=__GNUC__<3 ?!

gcc-2.96 introduces unnamed unions and structures which we make heavy use
of in the NTFS driver. To be able to compile with earlier gcc versions, we
had to do some macro magic which is what the below code snippet in your
patch shows. The idea is that as soon as the official kernel requirements
for the minimum compiler are raised to gcc-2.96 or above, we will remove
all the macro magic and just leave everything unnamed.

Unfortunately the gcc crew fscked up and broke typedefs to unnamed unions
and structures in gcc-3.1 I think it was. This has since been fixed again
in the more recent gcc versions (gcc-3.2 is ok).

So if any special casing needs to be made below it would be to extend the
existing test with an || (__GNUC__ == 3 && __GNUC_MINOR__ == 1) but I
prefer not to do that. People should just upgrade their compiler. After
all it is the compiler that is broken not the code.

Best regards,

	Anton

> 
> Justin
> 
> diff -Naur linux-2.5.51.org/fs/ntfs/types.h linux-2.5.51.ntfs/fs/ntfs/types.h
> --- linux-2.5.51.org/fs/ntfs/types.h	2002-12-10 02:17:52.000000000 -0500
> +++ linux-2.5.51.ntfs/fs/ntfs/types.h	2002-12-10 02:41:31.000000000 -0500
> @@ -23,12 +23,12 @@
>  #ifndef _LINUX_NTFS_TYPES_H
>  #define _LINUX_NTFS_TYPES_H
>  
> -#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 96)
> -#define SN(X)   X	/* Struct Name */
> -#define SC(P,N) P.N	/* ShortCut: Prefix, Name */
> -#else
> +#if __GNUC__ == 2 && __GNUC_MINOR__ >= 96
>  #define SN(X)
>  #define SC(P,N) N
> +#else
> +#define SN(X)   X	/* Struct Name */
> +#define SC(P,N) P.N	/* ShortCut: Prefix, Name */
>  #endif
>  
>  /* 2-byte Unicode character type. */
> 
> 

-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

