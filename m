Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265515AbUFCQCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265515AbUFCQCz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUFCQCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:02:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27659 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265554AbUFCQBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:01:44 -0400
Date: Thu, 3 Jun 2004 17:01:37 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Export swapper_space
Message-ID: <20040603170137.E8244@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040603161909.D8244@flint.arm.linux.org.uk> <20040603153727.GA17798@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040603153727.GA17798@infradead.org>; from hch@infradead.org on Thu, Jun 03, 2004 at 04:37:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 04:37:27PM +0100, Christoph Hellwig wrote:
> On Thu, Jun 03, 2004 at 04:19:10PM +0100, Russell King wrote:
> > swapper_space appears to be needed by modules:
> > 
> >   Building modules, stage 2.
> >   MODPOST
> > *** Warning: "swapper_space" [drivers/block/loop.ko] undefined!
> > *** Warning: "swapper_space" [drivers/scsi/st.ko] undefined!
> > *** Warning: "swapper_space" [drivers/scsi/sg.ko] undefined!
> 
> Please not.  This seems to be some cache-flushing magic on the stranger
> architectures again :)  Can you check how they're using it in the end
> and hopefully fix it by uninlining something?

extern struct address_space swapper_space;
static inline struct address_space *page_mapping(struct page *page)
{
        struct address_space *mapping = NULL;
 
        if (unlikely(PageSwapCache(page)))
                mapping = &swapper_space;
        else if (likely(!PageAnon(page)))
                mapping = page->mapping;
        return mapping;
}

I'll leave that for someone else to sort out.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
