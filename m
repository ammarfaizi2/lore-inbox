Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269333AbUIIB1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269333AbUIIB1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 21:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269342AbUIIB1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 21:27:39 -0400
Received: from holomorphy.com ([207.189.100.168]:44716 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269341AbUIIB0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 21:26:47 -0400
Date: Wed, 8 Sep 2004 18:26:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: [3/2] round up text memory to the nearest page in fs/proc/task_mmu.c
Message-ID: <20040909012639.GO3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909004320.GJ3106@holomorphy.com> <20040909011549.GK3106@holomorphy.com> <20040909011708.GL3106@holomorphy.com> <20040909012137.GM3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909012137.GM3106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 06:21:37PM -0700, William Lee Irwin III wrote:
> Make __task_mem() and __task_mem_cheap() use the appropriate methods
> for CONFIG_MMU=y and add some attempt at correct code for CONFIG_MMU=n.
> The new methods for /proc/ accounting involve using counters kept in
> the mm instead of iteration over vmas. For the CONFIG_MMU=y case this
> does not involve acquiring mm->mmap_sem for any per-mm statistics. The
> CONFIG_MMU=n case still needs iteration over tblocks to calculate them.

Round up text memory to the nearest page to resolve potential alignment
anomalies in reported statistics. Compiletested on ia64.


-- wli

Index: mm4-2.6.9-rc1/fs/proc/task_mmu.c
===================================================================
--- mm4-2.6.9-rc1.orig/fs/proc/task_mmu.c	2004-09-08 06:10:35.000000000 -0700
+++ mm4-2.6.9-rc1/fs/proc/task_mmu.c	2004-09-08 18:27:39.401017905 -0700
@@ -9,7 +9,7 @@
 	unsigned long data, text, lib;
 
 	data = mm->total_vm - mm->shared_vm - mm->stack_vm;
-	text = (mm->end_code - mm->start_code) >> 10;
+	text = PAGE_ALIGN(mm->end_code - mm->start_code) >> 10;
 	lib = (mm->exec_vm << (PAGE_SHIFT-10)) - text;
 	buffer += sprintf(buffer,
 		"VmSize:\t%8lu kB\n"
