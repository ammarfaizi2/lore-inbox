Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265807AbUGAPEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265807AbUGAPEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 11:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265811AbUGAPEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 11:04:44 -0400
Received: from mail.shareable.org ([81.29.64.88]:65453 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265807AbUGAPEm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 11:04:42 -0400
Date: Thu, 1 Jul 2004 16:04:30 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Do x86 NX and AMD prefetch check cause page fault infinite loop?
Message-ID: <20040701150430.GB5114@mail.shareable.org>
References: <20040630013824.GA24665@mail.shareable.org> <20040630055041.GA16320@elte.hu> <20040630143850.GF29285@mail.shareable.org> <20040701014818.GE32560@mail.shareable.org> <20040701063237.GA16166@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701063237.GA16166@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> -#ifdef CONFIG_X86_PAE
> -	{
> -		pgd_t *pgd;
> -		pmd_t *pmd;
> -		pgd = init_mm.pgd + pgd_index(address);
> -		if (pgd_present(*pgd)) {
> -			pmd = pmd_offset(pgd, address);
> -			if (pmd_val(*pmd) & _PAGE_NX)
> -				printk(KERN_CRIT "kernel tried to access NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
> -		}
> -	}
> -#endif
> +	if (nx_enabled && (error_code & 16))
> +		printk(KERN_CRIT "kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n", current->uid);

According to AMD's manual, bit 4 of error_code means the fault was due
to an instruction fetch.  It doesn't imply that it's an NX-protected
page: it might be a page not present fault instead.  (The manual
doesn't spell that out, it just says the bit is set when it's an
instruction fetch).

Just so you realise that the above code fragments aren't logically
equivalent.

-- Jamie
