Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267773AbUHEQ2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267773AbUHEQ2b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267775AbUHEQ2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:28:31 -0400
Received: from qserv01.quadrics.com ([194.202.174.11]:19898 "EHLO
	qserv01.quadrics.com") by vger.kernel.org with ESMTP
	id S267772AbUHEQ2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:28:00 -0400
Subject: Re: pte_modify fix backport...
From: Daniel J Blueman <daniel.blueman@quadrics.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com
In-Reply-To: <200408050956.39053.bjorn.helgaas@hp.com>
References: <1091704431.1829.235.camel@pc107.quadrics.com>
	 <200408050956.39053.bjorn.helgaas@hp.com>
Content-Type: text/plain
Organization: Quadrics Ltd
Message-Id: <1091722911.1829.247.camel@pc107.quadrics.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 Aug 2004 17:21:51 +0100
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Aug 2004 16:16:31.0015 (UTC) FILETIME=[918D2370:01C47B07]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-05 at 16:56, Bjorn Helgaas wrote:
> On Thursday 05 August 2004 5:13 am, Daniel J Blueman wrote:
> > This patch [1] corrects the behaviour of pte_modify() on ia64 to not
> > clear page protection flags it shouldn't touch.
> > 
> > Without this patch, it clears the uncacheable flag on UC memory regions,
> > which can cause MCAs with device I/O.
> > 
> > It was taken into 2.6.0 a while ago, but is yet to be included in 2.4 -
> > the patch here is rediffed against 2.4.26-rc5.
> > 
> > Is there chance of it being taken in?
> 
> I put this in the 2.4 ia64 BK tree a couple days ago.  Can you check
> here: http://lia64.bkbits.net:8080/linux-ia64-2.4 and make sure that
> it works for you?
> 
> The plain patch is also available here, if that works better for you:
> ftp://ftp.kernel.org/pub/linux/kernel/ports/ia64/v2.4/testing/cset/index.html
> 
> > diff -durN linux-2.4.26-rc5-orig/include/asm-ia64/pgtable.h linux-2.4.26-rc5-patched/include/asm-ia64/pgtable.h
> > --- linux-2.4.26-rc5-orig/include/asm-ia64/pgtable.h	2004-02-18 13:36:32.000000000 +0000
> > +++ linux-2.4.26-rc5-patched/include/asm-ia64/pgtable.h	2004-08-05 11:46:03.000000000 +0100
> > @@ -60,7 +60,8 @@
> >  #define _PAGE_PROTNONE		(__IA64_UL(1) << 63)
> >  
> >  #define _PFN_MASK		_PAGE_PPN_MASK
> > -#define _PAGE_CHG_MASK		(_PFN_MASK | _PAGE_A | _PAGE_D)
> > +/* Mask of bits which may be changed by pte_modify(); the odd bits are there for _PAGE_PROTNONE */
> > +#define _PAGE_CHG_MASK		(_PAGE_P | _PAGE_PROTNONE | _PAGE_PL_MASK | _PAGE_AR_MASK | _PAGE_ED)
> >  
> >  #define _PAGE_SIZE_4K	12
> >  #define _PAGE_SIZE_8K	13
> > @@ -216,7 +217,7 @@
> >  ({ pte_t __pte; pte_val(__pte) = physpage + pgprot_val(pgprot); __pte; })
> >  
> >  #define pte_modify(_pte, newprot) \
> > -	(__pte((pte_val(_pte) & _PAGE_CHG_MASK) | pgprot_val(newprot)))
> > +	(__pte((pte_val(_pte) & ~_PAGE_CHG_MASK) | (pgprot_val(newprot) & _PAGE_CHG_MASK)))
> >  
> >  #define page_pte_prot(page,prot)	mk_pte(page, prot)
> >  #define page_pte(page)			page_pte_prot(page, __pgprot(0))

Bjorn,

The two changesets are good. Thanks!
-- 
Daniel J Blueman
Software Engineer, Quadrics Ltd

