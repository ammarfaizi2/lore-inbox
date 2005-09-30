Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbVI3NJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbVI3NJs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 09:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbVI3NJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 09:09:48 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:41406 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1030294AbVI3NJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 09:09:47 -0400
Message-ID: <433D391A.70607@vc.cvut.cz>
Date: Fri, 30 Sep 2005 15:09:46 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org
Subject: Re: [Patch] x86, x86_64: fix cpu model for family 0x6
References: <20050929190419.C15943@unix-os.sc.intel.com>
In-Reply-To: <20050929190419.C15943@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> Andi, please pickup this patch and push to Andrew/Linus.
> 
> thanks,
> suresh
> 
> --
> According to cpuid instruction in IA32 SDM-Vol2, when computing cpu model,
> we need to consider extended model ID for family 0x6 also.
> 
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
> 
> --- linux-2.6.14-rc2-git7/arch/i386/kernel/cpu/common.c~	2005-09-29 17:44:12.030688920 -0700
> +++ linux-2.6.14-rc2-git7/arch/i386/kernel/cpu/common.c	2005-09-29 17:44:30.967810040 -0700
> @@ -233,10 +233,10 @@ static void __init early_cpu_detect(void
>  		cpuid(0x00000001, &tfms, &misc, &junk, &cap0);
>  		c->x86 = (tfms >> 8) & 15;
>  		c->x86_model = (tfms >> 4) & 15;
> -		if (c->x86 == 0xf) {
> +		if (c->x86 == 0xf)
>  			c->x86 += (tfms >> 20) & 0xff;
> +		if (c->x86 == 0x6 || c->x86 == 0xf)

Are you sure this is correct?  You just incremented c->x86 by extended
family, so I believe test should be

                 if (c->x86 == 0x6 || c->x86 >= 0xf)

or maybe just

                 if (c->x86 >= 0x6)

as chips with family 7..14 will either never appear, or they'll follow
existing rules (I believe all chips ever built return upper bits of tfms
zeroed, so maybe we could get rid of all these 'if' completely).
						Petr Vandrovec

