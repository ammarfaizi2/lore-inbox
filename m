Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965525AbWJBXVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965525AbWJBXVV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 19:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965521AbWJBXVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 19:21:21 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:24791 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S964974AbWJBXVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 19:21:20 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Message-Id: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net>
Subject: [PATCH take2 0/5] dio: clean up completion phase of direct_io_worker()
Date: Mon,  2 Oct 2006 16:21:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dio: clean up completion phase of direct_io_worker()

Andrew, testing has now uncovered 2 bugs in this patch set that have been
fixed.  XFS and the generic file path were using blkdev_direct_IO()'s return
code to test if ops were in flight and were missing EIOCBQUEUD.  They've been
fixed.  I think this can bake in -mm now.

Here's the initial introduction to the series with an update on what's
been tested:

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

I've tested these on low end PC drives with aio-stress, the direct IO tests I
could manage to get running in LTP, orasim, and some home-brew functional
tests.

In http://lkml.org/lkml/2006/9/21/103 IBM reports success with ext2 and ext3
running DIO LTP tests.  They found that XFS bug which has since been addressed
in the patch series.

- z
