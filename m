Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267278AbUIAQ5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbUIAQ5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUIAQzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 12:55:05 -0400
Received: from omx3-ext.SGI.COM ([192.48.171.20]:2482 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267341AbUIAQua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 12:50:30 -0400
Date: Wed, 1 Sep 2004 09:50:17 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: linux-kernel@vger.kernel.org, linux-ppc@vger.kernel.org
Subject: Re: page fault scalability patch: Need help/testing for x86_64,
 s390, ppc and ppc64
In-Reply-To: <20040901120946.GA2851@mschwid3.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.58.0409010944450.9907@schroedinger.engr.sgi.com>
References: <20040901120946.GA2851@mschwid3.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2004, Martin Schwidefsky wrote:

> Hi Christoph,
>
> > If you are in posssession of or are a kernel developer for x86_64, s390,
> > ppc or ppc64 then please review the relevant arch specific portions and
> > after fixing up my stuff please test and see if this actually works on
> > your platform.
>
> Well, the patch didn't apply on 2.6.8, 2.6.9-rc1 or BitKeeper. Please
> recreate on a defined kernel level.

It applies to 2.6.9-rc1-mm1. Sorry for not clarifying that.

> So far ptep_get_and_clear is called with the page table lock held. That
> means that you don't have to protect yourself against concurrent updates
> of a pte on different processors. The only thing you need to ensure is
> that the update of a pte is atomic in the sense that a page table walk
> by the hardware either sees the new or the old value.
> Without the page table lock all of a sudden you have to make sure that
> the sequence of the get and the clear is atomic, otherwise you have a
> race on a SMP system. That means that you have to implement ptep_xchg
> using an atomic instruction. You can't just read and store the pte like
> you do in your patch. Use xchg. And I fear that there are other subtle
> races as well if you remove the page table lock.
>
> > pgalloc.h: pgd_test_and_populate, pmd_test_and_populate.
>
> One of the problems with you patch is that on s/390 you can't do an atomic
> update of a page middle directory (pmd). On 64 bit there are two 8 byte
> words and on 31 bit there are four 4 bytes words that need to be modified
> for a single pmd entry. You need to use the page table lock to update pmds.
> Another problem is that an invalid PTE/PMD does not equal 0. For invalid,
> empty ptes the value is _PAGE_INVALID_EMPTY and for invalid, empty pmds the
> value is _PAGE_TABLE_INV for 31 bit and _PMD_ENTRY_INV for 64 bit.

We could acquire the page_table_lock in ptep_get_and_clear etc itself.
That would restore the old situation for those routines but also limit
the time the page_table_lock is held to an absolute minimum.

> > One note on S/390: It seems that ptep_test_and_clear does not use an
> > atomic operation. Is this correct? I have implemenmted the ptep_xchg
> > on S/390 also with non-atomic operations. Maybe for some unknown reason
> > (cannot imagine but ??) there is no need for atomic exchange operations
> > for ptes?
>
> Last time I looked there wasn't a ptep function called ptep_test_and_clear.
> If you are refering to ptep_get_and_clear aka pte_clear, on s/390 the store
> of a single word is atomic. I checked that the compiler really generates
> store instructions ("ST"/"STG") to write something to a ptep pointer.

The get and the clear are not atomic like on other platforms. So s390
is also relying on the page_table_lock there.

> P.S. You should send patches against the memory management to the linux-mm
> list.

Ok. Will post the next release to that list.
