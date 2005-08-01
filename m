Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVHAWEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVHAWEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 18:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVHAWDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 18:03:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27577 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261309AbVHAWBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 18:01:46 -0400
Date: Mon, 1 Aug 2005 15:01:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>, linux-mm@kvack.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <Pine.LNX.4.58.0508011438450.3341@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0508011455520.3341@g5.osdl.org>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com>
 <42EDDB82.1040900@yahoo.com.au> <20050801091956.GA3950@elte.hu>
 <42EDEAFE.1090600@yahoo.com.au> <20050801101547.GA5016@elte.hu>
 <42EE0021.3010208@yahoo.com.au> <Pine.LNX.4.61.0508012030050.5373@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508011250210.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508012153570.6323@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508011438450.3341@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Aug 2005, Linus Torvalds wrote:
> 
> Of course, if VM_MAYWRITE is not set, you could just convert it silently
> to a MAP_PRIVATE at the VM level (that's literally what we used to do, 
> back when we didn't support writable shared mappings at all, all those 
> years ago), so at least now the COW behaviour would match the vma_flags.

Heh. I just checked. We still do exactly that:

                        if (!(file->f_mode & FMODE_WRITE))
                                vm_flags &= ~(VM_MAYWRITE | VM_SHARED);

some code never dies ;)

However, we still set the VM_MAYSHARE bit, and thats' the one that
mm/rmap.c checks for some reason. I don't see quite why - VM_MAYSHARE
doesn't actually ever do anything else than make sure that we try to
allocate a mremap() mapping in a cache-coherent space, I think (ie it's a
total no-op on any sane architecture, and as far as rmap is concerned on
all of them).

		Linus
