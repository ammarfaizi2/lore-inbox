Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVCGAuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVCGAuz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 19:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVCGAuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 19:50:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:52185 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261618AbVCGAsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 19:48:09 -0500
Date: Sun, 6 Mar 2005 16:48:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, yrgrknmxpzlk@gawab.com
Subject: Re: [patch 10/12] arch/i386/math-emu/* - compile warning cleanup
Message-Id: <20050306164806.3e5529e9.akpm@osdl.org>
In-Reply-To: <20050305153539.2800D1F204@trashy.coderock.org>
References: <20050305153539.2800D1F204@trashy.coderock.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
>
> 
> compile warning cleanup - handle copy_to/from_user error 
> returns
> 

We made some changes like this in there a while back, and things broke
subtly.  I'd prefer that someone who remembers how this code works take a
good look at this.  But I don't think anyone remembers how this code works.



> 
> diff -puN arch/i386/math-emu/fpu_entry.c~return_code-arch_i386_math-emu arch/i386/math-emu/fpu_entry.c
> --- kj/arch/i386/math-emu/fpu_entry.c~return_code-arch_i386_math-emu	2005-03-05 16:13:04.000000000 +0100
> +++ kj-domen/arch/i386/math-emu/fpu_entry.c	2005-03-05 16:13:04.000000000 +0100
> @@ -742,7 +742,8 @@ int save_i387_soft(void *s387, struct _f
>    S387->fcs &= ~0xf8000000;
>    S387->fos |= 0xffff0000;
>  #endif /* PECULIAR_486 */
> -  __copy_to_user(d, &S387->cwd, 7*4);
> +  if (__copy_to_user(d, &S387->cwd, 7*4))
> +    return -1;
>    RE_ENTRANT_CHECK_ON;
>  
>    d += 7*4;
> diff -puN arch/i386/math-emu/reg_ld_str.c~return_code-arch_i386_math-emu arch/i386/math-emu/reg_ld_str.c
> --- kj/arch/i386/math-emu/reg_ld_str.c~return_code-arch_i386_math-emu	2005-03-05 16:13:04.000000000 +0100
> +++ kj-domen/arch/i386/math-emu/reg_ld_str.c	2005-03-05 16:13:04.000000000 +0100
> @@ -89,12 +89,17 @@ int FPU_tagof(FPU_REG *ptr)
>  int FPU_load_extended(long double __user *s, int stnr)
>  {
>    FPU_REG *sti_ptr = &st(stnr);
> +  int user_copy_err;
>  
>    RE_ENTRANT_CHECK_OFF;
>    FPU_verify_area(VERIFY_READ, s, 10);
> -  __copy_from_user(sti_ptr, s, 10);
> +  user_copy_err = __copy_from_user(sti_ptr, s, 10);
>    RE_ENTRANT_CHECK_ON;
>  
> +  if (user_copy_err) {
> +	EXCEPTION(EX_INTERNAL);
> +	return TAG_Special;
> +  }
>    return FPU_tagof(sti_ptr);
>  }
>  
> @@ -240,13 +245,19 @@ int FPU_load_int64(long long __user *_s)
>  {
>    long long s;
>    int sign;
> +  int user_copy_err;
>    FPU_REG *st0_ptr = &st(0);
>  
>    RE_ENTRANT_CHECK_OFF;
>    FPU_verify_area(VERIFY_READ, _s, 8);
> -  copy_from_user(&s,_s,8);
> +  user_copy_err = copy_from_user(&s,_s,8);
>    RE_ENTRANT_CHECK_ON;
>  
> +  if (user_copy_err) {
> +	EXCEPTION(EX_INTERNAL);
> +	return TAG_Special;
> +  }
> +
>    if (s == 0)
>      {
>        reg_copy(&CONST_Z, st0_ptr);
> @@ -859,6 +870,7 @@ int FPU_store_int64(FPU_REG *st0_ptr, u_
>    FPU_REG t;
>    long long tll;
>    int precision_loss;
> +  int user_copy_err;
>  
>    if ( st0_tag == TAG_Empty )
>      {
> @@ -907,9 +919,14 @@ int FPU_store_int64(FPU_REG *st0_ptr, u_
>  
>    RE_ENTRANT_CHECK_OFF;
>    FPU_verify_area(VERIFY_WRITE,d,8);
> -  copy_to_user(d, &tll, 8);
> +  user_copy_err = copy_to_user(d, &tll, 8);
>    RE_ENTRANT_CHECK_ON;
>  
> +  if (user_copy_err) {
> +	EXCEPTION(EX_INTERNAL);
> +	return 0;
> +  }
> +
>    return 1;
>  }
>  
> @@ -1271,15 +1288,21 @@ void frstor(fpu_addr_modes addr_modes, u
>    int i, regnr;
>    u_char __user *s = fldenv(addr_modes, data_address);
>    int offset = (top & 7) * 10, other = 80 - offset;
> +  int user_copy_err;
>  
>    /* Copy all registers in stack order. */
>    RE_ENTRANT_CHECK_OFF;
>    FPU_verify_area(VERIFY_READ,s,80);
> -  __copy_from_user(register_base+offset, s, other);
> -  if ( offset )
> -    __copy_from_user(register_base, s+other, offset);
> +  user_copy_err = __copy_from_user(register_base+offset, s, other);
> +  if (!user_copy_err && offset)
> +    user_copy_err = __copy_from_user(register_base, s+other, offset);
>    RE_ENTRANT_CHECK_ON;
>  
> +  if (user_copy_err) {
> +	EXCEPTION(EX_INTERNAL);
> +	return;
> +  }
> +
>    for ( i = 0; i < 8; i++ )
>      {
>        regnr = (i+top) & 7;
> @@ -1325,6 +1348,7 @@ u_char __user *fstenv(fpu_addr_modes add
>      }
>    else
>      {
> +      int user_copy_err;
>        RE_ENTRANT_CHECK_OFF;
>        FPU_verify_area(VERIFY_WRITE, d, 7*4);
>  #ifdef PECULIAR_486
> @@ -1336,8 +1360,12 @@ u_char __user *fstenv(fpu_addr_modes add
>        I387.soft.fcs &= ~0xf8000000;
>        I387.soft.fos |= 0xffff0000;
>  #endif /* PECULIAR_486 */
> -      __copy_to_user(d, &control_word, 7*4);
> +      user_copy_err = __copy_to_user(d, &control_word, 7*4);
>        RE_ENTRANT_CHECK_ON;
> +
> +      if (user_copy_err)
> +	EXCEPTION(EX_INTERNAL);
> +
>        d += 0x1c;
>      }
>    
> @@ -1352,6 +1380,7 @@ void fsave(fpu_addr_modes addr_modes, u_
>  {
>    u_char __user *d;
>    int offset = (top & 7) * 10, other = 80 - offset;
> +  int user_copy_err;
>  
>    d = fstenv(addr_modes, data_address);
>  
> @@ -1359,11 +1388,14 @@ void fsave(fpu_addr_modes addr_modes, u_
>    FPU_verify_area(VERIFY_WRITE,d,80);
>  
>    /* Copy all registers in stack order. */
> -  __copy_to_user(d, register_base+offset, other);
> -  if ( offset )
> -    __copy_to_user(d+other, register_base, offset);
> +  user_copy_err = __copy_to_user(d, register_base+offset, other);
> +  if (!user_copy_err && offset)
> +    user_copy_err = __copy_to_user(d+other, register_base, offset);
>    RE_ENTRANT_CHECK_ON;
>  
> +  if (user_copy_err)
> +	EXCEPTION(EX_INTERNAL);
> +
>    finit();
>  }
>  
> _
