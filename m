Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268671AbUHaOfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268671AbUHaOfZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 10:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268672AbUHaOfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 10:35:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36300 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268671AbUHaOfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 10:35:07 -0400
Date: Tue, 31 Aug 2004 10:34:49 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: Root reservations for strict overcommit
Message-ID: <20040831143449.GA26680@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was on my TODO list for a while and it turns out someone already fixed the
armwaving overcommit mode for the same problem. It is easy to get into a
situation where you have no overcommit and nothing can be done because there is
no memory to clean up the stable but non-useful state of the machine.

The fix is trivial and duplicated from the armwaving overcommit code path.
The last 3% of the memory can be claimed by root processes only. It isn't a
cure but it does seem to solve the real world problems - at least providing
you have enough memory for 3% to be useful 8).

--- security/commoncap.c~	2004-08-31 15:27:46.777504736 +0100
+++ security/commoncap.c	2004-08-31 15:27:46.778504584 +0100
@@ -357,6 +357,11 @@
 
 	allowed = (totalram_pages - hugetlb_total_pages())
 	       	* sysctl_overcommit_ratio / 100;
+	/*
+	 * Leave the last 3% for root
+	 */
+	if (!capable(CAP_SYS_ADMIN))
+		allowed -= allowed / 32;
 	allowed += total_swap_pages;
 
 	if (atomic_read(&vm_committed_space) < allowed)
