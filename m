Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265482AbUE0V45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265482AbUE0V45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 17:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265481AbUE0V44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 17:56:56 -0400
Received: from palrel11.hp.com ([156.153.255.246]:38102 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S265478AbUE0V4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 17:56:55 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16566.25617.363386.115466@napali.hpl.hp.com>
Date: Thu, 27 May 2004 14:56:33 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: davidm@hpl.hp.com, Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <20040525045322.GX29378@dualathlon.random>
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
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 25 May 2004 06:53:22 +0200, Andrea Arcangeli <andrea@suse.de> said:

  >> If the "accessed" or "dirty" bits are zero, accessing/writing the
  >> page will cause a fault which will be handled in a low-level
  >> fault handler.  The Linux version of these handlers simply turn
  >> on the respective bit.  See daccess_bit(), iaccess_bit(), and dirty_bit()
  >> in arch/ia64/kernel/ivt.S.

  Andrea> so you mean, this is being set in the arch section before
  Andrea> ever reaching handle_mm_fault?

Correct.  The low-level fault handlers set the ACCESSED/DIRTY bits
with an atomic compare-and-exchange (on SMP).  They don't (normally)
bubble up all the way to the Linux page-fault handler.

	--david
