Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422781AbWJTT6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422781AbWJTT6w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422820AbWJTT6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:58:52 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2021
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422781AbWJTT6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:58:51 -0400
Date: Fri, 20 Oct 2006 12:58:51 -0700 (PDT)
Message-Id: <20061020.125851.115909797.davem@davemloft.net>
To: torvalds@osdl.org
Cc: nickpiggin@yahoo.com.au, ralf@linux-mips.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0610201251440.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org>
	<20061020.123635.95058911.davem@davemloft.net>
	<Pine.LNX.4.64.0610201251440.3962@g5.osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Fri, 20 Oct 2006 12:54:17 -0700 (PDT)

> Well, sparc always was crud. I can see the missing tlb entry, but if it's 
> been turned read-only, the write-back should still work (it clearly _was_ 
> writable when the write that dirtied the cacheline happened).

I did some more digging, here's what I think the hardware actually
does:

1) On L2 cacheline load, the "user" and "writable" protection
   bits are propagated from the TLB entry into the L2 cache
   line.  Access checks are done on L2 cache hit using this
   cached copy of the two protection bits.

2) On L2 dirty cacheline writeback, the physical address is
   obtained from the TLB

So what you guys are suggesting should probably work fine.
