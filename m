Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbVH1Vml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVH1Vml (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 17:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVH1Vml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 17:42:41 -0400
Received: from smtpout.mac.com ([17.250.248.88]:43224 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750838AbVH1Vmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 17:42:40 -0400
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3B0AEB5C-4A65-413F-BD35-B9F0E0984653@mac.com>
Cc: Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Why is kmem_bufctl_t different across platforms?
Date: Sun, 28 Aug 2005 17:42:36 -0400
To: LKML <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While exploring the asm-*/types.h files, I discovered that the
type "kmem_bufctl_t" is differently defined across each platform,
sometimes as a short, and sometimes as an int.  The only file
where it's used is mm/slab.c, and as far as I can tell, that file
doesn't care at all, aside from preferring it to be a small-sized
type.  I found this comment:

> /*
>  * kmem_bufctl_t:
>  *
>  * Bufctl's are used for linking objs within a slab
>  * linked offsets.
>  *
>  * This implementation relies on "struct page" for locating the  
> cache &
>  * slab an object belongs to.
>  * This allows the bufctl structure to be small (one int), but limits
>  * the number of objects a slab (not a cache) can contain when off- 
> slab
>  * bufctls are used. The limit is the size of the largest general  
> cache
>  * that does not use off-slab slabs.
>  * For 32bit archs with 4 kB pages, is this 56.
>  * This is not serious, as it is only for large objects, when it is  
> unwise
>  * to have too many per slab.
>  * Note: This limit can be raised by introducing a general cache  
> whose size
>  * is less than 512 (PAGE_SIZE<<3), but greater than 256.
>  */

It appears to state that the max kmem_bufctl_t value is ~56 on most
setups, although it could be higher with 64-bit or bigger pages.
Since this value is never used by anything except that kernel-internal
file, should it be unified across all architectures?  If so, I'll send
a patch to remove the various typedefs and introduce a single
"typedef unsigned short kmem_bufctl_t" in include/linux/types.h

Cheers,
Kyle Moffett

--
Premature optimization is the root of all evil in programming
   -- C.A.R. Hoare



