Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269458AbUIZAlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269458AbUIZAlM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269462AbUIZAlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:41:12 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:21161 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S269458AbUIZAlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:41:07 -0400
Date: Sun, 26 Sep 2004 02:40:58 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: heap-stack-gap for 2.6
Message-ID: <20040926004058.GR3309@dualathlon.random>
References: <20040925162252.GN3309@dualathlon.random> <Pine.LNX.4.44.0409251956070.28582-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409251956070.28582-100000@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 07:57:04PM -0400, Rik van Riel wrote:
> On Sat, 25 Sep 2004, Andrea Arcangeli wrote:
> 
> > I didn't check the topdown model, in theory it should be extended to
> > cover that too, this is only working for the legacy model right now
> > because those apps aren't going to use topdown anyways.
> 
> Looks like it should just work, topdown shouldn't affect
> expand_stack() or find_vma_prev() ...

expand_stack growsdown page faults are already covered.

but the mmap side of topdown doesn't seem covered instead. Think if an
application maps everything from TASK_UNMAPPED_BASE to the last byte of
heap allowed by topdown. Then userspace unmaps the nearest page to the
stack. Then the stack growsdown of 1 page. Then you mmap again for
a PAGE_SIZE area. You will then fill the gap, and that shouldn't happen,
mmap should fail instead to guarantee a failure notification to
userspace.  This is what I meant with topdown not being fully covered.

BTW, I never tried to enforce a gap with MAP_FIXED, that's more a
feature than a bug, I expect people playing MAP_FIXED games, to know
what they're doing, and if they want they can also close the gap. But
they've to do it by hand. If they put a MAP_FIXED near the stack, the
growsdown page faults will then enforce the gap to be sure the stack
doesn't overwrite such MAP_FIXED.

So it's more a stack-growsdown only thing, but the get_unmapped_area
needs collaboration too to really enforce it, and that's the part
missing for topdown. MAP_FIXED is more than a stack-growsdown only thing
and so I still allow that.
