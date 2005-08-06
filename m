Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVHFKf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVHFKf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 06:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVHFKf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 06:35:28 -0400
Received: from silver.veritas.com ([143.127.12.111]:29549 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S262095AbVHFKfZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 06:35:25 -0400
Date: Sat, 6 Aug 2005 11:37:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Prasanna Meda <pmeda@akamai.com>
cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix madvise vma merging
In-Reply-To: <42F3FF90.9C030CEB@akamai.com>
Message-ID: <Pine.LNX.4.61.0508061134520.6205@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0508051911120.6203@goblin.wat.veritas.com>
 <42F3FF90.9C030CEB@akamai.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Aug 2005 10:35:23.0090 (UTC) FILETIME=[8CE82320:01C59A72]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2005, Prasanna Meda wrote:
> Hugh Dickins wrote:
> 
> > 2. Correct initial value of prev when starting part way into a vma: as
> >    in sys_mprotect and do_mlock, it needs to be set to vma in this case
> >    (vma_merge handles only that minimum of cases shown in its comments).
> 
> Acknowledge corrections 1 and  3 readily.  Treated vma_merge
> as block box that can handle all cases.  Motivation for pointless
> case 3 is to skip holes and did not notice that has been covered.
> Thanks for corrections.

And thanks for the confirmations.

> Correction 2 is tricky.  Sometimes it merges similar to case 3,
> misses a needed split,  where after the fix  we can get case 4
> merge. If that is what you are saying, we are in agreement.
> Otherwise, can you explain the real problem?

I probably am saying what you are saying there,
but it's hard for me to understand it that way.

Missing out the "start > vma->vm_start" adjustment of prev introduces
additional (but redundant: non-canonical) cases not considered at all
by vma_merge, now entered with a "prev" which is remote and surely
irrelevant to merging.  "misses a needed split", yes, I saw that;
indeed my test ended up taking the "cases 3, 8" path, when, given
the right prev, it should have been handled as a "case 4".

mmap(0x80000000, 0x3000, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, fd, 0);
madvise(0x80000000, 0x2000, MADV_RANDOM);
madvise(0x80001000, 0x1000, MADV_NORMAL);

ended up (if I'm remembering it aright) as one single VM_RAND_READ vma,
when it should have been a one page VM_RAND_READ vma followed by a two
page normal vma.  Merged into one because of the incorrect prev, and
VM_RAND_READ rather than normal because of the misplaced success label.

Hugh
