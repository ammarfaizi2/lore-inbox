Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVHAUEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVHAUEY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVHAUC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:02:28 -0400
Received: from silver.veritas.com ([143.127.12.111]:29458 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S261205AbVHAUBu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:01:50 -0400
Date: Mon, 1 Aug 2005 21:03:25 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Roland McGrath <roland@redhat.com>, linux-mm@kvack.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <42EDDB82.1040900@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0508012045050.5373@goblin.wat.veritas.com>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com>
 <42EDDB82.1040900@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 01 Aug 2005 20:01:46.0313 (UTC) FILETIME=[D86BB390:01C596D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005, Nick Piggin wrote:
> 
> This was tested by Robin and appears to solve the problem. Roland
> had a quick look and thought the basic idea was sound. I'd like to
> get a couple more acks before going forward, and in particular
> Robin was contemplating possible efficiency improvements (although
> efficiency can wait on correctness).

I'd much prefer a solution that doesn't invade all the arches, but
I don't think Linus' pte_dirty method will work on s390 (unless we
change s390 in a less obvious way than your patch), so it looks
like we do need something like yours.

Comments:

There are currently 21 architectures,
but so far your patch only updates 14 of them?

Personally (rather like Robin) I'd have preferred a return code more
directed to the issue at hand, than your VM_FAULT_RACE.  Not for
efficiency reasons, I think you're right that's not a real issue,
but more to document the peculiar case we're addressing.  Perhaps a
code that says do_wp_page has gone all the way through, even though
it hasn't set the writable bit.

That would require less change in mm/memory.c, but I've no strong
reason to argue that you change your approach in that way.  Perhaps
others prefer the race case singled out, to gather statistics on that.
Assuming we stick with your VM_FAULT_RACE...

Could we define VM_FAULT_RACE as 3 rather than -2?  I think there's 
some historical reason why VM_FAULT_OOM is -1, but see no cause to
extend the range in that strange direction.

VM_FAULT_RACE is a particular subcase of VM_FAULT_MINOR: throughout
the arches I think they should just be adjacent cases of the switch
statement, both doing the min_flt++.

Your continue in get_user_pages skips page_table_lock as Linus noted.

The do_wp_page call from do_swap_page needs to be adjusted, to return
VM_FAULT_RACE if that's what it returned.

If VM_FAULT_RACE is really recording races, then the bottom return
value from handle_pte_fault ought to be VM_FAULT_RACE rather than
VM_FAULT_MINOR.

Hugh
