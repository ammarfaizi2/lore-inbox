Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUCIIpP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 03:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUCIIpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 03:45:15 -0500
Received: from holomorphy.com ([207.189.100.168]:4872 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261786AbUCIIpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 03:45:11 -0500
Date: Tue, 9 Mar 2004 00:44:59 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309084459.GK655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040308202433.GA12612@dualathlon.random> <Pine.LNX.4.58.0403081238060.9575@ppc970.osdl.org> <20040308132305.3c35e90a.akpm@osdl.org> <20040308230247.GC12612@dualathlon.random> <20040308152126.54f4f681.akpm@osdl.org> <20040308234014.GG12612@dualathlon.random> <20040309083103.GB8021@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309083103.GB8021@elte.hu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 09:31:03AM +0100, Ingo Molnar wrote:
> with rmap we do have the ability to make it truly O(1) all across, by
> making the pte chains a double linked list. Moreover, we can freely
> reduce the rmap overhead (both the memory, algorithmic and locking
> overhead) by increasing the page size - a natural thing to do on big
> boxes anyway. The increasing of the page size also linearly _reduces_
> the RAM footprint of rmap. So rmap and pgcl are a natural fit and the
> thing of the future.
> now, the linear searching of vmas does not reduce with increased
> page-size. In fact, it will increase in time as the sharing factor
> increases.

This is getting bandied about rather frequently. I should make some
kind of attack on an implementation. The natural implementation is
to add one pte per contiguous and aligned group of PAGE_MMUCOUNT ptes
to the pte_chain and search the area surrounding any pte_chain element.

But the linear search you're pointing at is unnecessary to begin with.
Only the single nonlinear mappings' pte needs to be added to the
pte_chain there; one need only also scan the vma lists at reclaim-time.
This would also make page_convert_anon() a misnomer and SetPageAnon()
on nonlinearly-mapped file-backed pages a bug.


-- wli
