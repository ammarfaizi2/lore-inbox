Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290695AbSARTDE>; Fri, 18 Jan 2002 14:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290633AbSARTCy>; Fri, 18 Jan 2002 14:02:54 -0500
Received: from altus.drgw.net ([209.234.73.40]:44809 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S290668AbSARTCq>;
	Fri, 18 Jan 2002 14:02:46 -0500
Date: Fri, 18 Jan 2002 13:02:09 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        Gerard Roudier <groudier@free.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>,
        Dan Malek <dan@embeddededge.com>, mattl@mvista.com
Subject: pci_alloc_consistent from interrupt == BAD
Message-ID: <20020118130209.J14725@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow the docs in DMA-mappings.txt say pci_alloc_consistent is allowed from 
interrupt, but this is a "bad thing" on at least arm and PPC non-cache 
coherent cpus.

On these cpus we have to allocate page tables for consistent_alloc.. I really 
dont' think we want to be doing this during interrupt context.

This also causes the sym53c8xx_2 driver to not work on some embedded ppc 4xx 
boards, and in general, seems to be a 'bad thing' to allow.

For example, in the arch/arm/consistent.c:

/*
 * This allocates one page of cache-coherent memory space and returns
 * both the virtual and a "dma" address to that space.  It is not clear
 * whether this could be called from an interrupt context or not.  For
 * now, we expressly forbid it, especially as some of the stuff we do
 * here is not interrupt context safe.
 *
 * Note that this does *not* zero the allocated area!
 */
void *consistent_alloc(int gfp, size_t size, dma_addr_t *dma_handle)

(arm's pci_alloc_consistent always calls consistent_alloc).

The PPC version calls a similiar function when CONFIG_NOT_COHERENT_CACHE is 
defined. On 'regular' ppc machines, it's just a __get_free_pages, which is 
why no one from the pmac crowd has screamed.


-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
