Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130610AbRBTUHv>; Tue, 20 Feb 2001 15:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130612AbRBTUHl>; Tue, 20 Feb 2001 15:07:41 -0500
Received: from [194.213.32.137] ([194.213.32.137]:52228 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130610AbRBTUHa>;
	Tue, 20 Feb 2001 15:07:30 -0500
Message-ID: <20010220183513.B5102@bug.ucw.cz>
Date: Tue, 20 Feb 2001 18:35:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [beta patch] SSE copy_page() / clear_page()
In-Reply-To: <3A846C84.109F1D7D@colorfullife.com> <200102092240.OAA15902@penguin.transmeta.com> <3A8B08C7.BD79E3B4@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A8B08C7.BD79E3B4@colorfullife.com>; from Manfred Spraul on Wed, Feb 14, 2001 at 11:37:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> --- 2.4/mm/filemap.c	Wed Feb 14 10:51:42 2001
> +++ build-2.4/mm/filemap.c	Wed Feb 14 22:11:44 2001
> @@ -1248,6 +1248,20 @@
>  		size = count;
>  
>  	kaddr = kmap(page);
> +	if (size > 128) {
> +		int i;
> +		__asm__ __volatile__(
> +			"mov %1, %0\n\t"
> +			: "=r" (i)
> +			: "r" (kaddr+offset)); /* load tlb entry */
> +		for(i=0;i<size;i+=64) {
> +			__asm__ __volatile__(
> +				"prefetchnta (%1, %0)\n\t"
> +				"prefetchnta 32(%1, %0)\n\t"
> +				: /* no output */
> +				: "r" (i), "r" (kaddr+offset));
> +		}
> +	}
>  	left = __copy_to_user(desc->buf, kaddr + offset, size);
>  	kunmap(page);

This seems bogus -- you need to handle faults --
i.e. __prefetchnta_to_user() ;-).
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
