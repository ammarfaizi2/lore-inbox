Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVA1Fa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVA1Fa6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 00:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVA1Fa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 00:30:58 -0500
Received: from holomorphy.com ([66.93.40.71]:49101 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261464AbVA1Fay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 00:30:54 -0500
Date: Thu, 27 Jan 2005 21:30:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@redhat.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
Message-ID: <20050128053036.GO10843@holomorphy.com>
References: <20050127050927.GR10843@holomorphy.com> <16888.46184.52179.812873@alkaid.it.uu.se> <20050127125254.GZ10843@holomorphy.com> <20050127142500.A775@flint.arm.linux.org.uk> <20050127151211.GB10843@holomorphy.com> <Pine.LNX.4.61.0501271420070.13927@chimarrao.boston.redhat.com> <20050127204455.GM10843@holomorphy.com> <Pine.LNX.4.61.0501271557300.13927@chimarrao.boston.redhat.com> <20050127211319.GN10843@holomorphy.com> <Pine.LNX.4.61.0501271626460.13927@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501271626460.13927@chimarrao.boston.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, William Lee Irwin III wrote:
>> The intention was to disallow vmas starting at 0 categorically. i.e. it
>> is very intentional to deny the MREMAP_FIXED to 0 case of mremap().
>> It was also the intention to deny the MAP_FIXED to 0 case of mmap(),
>> though I didn't actually sweep that much (if at all).

On Thu, Jan 27, 2005 at 04:28:19PM -0500, Rik van Riel wrote:
> We can't do that, look at line 944 of fs/binfmt_elf.c:
>         if (current->personality & MMAP_PAGE_ZERO) {
>                 /* Why this, you ask???  Well SVr4 maps page 0 as read-only,
>                    and some applications "depend" upon this behavior.
>                    Since we do not have the power to recompile these, we
>                    emulate the SVr4 behavior.  Sigh.  */
>                 down_write(&current->mm->mmap_sem);
>                 error = do_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
>                                 MAP_FIXED | MAP_PRIVATE, 0);
>                 up_write(&current->mm->mmap_sem);
>         }

You seem to be on about something else, e.g. only forbidding the vma
allocator to return a vma starting at 0 when not specifically requested.
In that case vma->vm_start < mm->brk and similar are all fine.


-- wli
