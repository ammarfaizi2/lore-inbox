Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269779AbUJMSmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269779AbUJMSmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 14:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269780AbUJMSmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 14:42:13 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:8600 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S269779AbUJMSmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 14:42:11 -0400
Date: Wed, 13 Oct 2004 20:41:53 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 4level page tables for Linux
Message-ID: <20041013184153.GO17849@dualathlon.random>
References: <20041012135919.GB20992@wotan.suse.de> <1097606902.10652.203.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097606902.10652.203.camel@localhost>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 11:48:22AM -0700, Dave Hansen wrote:
> @@ -110,13 +115,18 @@ int install_file_pte(struct mm_struct *m
>                 unsigned long addr, unsigned long pgoff, pgprot_t prot)
>  {
> ...
> +       pml4 = pml4_offset(mm, addr);
> +
> +       spin_lock(&mm->page_table_lock);
> +       pgd = pgd_alloc(mm, pml4, addr);
> +       if (!pgd)
> +               goto err_unlock;
> 
> Locking isn't needed for access to the pml4?  This is a wee bit
> different from pgd's and I didn't see any documentation about it

btw, locking isn't needed even for the pgd.

fremap.c is the only one that gets it right:

	pgd = pgd_offset(mm, addr);
	spin_lock(&mm->page_table_lock);
	pmd = pmd_alloc(mm, pgd, addr);

the rest is just overkill but it doesn't hurt in practice.

after you add the 4level, locking will become necessary for the pgd, but
it's still not needed for the pml4.

I'm not very excited about changing the naming, of the pgd/pmd/pte so I
like to keep it like it is now.

peraphs we could consider pgd4 instead of pml4. What does "pml" stands
for?
