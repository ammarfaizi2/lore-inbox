Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263756AbUESBIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263756AbUESBIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 21:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUESBIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 21:08:20 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:13543
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263756AbUESBIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 21:08:18 -0400
Date: Wed, 19 May 2004 03:08:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: invalidate_inode_pages2
Message-ID: <20040519010817.GQ3044@dualathlon.random>
References: <20040519001520.GO3044@dualathlon.random> <20040518172718.773d32c1.akpm@osdl.org> <20040519005106.GP3044@dualathlon.random> <20040518180028.2f3f5744.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040518180028.2f3f5744.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2004 at 06:00:28PM -0700, Andrew Morton wrote:
> OK.  Can we do a full pte invalidation and force a major fault?

we'd need to take the page_table_lock to do that from there, I find
safer to stay at the pagecache layer at that point inside the nfs
filesystem routines. the semantics of invalidate_inode_pages2 doesn't
require a synchronous invalidate with major fault, both O_DIRECT and nfs
cannot provide distributed shared memory anyways, all it matters is that
_future_ reads will trigger readpage again to provide inode invalidate
semantics.

> > > It's currently the case that pages which are mapped into process pagetables
> > > are always up to date, which sounds like a good invariant to have.  This
> > 
> > I already intentionally broke that invariant in 2.4 just to make exactly
> > this thing work safely, this is needed for correct O_DIRECT semantics
> > too.
> > 
> > All it matters is that the pages are re-read after munmap+mmap.
> > 
> > > changes that rule.  I dunno if it'll break anything though.
> > 
> > It didn't break anything in 2.4 AFIK.
> 
> It might have caused some of the debug checks in fs/buffer.c to get angry
> when it's used by direct-IO.  But they're gone now anyway...

sounds good then ;)
