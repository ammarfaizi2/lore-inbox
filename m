Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266775AbUHROqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUHROqa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 10:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266777AbUHROqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 10:46:30 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:22046 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266775AbUHROq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 10:46:28 -0400
Date: Wed, 18 Aug 2004 15:46:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Jakob Oestergaard <jakob@unthought.net>
cc: Gene Heskett <gene.heskett@verizon.net>, <linux-kernel@vger.kernel.org>,
       Anders Saaby <as@cohaesio.com>, <sct@redhat.com>
Subject: Re: oom-killer 2.6.8.1
In-Reply-To: <20040818141118.GY27443@unthought.net>
Message-ID: <Pine.LNX.4.44.0408181524550.14783-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004, Jakob Oestergaard wrote:
> 
> Looking thru the swapfile.c and oom killer code, one thing that is
> making me scratch my head:
> 
> nr_swap_pages is a *signed* integer.  This does not make sense. There
> are even tests in swapfile.c that explicitly test "nr_swap_pages <= 0"
> instead of simply "!nr_swap_pages" - this does not make sense at all
> either - or does it?
> 
> Stephen is that your code?

I'm not Stephen, and it wasn't originally my code, but I do remember
tidying this up to stop /proc/meminfo showing negative SwapFree
(see nr_to_be_unused).

nr_swap_pages _may_ legitimately be negative, during sys_swapoff:
that does "nr_swap_pages -= p->pages", which is liable to send it
negative, before going on to "try_to_unuse", which slowly increments
nr_swap_pages back up to its final value (0 if no other swap areas),
page by page via delete_from_swap_cache's swap_free.

Surprising, I agree, but it allows swap_free to increment
nr_swap_pages without any special casing for swapoff.

Hugh

> See, if nr_swap_pages can validly be negative and some meaning is
> attached to that (some meaning other than "we're out of swap"), the
> oom_killer surely misses that, as it tests "nr_swap_pages > 0".
> 
> I don't think that nr_swap_pages can be negative (unless one adds a
> *lot* of swap in which case this will unintentionally happen all by
> itself),  but I felt I should chirp in with this comment in case
> someone's looking at it anyway  :)

