Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVA0V2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVA0V2p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVA0V2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:28:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32643 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261213AbVA0V2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 16:28:37 -0500
Date: Thu, 27 Jan 2005 16:28:19 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
In-Reply-To: <20050127211319.GN10843@holomorphy.com>
Message-ID: <Pine.LNX.4.61.0501271626460.13927@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com>
 <20050126172538.GN10843@holomorphy.com> <20050127050927.GR10843@holomorphy.com>
 <16888.46184.52179.812873@alkaid.it.uu.se> <20050127125254.GZ10843@holomorphy.com>
 <20050127142500.A775@flint.arm.linux.org.uk> <20050127151211.GB10843@holomorphy.com>
 <Pine.LNX.4.61.0501271420070.13927@chimarrao.boston.redhat.com>
 <20050127204455.GM10843@holomorphy.com> <Pine.LNX.4.61.0501271557300.13927@chimarrao.boston.redhat.com>
 <20050127211319.GN10843@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, William Lee Irwin III wrote:

> The intention was to disallow vmas starting at 0 categorically. i.e. it
> is very intentional to deny the MREMAP_FIXED to 0 case of mremap().
> It was also the intention to deny the MAP_FIXED to 0 case of mmap(),
> though I didn't actually sweep that much (if at all).

We can't do that, look at line 944 of fs/binfmt_elf.c:

         if (current->personality & MMAP_PAGE_ZERO) {
                 /* Why this, you ask???  Well SVr4 maps page 0 as read-only,
                    and some applications "depend" upon this behavior.
                    Since we do not have the power to recompile these, we
                    emulate the SVr4 behavior.  Sigh.  */
                 down_write(&current->mm->mmap_sem);
                 error = do_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
                                 MAP_FIXED | MAP_PRIVATE, 0);
                 up_write(&current->mm->mmap_sem);
         }


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
