Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSLONvR>; Sun, 15 Dec 2002 08:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbSLONvR>; Sun, 15 Dec 2002 08:51:17 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:63498 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261524AbSLONvQ>; Sun, 15 Dec 2002 08:51:16 -0500
Date: Sun, 15 Dec 2002 22:59:42 +0900 (JST)
Message-Id: <20021215.225942.24871004.yoshfuji@linux-ipv6.org>
To: tomita@cinet.co.jp
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCHSET] PC-9800 addtional for 2.5.50-ac1 (21/21)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <3DFC818F.80E3DC00@cinet.co.jp>
References: <3DFC50E9.656B96D0@cinet.co.jp>
	<3DFC818F.80E3DC00@cinet.co.jp>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3DFC818F.80E3DC00@cinet.co.jp> (at Sun, 15 Dec 2002 22:20:15 +0900), Osamu Tomita <tomita@cinet.co.jp> says:

> +#ifndef CONFIG_PC9800
>  			if (mpf->mpf_physptr)
>  				reserve_bootmem(mpf->mpf_physptr, PAGE_SIZE);
> +#else
> +			/*
> +			 * PC-9800's MPC table places on the very last of
> +			 * physical memory; so that simply reserving PAGE_SIZE
> +			 * from mpg->mpf_physptr yields BUG() in
> +			 * reserve_bootmem.
> +			 */
> +			if (mpf->mpf_physptr) {
> +				/*
> +				 * We cannot access to MPC table to compute
> +				 * table size yet, as only few megabytes from
> +				 * the bottom is mapped now.
> +				 */
> +				unsigned long size = PAGE_SIZE;
> +				unsigned long end = max_low_pfn * PAGE_SIZE;
> +				if (mpf->mpf_physptr + size > end)
> +					size = end - mpf->mpf_physptr;
> +				reserve_bootmem(mpf->mpf_physptr, size);
> +			}
> +#endif
> +

I'm not sure if we need this #ifdef; 
it doesn't seem that this #ifdef CONFIG_PC9800 part is harmful 
for others at all.

Well, if it is required, I prefer putting #ifdef..#endif inside the 
if-clause like this:

 			if (mpf->mpf_physptr) {
				unsigned long size = PAGE_SIZE;
#ifdef CONFIG_PC9800
				/*
				 * PC-9800's MPC table places on the very last of
				 * physical memory; so that simply reserving PAGE_SIZE
				 * from mpg->mpf_physptr yields BUG() in
				 * reserve_bootmem.
				 *
				 * We cannot access to MPC table to compute
				 * table size yet, as only few megabytes from
				 * the bottom is mapped now.
				 */
				unsigned long end = max_low_pfn * PAGE_SIZE;

				if (mpf->mpf_physptr + size > end)
					size = end - mpf->mpf_physptr;
#endif
				reserve_bootmem(mpf->mpf_physptr, size);
			}

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
