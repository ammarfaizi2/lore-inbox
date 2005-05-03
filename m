Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVECHWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVECHWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 03:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVECHWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 03:22:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:22253 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261416AbVECHWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 03:22:02 -0400
Date: Tue, 3 May 2005 00:21:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: blaisorblade@yahoo.it
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       ak@suse.de
Subject: Re: [patch 1/1] x86_64: make string func definition work as
 intended
Message-Id: <20050503002126.1f40f5bf.akpm@osdl.org>
In-Reply-To: <20050501190851.5FD5B45EBB@zion>
References: <20050501190851.5FD5B45EBB@zion>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade@yahoo.it wrote:
>
> In include/asm-x86_64/string.h there are such comments:
> 
>  /* Use C out of line version for memcmp */ 
>  #define memcmp __builtin_memcmp
>  int memcmp(const void * cs,const void * ct,size_t count);
> 
>  This would mean that if the compiler does not decide to use __builtin_memcmp,
>  it emits a call to memcmp to be satisfied by the C out-of-line version in
>  lib/string.c. What happens is that after preprocessing, in lib/string.i you
>  may find the definition of "__builtin_strcmp".
> 
>  Actually, by accident, in the object you will find the definition of
>  strcmp and such (maybe a trick intended to redirect calls to __builtin_memcmp
>  to the default memcmp when the definition is not expanded); however, this
>  particular case is not a documented feature as far as I can see.
> 
>  Also, the EXPORT_SYMBOL does not work, so it's duplicated in the arch.

This breaks the x86 build.  I guess the below is right.

You wanna check other architectures please?


diff -puN arch/i386/kernel/i386_ksyms.c~x86_64-make-string-func-definition-work-as-intended-fix arch/i386/kernel/i386_ksyms.c
--- 25/arch/i386/kernel/i386_ksyms.c~x86_64-make-string-func-definition-work-as-intended-fix	2005-05-03 00:16:36.000000000 -0700
+++ 25-akpm/arch/i386/kernel/i386_ksyms.c	2005-05-03 00:16:44.000000000 -0700
@@ -169,10 +169,6 @@ EXPORT_SYMBOL(rtc_lock);
 EXPORT_SYMBOL_GPL(set_nmi_callback);
 EXPORT_SYMBOL_GPL(unset_nmi_callback);
 
-#undef memcmp
-extern int memcmp(const void *,const void *,__kernel_size_t);
-EXPORT_SYMBOL(memcmp);
-
 EXPORT_SYMBOL(register_die_notifier);
 #ifdef CONFIG_HAVE_DEC_LOCK
 EXPORT_SYMBOL(_atomic_dec_and_lock);
_

