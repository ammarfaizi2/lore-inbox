Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVAVLsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVAVLsN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 06:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbVAVLsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 06:48:13 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:26759 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262703AbVAVLsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 06:48:09 -0500
Message-ID: <41F23D74.9080606@yahoo.com.au>
Date: Sat, 22 Jan 2005 22:48:04 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Zou Nan hai <nanhai.zou@intel.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Patch]Fix an error in copy_page_range
References: <1106199886.9401.19.camel@linux-znh>
In-Reply-To: <1106199886.9401.19.camel@linux-znh>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zou Nan hai wrote:
> Hi, 
> 
> There is a bug in copy_page_range in current 2.6.11-rc1 with 4 level
> page table change. copy_page_range do a continue without adding pgds and
> addr when pgd_none(*src_pgd) or pgd_bad(*src_pgd).
> 
> I think it's wrong in logic, copy_page_range will run into infinite loop
> when when pgd_none(*src_pgd) or pgd_bad(*src_pgd).
> 
> Although maybe this bug does not break anything currently..., 
> 
> 
> Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>
> 
> --- a/mm/memory.c	2005-01-21 01:21:18.000000000 +0800
> +++ b/mm/memory.c	2005-01-21 04:49:13.000000000 +0800
> @@ -442,17 +442,18 @@ int copy_page_range(struct mm_struct *ds
>  		if (next > end || next <= addr)
>  			next = end;
>  		if (pgd_none(*src_pgd))
> -			continue;
> +			goto next_pgd;
>  		if (pgd_bad(*src_pgd)) {
>  			pgd_ERROR(*src_pgd);
>  			pgd_clear(src_pgd);
> -			continue;
> +			goto next_pgd;
>  		}
>  		err = copy_pud_range(dst, src, dst_pgd, src_pgd,
>  							vma, addr, next);
>  		if (err)
>  			break;
>  
> +next_pgd:
>  		src_pgd++;
>  		dst_pgd++;
>  		addr = next;
> 
> 
> 

This looks right to me. Andrew and/or Linus, did this get picked up?

