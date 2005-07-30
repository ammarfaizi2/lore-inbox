Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263132AbVG3Tbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbVG3Tbe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbVG3Tbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:31:33 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13218
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S263132AbVG3Tb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:31:28 -0400
Date: Sat, 30 Jul 2005 12:31:25 -0700 (PDT)
Message-Id: <20050730.123125.71116248.davem@davemloft.net>
To: dada1@cosmosbay.com
Cc: akpm@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab.c : prefetchw the start of new allocated
 objects
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42E9F145.7040302@cosmosbay.com>
References: <42E7A8D8.1030809@earthlink.net>
	<20050729014150.6e97dfd2.akpm@osdl.org>
	<42E9F145.7040302@cosmosbay.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Fri, 29 Jul 2005 11:05:09 +0200

> Some CPU lacks a prefetchw() and currently do nothing, so I ask this
> question : Should'nt make prefetchw() do at least a prefetch() ? A
> read hint is better than nothing.

This is not true, especially on SMP.  If the only prefetch variant
available does a "prefetch for read", the cpu will only grab the
cacheline in shared state if other cpus have a dirty copy.

And, as a result, when the write to the cache line occurs yet
another bus transaction will go out in order to get exclusive
access to the cache line on the local cpu.  This is extremely
inefficient.

So it's better in this case to make no prefetch, and thus only
incur one bus transaction when the memory access occurs.
