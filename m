Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290838AbSARVdB>; Fri, 18 Jan 2002 16:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290841AbSARVct>; Fri, 18 Jan 2002 16:32:49 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:51976 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S290837AbSARVbm>;
	Fri, 18 Jan 2002 16:31:42 -0500
Date: Fri, 18 Jan 2002 22:18:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrea Arcangeli <andrea@suse.de>, rwhron@earthlink.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1-2-3 GB
Message-ID: <20020118211851.GB130@elf.ucw.cz>
In-Reply-To: <20020112125625.E1482@inspiron.school.suse.de> <Pine.LNX.4.21.0201121825200.1105-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0201121825200.1105-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The patch below seems to be enough to convince egcs-2.91.66 and
> gcc-2.95.3 to use a "jb" comparison there.  I'm working on PIII,
> prefetchw() just a stub, if that makes any difference.

If this is really gcc bug, would simply making j volatile fix it?

								Pavel
> --- 2.4.18pre2aa2/mm/memory.c	Sat Jan 12 18:01:36 2002
> +++ linux/mm/memory.c	Sat Jan 12 18:09:27 2002
> @@ -106,8 +106,7 @@
>  
>  static inline void free_one_pgd(pgd_t * dir)
>  {
> -	int j;
> -	pmd_t * pmd;
> +	pmd_t * pmd, * md, * emd;
>  
>  	if (pgd_none(*dir))
>  		return;
> @@ -118,9 +117,9 @@
>  	}
>  	pmd = pmd_offset(dir, 0);
>  	pgd_clear(dir);
> -	for (j = 0; j < PTRS_PER_PMD ; j++) {
> -		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
> -		free_one_pmd(pmd+j);
> +	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++) {
> +		prefetchw(md+(PREFETCH_STRIDE/16));
> +		free_one_pmd(md);
>  	}
>  	pmd_free(pmd);
>  }

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
