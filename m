Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281933AbRKURnq>; Wed, 21 Nov 2001 12:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281931AbRKURnh>; Wed, 21 Nov 2001 12:43:37 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:28751 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S281927AbRKURn0>; Wed, 21 Nov 2001 12:43:26 -0500
Date: Wed, 21 Nov 2001 17:45:16 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Rik van Riel <riel@conectiva.com.br>, "David S. Miller" <davem@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 + Bug in swap_out.
In-Reply-To: <m1y9l0ytsi.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.21.0111211712140.1506-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Nov 2001, Eric W. Biederman wrote:
> 
> The primary problem with swap_mm is that swap_mm is used totally
> unexpectedly in a different file.  Instead of it's usage being small
> local and contained.

swap_mm is not the kernel's only global variable, and it is commented:

/* Placeholder for swap_out(): may be updated by fork.c:mmput() */
struct mm_struct *swap_mm = &init_mm;

I think the problem is rather that people thought they knew this code
without reading it, then found it different from what they imagined.

> There is some sense in allowing swapoff not to check new processes

No, it used to miss new processes, it needs to catch them, now it does.
But that's not the reason for the mmlist ordering: the ordering is
desirable so that you can eliminate all swapents from parent, then
eliminate all from child - other way round may leave some in child.

> but...  The only optimization that really makes sense with swapoff is
> to turn it inside out and traverse each process only once...  With
> possibly a little of the current logic to handle the shared swap case.

I wouldn't say "only"; and isn't it true that at least the current
(hideously cpu intensive) way does minimize swap disk head movement?
which may often (especially at shutdown time) be more important than
than minimizing cpu use.

But certainly, cpu-wise, it's much more attractive at least to try
to traverse each mm once only.  Unfortunately, as you observe, it
does then still need the current logic to pick up the leftovers.
That current logic could certainly be simplified (once it's a rare
path, throw out complicating speedups); but overall it would be
more not less complicated - a series of two different methods -
so I haven't yet gathered up the energy to go that way.

Hugh

