Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbULTR7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbULTR7v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 12:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbULTR7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 12:59:50 -0500
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:45517 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S261592AbULTR4l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 12:56:41 -0500
Date: Mon, 20 Dec 2004 19:56:35 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Message-ID: <20041220175635.GC7459@m.safari.iki.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <037BE7456155544096945D871C4709AA01A99EB3@ausx2kmps318.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <037BE7456155544096945D871C4709AA01A99EB3@ausx2kmps318.aus.amer.dell.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 10:46:48AM -0600, Robert_Hentosh@Dell.com wrote:
> 
> 
> > On Mon, 20 Dec 2004, Rik van Riel wrote:
> >
> >> Simply running "dd if=/dev/zero of=/dev/hd<one you can miss>"
> >> will result in OOM kills, with the dirty pagecache
> >> completely filling up lowmem.  This patch is part 1 to
> >> fixing that problem.
> >
> > What I forgot to say is that in order to trigger this OOM
> > Kill the dirty_limit of 40% needs to be more memory than
> > what fits in low memory.  So this will work on x86 with 
> > 4GB RAM, since the dirty_limit is 1.6GB, but the block 
> > device cache cannot grow that big because it is restricted
> > to low memory.
> >
> > This has the effect of all low memory being tied up in
> > Dirty page cache and userspace try_to_free_pages() skipping
> > the writeout of these pages because the block device is
> > congested.
> 
> I am just confirming that this is a real problem.  The problem 
> more frequently shows up with block sizes above 4k on the
> dd and also showed up on some platforms with just a mke2fs
> on a slower device such as a USB hard drive.
> 
> Rik's patch has solved the issue and has been running under
> stress (via ctcs) over the weekend without failure.  

Rik's patch was broken (word-wrap by pine), but I patched
manually.  However, I have tglx-oom-final patch which moved
out_of_memory call from vmscan.c:try_to_free_pages()
to page_alloc.c:__alloc_pages().

Basically, (sc.nr_congested < SWAP_CLUSTER_MAX) check is missing.
So, what's the best way to combine these two patches?

If you use mutt, the patch can be found with command
/~i 1102697553.3306.91.camel@tglx.tec.linutronix.de
from your LKML mailbox.

-- 
