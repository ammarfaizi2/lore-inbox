Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVF0Tyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVF0Tyh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVF0Tyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:54:36 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36534
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261429AbVF0TvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:51:05 -0400
Date: Mon, 27 Jun 2005 12:50:52 -0700 (PDT)
Message-Id: <20050627.125052.108115648.davem@davemloft.net>
To: dan@embeddededge.com
Cc: akpm@osdl.org, marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: increased translation cache footprint in v2.6
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <705a40397bb8383399109debccaebaa3@embeddededge.com>
References: <20050626190944.GC6091@logos.cnet>
	<20050626.175347.104031526.davem@davemloft.net>
	<705a40397bb8383399109debccaebaa3@embeddededge.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Malek <dan@embeddededge.com>
Date: Mon, 27 Jun 2005 11:57:51 -0400

> Because of the configurability of the address space among text, data,
> IO, and uncached mapping, we simply can't test an address bit and
> build a new TLB entry.

Maybe not by testing a bit, but instead via a range test.

      cmp %reg, PAGE_OFFSET_BEGIN
      bl  not_kernel
      cmp %reg, PAGE_OFFSET_END
      bge not_kernel

      Calculate 8MB PTE here

not_kernel:

That's 4 instructions, completely trivial.

I think you're making this problem more complex than it really
is.  There is no reason at all to hold page tables for the direct
physical memory mappings of lowmem if you have any control whatsoever
over the TLB miss handler.

You'll be saving tons of memory accesses, and that alone should
count for some significant performance savings especially on
embedded setups.  What's more, you'll get 8MB mappings as well,
decreasing the TLB miss rate.
