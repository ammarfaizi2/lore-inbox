Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266205AbUF3FRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266205AbUF3FRx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 01:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUF3FRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 01:17:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9118 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265902AbUF3FRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 01:17:43 -0400
Date: Tue, 29 Jun 2004 22:17:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: wesolows@foobazco.org, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org,
       wesolows@foobazco.org
Subject: Re: A question about PROT_NONE on Sparc and Sparc64
Message-Id: <20040629221711.77f0fca5.davem@redhat.com>
In-Reply-To: <20040630030503.GA25149@mail.shareable.org>
References: <20040630030503.GA25149@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2004 04:05:03 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> In include/asm-sparc64/pgtable.h, there's:
> 
> #define __ACCESS_BITS   (_PAGE_ACCESSED | _PAGE_READ | _PAGE_R)
> #define PAGE_NONE       __pgprot (_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_CACHE)
> #define PAGE_READONLY   __pgprot (_PAGE_PRESENT | _PAGE_VALID | _PAGE_CACHE | \
>                                   __ACCESS_BITS)
> 
> PAGE_NONE has the hardware _PAGE_PRESENT bit set.  However unlike
> PAGE_READONLY, it doesn't have the hardware _PAGE_R and software
> _PAGE_READ bits.
> 
> I guess that means that PAGE_NONE pages aren't readable from
> userspace.  Presumably the TLB handler takes care of it.
> Does it prevent reads from kernel space as well?

Neither user nor kernel can get at that page.  If _PAGE_R is not set
we get a real fault no matter who attempts the access.

> I.e. can you confirm that write() won't succeed in reading the data
> from a PROT_NONE page on Sparc64?  I think that's probably the case.
> You'll see why I ask, from the next one:

That's correct.

> In include/asm-sparc/pgtsrmmu.h, there's:
> 
> #define SRMMU_PAGE_NONE    __pgprot(SRMMU_VALID | SRMMU_CACHE | \
> 				    SRMMU_PRIV | SRMMU_REF)
> #define SRMMU_PAGE_RDONLY  __pgprot(SRMMU_VALID | SRMMU_CACHE | \
> 				    SRMMU_EXEC | SRMMU_REF)
> 
> This one bothers me.  The difference is that PROT_NONE pages are not
> accessible to userspace, and not executable.
> 
> So userspace will get a fault if it tries to read a PROT_NONE page.
> 
> But what happens when the kernel reads one?  Don't those bits mean
> that the read will succeed?  I.e. write() on a PROT_NONE page will
> succeed, instead of returning EFAULT?
> 
> If so, this is a bug.  A minor bug, perhaps, but nonetheless I wish to
> document it.

Yes this one is a bug and not intentional.

Keith W., we need to fix this.  Probably the simplest fix is just to
drop the SRMMU_VALID bit.

> Alternatively, perhaps in this case simply omitting the SRMMU_REF bit
> would be enough?  Would that cause the TLB handler to be entered, and
> the TLB handler could then refuse access?  Again, I don't know enough
> about Sparc to say more.

No, if it's SRMMU_VALID the hardware lets the translation succeed and
like on x86 the hardware does the page table walk and thus the SRMMU_REF
bit setting.
