Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTLSRfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 12:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTLSRfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 12:35:37 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:34460 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263496AbTLSRfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 12:35:36 -0500
Date: Fri, 19 Dec 2003 09:22:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, David Mosberger <davidm@napali.hpl.hp.com>,
       Andi Kleen <ak@muc.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test11-mm1 doesn't compile on x86_64
Message-ID: <41640000.1071854568@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/proc/task_mmu.c: In function `show_map':
fs/proc/task_mmu.c:127: `gate_dso_path' undeclared (first use in this function)
fs/proc/task_mmu.c:127: (Each undeclared identifier is reported only once
fs/proc/task_mmu.c:127: for each function it appears in.)
make[2]: *** [fs/proc/task_mmu.o] Error 1
make[1]: *** [fs/proc] Error 2
make: *** [fs] Error 2
make: *** Waiting for unfinished jobs....

It seems to be fixmap-in-proc-pid-maps-ng.patch that's broken
(davidm cc'ed). Maybe something as simple as the below fixes it.
Or maybe it's total crap ... I don't really know what AT_SYSINFO_EHDR
is, but presumably someone does.

M.

diff -urpN -X /home/fletch/.diff.exclude mm1/fs/proc/task_mmu.c mm1-fix/fs/proc/task_mmu.c
--- mm1/fs/proc/task_mmu.c	Fri Dec 19 09:15:45 2003
+++ mm1-fix/fs/proc/task_mmu.c	Fri Dec 19 09:21:11 2003
@@ -76,9 +76,10 @@ int task_statm(struct mm_struct *mm, int
 	return size;
 }
 
+char gate_dso_path[256] = "";
+
 #ifdef AT_SYSINFO_EHDR
 
-char gate_dso_path[256] = "";
 static struct vm_area_struct gate_vmarea = {
 	/* Do _not_ mark this area as readable, cuz not the entire range may be readable
 	   (e.g., due to execute-only pages or holes) and the tools that read

