Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbTJQXNM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 19:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbTJQXNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 19:13:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:33719 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261214AbTJQXNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 19:13:08 -0400
Subject: AIO and DIO testing on 2.6.0-test7-mm1
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>, Suparna Bhattacharya <suparna@in.ibm.com>
Cc: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1066432378.2133.40.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Oct 2003 16:12:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been doing some testing on 2.6.0-test7-mm1 with O_DIRECT and
AIO.  I wrote some tests to check the buffered i/o verses O_DIRECT
i/o races and O_DIRECT verses truncate.

I still had apply suparna's direct-io.c patch to prevent oopses.
Suparna, you said the patch was not the complete patch, do you have
the complete patch?

I wrote some simple tests to create 2 processes with one doing
O_DIRECT i/o (of zeros) and the other doing buffered i/o and checking
that the buffered i/o process never saw non-zero data which was
posssible before the i_alloc_sem and other changes.  The test I
wrote are:
	dio_append - use O_DIRECT to append while doing buffered reads
 	dio_sparse - write O_DIRECT to holes while doing buffered reads
	dio_truncate - do O_DIRECT reads while truncating
	aiodio_append - same as dio_append but with AIO
	aiodio_sparse - same as dio_sparse but with AIO

These and a simple README are available here
	http://developer.osdl.org/daniel/AIO/TESTS/

The good news was I  never got any non-zero data or oops on test7-mm1
(with the direct-io patch).

Unfortunately, when I ran these on test7, I also did not get any
non-zero data.  On AIO test7 still gives me oopses:

Slab corruption: start=e7d9573c, expend=e7d957db, problemat=e7d95774
Last user: [<c018b612>](__aio_put_req+0x97/0x185)
Data: ********************************************************00 00 89 02 00 00
00 00 ***********************************************************************************************A5
Next: 71 F0 2C .12 B6 18 C0 71 F0 2C .********************
slab error in check_poison_obj(): cache `kiocb': object was modified after freeing
Call Trace:
 [<c0148c95>] check_poison_obj+0x106/0x18f
 [<c0148ed4>] slab_destroy+0x1b6/0x1be
 [<c014bf2f>] reap_timer_fnc+0x254/0x326
 [<c014bcdb>] reap_timer_fnc+0x0/0x326
 [<c012d80d>] run_timer_softirq+0xed/0x226
 [<c0128dcd>] do_softirq+0xc9/0xcb
 [<c011a165>] smp_apic_timer_interrupt+0xcd/0x135
 [<c0108029>] default_idle+0x0/0x32
 [<c010b0b6>] apic_timer_interrupt+0x1a/0x20
 [<c0108029>] default_idle+0x0/0x32
 [<c0108056>] default_idle+0x2d/0x32
 [<c01080d4>] cpu_idle+0x3a/0x43
 [<c0125050>] printk+0x1b4/0x258


I guess this expected because it does not have the ref counting and
other AIO fixes.

I'm planning on doing more testing and write some AIO verses truncate
tests.

If you have any ideas on how to better test the AIO and O_DIRET changes
in -mm, just let me know.

Daniel

