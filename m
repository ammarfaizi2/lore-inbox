Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319005AbSH1Vv3>; Wed, 28 Aug 2002 17:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319009AbSH1Vv3>; Wed, 28 Aug 2002 17:51:29 -0400
Received: from cerberus.stardot-tech.com ([67.105.126.66]:26122 "EHLO
	cerberus.stardot-tech.com") by vger.kernel.org with ESMTP
	id <S319005AbSH1Vv1>; Wed, 28 Aug 2002 17:51:27 -0400
Date: Wed, 28 Aug 2002 14:55:39 -0700 (PDT)
From: Jim Treadway <jim@stardot-tech.com>
To: junkio@cox.net
cc: linux-kernel@vger.kernel.org, <trivial@rustcorp.com.au>
Subject: Re: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1)
In-Reply-To: <200208282131.g7SLVVGx024191@siamese.dyndns.org>
Message-ID: <Pine.LNX.4.44.0208281450220.12387-100000@cerberus.stardot-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2002 junkio@cox.net wrote:

> Here is a patch that does the same as what Keith Owens did in
> his patch recently.
> 
>     Message-ID: <fa.iks3ohv.1flge08@ifi.uio.no>
>     From: Keith Owens <kaos@ocs.com.au>
>     Subject: [patch] 2.4.19 Generate better code for nfs_sillyrename
>     Date: Wed, 28 Aug 2002 07:08:17 GMT
> 
>     Using strlen() generates an unnecessary inline function expansion plus
>     dynamic stack adjustment.  For constant strings, strlen() == sizeof()-1
>     and the object code is better.
> 
> The patch is against 2.4.19.
> 
> diff -ru 2.4.19/arch/mips/hp-lj/utils.c 2.4.19-strlen/arch/mips/hp-lj/utils.c
> --- 2.4.19/arch/mips/hp-lj/utils.c	2002-08-02 10:48:43.000000000 -0700
> +++ 2.4.19-strlen/arch/mips/hp-lj/utils.c	2002-08-28 01:17:20.000000000 -0700
> @@ -48,7 +48,7 @@
>  {
>  	char* pos = strstr(cl, "reserved_buffer=");
>   	if (pos) {
> -		buffer_size = simple_strtol(pos+strlen("reserved_buffer="), 
> +		buffer_size = simple_strtol(pos+(sizeof("reserved_buffer=")-1), 
>  					    0, 10);
>  		buffer_size <<= 20;
>  		if (buffer_size + MIN_GEN_MEM > base_mem)

Would redefining strlen() as __strlen() and then using

#define strlen(x) (__builtin_constant_p(x) ? (sizeof(x) - 1) : __strlen(x))

work in this situation?


Jim

