Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTLDStm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbTLDStm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:49:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:34730 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263464AbTLDStb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:49:31 -0500
Date: Thu, 4 Dec 2003 10:49:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: pinotj@club-internet.fr
cc: nathans@sgi.com, manfred@colorfullife.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
In-Reply-To: <mnet1.1070562461.26292.pinotj@club-internet.fr>
Message-ID: <Pine.LNX.4.58.0312041035530.6638@home.osdl.org>
References: <mnet1.1070562461.26292.pinotj@club-internet.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Dec 2003 pinotj@club-internet.fr wrote:
>
> OK, I tried again the patch on "small kernel" test11 with
> CONFIG_DEBUG_PAGEALLOC only. Here are the first results. I will do more
> tests later because it seems weird. This time I have very different
> behavior for XFS and Ext3.

Ok, interesting indeed.

> I got an oops at boot time, when system try to mount root filesystem (XFS).
>
> But when I tried on a root Ext3, I got no problem at all. I even
> compiled 2 kernel straight without any problems. It seems to be the
> first time a test11 works flawless on my system.

All right. That may or may not mean that the bug is actually in mm/slab.c,
rather than anywhere else. It doesn't explain why _you_ hit it and few
others do, but it's still an interesting fact.

Manfred, any ideas? What's different between 2.6.x and 2.4.x in slab?

But it may also be that the bug is in some slab user - since my slab-
translates-to-page-alloc hack always calls the slab constructor function
on every allocation, and the destructor gets called immediately after the
free, my debug version might hide some usage bugs.

> The XFS oops (I was too lazy to write down all the backtraces, all about
> xfs_* things, I can send if needed):
>
> ---
> kernel BUG at include/linux/mm.h:267!

YEAH! That's "put_page_testzero()", and either the BUG_ON() or the
atomic_dec_and_test() noticing bad things.

So that's the "test for count going negative" bug, and it seems to have
found somebody doing a double free on a page. Which is _exactly_ what we
expected from the XFS problems, and would explain the "struct page"
corruption that people report.

> Call Trace:
>  [<c01aaf90>] pagebuf_free+0x24/0x30
>  [<c019669b>] xlog_find_verify_cycle+0x18b/0x1e0
> Code: 0f 0b 0b 01 d6 cb 1f c0 eb 8e ff 73 54 eb b3 90 53 e8 0e 11

It would be good to get the full backtrace, though.

Nathan - did you see the two debug patches I sent out that caught this?

One adds checks to "atomic_dec_and_test()" to verify that the count never
goes negative. The other basically disables all the slab code, and
replaces them with straight page allocations, and that together with
CONFIG_DEBUG_PAGEALLOC helps find bad behaviour (touching allocations
after they are free'd etc).

		Linus
