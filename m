Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbUCZUeE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 15:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUCZUeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 15:34:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:57216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261202AbUCZUd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 15:33:59 -0500
Date: Fri, 26 Mar 2004 12:33:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, davej@redhat.com, mpm@selenic.com,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
Message-Id: <20040326123303.7a775b02.akpm@osdl.org>
In-Reply-To: <16484.37279.839961.375027@napali.hpl.hp.com>
References: <20040325141923.7080c6f0.akpm@osdl.org>
	<20040325224726.GB8366@waste.org>
	<16483.35656.864787.827149@napali.hpl.hp.com>
	<20040325180014.29e40b65.akpm@osdl.org>
	<20040326110619.GA25210@redhat.com>
	<16484.29095.842735.102236@napali.hpl.hp.com>
	<20040326104904.59f7a156.akpm@osdl.org>
	<16484.37279.839961.375027@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> >>>>> On Fri, 26 Mar 2004 10:49:04 -0800, Andrew Morton <akpm@osdl.org> said:
> 
>   Andrew> But the start address which is fed into prefetch_range() may
>   Andrew> not be cacheline-aligned.  So if appropriately abused, a
>   Andrew> prefetch_range() could wander off the end of the user's
>   Andrew> buffer and into a new page.
> 
>   Andrew> I think this gets it right, but I probably screwed something
>   Andrew> up.
> 
> Please, let's not make this more complicated than it is.  The
> cacheline alignment doesn't matter at all.  Provided prefetch_range()
> is given a range of guaranteed to be valid memory, then it will be
> fine.  It never touches anything outside the specified range.

If someone does, say,

	prefetch_range(some_pointer, sizeof(*some_pointer));

then it is possible that prefetch_range() could

a) execute a prefetch at addresses which are not PREFETCH_STRIDE-aligned
   and, as a consequence,

b) prefetch data from the next page, outside the range of the user's
   (addr,len).

