Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVEEUOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVEEUOL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 16:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVEETd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:33:58 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:29645 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262196AbVEEStL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 14:49:11 -0400
Message-ID: <427A6A7E.8000604@ammasso.com>
Date: Thu, 05 May 2005 13:48:30 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Timur Tabi <timur.tabi@ammasso.com>
CC: Libor Michalek <libor@topspin.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs
 implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com> <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org> <20050412180447.E6958@topspin.com> <20050425203110.A9729@topspin.com> <4279142A.8050501@ammasso.com>
In-Reply-To: <4279142A.8050501@ammasso.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:

> When you say "older", what exactly do you mean?  I have different test 
> that normally fails with just get_user_pages(), but it works with 2.6.9 
> and above.  I haven't been able to get any kernel earlier than 2.6.9 to 
> compile or boot properly, so I'm having a hard time narrowing down the 
> actual point when get_user_pages() started working.

I haven't gotten a reply to this question, but I've done my own research, and I think I 
found the answer.  Using my own test of get_user_pages(), it appears that the fix was 
placed in 2.6.7.  However, I would like to know specifically what the fix is. 
Unfortunately, tracking this stuff down is beyond my understanding of the Linux VM.

Assuming that the fix is in try_to_unmap_one(), the only significant change I see between
2.6.6 and 2.6.7 is the addition of this code:

	pgd = pgd_offset(mm, address);
	if (!pgd_present(*pgd))
		goto out_unlock;

	pmd = pmd_offset(pgd, address);
	if (!pmd_present(*pmd))
		goto out_unlock;

	pte = pte_offset_map(pmd, address);
	if (!pte_present(*pte))
		goto out_unmap;

	if (page_to_pfn(page) != pte_pfn(*pte))
		goto out_unmap;

Can anyone tell me if this is the actual fix, or at least a major part of the actual fix?

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
