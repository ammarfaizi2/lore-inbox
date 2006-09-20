Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWITAFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWITAFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 20:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWITAFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 20:05:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:17366 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750704AbWITAFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 20:05:33 -0400
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Waychison <mikew@google.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1158709835.6002.203.camel@localhost.localdomain>
References: <1158274508.14473.88.camel@localhost.localdomain>
	 <20060915001151.75f9a71b.akpm@osdl.org>  <45107ECE.5040603@google.com>
	 <1158709835.6002.203.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 10:05:12 +1000
Message-Id: <1158710712.6002.216.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I need to re-read your mail and Andrew as at this point, I don't quite
> see why we need that args and/or that current->flags bit instead of
> always returning all the way to userland and let the faulting
> instruction happen again (which means you don't block in the kernel, can
> take signals etc... thus do you actually need to prevent multiple
> retries ?)

Actually... I can see it's faster to not return all the way and take the
fault again ... though only in some cases. For example, if the pte has
been filled in the meantime (concurrent faults) it's actually faster to
just go back. The only reason I see why you need those args is to tell
the no_page() handler wether retrying is acceptable or wether it should
use the old way. Any reason why this is necessary at all ? What are you
trying to avoid by not letting it always do the retry path ?

My thinking was something around the lines of no_page() always does the
retry logic. Then, we do something like:

handle_pte_fault() gets modified. If do_no_page() returns
VM_FAULT_RETRY, it checks pte_present() again. If the PTE is present, it
returns VM_FAULT_MINOR. If PTE is absent, it checks for signals, and
returns VM_FAULT_MINOR if a signal is pending. If PTE is absent and no
signals are pending, it returns VM_FAULT_RETRY.

In addition, we still need to modify all archs do_page_fault() to handle
VM_FAULT_RETRY...

Or is there a specific scenario you are trying to avoid by keeping this
mecanism for preventing retries ?

Ben.

