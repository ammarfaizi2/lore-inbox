Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966712AbWKTWDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966712AbWKTWDg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966748AbWKTWDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:03:36 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:59578 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S966712AbWKTWDf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:03:35 -0500
Subject: Re: [PATCH -mm 0/2] Use freezeable workqueues to avoid
	suspend-related XFS corruptions
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Chinner <dgc@sgi.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200611202140.47322.rjw@sisk.pl>
References: <200611160912.51226.rjw@sisk.pl>
	 <20061120001540.GX11034@melbourne.sgi.com>
	 <1164020537.10428.11.camel@nigel.suspend2.net>
	 <200611202140.47322.rjw@sisk.pl>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 09:03:26 +1100
Message-Id: <1164060206.14889.13.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2006-11-20 at 21:40 +0100, Rafael J. Wysocki wrote:
> On Monday, 20 November 2006 12:02, Nigel Cunningham wrote:
> > If I put a BUG_ON() in submit_bio for non suspend2 I/O, it catches this
> > trace:
> > 
> > submit_bio
> > xfs_buf_iorequest
> > xlog_bdstrat_cb
> > xlog_state_release_iclog
> > xlog_state_sync_all
> > xfs_log_force
> > xfs_syncsub
> > xfs_sync
> > vfs_sync
> > vfs_sync_worker
> > xfssyncd
> > keventd_create_kthread
> 
> Well, this trace apparently comes from xfssyncd wich explicitly calls
> try_to_freeze().  When does this happen?

I'm sorry. Since sending the email I looked at this more, deciding in
the end that I had a false positive. I was resetting the flag that
enabled the check after thawing kernel threads instead of before.

I've looked back in logs to this time last year, when we were doing the
modifications that lead to using bdev freezing. This is one instance of
the BUG_ON() triggering then, from a different path. I don't believe
it's bogus :)

Nov 12 11:43:06 home-nb kernel: CPU:    0
Nov 12 11:43:06 home-nb kernel: EIP:    0060:[submit_bio+244/256]    Not tainted VLI
Nov 12 11:43:06 home-nb kernel: EIP:    0060:[<c025ff54>]    Not tainted VLI
Nov 12 11:43:06 home-nb kernel: EFLAGS: 00010246   (2.6.14d) 
Nov 12 11:43:06 home-nb kernel: EIP is at submit_bio+0xf4/0x100
Nov 12 11:43:06 home-nb kernel: eax: 00000003   ebx: 00001000   ecx: 00000202   edx: 00000000
Nov 12 11:43:06 home-nb kernel: esi: c63700c0   edi: 00000001   ebp: df86dec8   esp: df86de80
Nov 12 11:43:07 home-nb kernel: ds: 007b   es: 007b   ss: 0068
Nov 12 11:43:07 home-nb kernel: Process xfsbufd (pid: 780, threadinfo=df86c000 task=c17cca50)
Nov 12 11:43:07 home-nb kernel: Stack: 0000001c 00000008 00000000 00000000 df86deb4 c016b942 dff45440 00000010 
Nov 12 11:43:08 home-nb kernel:        00001000 00001000 00000001 df86dec8 c016bee3 dfcb74f8 c63700c0 00001000 
Nov 12 11:43:08 home-nb kernel:        00000000 00000000 df86df14 e0b4dd52 00000001 c63700c0 00001000 00000000 
Nov 12 11:43:08 home-nb kernel: Call Trace:
Nov 12 11:43:08 home-nb kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
Nov 12 11:43:08 home-nb kernel:  [<c010357f>] show_stack+0x7f/0xa0
Nov 12 11:43:08 home-nb kernel:  [show_registers+344/464] show_registers+0x158/0x1d0
Nov 12 11:43:09 home-nb kernel:  [<c0103718>] show_registers+0x158/0x1d0
Nov 12 11:43:09 home-nb kernel:  [die+204/368] die+0xcc/0x170
Nov 12 11:43:09 home-nb kernel:  [<c01038fc>] die+0xcc/0x170
Nov 12 11:43:09 home-nb kernel:  [do_trap+137/208] do_trap+0x89/0xd0
Nov 12 11:43:09 home-nb kernel:  [<c03138c9>] do_trap+0x89/0xd0
Nov 12 11:43:09 home-nb kernel:  [do_invalid_op+184/208] do_invalid_op+0xb8/0xd0
Nov 12 11:43:10 home-nb kernel:  [<c0103c48>] do_invalid_op+0xb8/0xd0
Nov 12 11:43:10 home-nb kernel:  [error_code+79/84] error_code+0x4f/0x54
Nov 12 11:43:10 home-nb kernel:  [<c010323b>] error_code+0x4f/0x54
Nov 12 11:43:10 home-nb kernel:  [pg0+544066898/1069077504] _pagebuf_ioapply+0x1a2/0x2f0 [xfs]
Nov 12 11:43:10 home-nb kernel:  [<e0b4dd52>] _pagebuf_ioapply+0x1a2/0x2f0 [xfs]
Nov 12 11:43:10 home-nb kernel:  [pg0+544067295/1069077504] pagebuf_iorequest+0x3f/0x180 [xfs]
Nov 12 11:43:10 home-nb kernel:  [<e0b4dedf>] pagebuf_iorequest+0x3f/0x180 [xfs]
Nov 12 11:43:11 home-nb kernel:  [pg0+544091130/1069077504] xfs_bdstrat_cb+0x3a/0x50 [xfs]
Nov 12 11:43:11 home-nb kernel:  [<e0b53bfa>] xfs_bdstrat_cb+0x3a/0x50 [xfs]
Nov 12 11:43:11 home-nb kernel:  [pg0+544069743/1069077504] xfsbufd+0x12f/0x1c0 [xfs]
Nov 12 11:43:11 home-nb kernel:  [<e0b4e86f>] xfsbufd+0x12f/0x1c0 [xfs]
Nov 12 11:43:11 home-nb kernel:  [kthread+182/256] kthread+0xb6/0x100
Nov 12 11:43:11 home-nb kernel:  [<c012c5c6>] kthread+0xb6/0x100
Nov 12 11:43:11 home-nb kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Nov 12 11:43:12 home-nb kernel:  [<c01013a9>] kernel_thread_helper+0x5/0xc
Nov 12 11:43:12 home-nb kernel: Code: 24 0c 8b 81 9c 00 00 00 89 5c 24 04 c7 04 24 70 c7 34 c0 89 44 24 08 e8 1b 99 eb ff e9 63 ff ff ff f6 46 11 01 0f 85 66 ff ff ff <0f> 0b e9 5f ff ff ff 90 8d 74 26 00 55 89 e5 57 56 53 83 ec 2c 

Looking at the start of the xfsbufd function, this now supports
freezing, so it shouldn't be an issue anymore, right?

> > So, it would appear that freezing kthreads without freezing bdevs should
> > be a possible solution. It may however leave some I/O unsynced
> > pre-resume and therefore result in possible dataloss if no resume
> > occurs. I therefore wonder whether it's better to stick with bdev
> > freezing
> 
> It looks like xfs is the only filesystem that really implements bdev freezing,
> so for other filesystems it's irrelevant.  However, it may affect the dm, and
> I'm not sure what happens if someone tries to use a swap file on a dm
> device for the suspend _after_ we have frozen bdevs.
> 
> > or create some variant wherein XFS is taught to fully flush 
> > pending writes and not create new I/O.
> 
> I think we should prevent filesystems from submitting any new I/O after
> processes have been frozen, this way or another.

Yes. We should have some means of properly telling them to put things in
a sane state (however you define sane). It seems to belong between
freezing userspace and freezing kernelspace because we otherwise might
have problems with processes blocking, waiting for I/O and never
entering the refrigerator. But doing it there also creates problems with
(*cough*) fuse. Gah!

I would suggest that other filesystems be encouraged to implement bdev
freezing.

Nigel

