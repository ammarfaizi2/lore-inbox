Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129994AbQKORQN>; Wed, 15 Nov 2000 12:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130364AbQKORQD>; Wed, 15 Nov 2000 12:16:03 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129994AbQKORP5>; Wed, 15 Nov 2000 12:15:57 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Memory management bug
Date: 15 Nov 2000 08:45:47 -0800
Organization: Transmeta Corporation
Message-ID: <8uuejr$hbq$1@penguin.transmeta.com>
In-Reply-To: <C1256998.004585F4.00@d12mta07.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <C1256998.004585F4.00@d12mta07.de.ibm.com>,
>	 After some trickery with some special hardware feature (storage
>keys) I found out that empty_bad_pmd_table and empty_bad_pte_table have
>been put to the page table quicklists multiple(!) times.

This is definitely bad, and means that something else really bad is
going on.

In fact, I have this fairly strong suspicion that we should just get rid
of the "bad" page tables altogether, and make the stuff that now uses
them BUG() instead. 

The whole concept of "bad" page tables comes from very early on in
Linux, when the way the page fault handler worked was that if it ran out
of memory or something else really bad happened, it would insert a dummy
page table entry that was guaranteed to let the CPU continue.  That way
the page fault handler was always "successful" from a hardware
standpoint, even if it ended up trying to kill the process. 

This used to be required simply because a page fault in kernel space
originally needed to let the process unwind sanely and cleanly.

These days, the requirement that page faults always "succeed" is long
long gone. The exception handling mechanism handles the cases where we
validly can take a page fault, and in other cases we will just kill the
process outright. As such, the bad page tables should no longer be
needed, and are apparently just hiding some nasty bugs.

What happens if you just replace all places that would use a bad page
table with a BUG()? (Ie do _not_ add the bug to the place where you
added the test: by that time it's too late.  I'm talking about the
places where the bad page tables are used, like in the error cases of
"get_pte_kernel_slow()" etc.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
