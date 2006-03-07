Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbWCGBHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbWCGBHo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWCGBHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:07:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37097 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932576AbWCGBHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:07:43 -0500
Date: Mon, 6 Mar 2006 17:05:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64bit unaligned access on 32bit kernel
Message-Id: <20060306170552.0aab29c5.akpm@osdl.org>
In-Reply-To: <20060306.203218.69025300.nemoto@toshiba-tops.co.jp>
References: <20050830104056.GA4710@linux-mips.org>
	<20060306.203218.69025300.nemoto@toshiba-tops.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> >>>>> On Tue, 30 Aug 2005 11:40:56 +0100, Ralf Baechle <ralf@linux-mips.org> said:
> > I've rewriten Atushi's fix for the 64-bit put_unaligned on 32-bit
> > systems bug to generate more efficient code.
> 
> > This case has buzilla URL http://bugzilla.kernel.org/show_bug.cgi?id=5138.
> 
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ...
> >  #define __get_unaligned(ptr, size) ({		\
> >  	const void *__gu_p = ptr;		\
> > -	unsigned long val;			\
> > +	__typeof__(*(ptr)) val;			\
> >  	switch (size) {				\
> >  	case 1:					\
> >  		val = *(const __u8 *)__gu_p;	\
> 
> It looks gcc 4.x strike back.  If the 'ptr' is a const, this code
> cause "assignment of read-only variable" error on gcc 4.x.  Let's step
> a back, or do you have any other good idea?
> 
> 
> Use __u64 instead of __typeof__(*(ptr)) for temporary variable to get
> rid of errors on gcc 4.x.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
> index 4dc8ddb..09ec447 100644
> --- a/include/asm-generic/unaligned.h
> +++ b/include/asm-generic/unaligned.h
> @@ -78,7 +78,7 @@ static inline void __ustw(__u16 val, __u
>  
>  #define __get_unaligned(ptr, size) ({		\
>  	const void *__gu_p = ptr;		\
> -	__typeof__(*(ptr)) val;			\
> +	__u64 val;				\
>  	switch (size) {				\
>  	case 1:					\
>  		val = *(const __u8 *)__gu_p;	\
> @@ -95,7 +95,7 @@ static inline void __ustw(__u16 val, __u
>  	default:				\
>  		bad_unaligned_access_length();	\
>  	};					\
> -	val;					\
> +	(__typeof__(*(ptr)))val;		\
>  })
>  
>  #define __put_unaligned(val, ptr, size)		\

I worry about what impact that change might have on code generation. 
Hopefully none, if gcc is good enough.

But I cannot think of a better fix.
