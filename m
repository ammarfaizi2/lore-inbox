Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbWIEX5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbWIEX5e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 19:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbWIEX5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 19:57:34 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:61876 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S965216AbWIEX5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 19:57:32 -0400
From: Zach Brown <zach.brown@oracle.com>
To: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Message-Id: <20060905235732.29630.3950.sendpatchset@tetsuo.zabbo.net>
Subject: [RFC 0/5] dio: clean up completion phase of direct_io_worker()
Date: Tue,  5 Sep 2006 16:57:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dio: clean up completion phase of direct_io_worker()

There have been a lot of bugs recently due to the way direct_io_worker() tries
to decide how to finish direct IO operations.  In the worst examples it has
failed to call aio_complete() at all (hang) or called it too many times (oops).

This set of patches cleans up the completion phase with the goal of removing
the complexity that lead to these bugs.  We end up with one path that
calculates the result of the operation after all off the bios have completed.
We decide when to generate a result of the operation using that path based on
the final release of a refcount on the dio structure.

I tried to progress towards the final state in steps that were relatively easy
to understand.  Each step should compile but I only tested the final result of
having all the patches applied.

The patches result in a slight net decrease in code and binary size:

 2.6.18-rc4-dio-cleanup/fs/direct-io.c |    8
 2.6.18-rc5-dio-cleanup/fs/direct-io.c |   94 +++++------
 2.6.18-rc5-dio-cleanup/mm/filemap.c   |    4
 fs/direct-io.c                        |  273 ++++++++++++++--------------------
 4 files changed, 159 insertions(+), 220 deletions(-)

   text    data     bss     dec     hex filename
2592385  450996  210296 3253677  31a5ad vmlinux.before
2592113  450980  210296 3253389  31a48d vmlinux.after

The patches pass light testing with aio-stress, the direct IO tests I could
manage to get running in LTP, and some home-brew functional tests.  It's still
making its way through stress testing.  It should not be merged until we hear
from that more rigorous testing, I don't think.

I hoped to get some feedback (and maybe volunteers for testing!) by sending the
patches out before waiting for the stress tests.

- z
