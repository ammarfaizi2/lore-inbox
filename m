Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVCLRHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVCLRHa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 12:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVCLRHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 12:07:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:51392 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261973AbVCLRHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 12:07:22 -0500
Date: Sat, 12 Mar 2005 09:09:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: Paul Mackerras <paulus@samba.org>, Dave Jones <davej@redhat.com>,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
In-Reply-To: <87vf7xg72s.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.58.0503120906020.2398@ppc970.osdl.org>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
 <20050311021248.GA20697@redhat.com> <16944.65532.632559.277927@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0503101839530.2530@ppc970.osdl.org> <87vf7xg72s.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 12 Mar 2005, OGAWA Hirofumi wrote:
> 
> diff -puN include/asm-i386/atomic.h~detect-atomic-counter-underflows include/asm-i386/atomic.h
> --- 25/include/asm-i386/atomic.h~detect-atomic-counter-underflows	Wed Nov  3 15:27:37 2004
> +++ 25-akpm/include/asm-i386/atomic.h	Wed Nov  3 15:27:37 2004
> @@ -132,6 +132,10 @@ static __inline__ int atomic_dec_and_tes
>  {
>  	unsigned char c;
>  
> +	if (!atomic_read(v)) {
> +		printk("BUG: atomic counter underflow at:\n");
> +		dump_stack();
> +	}

Btw, this should probably check for negative 32-bit values too, ie the 
test should probably be

	if ((int)atomic_read(v) <= 0)

and it should probably be done for the regular atomic_dec() etc cases too, 
not just the dec-and-test. "atomic" values simply aren't historically 
well-defined for negative values (sparc used to limit them to 24 bits), so 
a negative thing would always be a bug, I think.

		Linus
