Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUIITQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUIITQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUIITQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:16:20 -0400
Received: from holomorphy.com ([207.189.100.168]:43698 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266768AbUIITPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:15:35 -0400
Date: Thu, 9 Sep 2004 12:15:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: [5/2] fix nommu VSZ reporting in consolidated task_mem()
Message-ID: <20040909191530.GJ3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909184300.GA28278@k3.hellgate.ch> <20040909184933.GG3106@holomorphy.com> <20040909190024.GH3106@holomorphy.com> <20040909190214.GI3106@holomorphy.com> <20040909190757.GA30582@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909190757.GA30582@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Sep 2004 12:02:14 -0700, William Lee Irwin III wrote:
>> +		stats->vmrss += mm->end_code - mm->start_code;

On Thu, Sep 09, 2004 at 09:07:57PM +0200, Roger Luethi wrote:
> s/vmrss/vmsize/ ?

This follows fs/proc/task_nommu.c:task_statm, which ->vmsize would not.
vmsize would be the sum of kobjsize(tblk->rblock->kblock) for each
tblock, which actually does need fixing in the above.


-- wli

Index: mm4-2.6.9-rc1/kernel/nproc.c
===================================================================
--- mm4-2.6.9-rc1.orig/kernel/nproc.c	2004-09-09 12:00:44.649267323 -0700
+++ mm4-2.6.9-rc1/kernel/nproc.c	2004-09-09 12:18:01.876793680 -0700
@@ -77,7 +77,7 @@
 			if (tblk->next)
 				stats->vmrss += kobjsize(tblk->next);
 			if (tblk->rblock) {
-				stats->vmsize += kobjsize(tblk->rblock);
+				stats->vmsize += kobjsize(tblk->rblock->kblock);
 				stats->vmrss += kobjsize(tblk->rblock);
 				stats->vmrss += kobjsize(tblk->rblock->kblock);
 			} else
