Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262931AbVAFSQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbVAFSQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbVAFSOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 13:14:22 -0500
Received: from one.firstfloor.org ([213.235.205.2]:14779 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262932AbVAFSMT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 13:12:19 -0500
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: chasing the four level page table
References: <9e47339105010609175dabc381@mail.gmail.com>
From: Andi Kleen <ak@muc.de>
Date: Thu, 06 Jan 2005 19:12:15 +0100
In-Reply-To: <9e47339105010609175dabc381@mail.gmail.com> (Jon Smirl's
 message of "Thu, 6 Jan 2005 12:17:33 -0500")
Message-ID: <m1vfaav340.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@gmail.com> writes:

> The DRM driver contains this routine:
>
> drivers/char/drm/drm_memory.h
>
> static inline unsigned long
> drm_follow_page (void *vaddr)
> {
> 	pgd_t *pgd = pgd_offset_k((unsigned long) vaddr);
> 	pud_t *pud = pud_offset(pgd, (unsigned long) vaddr);
> 	pmd_t *pmd = pmd_offset(pud, (unsigned long) vaddr);
> 	pte_t *ptep = pte_offset_kernel(pmd, (unsigned long) vaddr);
> 	return pte_pfn(*ptep) << PAGE_SHIFT;
> }
>
> No other driver needs to chase the page table like this so there is
> probably some other way to achieve this. Can someone who knows more
> about the VM system tell me if there is a way to eliminate this code?

Yes, you should use get_user_pages() instead if you access real memory.
If you try to find hardware mappings using that there is no ready
function for you right now, although I guess it could be added.

The function is also not quite correct, it should already least take
the page_table_lock (depending on where you call it from) and check
p*_none() on each level.

-Andi
