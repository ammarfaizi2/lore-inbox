Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267764AbUHEP50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267764AbUHEP50 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267762AbUHEP5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:57:25 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:57490 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S267758AbUHEP4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:56:52 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Daniel J Blueman <daniel.blueman@quadrics.com>
Subject: Re: pte_modify fix backport...
Date: Thu, 5 Aug 2004 09:56:39 -0600
User-Agent: KMail/1.6.2
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com
References: <1091704431.1829.235.camel@pc107.quadrics.com>
In-Reply-To: <1091704431.1829.235.camel@pc107.quadrics.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408050956.39053.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 5:13 am, Daniel J Blueman wrote:
> This patch [1] corrects the behaviour of pte_modify() on ia64 to not
> clear page protection flags it shouldn't touch.
> 
> Without this patch, it clears the uncacheable flag on UC memory regions,
> which can cause MCAs with device I/O.
> 
> It was taken into 2.6.0 a while ago, but is yet to be included in 2.4 -
> the patch here is rediffed against 2.4.26-rc5.
> 
> Is there chance of it being taken in?

I put this in the 2.4 ia64 BK tree a couple days ago.  Can you check
here: http://lia64.bkbits.net:8080/linux-ia64-2.4 and make sure that
it works for you?

The plain patch is also available here, if that works better for you:
ftp://ftp.kernel.org/pub/linux/kernel/ports/ia64/v2.4/testing/cset/index.html

> diff -durN linux-2.4.26-rc5-orig/include/asm-ia64/pgtable.h linux-2.4.26-rc5-patched/include/asm-ia64/pgtable.h
> --- linux-2.4.26-rc5-orig/include/asm-ia64/pgtable.h	2004-02-18 13:36:32.000000000 +0000
> +++ linux-2.4.26-rc5-patched/include/asm-ia64/pgtable.h	2004-08-05 11:46:03.000000000 +0100
> @@ -60,7 +60,8 @@
>  #define _PAGE_PROTNONE		(__IA64_UL(1) << 63)
>  
>  #define _PFN_MASK		_PAGE_PPN_MASK
> -#define _PAGE_CHG_MASK		(_PFN_MASK | _PAGE_A | _PAGE_D)
> +/* Mask of bits which may be changed by pte_modify(); the odd bits are there for _PAGE_PROTNONE */
> +#define _PAGE_CHG_MASK		(_PAGE_P | _PAGE_PROTNONE | _PAGE_PL_MASK | _PAGE_AR_MASK | _PAGE_ED)
>  
>  #define _PAGE_SIZE_4K	12
>  #define _PAGE_SIZE_8K	13
> @@ -216,7 +217,7 @@
>  ({ pte_t __pte; pte_val(__pte) = physpage + pgprot_val(pgprot); __pte; })
>  
>  #define pte_modify(_pte, newprot) \
> -	(__pte((pte_val(_pte) & _PAGE_CHG_MASK) | pgprot_val(newprot)))
> +	(__pte((pte_val(_pte) & ~_PAGE_CHG_MASK) | (pgprot_val(newprot) & _PAGE_CHG_MASK)))
>  
>  #define page_pte_prot(page,prot)	mk_pte(page, prot)
>  #define page_pte(page)			page_pte_prot(page, __pgprot(0))
> 
> -- 
> Daniel J Blueman
> Software Engineer, Quadrics Ltd
