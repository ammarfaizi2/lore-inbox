Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265499AbUE0WI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbUE0WI2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 18:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUE0WI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 18:08:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:13210 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265493AbUE0WI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 18:08:26 -0400
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: davidm@hpl.hp.com
Cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
In-Reply-To: <16566.25617.363386.115466@napali.hpl.hp.com>
References: <1085369393.15315.28.camel@gaston>
	 <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
	 <1085371988.15281.38.camel@gaston>
	 <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
	 <1085373839.14969.42.camel@gaston>
	 <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
	 <20040525034326.GT29378@dualathlon.random>
	 <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
	 <20040525042054.GU29378@dualathlon.random>
	 <16562.52948.981913.814783@napali.hpl.hp.com>
	 <20040525045322.GX29378@dualathlon.random>
	 <16566.25617.363386.115466@napali.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1085695254.7835.126.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 28 May 2004 08:00:54 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-28 at 07:56, David Mosberger wrote:
> >>>>> On Tue, 25 May 2004 06:53:22 +0200, Andrea Arcangeli <andrea@suse.de> said:
> 
>   >> If the "accessed" or "dirty" bits are zero, accessing/writing the
>   >> page will cause a fault which will be handled in a low-level
>   >> fault handler.  The Linux version of these handlers simply turn
>   >> on the respective bit.  See daccess_bit(), iaccess_bit(), and dirty_bit()
>   >> in arch/ia64/kernel/ivt.S.
> 
>   Andrea> so you mean, this is being set in the arch section before
>   Andrea> ever reaching handle_mm_fault?
> 
> Correct.  The low-level fault handlers set the ACCESSED/DIRTY bits
> with an atomic compare-and-exchange (on SMP).  They don't (normally)
> bubble up all the way to the Linux page-fault handler.

Same for PPC, but we still have a race where we can reach that code, see
my initial mail (typically, because your low level code, for obvious
reasons, doesn't take the mm semaphore, thus the page may have been
mapped right after you decide to go to do_page_fault and before it takes
the mm sem).

Ben.

