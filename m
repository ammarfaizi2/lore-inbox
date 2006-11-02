Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWKBQIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWKBQIv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 11:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWKBQIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 11:08:51 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:4248 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1751467AbWKBQIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 11:08:50 -0500
Date: Thu, 2 Nov 2006 16:08:47 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Magnus Damm <magnus@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>,
       Andi Kleen <ak@muc.de>, magnus.damm@gmail.com, fastboot@lists.osdl.org
Subject: Re: [PATCH] x86_64: setup saved_max_pfn correctly (kdump)
In-Reply-To: <20061102131934.24684.93195.sendpatchset@localhost>
Message-ID: <Pine.LNX.4.64.0611021604080.14806@skynet.skynet.ie>
References: <20061102131934.24684.93195.sendpatchset@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006, Magnus Damm wrote:

> x86_64: setup saved_max_pfn correctly
>
> 2.6.19-rc4 has broken CONFIG_CRASH_DUMP support on x86_64. It is impossible
> to read out the kernel contents from /proc/vmcore because saved_max_pfn is set
> to zero instead of the max_pfn value before the user map is setup.
>
> This happens because saved_max_pfn is initialized at parse_early_param() time,
> and at this time no active regions have been registered. save_max_pfn is setup
> from e820_end_of_ram(), more exact find_max_pfn_with_active_regions() which
> returns 0 because no regions exist.
>
> This patch fixes this by registering before and removing after the call
> to e820_end_of_ram().
>

Hey Magnus,

I see what you are doing and why. However if you look in 
arch/x86_64/kernel/setup.c, you'll see

         parse_early_param();

         finish_e820_parsing();

         e820_register_active_regions(0, 0, -1UL);

If you just called e820_register_active_regions(0, 0, -1UL) before 
parse_early_param(), would it still fix the problem without having to call 
e820_register_active_regions(0, 0, -1UL) twice?


> Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
> ---
>
> Applies to 2.6.19-rc4.
>
> arch/x86_64/kernel/e820.c |    2 ++
> 1 file changed, 2 insertions(+)
>
> --- 0002/arch/x86_64/kernel/e820.c
> +++ work/arch/x86_64/kernel/e820.c	2006-11-02 21:37:19.000000000 +0900
> @@ -594,7 +594,9 @@ static int __init parse_memmap_opt(char
> 		 * size before original memory map is
> 		 * reset.
> 		 */
> +		e820_register_active_regions(0, 0, -1UL);
> 		saved_max_pfn = e820_end_of_ram();
> +		remove_all_active_ranges();
> #endif
> 		end_pfn_map = 0;
> 		e820.nr_map = 0;
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
