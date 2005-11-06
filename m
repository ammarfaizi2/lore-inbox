Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVKFIfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVKFIfT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVKFIfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:35:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48320 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932334AbVKFIfQ (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 03:35:16 -0500
Subject: Re: [patch 2/14] mm: pte prefetch
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
In-Reply-To: <436DBCE2.4050502@yahoo.com.au>
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au>
	 <436DBCE2.4050502@yahoo.com.au>
Content-Type: text/plain
Date: Sun, 06 Nov 2005 09:35:01 +0100
Message-Id: <1131266102.2826.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-06 at 19:20 +1100, Nick Piggin wrote:
> 2/14
> 
> plain text document attachment (mm-pte-prefetch.patch)
> Prefetch ptes a line ahead. Worth 25% on ia64 when doing big forks.
> 
> Index: linux-2.6/include/asm-generic/pgtable.h
> ===================================================================
> --- linux-2.6.orig/include/asm-generic/pgtable.h
> +++ linux-2.6/include/asm-generic/pgtable.h
> @@ -196,6 +196,33 @@ static inline void ptep_set_wrprotect(st
>  })
>  #endif
>  
> +#ifndef __HAVE_ARCH_PTE_PREFETCH
> +#define PTES_PER_LINE (L1_CACHE_BYTES / sizeof(pte_t))
> +#define PTE_LINE_MASK (~(PTES_PER_LINE - 1))
> +#define ADDR_PER_LINE (PTES_PER_LINE << PAGE_SHIFT)
> +#define ADDR_LINE_MASK (~(ADDR_PER_LINE - 1))
> +
> +#define pte_prefetch(pte, addr, end)					\
> +({									\
> +	unsigned long __nextline = ((addr) + ADDR_PER_LINE) & ADDR_LINE_MASK; \
> +	if (__nextline < (end))						\
> +		prefetch(pte + PTES_PER_LINE);				\
> +})
> +

are you sure this is right? at least on pc's having a branch predictor
miss is very expensive and might well be more expensive than the gain
you get from a prefetch


