Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbTJRBsi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 21:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbTJRBsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 21:48:38 -0400
Received: from palrel11.hp.com ([156.153.255.246]:11146 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261267AbTJRBsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 21:48:35 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16272.39921.537615.433272@napali.hpl.hp.com>
Date: Fri, 17 Oct 2003 18:48:33 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, bjorn.helgaas@hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
In-Reply-To: <20031017174955.6c710949.akpm@osdl.org>
References: <200310171610.36569.bjorn.helgaas@hp.com>
	<20031017155028.2e98b307.akpm@osdl.org>
	<200310171725.10883.bjorn.helgaas@hp.com>
	<20031017165543.2f7e9d49.akpm@osdl.org>
	<16272.34681.443232.246020@napali.hpl.hp.com>
	<20031017174955.6c710949.akpm@osdl.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 17 Oct 2003 17:49:55 -0700, Andrew Morton <akpm@osdl.org> said:

  Andrew> We _want_ to be able to read mmio ranges via /dev/mem, don't
  Andrew> we?  I guess it has never come up because everyone uses
  Andrew> kmem.

I just don't see how making a "dd if=/dev/mem" safe and allowing
access to arbitrary physical memory can go to together.  Given that
/dev/mem _is_ being used for accessing mmio space, is it really worth
bothering trying to make such a "dd" safe?

  Andrew> If the hardware doesn't give the system programmer a choice
  Andrew> then the hardware is poorly designed, surely?

Emh, we're talking about _physical_ memory accesses here.  AFAIK,
failures on physical memory accesses are never signaled with
synchronous faults (not on any reasonably modern high performance
architecture, at least).  Loads probably _could_ be signalled
synchronously, but consider stores: would you really want to wait with
retiring a store until it has made it all the way to some slow ISA
device?  I think not (IN/OUT do that).  No, modern CPUs check the
TLB/page-table and if that check passes, they'll _assume_ the memory
access will complete without errors.  If it doesn't, they signal an
asynchronous failure (e.g., via an MCA).

	--david
