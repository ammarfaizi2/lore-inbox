Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266994AbTGKW1o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 18:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266982AbTGKW1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 18:27:43 -0400
Received: from air-2.osdl.org ([65.172.181.6]:16354 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266994AbTGKW0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 18:26:17 -0400
Date: Fri, 11 Jul 2003 15:34:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <willy@debian.org>
Cc: bernie@develer.com, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: do_div vs sector_t
Message-Id: <20030711153415.6776a680.akpm@osdl.org>
In-Reply-To: <20030711223359.GP20424@parcelfarce.linux.theplanet.co.uk>
References: <20030711223359.GP20424@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> wrote:
>
> This almost works (the warning is harmless since gcc optimises away the call)
> 
> # define do_div(n,base) ({                                              \
>         uint32_t __base = (base);                                       \
>         uint32_t __rem;                                                 \
>         if ((sizeof(n) < 8) || (likely(((n) >> 32) == 0))) {            \
>                 __rem = (uint32_t)(n) % __base;                         \
>                 (n) = (uint32_t)(n) / __base;                           \
>         } else                                                          \
>                 __rem = __div64_32(&(n), __base);                       \
>         __rem;                                                          \
>  })

Could we just do:

diff -puN include/asm-generic/div64.h~do_div-fix-43 include/asm-generic/div64.h
--- 25/include/asm-generic/div64.h~do_div-fix-43	Fri Jul 11 15:32:33 2003
+++ 25-akpm/include/asm-generic/div64.h	Fri Jul 11 15:33:26 2003
@@ -34,7 +34,8 @@
 
 extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
 
-# define do_div(n,base) ({				\
+# define do_div(_n,base) ({				\
+	uint64_t n = _n;				\
 	uint32_t __base = (base);			\
 	uint32_t __rem;					\
 	if (likely(((n) >> 32) == 0)) {			\
@@ -42,6 +43,7 @@ extern uint32_t __div64_32(uint64_t *div
 		(n) = (uint32_t)(n) / __base;		\
 	} else 						\
 		__rem = __div64_32(&(n), __base);	\
+	_n = n;						\
 	__rem;						\
  })
 

_



