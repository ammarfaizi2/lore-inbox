Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWIIPxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWIIPxA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 11:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWIIPxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 11:53:00 -0400
Received: from colin.muc.de ([193.149.48.1]:10 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932280AbWIIPw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 11:52:59 -0400
Date: 9 Sep 2006 17:52:57 +0200
Date: Sat, 9 Sep 2006 17:52:57 +0200
From: Andi Kleen <ak@muc.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386-pda updates
Message-ID: <20060909155257.GA50136@muc.de>
References: <45027822.2010906@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45027822.2010906@goop.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 01:15:30AM -0700, Jeremy Fitzhardinge wrote:
> 
> -/* Make sure %gs it initialized properly in idle threads */
> +/* Make sure %gs is initialized properly in idle threads */

Merged

> };
> @@ -20,7 +22,14 @@ extern struct i386_pda _proxy_pda;
> #define pda_to_op(op,field,val)					 \
> 	do {								\
> 		typedef typeof(_proxy_pda.field) T__;			\
> +		if (0) { T__ tmp__; tmp__ = (val); }			\

Merged into original patch

> 		switch (sizeof(_proxy_pda.field)) {			\
> +		case 1:							\
> +			asm(op "b %1,%%gs:%c2"				\
> +			    : "+m" (_proxy_pda.field)			\
> +			    :"ri" ((T__)val),				\
> +			     "i"(pda_offset(field)));			\
> +			break;						\
> 		case 2:							\
> 			asm(op "w %1,%%gs:%c2"				\
> 			    : "+m" (_proxy_pda.field)			\
> @@ -41,6 +50,12 @@ extern struct i386_pda _proxy_pda;
> 	({								\
> 		typeof(_proxy_pda.field) ret__;				\
> 		switch (sizeof(_proxy_pda.field)) {			\
> +		case 1:							\
> +			asm(op "b %%gs:%c1,%0"				\
> +			    : "=r" (ret__)				\
> +			    : "i" (pda_offset(field)),			\
> +			      "m" (_proxy_pda.field));			\
> +			break;						\
> 		case 2:							\
> 			asm(op "w %%gs:%c1,%0"				\
> 			    : "=r" (ret__)				\
> @@ -57,6 +72,10 @@ extern struct i386_pda _proxy_pda;
> 		}							\
> 		ret__; })
> 
> +/* Return a pointer to a pda field */
> +#define pda_addr(field)						 \
> +	((typeof(_proxy_pda.field) *)((unsigned char *)read_pda(_pda) + \
> +				      pda_offset(field)))

I think i would prefer to merge that and the 1 byte one only
with actual users (x86-64 hasn't needed either for a long time)

-Andi
