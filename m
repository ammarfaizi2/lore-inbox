Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWBBPyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWBBPyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWBBPyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:54:04 -0500
Received: from gold.veritas.com ([143.127.12.110]:11305 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932090AbWBBPyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:54:02 -0500
Date: Thu, 2 Feb 2006 15:54:34 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ken MacFerrin <lists@macferrin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
In-Reply-To: <43E15DB6.9070003@macferrin.com>
Message-ID: <Pine.LNX.4.61.0602021511160.7689@goblin.wat.veritas.com>
References: <43DAE307.5010306@macferrin.com> <Pine.LNX.4.61.0601281537120.5929@goblin.wat.veritas.com>
 <43E15DB6.9070003@macferrin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Feb 2006 15:54:01.0610 (UTC) FILETIME=[E2C9C6A0:01C62810]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2006, Ken MacFerrin wrote:
> 
> Well, unfortunately I'm back again.  I applied your patch last night but had
> another crash again today.  My X session crashed and dropped me into the
> console, which then froze, requiring a hard reboot.  I was only able to
> capture the output below because of remote logging.  This time I did not get
> the specific "BUG at mm/rmap.c" message I had in my previous report

Yes, that's replaced by "Bad rmap..." by my patch.

> but do have some "Bad rmap..." messages as you can see below.

Which in many cases allow the system to continue undisturbed;
but unfortunately not in your case, which is in a nastier state.
And only one "Bad rmap...", so not a lot I could glean from it.

> Feb  1 17:01:01 mm-home1 cron[31322]: (root) CMD (/usr/bin/updatedb)

Okay, so plenty of disk and cache activity then.
Were you doing anything interesting at the graphics end?

> Feb  1 17:04:13 mm-home1 __find_get_block_slow() failed. block=1410,
> b_blocknr=71213169107797378

Or in hex, block=0x582 b_blocknr=0x00fd000000000582: something has
corrupted the upper short of the bufheader's block number with 0xfd.

> Feb  1 17:04:13 mm-home1 Unable to handle kernel NULL pointer dereference at
> virtual address 00000000
> Feb  1 17:04:13 mm-home1 EIP is at flush_commit_list+0x229/0x3ef
> Feb  1 17:04:13 mm-home1 Process pdflush (pid: 164, threadinfo=f7e10000
> task=f7c15030)

And ReiserFS is justifiably surprised that no bufheader could be
found for one of its journal pages.

> Feb  1 17:04:13 mm-home1 Badness in do_exit at kernel/exit.c:796

Concomitant fallout from the above fault.

> Feb  1 17:04:14 mm-home1 kdm[10322]: X server for display :0 terminated
> unexpectedly

Nothing to say why that was, but we already know the system is bad.

> Feb  1 17:04:14 mm-home1 Bad rmap: page c1ee7ee0 flags c0000014 count 1
> mapcount 0
> Feb  1 17:04:14 mm-home1 firefox-bin addr b5313000 ptpfn 69515 vm_flags 100077
> Feb  1 17:04:14 mm-home1 page mapping 00000000 95d4 vma mapping 00000000 b5313

A page is being unmapped which was not recorded as being mapped.  Could be
page table corruption.  I'd been hoping for a sequence of these, and would
then have looked for some commonality, but it's an isolated occurrence.
Probably related to the bufheader corruption.

> Feb  1 17:04:19 mm-home1 Unable to handle kernel paging request at virtual
> address 00180000
> Feb  1 17:04:19 mm-home1 Process kswapd0 (pid: 165, threadinfo=f7d8e000 
> Feb  1 17:04:19 mm-home1 EIP is at find_get_pages+0x33/0x54

The radix-tree lookup found 0x00180000 where it should have found a struct
page pointer or NULL: something has corrupted the upper short with 0x18.

> Feb  1 17:04:19 mm-home1 <6>note: kswapd0[165] exited with preempt_count 1

Concomitant fallout from the above fault.

> Feb  1 17:04:19 mm-home1 (krm-11020): GConf server is not in use, shutting
> down.
> Feb  1 17:04:21 mm-home1 kdm: :0[15897]: Abnormal termination of greeter for
> display :0, code 127, signal 0

Things are getting worse.

> Feb  1 17:04:29 mm-home1 login(pam_unix)[10286]: session opened for user root
> by LOGIN(uid=0)
> Feb  1 17:06:45 mm-home1 __find_get_block_slow() failed. block=1681,
> b_blocknr=23362423066986129

Or in hex, block=0x691 b_blocknr=0x0053000000000691: something has
corrupted the upper short of the bufheader's block number with 0x53.

Well, you're getting plenty of memory corruption, and there's some pattern
to it (bits 8-11 each time), but I can't guess where it's coming from,
I'm afraid.  The "Bad rmap", my speciality, looks merely incidental
to the more general memory corruption.

I know you already said you really need to use the nVidia driver for
xinerama, but it has to be suspect #1.  Any chance of doing without it
just for a day, to see what happens then?  Or would that force you into
such a different work pattern that it would prove nothing?

After that, the next thing to try is going back to 2.6.12: I think you
said this bad behaviour started with 2.6.13 (but I may be quite wrong
to assume that you were running 2.6.12 before).  Perhaps the problem
lies with your hardware, but started to manifest around the time you
moved to 2.6.13, we do need to rule that out.

Hugh
