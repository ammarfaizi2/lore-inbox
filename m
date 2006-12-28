Return-Path: <linux-kernel-owner+w=401wt.eu-S964849AbWL1AwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWL1AwW (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 19:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWL1AwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 19:52:22 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:59157
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S964834AbWL1AwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 19:52:22 -0500
Date: Wed, 27 Dec 2006 16:52:21 -0800 (PST)
Message-Id: <20061227.165221.55508787.davem@davemloft.net>
To: torvalds@osdl.org
Cc: schwidefsky@de.ibm.com, a.p.zijlstra@chello.nl, tbm@cyrius.com,
       hugh@veritas.com, nickpiggin@yahoo.com.au, arjan@infradead.org,
       andrei.popa@i-neo.ro, akpm@osdl.org, linux-kernel@vger.kernel.org,
       fw@deneb.enyo.de, mh+linux-kernel@zugschlus.de,
       heiko.carstens@de.ibm.com, arnd.bergmann@de.ibm.com,
       gordonfarquharson@gmail.com
Subject: Re: [PATCH] mm: fix page_mkclean_one
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0612271639510.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612211134370.3536@woody.osdl.org>
	<1167264000.5200.21.camel@localhost>
	<Pine.LNX.4.64.0612271639510.4473@woody.osdl.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Wed, 27 Dec 2006 16:42:40 -0800 (PST)

> That's fine. In that situation, you shouldn't need any atomic ops at all, 
> I think all our sw page-table operations are already done under the pte 
> lock. 

This is true, but there is one subtlety to this I want to
point out in passing.

That lock can possibly only protect a page of PTEs.

When NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS, the locking is done per page
of PTEs, not for all of the page tables of an address space at once.

What this means is that it's really difficult to forcefully block out
all page table operations for a given mm, and I actually needed to do
something like this on sparc64 (when growing the TLB lookup hash
table, you can't let any PTEs change state while the table is
changing).  For my case, I added a spinlock to mm->context since
actually what I need is to block modifications to the hash table
itself during PTE changes.
