Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVCJDaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVCJDaG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 22:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVCJD1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 22:27:32 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:36093 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262383AbVCJD0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 22:26:23 -0500
Date: Wed, 9 Mar 2005 21:22:13 -0600
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org, paulus@samba.org,
       linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/2] No-exec support for ppc64
Message-ID: <20050310032213.GB20789@austin.ibm.com>
References: <20050308165904.0ce07112.moilanen@austin.ibm.com> <20050308170826.13a2299e.moilanen@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308170826.13a2299e.moilanen@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040523i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 05:08:26PM -0600, Jake Moilanen wrote:
> No-exec base and user space support for PPC64.  

Hi, a couple of comments below.


-Olof

> @@ -786,6 +786,7 @@ int hash_huge_page(struct mm_struct *mm,
>  	pte_t old_pte, new_pte;
>  	unsigned long hpteflags, prpn;
>  	long slot;
> +	int is_exec;
>  	int err = 1;
>  
>  	spin_lock(&mm->page_table_lock);
> @@ -796,6 +797,10 @@ int hash_huge_page(struct mm_struct *mm,
>  	va = (vsid << 28) | (ea & 0x0fffffff);
>  	vpn = va >> HPAGE_SHIFT;
>  
> +	is_exec = access & _PAGE_EXEC;
> +	if (unlikely(is_exec && !(pte_val(*ptep) & _PAGE_EXEC)))
> +		goto out;

You only use is_exec this one time, you can probably skip it and just
add the mask in the if statement.

> @@ -898,6 +908,7 @@ repeat:
>  	err = 0;
>  
>   out:
> +
>  	spin_unlock(&mm->page_table_lock);

Whitespace change

> diff -puN include/asm-ppc64/pgtable.h~nx-user-ppc64 include/asm-ppc64/pgtable.h
> --- linux-2.6-bk/include/asm-ppc64/pgtable.h~nx-user-ppc64	2005-03-08 16:08:54 -06:00
> +++ linux-2.6-bk-moilanen/include/asm-ppc64/pgtable.h	2005-03-08 16:08:54 -06:00
> @@ -82,14 +82,14 @@
>  #define _PAGE_PRESENT	0x0001 /* software: pte contains a translation */
>  #define _PAGE_USER	0x0002 /* matches one of the PP bits */
>  #define _PAGE_FILE	0x0002 /* (!present only) software: pte holds file offset */
> -#define _PAGE_RW	0x0004 /* software: user write access allowed */
> +#define _PAGE_EXEC	0x0004 /* No execute on POWER4 and newer (we invert) */

Good to see the comment there, I remember we talked about that earlier.
It can be somewhat confusing. :-)

>  #define _PAGE_GUARDED	0x0008
>  #define _PAGE_COHERENT	0x0010 /* M: enforce memory coherence (SMP systems) */
>  #define _PAGE_NO_CACHE	0x0020 /* I: cache inhibit */
>  #define _PAGE_WRITETHRU	0x0040 /* W: cache write-through */
>  #define _PAGE_DIRTY	0x0080 /* C: page changed */
>  #define _PAGE_ACCESSED	0x0100 /* R: page referenced */
> -#define _PAGE_EXEC	0x0200 /* software: i-cache coherence required */
> +#define _PAGE_RW	0x0200 /* software: user write access allowed */
>  #define _PAGE_HASHPTE	0x0400 /* software: pte has an associated HPTE */
>  #define _PAGE_BUSY	0x0800 /* software: PTE & hash are busy */ 
>  #define _PAGE_SECONDARY 0x8000 /* software: HPTE is in secondary group */
> @@ -100,7 +100,7 @@
>  /* PAGE_MASK gives the right answer below, but only by accident */
>  /* It should be preserving the high 48 bits and then specifically */
>  /* preserving _PAGE_SECONDARY | _PAGE_GROUP_IX */
> -#define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_HPTEFLAGS)
> +#define _PAGE_CHG_MASK (_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | _PAGE_WRITETHRU | _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_HPTEFLAGS | PAGE_MASK)

Can you break it into 80 columns with \ ?

