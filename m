Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269225AbUISMH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269225AbUISMH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 08:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269227AbUISMH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 08:07:29 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:38564 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S269225AbUISMH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 08:07:27 -0400
Date: Sun, 19 Sep 2004 13:07:13 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Mike Kirk <mike.kirk@sympatico.ca>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2: "kernel BUG at mm/rmap.c:473!"
In-Reply-To: <008601c49de9$cf8817c0$1b00a8c0@cruncher>
Message-ID: <Pine.LNX.4.44.0409191220390.13142-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2004, Mike Kirk wrote:
> Not sure what this means: but the system kept running and I only lost a
> bzip2 process: 2.6.9-rc2 w/preempt AMD 2700+ on A7N8X motherboard, 1GB
> DDR400:
> ==============================
> kernel BUG at mm/rmap.c:473!
> EIP is at page_remove_rmap+0x29/0x40

Was there a "Bad page state" message and backtrace shortly before this?
I say "shortly" because I don't suppose bzip2 had been running for hours,
I'd expect the underlying error to have occurred while it was running.

BUG_ON(page_mapcount(page) < 0);

Previous incidents of this BUG (or its antecedents: the mapcount has
recently changed to atomic from guarded by spinlock) have been after
something elsewhere has freed a page it no longer owned, which has
meanwhile got mapped into process address space.

If that's the case this time around, then I hope the bad_page backtrace
will shed light on what's freeing that shouldn't.  But if there was no
"Bad page state" message before, then I'll have to start worrying about
rmap mapcount consistency.

(The page_remove_rmap BUG follows as a consequence of bad_page resetting
the mapcount on such a page.  This is unsatisfactory: that code remote
from the cause should force a BUG, whereas code nearer the cause try to
continue without forcing a BUG.  Just removing the BUG from mm/rmap.c
would let me off the hook, but seems irresponsible.  Adding a BUG into
bad_page would revert an intentional relaxation.  I don't know.)

Hugh

