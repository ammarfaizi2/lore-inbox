Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTDEDLi (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 22:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbTDEDLi (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 22:11:38 -0500
Received: from [12.47.58.55] ([12.47.58.55]:4446 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261743AbTDEDLh (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 22:11:37 -0500
Date: Fri, 4 Apr 2003 19:24:01 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-Id: <20030404192401.03292293.akpm@digeo.com>
In-Reply-To: <20030405024414.GP16293@dualathlon.random>
References: <20030404163154.77f19d9e.akpm@digeo.com>
	<12880000.1049508832@flay>
	<20030405024414.GP16293@dualathlon.random>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Apr 2003 03:23:03.0295 (UTC) FILETIME=[AACF08F0:01C2FB22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> Indeed. objrmap is the only way to avoid the big rmap waste. Infact I'm
> not even convinced about the hybrid approch, rmap should be avoided even
> for the anon pages. And the swap cpu doesn't matter, as far as we can
> reach pagteables in linear time that's fine, doesn't matter how many
> fixed cycles it takes. Only the complexity factor matters, and objrmap
> takes care of it just fine.

Well not really.

Consider the case where 100 processes each own 100 vma's against the same
file.

To unmap a page with objrmap we need to search those 10,000 vma's (10000
cachelines).  With full rmap we need to search only 100 pte_chain slots (3 to
33 cachelines).  That's an enormous difference.  It happens for *each* page.

And, worse, we have the same cost when searching for referenced bits in the
pagetables.  Nobody has written an "exploit" for this yet, but it's there.

Possibly we should defer the assembly of the pte chain until a page hits the
tail of the LRU.  That's an awkward time to be allocating memory though.  We
could perhaps fall back to the vma walk if pte_chain allocation starts to
endanger the page reserves.

