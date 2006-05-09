Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWEIOuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWEIOuT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWEIOuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:50:12 -0400
Received: from dvhart.com ([64.146.134.43]:483 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751773AbWEIOtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:49:52 -0400
Message-ID: <4460AC09.8030208@mbligh.org>
Date: Tue, 09 May 2006 07:49:45 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 08/35] Add Xen-specific memory management definitions
References: <20060509084945.373541000@sous-sol.org> <20060509085151.047254000@sous-sol.org>
In-Reply-To: <20060509085151.047254000@sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +#define virt_to_ptep(__va)						\
> +({									\
> +	pgd_t *__pgd = pgd_offset_k((unsigned long)(__va));		\
> +	pud_t *__pud = pud_offset(__pgd, (unsigned long)(__va));	\
> +	pmd_t *__pmd = pmd_offset(__pud, (unsigned long)(__va));	\
> +	pte_offset_kernel(__pmd, (unsigned long)(__va));		\
> +})

Do we really need yet another function to do this?
Especially one in a mult-line #define instead of a real function call,
and that doesn't seem to error check at each step?

> +
> +#define arbitrary_virt_to_machine(__va)					\
> +({									\
> +	maddr_t m = (maddr_t)pte_mfn(*virt_to_ptep(__va)) << PAGE_SHIFT;\
> +	m | ((unsigned long)(__va) & (PAGE_SIZE-1));			\
> +})
> +
> +#define make_lowmem_page_readonly(va, feature) do {		\
> +	pte_t *pte;						\
> +	int rc;							\
> +								\
> +	if (xen_feature(feature))				\
> +		return;						\
> +								\
> +	pte = virt_to_ptep(va);					\
> +	rc = HYPERVISOR_update_va_mapping(			\
> +		(unsigned long)va, pte_wrprotect(*pte), 0);	\
> +	BUG_ON(rc);						\
> +} while (0)

Things this long should definitely not be #defines.
