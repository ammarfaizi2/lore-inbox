Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVAECPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVAECPT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVAECPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:15:18 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:44398 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262196AbVAECPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:15:12 -0500
Message-ID: <41DB4DAC.8060606@yahoo.com.au>
Date: Wed, 05 Jan 2005 13:15:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Exclude PUD/PMD alloc functions if !MMU
References: <17892.1104868588@redhat.com>
In-Reply-To: <17892.1104868588@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Don't declare pud_alloc() and pmd_alloc() if a nommu kernel is being
> compiled. These functions require various things that aren't defined for
> nommu.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> warthog>diffstat nommu-exclusions-2610mm1.diff 
>  mm.h |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -uNrp /warthog/kernels/linux-2.6.10-mm1/include/linux/mm.h linux-2.6.10-mm1-frv/include/linux/mm.h
> --- /warthog/kernels/linux-2.6.10-mm1/include/linux/mm.h	2005-01-04 11:15:27.000000000 +0000
> +++ linux-2.6.10-mm1-frv/include/linux/mm.h	2005-01-04 17:39:56.462745022 +0000
> @@ -668,7 +668,7 @@ extern void remove_shrinker(struct shrin
>   * The following ifdef needed to get the 4level-fixup.h header to work.
>   * Remove it when 4level-fixup.h has been removed.
>   */
> -#ifndef __ARCH_HAS_4LEVEL_HACK 
> +#if defined(CONFIG_MMU) && !defined(__ARCH_HAS_4LEVEL_HACK)
>  static inline pud_t *pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
>  {
>  	if (pgd_none(*pgd))

I think you need to do it in the following way:

#ifdef CONFIG_MMU
#ifndef __ARCH_HAS_4LEVEL_HACK
static inline pud_t *pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
{
          if (pgd_none(*pgd))
...
#else /* __ARCH_HAS_4LEVEL_HACK */
...
#endif /* __ARCH_HAS_4LEVEL_HACK */
#endif /* CONFIG_MMU */

No?
