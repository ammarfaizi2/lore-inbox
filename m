Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbVAFTnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbVAFTnI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 14:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbVAFTkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 14:40:12 -0500
Received: from colin2.muc.de ([193.149.48.15]:22283 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262997AbVAFTi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 14:38:27 -0500
Date: 6 Jan 2005 20:38:27 +0100
Date: Thu, 6 Jan 2005 20:38:26 +0100
From: Andi Kleen <ak@muc.de>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, DRI Devel <dri-devel@lists.sourceforge.net>
Subject: Re: chasing the four level page table
Message-ID: <20050106193826.GC47320@muc.de>
References: <9e47339105010609175dabc381@mail.gmail.com> <m1vfaav340.fsf@muc.de> <9e47339105010610362fd7fffe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105010610362fd7fffe@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 01:36:46PM -0500, Jon Smirl wrote:
> On Thu, 06 Jan 2005 19:12:15 +0100, Andi Kleen <ak@muc.de> wrote:
> > Yes, you should use get_user_pages() instead if you access real memory.
> > If you try to find hardware mappings using that there is no ready
> > function for you right now, although I guess it could be added.
> 
> drm_follow_page is used like this:
> 
> offset = drm_follow_page(pt) | ((unsigned long) pt & ~PAGE_MASK);
> map = drm_lookup_map(offset, size, dev);
> if (map && map->type == _DRM_AGP) {
> 	vunmap(pt);
> 	return;
> }
> 
> I think pt is a user space address. In DRM AGP memory is mapped into
> kernel and user space so the user space address is being converted
> into a kernel space one. The kernel space one is used to verify that
> the address is a valid mapping to AGP space, if so the page is
> unmapped.  I didn't write this code so I'm not 100% sure of what is
> going on.

You can't use get_user_pages in this case because the AGP aperture
can be above mem_map.  If none of the callers take page_table_lock
already you would need to add that too. I guess from the context the lock
is not taken, but better double check.

Perhaps we should add a get_user_phys() or somesuch for this.

-Andi

