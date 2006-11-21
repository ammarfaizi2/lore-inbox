Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934298AbWKUEVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934298AbWKUEVE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 23:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934300AbWKUEVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 23:21:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:33169 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S934298AbWKUEVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 23:21:02 -0500
Date: Tue, 21 Nov 2006 15:20:09 +1100
From: David Chinner <dgc@sgi.com>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, David Chinner <dgc@sgi.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 0/2] Use freezeable workqueues to avoid suspend-related XFS corruptions
Message-ID: <20061121042009.GO11034@melbourne.sgi.com>
References: <200611160912.51226.rjw@sisk.pl> <20061120001540.GX11034@melbourne.sgi.com> <1164020537.10428.11.camel@nigel.suspend2.net> <200611202140.47322.rjw@sisk.pl> <1164060206.14889.13.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164060206.14889.13.camel@nigel.suspend2.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 09:03:26AM +1100, Nigel Cunningham wrote:
> I've looked back in logs to this time last year, when we were doing the
> modifications that lead to using bdev freezing. This is one instance of
> the BUG_ON() triggering then, from a different path. I don't believe
> it's bogus :)
> 
> Nov 12 11:43:06 home-nb kernel: CPU:    0
> Nov 12 11:43:06 home-nb kernel: EIP:    0060:[submit_bio+244/256]    Not tainted VLI
> Nov 12 11:43:06 home-nb kernel: EIP:    0060:[<c025ff54>]    Not tainted VLI
> Nov 12 11:43:06 home-nb kernel: EFLAGS: 00010246   (2.6.14d) 
> Nov 12 11:43:06 home-nb kernel: EIP is at submit_bio+0xf4/0x100
> Nov 12 11:43:06 home-nb kernel: eax: 00000003   ebx: 00001000   ecx: 00000202   edx: 00000000
> Nov 12 11:43:06 home-nb kernel: esi: c63700c0   edi: 00000001   ebp: df86dec8   esp: df86de80
> Nov 12 11:43:07 home-nb kernel: ds: 007b   es: 007b   ss: 0068
> Nov 12 11:43:07 home-nb kernel: Process xfsbufd (pid: 780, threadinfo=df86c000 task=c17cca50)
> Nov 12 11:43:07 home-nb kernel: Stack: 0000001c 00000008 00000000 00000000 df86deb4 c016b942 dff45440 00000010 
> Nov 12 11:43:08 home-nb kernel:        00001000 00001000 00000001 df86dec8 c016bee3 dfcb74f8 c63700c0 00001000 
> Nov 12 11:43:08 home-nb kernel:        00000000 00000000 df86df14 e0b4dd52 00000001 c63700c0 00001000 00000000 
> Nov 12 11:43:08 home-nb kernel: Call Trace:
> Nov 12 11:43:08 home-nb kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
> Nov 12 11:43:08 home-nb kernel:  [<c010357f>] show_stack+0x7f/0xa0
> Nov 12 11:43:08 home-nb kernel:  [show_registers+344/464] show_registers+0x158/0x1d0
> Nov 12 11:43:09 home-nb kernel:  [<c0103718>] show_registers+0x158/0x1d0
> Nov 12 11:43:09 home-nb kernel:  [die+204/368] die+0xcc/0x170
> Nov 12 11:43:09 home-nb kernel:  [<c01038fc>] die+0xcc/0x170
> Nov 12 11:43:09 home-nb kernel:  [do_trap+137/208] do_trap+0x89/0xd0
> Nov 12 11:43:09 home-nb kernel:  [<c03138c9>] do_trap+0x89/0xd0
> Nov 12 11:43:09 home-nb kernel:  [do_invalid_op+184/208] do_invalid_op+0xb8/0xd0
> Nov 12 11:43:10 home-nb kernel:  [<c0103c48>] do_invalid_op+0xb8/0xd0
> Nov 12 11:43:10 home-nb kernel:  [error_code+79/84] error_code+0x4f/0x54
> Nov 12 11:43:10 home-nb kernel:  [<c010323b>] error_code+0x4f/0x54
> Nov 12 11:43:10 home-nb kernel:  [pg0+544066898/1069077504] _pagebuf_ioapply+0x1a2/0x2f0 [xfs]
> Nov 12 11:43:10 home-nb kernel:  [<e0b4dd52>] _pagebuf_ioapply+0x1a2/0x2f0 [xfs]
> Nov 12 11:43:10 home-nb kernel:  [pg0+544067295/1069077504] pagebuf_iorequest+0x3f/0x180 [xfs]
> Nov 12 11:43:10 home-nb kernel:  [<e0b4dedf>] pagebuf_iorequest+0x3f/0x180 [xfs]
> Nov 12 11:43:11 home-nb kernel:  [pg0+544091130/1069077504] xfs_bdstrat_cb+0x3a/0x50 [xfs]
> Nov 12 11:43:11 home-nb kernel:  [<e0b53bfa>] xfs_bdstrat_cb+0x3a/0x50 [xfs]
> Nov 12 11:43:11 home-nb kernel:  [pg0+544069743/1069077504] xfsbufd+0x12f/0x1c0 [xfs]
> Nov 12 11:43:11 home-nb kernel:  [<e0b4e86f>] xfsbufd+0x12f/0x1c0 [xfs]
> Nov 12 11:43:11 home-nb kernel:  [kthread+182/256] kthread+0xb6/0x100
> Nov 12 11:43:11 home-nb kernel:  [<c012c5c6>] kthread+0xb6/0x100
> Nov 12 11:43:11 home-nb kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
> Nov 12 11:43:12 home-nb kernel:  [<c01013a9>] kernel_thread_helper+0x5/0xc
> Nov 12 11:43:12 home-nb kernel: Code: 24 0c 8b 81 9c 00 00 00 89 5c 24 04 c7 04 24 70 c7 34 c0 89 44 24 08 e8 1b 99 eb ff e9 63 ff ff ff f6 46 11 01 0f 85 66 ff ff ff <0f> 0b e9 5f ff ff ff 90 8d 74 26 00 55 89 e5 57 56 53 83 ec 2c 
> 
> Looking at the start of the xfsbufd function, this now supports
> freezing, so it shouldn't be an issue anymore, right?

xfsbufd supported freezing long before this (first supported
in Feb '03), but API changes along the way have broken it at
times. e.g:

----------------------------
revision 1.193
date: 2005/04/22 07:25:00;  author: nathans;  state: Exp;  lines: +0 -0
modid: xfs-linux-melb:xfs-kern:22342a
Resolve an issue with xfsbufd  not getting along with swsusp.
----------------------------

This one, reported on 2.6.12-rc2-mm1 indicated the xfsbufd was
getting woken when it was already in the refrigerator. That was
to do with memory reclaim, but that was fixed well before November
last year....

So if there is a problem with xfsbufd running when it shouldn't
be, the problem has not been found nor has it been fixed as the
current code is funtionally identical w.r.t freezing xfsbufds
to November last year..

> > I think we should prevent filesystems from submitting any new I/O after
> > processes have been frozen, this way or another.
> 
> Yes. We should have some means of properly telling them to put things in
> a sane state (however you define sane).

IMO, sane state == frozen filesystem.

> I would suggest that other filesystems be encouraged to implement bdev
> freezing.

Get's my vote. ;)

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
