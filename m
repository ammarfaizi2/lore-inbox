Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbTIWG7g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 02:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTIWG7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 02:59:36 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:4826 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S261884AbTIWG7f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 02:59:35 -0400
Date: Tue, 23 Sep 2003 08:59:25 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Bernd Harries <bha@gmx.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH] atyfb updates
In-Reply-To: <Pine.GSO.4.21.0309230743060.5202-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0309230842010.15242-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Sep 2003, Geert Uytterhoeven wrote:

>   - aty_ld_pll() used to be global, but now it's defined for Mach64 CT only,
>     causing a link failure if you don't enable Mach64 CT support.
>     Since Mach64 GX never has a GTB-style DSP, make that part of the code
>     Mach64 CT dependant.

Now I look at it, that code is suspicious:

> +#ifdef CONFIG_FB_ATY_CT
> +    if (M64_HAS(GTB_DSP)) {
> +	u8 pll_ref_div = aty_ld_pll(PLL_REF_DIV, info);
> +	if (pll_ref_div) {
> +	    int diff1, diff2;
> +	    diff1 = 510*14/pll_ref_div-pll;
> +	    diff2 = 510*29/pll_ref_div-pll;
> +	    if (diff1 < 0)
> +		diff1 = -diff1;
> +	    if (diff2 < 0)
> +		diff2 = -diff2;
> +	    if (diff2 < diff1) {
> +		info->ref_clk_per = 1000000000000ULL/29498928;
> +		xtal = "29.498928";
> +	    }
> +	}
>      }
> +#endif /* CONFIG_FB_ATY_CT */

It's true that at_ld_pll should never be called on a GX boards, but only
boards with a GTB DSP can use a 29.49 XTALIN? For safety, I would also
remove the GTB_DSP check.

Daniël

