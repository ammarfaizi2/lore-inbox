Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbWGSVFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWGSVFB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 17:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWGSVFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 17:05:01 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:26253 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030312AbWGSVFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 17:05:00 -0400
Message-ID: <44BE9E78.3010409@garzik.org>
Date: Wed, 19 Jul 2006 17:04:56 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: ricknu-0@student.ltu.se
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se>
In-Reply-To: <1153341500.44be983ca1407@portal.student.luth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ricknu-0@student.ltu.se wrote:
> A first step to a generic boolean-type. The patch just introduce the bool (in

Since gcc supports boolean types and can optimize for such, introducing 
bool is IMO a good thing.


> -Why would we want it?
> -There is already some how are depending on a "boolean"-type (like NTFS). Also,
> it will clearify functions who returns a boolean from one returning a value, ex:
> bool it_is_ok();
> char it_is_ok();
> The first one is obvious what it is doing, the secound might return some sort of
> status.

A better reason is that there is intrinsic compiler support for booleans.


> -Why false and not FALSE, why not "enum {...} bool"
> -They are not #define(d) and shouldn't because it is a value, like 'a'. But
> because it is just a value, then bool is just a variable and should be able to
> handle 0 and 1 equally well.
> 
> Well, this is _my_ opinion, it may be totally wrong. If so, please tell me ;)

> Yes, I know about Andrew's try to unify TRUE and FALSE, did read the thread with
> interest (that's from where I got to know about _Bool). But mostly (then still
> on the subject) was some people did not want FALSE and TRUE instead of 0 and 1.
> I look at it as: 'a' = 97, if someone like to write 97 instead of 'a', please do
> if you find it easier to read. I, on the other hand, think it is easier with
> 'a', false/FALSE, NULL, etc.

We should follow what C99 directs.


> diff --git a/include/asm-i386/types.h b/include/asm-i386/types.h
> index 4b4b295..e35709a 100644
> --- a/include/asm-i386/types.h
> +++ b/include/asm-i386/types.h
> @@ -10,6 +10,15 @@ typedef unsigned short umode_t;
>   * header files exported to user space
>   */
>  
> +#if defined(__GNUC__) && __GNUC__ >= 3
> +typedef _Bool bool;
> +#else
> +#warning You compiler doesn't seem to support boolean types, will set 'bool' as
> an 'unsigned char'
> +typedef unsigned char bool;
> +#endif
> +
> +typedef bool u2;

NAK.  gcc >= 3 is required by now, AFAIK.

Also, you don't want to force 'unsigned char' on code, because often 
code prefers a machine integer to something smaller than a machine integer.


> diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> index b3a2cad..5e5c611 100644
> --- a/include/linux/stddef.h
> +++ b/include/linux/stddef.h
> @@ -10,6 +10,8 @@ #else
>  #define NULL ((void *)0)
>  #endif
>  
> +enum { false = 0, true = 1 } __attribute__((packed));

How is 'packed' attribute useful here?

	Jeff


