Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRBPQoB>; Fri, 16 Feb 2001 11:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129159AbRBPQnw>; Fri, 16 Feb 2001 11:43:52 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:26894 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129111AbRBPQne>;
	Fri, 16 Feb 2001 11:43:34 -0500
Date: Fri, 16 Feb 2001 17:43:16 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        bcrl@redhat.com
Subject: Re: x86 ptep_get_and_clear question
Message-ID: <20010216174316.A4500@pcep-jamie.cern.ch>
In-Reply-To: <3A8C499A.E0370F63@colorfullife.com> <Pine.LNX.4.10.10102151702320.12656-100000@penguin.transmeta.com> <20010216151839.A3989@pcep-jamie.cern.ch> <3A8D4045.F8F27782@colorfullife.com> <20010216162741.A4284@pcep-jamie.cern.ch> <3A8D4D43.CF589FA0@colorfullife.com> <20010216170029.A4450@pcep-jamie.cern.ch> <3A8D540C.92C66398@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A8D540C.92C66398@colorfullife.com>; from manfred@colorfullife.com on Fri, Feb 16, 2001 at 05:23:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> The other cpu writes the dirty bit - we just overwrite it ;-)
> After the ptep_get_and_clear(), before the set_pte().

Ah, I see.  The other CPU does an atomic *pte |= _PAGE_DIRTY, without
checking the present bit.  ('scuse me for temporary brain failure).

How about a pragmatic solution.

Given that Ben's found that "checks pte_present on dirtying" works in
practice, and it is _much_ simpler to do things that way, perhaps we
could write a boot time test for this?

If the boot time test fails, we

 (a) printk("Sorry we've never seen a CPU like this, please report");

 (b) Put this in ptep_get_and_clear:

      if (tlb_dirty_doesnt_sync)
        flush_tlb_page(page)

It should be fast on known CPUs, correct on unknown ones, and much
simpler than "gather" code which may be completely unnecessary and
rather difficult to test.

If anyone reports the message, _then_ we think about the problem some more.

Ben, fancy writing a boot-time test?

-- Jamie
