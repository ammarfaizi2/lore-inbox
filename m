Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWHCDbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWHCDbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 23:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWHCDbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 23:31:44 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:22195 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932167AbWHCDbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 23:31:43 -0400
Date: Thu, 3 Aug 2006 12:33:22 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: LHMS <lhms-devel@lists.sourceforge.net>,
       "kmannth@us.ibm.com" <kmannth@us.ibm.com>,
       "y-goto@jp.fujitsu.com" <y-goto@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] memory hotadd fixes [2/5] change find_next_system_ram's
 return value manner
Message-Id: <20060803123322.baa6877b.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

find_next_system_ram() returns valid memory range which meets requested
area, only used by memory-hot-add.
This function always rewrite requested resource even if returned area is
not fully fit in requested one. And sometimes the returnd resource is larger
than requested area. This annoyes the caller.
This patch changes the returned value to fit in requested area.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 kernel/resource.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc3/kernel/resource.c
===================================================================
--- linux-2.6.18-rc3.orig/kernel/resource.c	2006-08-01 16:11:56.000000000 +0900
+++ linux-2.6.18-rc3/kernel/resource.c	2006-08-01 16:38:45.000000000 +0900
@@ -261,8 +261,10 @@
 	if (!p)
 		return -1;
 	/* copy data */
-	res->start = p->start;
-	res->end = p->end;
+	if (res->start < p->start)
+		res->start = p->start;
+	if (res->end > p->end)
+		res->end = p->end;
 	return 0;
 }
 #endif

