Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbTCQIna>; Mon, 17 Mar 2003 03:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262810AbTCQIna>; Mon, 17 Mar 2003 03:43:30 -0500
Received: from mail.zmailer.org ([62.240.94.4]:42628 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S262806AbTCQIn3>;
	Mon, 17 Mar 2003 03:43:29 -0500
Date: Mon, 17 Mar 2003 10:54:20 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: dave <davekern@ihug.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: error using unsigned long long not working in 2.4.x
Message-ID: <20030317085420.GZ29167@mea-ext.zmailer.org>
References: <002d01c2ed11$6ba7a110$0b721cac@stacy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002d01c2ed11$6ba7a110$0b721cac@stacy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 09:44:16PM -0800, dave wrote:
> hi i am writing a kernel 2.4.x driver and need to do maths on 64 bit ints
> (unsigned long long)
> bcause you can not use the FPU
> but when i insmod i get the error unresolved symbol __udivdi3 i need!! 64
> bit ints
> 
> i have included the code
> thank you

The original reason for Linux kernel not being linked with  -lgcc
where that routine is defined, is that of wanting to catch careless
coding of 64-bit arithmetic in kernel.  It does cause massiveish
performance penalty in the system, if used unchecked in code
fast paths.

If you can do it with at most 31 bit divider, and can handle 
side-effectfull division, system has   do_div()   macro.

Use like:

	#include <asm/div64.h>


	long long n, vco;
	long divisor;
	long remainder;

	n = vco;
	divisor = some_expression;
	remainder = do_div(n, divisor);


You will, most likely, ignore the remainder.
BECAUSE there is side-effect of modifying the dividend (n), you must
use it like in this illustriation.

The  divisor  can not have value in excess of 2^31.

Also there are architectures which do not properly implement this
routine, and do merely  32/32 division, where 64/32 is really wanted.
(The i386 architecture does handle it.)

/Matti Aarnio
