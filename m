Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVAMDm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVAMDm1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 22:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVAMDm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 22:42:27 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:40438 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261405AbVAMDlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 22:41:53 -0500
Date: Thu, 13 Jan 2005 00:42:19 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Prasanna Meda <pmeda@akamai.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] contort getdents64 to pacify gcc-2.96
Message-ID: <20050113004219.A25351@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A recent trivial fixup in sys_getdents64...

> diff -Nru a/fs/readdir.c b/fs/readdir.c
> --- a/fs/readdir.c	2005-01-12 19:22:35 -08:00
> +++ b/fs/readdir.c	2005-01-12 19:22:35 -08:00
> @@ -287,8 +287,9 @@
>  	lastdirent = buf.previous;
>  	if (lastdirent) {
>  		typeof(lastdirent->d_off) d_off = file->f_pos;
> -		__put_user(d_off, &lastdirent->d_off);
>  		error = count - buf.count;
> +		if (__put_user(d_off, &lastdirent->d_off))
> +			error = -EFAULT;
>  	}
>  
>  out_putf:

...gives gcc-2.96 indigestion:

> fs/readdir.c: In function `sys_getdents64':
> fs/readdir.c:299: Unrecognizable insn:
> (insn 166 257 174 (parallel[
>             (set (reg/v:SI 6 ebp)
>                 (asm_operands/v ("1:    movl %%eax,0(%2)
> 2:      movl %%edx,4(%2)
> 3:
> .section .fixup,"ax"
> 4:      movl %3,%0
>         jmp 3b
> .previous
> .section __ex_table,"a"
>         .align 4
>         .long 1b,4b
>         .long 2b,4b
> .previous") ("=r") 0[
>                         (reg:DI 1 edx)
>                         (reg:SI 0 eax)
>                         (const_int -14 [0xfffffff2])
>                         (reg/v:SI 6 ebp)
>                     ]
>                     [
>                         (asm_input:DI ("A"))
>                         (asm_input:SI ("r"))
>                         (asm_input:SI ("i"))
>                         (asm_input:SI ("0"))
>                     ]  ("fs/readdir.c") 291))
>             (clobber (reg:QI 19 dirflag))
>             (clobber (reg:QI 18 fpsr))
>             (clobber (reg:QI 17 flags))
>         ] ) -1 (insn_list 132 (insn_list 146 (insn_list 165 (nil))))
>     (nil))
> fs/readdir.c:299: confused by earlier errors, bailing out

While upgrading to a sane gcc would be the preferred solution, 
rewriting the change as follows eliminates the error for those who
cannot do so.

Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>

--- linux-2.6.11-rc1.orig/fs/readdir.c	Wed Jan 12 22:35:03 2005
+++ linux-2.6.11-rc1/fs/readdir.c	Wed Jan 12 22:16:55 2005
@@ -287,9 +287,10 @@
 	lastdirent = buf.previous;
 	if (lastdirent) {
 		typeof(lastdirent->d_off) d_off = file->f_pos;
-		error = count - buf.count;
+		error = -EFAULT;
 		if (__put_user(d_off, &lastdirent->d_off))
-			error = -EFAULT;
+			goto out_putf;
+		error = count - buf.count;
 	}
 
 out_putf:

