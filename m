Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265373AbUF2CpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUF2CpP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 22:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265370AbUF2CpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 22:45:15 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:49600 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S265383AbUF2CpJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 22:45:09 -0400
Subject: Re: __setup()'s not processed in bk-current
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Ricky Beam <jfbeam@bluetronic.net>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>, rth@twiddle.net
In-Reply-To: <20040628165707.328cce15.akpm@osdl.org>
References: <Pine.GSO.4.33.0406281523340.25702-100000@sweetums.bluetronic.net>
	 <20040628165707.328cce15.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1088477020.10622.82.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 29 Jun 2004 12:43:41 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-29 at 09:57, Andrew Morton wrote:
> We're now putting 24-byte structures into .init.setup via __setup.  But
> x86_64's compiler is emitting a `.align 16' in there, so they end up on
> 32-byte boundaries and do_early_param()'s pointer arithmetic goes wrong.
> 
> Fix that up by forcing the compiler to align these structures to sizeof(long).

Um, that's really odd, and at least deserves a comment.

There are a number of places where we assume that we can iterate through
all entries in a section as an array, rth would know if we've just been
lucky...

Thanks,
Rusty.

> diff -puN include/linux/init.h~x86_64-setup-section-alignment-fix include/linux/init.h
> --- 25/include/linux/init.h~x86_64-setup-section-alignment-fix	2004-06-28 16:47:41.000000000 -0700
> +++ 25-akpm/include/linux/init.h	2004-06-28 16:47:41.000000000 -0700
> @@ -119,6 +119,7 @@ struct obs_kernel_param {
>  	static struct obs_kernel_param __setup_##unique_id	\
>  		 __attribute_used__				\
>  		 __attribute__((__section__(".init.setup")))	\
> +		__attribute__((aligned((sizeof(long)))))	\
>  		= { __setup_str_##unique_id, fn, early }
>  
>  #define __setup_null_param(str, unique_id)			\
> 
> _
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

