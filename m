Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262973AbVAFSk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbVAFSk7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVAFSi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 13:38:26 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:22983 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262985AbVAFSgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 13:36:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=LlwOEJ8EIr3jbfrJUEJSQvPA7oS8YmBrWS9ZsBZ/we74BbdfgcCaLwQDeZ4c0FhgBNOyVUuI6yBzE8+aw1huDo9iNG1HvrW+sReNbxg8pb01Y1qEm8WadrP/4zWAU5ib1Y/NgxffD49kkP2pbDKBWJk3LJGJ+yU1EkYvKl5kjIU=
Message-ID: <9e47339105010610362fd7fffe@mail.gmail.com>
Date: Thu, 6 Jan 2005 13:36:46 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: chasing the four level page table
Cc: linux-kernel@vger.kernel.org, DRI Devel <dri-devel@lists.sourceforge.net>
In-Reply-To: <m1vfaav340.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105010609175dabc381@mail.gmail.com> <m1vfaav340.fsf@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2005 19:12:15 +0100, Andi Kleen <ak@muc.de> wrote:
> Yes, you should use get_user_pages() instead if you access real memory.
> If you try to find hardware mappings using that there is no ready
> function for you right now, although I guess it could be added.

drm_follow_page is used like this:

offset = drm_follow_page(pt) | ((unsigned long) pt & ~PAGE_MASK);
map = drm_lookup_map(offset, size, dev);
if (map && map->type == _DRM_AGP) {
	vunmap(pt);
	return;
}

I think pt is a user space address. In DRM AGP memory is mapped into
kernel and user space so the user space address is being converted
into a kernel space one. The kernel space one is used to verify that
the address is a valid mapping to AGP space, if so the page is
unmapped.  I didn't write this code so I'm not 100% sure of what is
going on.

On Thu, 06 Jan 2005 19:12:15 +0100, Andi Kleen <ak@muc.de> wrote:
> Jon Smirl <jonsmirl@gmail.com> writes:
> 
> > The DRM driver contains this routine:
> >
> > drivers/char/drm/drm_memory.h
> >
> > static inline unsigned long
> > drm_follow_page (void *vaddr)
> > {
> >       pgd_t *pgd = pgd_offset_k((unsigned long) vaddr);
> >       pud_t *pud = pud_offset(pgd, (unsigned long) vaddr);
> >       pmd_t *pmd = pmd_offset(pud, (unsigned long) vaddr);
> >       pte_t *ptep = pte_offset_kernel(pmd, (unsigned long) vaddr);
> >       return pte_pfn(*ptep) << PAGE_SHIFT;
> > }
> >
> > No other driver needs to chase the page table like this so there is
> > probably some other way to achieve this. Can someone who knows more
> > about the VM system tell me if there is a way to eliminate this code?
> 
> Yes, you should use get_user_pages() instead if you access real memory.
> If you try to find hardware mappings using that there is no ready
> function for you right now, although I guess it could be added.
> 
> The function is also not quite correct, it should already least take
> the page_table_lock (depending on where you call it from) and check
> p*_none() on each level.
> 
> -Andi
> 

-- 
Jon Smirl
jonsmirl@gmail.com
