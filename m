Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRBPPyn>; Fri, 16 Feb 2001 10:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbRBPPyY>; Fri, 16 Feb 2001 10:54:24 -0500
Received: from colorfullife.com ([216.156.138.34]:22799 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129111AbRBPPyR>;
	Fri, 16 Feb 2001 10:54:17 -0500
Message-ID: <3A8D4D43.CF589FA0@colorfullife.com>
Date: Fri, 16 Feb 2001 16:54:44 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <3A8C499A.E0370F63@colorfullife.com> <Pine.LNX.4.10.10102151702320.12656-100000@penguin.transmeta.com> <20010216151839.A3989@pcep-jamie.cern.ch> <3A8D4045.F8F27782@colorfullife.com> <20010216162741.A4284@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> /* mprotect.c */
>         entry = ptep_get_and_clear(pte);
>         set_pte(pte, pte_modify(entry, newprot));
> 
> I.e. the only code with the race condition is code which explicitly
> clears the dirty bit, in vmscan.c.
> 
> Do you see any possibility of losing a dirty bit here?
>
Of course.
Just check the output after preprocessing.
It's 
	int entry;
	entry = *pte;
	entry &= ~_PAGE_CHG_MASK;
	entry |= pgprot_val(newprot)
	*pte = entry;

We need
	atomic_clear_mask (_PAGE_CHG_MASK, pte);
	atomic_set_mask (pgprot_val(newprot), *pte);

for multi threaded apps.

> If not, there's no need for the intricate "gather" or "double scan"
> schemes for mprotect() and it can stay as fast as possible.
>
Correct, but we need a platform specific "update_pte", and perhaps
update_begin, update_end hooks (empty on i386) for other archs.

--
	Manfred
