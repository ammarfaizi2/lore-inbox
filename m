Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTJSL1i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 07:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTJSL1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 07:27:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50739 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262110AbTJSL12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 07:27:28 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, bjorn.helgaas@hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
References: <200310171610.36569.bjorn.helgaas@hp.com>
	<20031017155028.2e98b307.akpm@osdl.org>
	<200310171725.10883.bjorn.helgaas@hp.com>
	<20031017165543.2f7e9d49.akpm@osdl.org>
	<16272.34681.443232.246020@napali.hpl.hp.com>
	<20031017174955.6c710949.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Oct 2003 05:25:37 -0600
In-Reply-To: <20031017174955.6c710949.akpm@osdl.org>
Message-ID: <m1llrh79la.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> David Mosberger <davidm@napali.hpl.hp.com> wrote:
> >
> > >>>>> On Fri, 17 Oct 2003 16:55:43 -0700, Andrew Morton <akpm@osdl.org> said:
> > 
> >   >> If we really believe copy_*_user() must correctly handle *all* faults,
> >   >> isn't the "p >= __pa(high_memory)" test superfluous?
> > 
> > Andrew> This code was conceived before my time and I don't recall seeing much
> 
> >   Andrew> discussion, so this is all guesswork..
> > 
> >   Andrew> I'd say that the high_memory test _is_ superfluous and that
> >   Andrew> if anyone cared, we would remove it and establish a
> >   Andrew> temporary pte against the address if it was outside the
> >   Andrew> direct-mapped area.  But nobody cares enough to have done
> >   Andrew> anything about it.

This can be useful for the case of > 4GB on a 32bit box.  But for mmio
it is useless.

> > What about memory-mapped device registers?  Isn't all memory
> > physically contiguous on x86 and that's why the "p >=
> > __pa(high_memory)" test saves you from that?
> 
> We _want_ to be able to read mmio ranges via /dev/mem, don't we?  I guess
> it has never come up because everyone uses kmem.

No.

sys_read/sys_write does not give you enough control to write a device driver
from user space if you want to access something other than RAM you need to
mmap /dev/mem and issue the appropriate read/write commands.  

On ia64 you can send the variant that won't generate a machine check if it
fails.  You can get the alignment right etc, etc.  

And even if you can get the interface right from user space to make mmio
work through sys_read/sys_write it will still be slow and silly to use.
And since it is useless it will go unused and then regress in
strange peculiar unexpected ways.

We do have all of the information we need in struct page to see if a
page address is valid, so checking that is reasonable.  I suspect it
will require some interesting variant of pfn_to_page to handle of the
weird sparse memory locations properly.

Of course it might just be reasonable to require knowing and
responsible use of /dev/mem.  Whatever you are doing.

Eric
