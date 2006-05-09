Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWEIRoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWEIRoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 13:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWEIRoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 13:44:20 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:169 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1750788AbWEIRoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 13:44:19 -0400
Date: Tue, 9 May 2006 18:44:11 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 08/35] Add Xen-specific memory management definitions
Message-ID: <20060509174411.GN7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085151.047254000@sous-sol.org> <4460AC09.8030208@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4460AC09.8030208@mbligh.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 07:49:45AM -0700, Martin J. Bligh wrote:
> 
> >+#define virt_to_ptep(__va)						\
> >+({									\
> >+	pgd_t *__pgd = pgd_offset_k((unsigned long)(__va));		\
> >+	pud_t *__pud = pud_offset(__pgd, (unsigned long)(__va));	\
> >+	pmd_t *__pmd = pmd_offset(__pud, (unsigned long)(__va));	\
> >+	pte_offset_kernel(__pmd, (unsigned long)(__va));		\
> >+})
> 
> Do we really need yet another function to do this?
> Especially one in a mult-line #define instead of a real function call,
> and that doesn't seem to error check at each step?

Indeed, I'll use lookup_address instead.

> >+
> >+#define arbitrary_virt_to_machine(__va)				 \
> >+({									\
> >+	maddr_t m = (maddr_t)pte_mfn(*virt_to_ptep(__va)) << PAGE_SHIFT;\
> >+	m | ((unsigned long)(__va) & (PAGE_SIZE-1));			\
> >+})
> >+
> >+#define make_lowmem_page_readonly(va, feature) do {		\
> >+	pte_t *pte;						\
> >+	int rc;							\
> >+								\
> >+	if (xen_feature(feature))				\
> >+		return;						\
> >+								\
> >+	pte = virt_to_ptep(va);					\
> >+	rc = HYPERVISOR_update_va_mapping(			\
> >+		(unsigned long)va, pte_wrprotect(*pte), 0);	\
> >+	BUG_ON(rc);						\
> >+} while (0)
> 
> Things this long should definitely not be #defines.

I've changed these to be functions and moved them into a .c file
under arch/i386/mach-xen.

    christian

