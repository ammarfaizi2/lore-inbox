Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWFATz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWFATz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 15:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWFATz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 15:55:58 -0400
Received: from users.ccur.com ([66.10.65.2]:56444 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S1030202AbWFATz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 15:55:57 -0400
Date: Thu, 1 Jun 2006 15:55:35 -0400
From: Joe Korty <joe.korty@ccur.com>
To: linux-kernel@vger.kernel.org
Cc: drepper@redhat.com, akpm@osdl.org, Trond.Myklebust@netapp.com,
       mingo@elte.hu
Subject: lock_kernel called under spinlock in NFS
Message-ID: <20060601195535.GA28188@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tree 5fdccf2354269702f71beb8e0a2942e4167fd992

        [PATCH] vfs: *at functions: core

introduced a bug where lock_kernel() can be called from
under a spinlock.  To trigger the bug one must have
CONFIG_PREEMPT_BKL=y and be using NFS heavily.  It is
somewhat rare and, so far, haven't traced down the userland
sequence that causes the fatal path to be taken.

The bug was caused by the insertion into do_path_lookup()
of a call to file_permission().  do_path_lookup()
read-locks current->fs->lock for most of its operation.
file_permission() calls permission() which calls
nfs_permission(), which has one path through it
that uses lock_kernel().

I am not sure how to fix this bug.  It is not clear what
the lock_kernel() call is protecting. Nor is it clear why,
as part of the introduction of the openat() etc services,
it was desirable to add a call to file_permission()
to do_path_lookup().

For now, I plan to turn off CONFIG_PREEMPT_BKL.

Regards,
Joe
