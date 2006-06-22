Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161082AbWFVLeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161082AbWFVLeQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWFVLeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:34:15 -0400
Received: from [213.46.243.16] ([213.46.243.16]:33102 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161082AbWFVLeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:34:14 -0400
Subject: Re: [PATCH 1/6] mm: tracking shared dirty pages
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, hugh@veritas.com,
       dhowells@redhat.com, christoph@lameter.com, mbligh@google.com,
       npiggin@suse.de, torvalds@osdl.org
In-Reply-To: <20060621225639.4c8bad93.akpm@osdl.org>
References: <20060619175243.24655.76005.sendpatchset@lappy>
	 <20060619175253.24655.96323.sendpatchset@lappy>
	 <20060621225639.4c8bad93.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 13:33:51 +0200
Message-Id: <1150976031.15744.122.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 22:56 -0700, Andrew Morton wrote:
> On Mon, 19 Jun 2006 19:52:53 +0200

> > +		vma->vm_page_prot =
> > +			__pgprot(pte_val
> > +				(pte_wrprotect
> > +				 (__pte(pgprot_val(vma->vm_page_prot)))));
> > +
> 
> Is there really no simpler way?

	pgprot_t prot_shared = protection_map[vm_flags & 
		(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
	pgprot_t prot_priv = protection_map[vm_flags & 
		(VM_READ|VM_WRITE|VM_EXEC)];

	typeof(pgprot_val(prot_shared)) mask = 
		~(pgprot_val(prot_shared) ^ pgprot_val(prot_priv));

	pgprot_val(vma->vm_page_prot) &= mask;
	pgprot_val(vma->vm_page_prot) |= 
		(pgprot_val(prot_priv) & mask);

its more readable, but barely so.

BTW, is there a difference between:
  (VM_READ|VM_WRITE|VM_EXEC)
and
  (VM_READ|VM_EXEC|VM_SHARED)
in this context?

Or I can make it a generic arch specific function and override for i386
and x86-64. That way I can also cleanup drivers/char/drm/drm_vm.c where
I found this thing.

include/asm-generic/pgtable.h

#ifndef __HAVE_ARCH_PGPROT_WRPROTECT
#define pgprot_wrprotect(prot) \
({ (prot) = __pgprot(pte_val \
		(pte_wrprotect	\
		(__pte(pgprot_val(prot))))) \
})
#endif

include/asm-{i386,x86-64}/pgtable.h

#define pgprot_wrprotect(prot) ({ pgprot_val(prot) &= ~_PAGE_RW; })
#define __HAVE_ARCH_PGPROT_WRPROTECT

I can go through some other archs and see what I can do.

Hmm, now that I look at this, might give a include-dependency problem.
Awell, thoughts, comments?

