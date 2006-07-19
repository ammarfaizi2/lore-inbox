Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWGSVVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWGSVVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 17:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbWGSVVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 17:21:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:58377 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932415AbWGSVVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 17:21:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=HBvO/8TqDh9T515uL777uz2ky9x1TTeqs6ok5xMLQmGLtU7sgpVwQWf0HSE7VOvPRsWvwHXnoe68Gboqvy9YhVi2D2a4bMpqw2dgKeN0dZdoSSRha7ZeCRH9mtvMlSBAT1dEXPArymT+0UaLtkE6wFB8MgdtPQmfk60EfsTlXaM=
Date: Thu, 20 Jul 2006 01:20:49 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: ricknu-0@student.ltu.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] A generic boolean
Message-ID: <20060719212049.GA6828@martell.zuzino.mipt.ru>
References: <1153341500.44be983ca1407@portal.student.luth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153341500.44be983ca1407@portal.student.luth.se>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 10:38:20PM +0200, ricknu-0@student.ltu.se wrote:
> A first step to a generic boolean-type. The patch just introduce the bool (in
> arch. i386 only (for the moment)),

What's do special about i386?

> false and true + fixing some duplications in
> the code.

> -Why would we want it?
> -There is already some how are depending on a "boolean"-type (like NTFS). Also,
> it will clearify functions who returns a boolean from one returning a value, ex:
> bool it_is_ok();
> char it_is_ok();
> The first one is obvious what it is doing, the secound might return some sort of
> status.

It should be obvious from name whether function returns int which is a
boolean or int which is a number.

> -Why false and not FALSE, why not "enum {...} bool"
> -They are not #define(d) and shouldn't because it is a value, like 'a'. But
> because it is just a value, then bool is just a variable and should be able to
> handle 0 and 1 equally well.

  -Why we wouldn't want it
  -C++ and Java fans will treat bool as a green light to the following

	if (!(flags == true))
  and
	if (!(flags == false))

> If this takes off, I guess I will spend quite some time at kernel-janitors
> "cleaning" those who use a boolean-type.

> Yes, I know about Andrew's try to unify TRUE and FALSE, did read the thread with
> interest (that's from where I got to know about _Bool). But mostly (then still
> on the subject) was some people did not want FALSE and TRUE instead of 0 and 1.
> I look at it as: 'a' = 97, if someone like to write 97 instead of 'a', please do
> if you find it easier to read. I, on the other hand, think it is easier with
> 'a', false/FALSE, NULL, etc.
> DS
> 
> PPS
> One thing about _Bool thue:
> _Bool a = 12; results in a = 1
> 
> test( char * t ) { t = 12; }
		    ^^^
> main() {
> _Bool a;
> test( (char *) &a ); results in a = 12.
> }
> 
> But I do not think of it as a problem since a "true" is just !false. Doing:
> if (boolvar == true)
> seems odd, after all...
> 
> ... and sorry for the longwinded letter :)
>

Please, show compiler flag[s] to enable warning[s] from gcc about

	_Bool foo = 42;

Until you do that the whole activity is moot.

> --- a/drivers/net/dgrs.c
> +++ b/drivers/net/dgrs.c
> @@ -110,7 +110,6 @@ static char version[] __initdata =
>   *	DGRS include files
>   */
>  typedef unsigned char uchar;
> -typedef unsigned int bool;
>  #define vol volatile
>  
>  #include "dgrs.h"

The only chunk that looks OK to me.

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

Why unsigned char? Why not unsigned int? What would this do wrt
bitfields?

> +#endif
> +
> +typedef bool u2;

What is it?

