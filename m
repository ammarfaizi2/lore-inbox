Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266851AbUFYTSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266851AbUFYTSv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 15:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266847AbUFYTSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 15:18:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:3565 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266852AbUFYTSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 15:18:15 -0400
Subject: [PATCH] PCI insert_resource() nesting fix
From: John Rose <johnrose@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org, greg@kroah.org
Content-Type: text/plain
Message-Id: <1088191293.29106.13.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 25 Jun 2004 14:21:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed that insert_resource() incorrectly handles the case of an existing
parent resource with the same ending address as a newly added child. 
This results in incorrect nesting, like the following:

# cat /proc/ioports
<snip>
002f0000-002fffff : PCI Bus #48
  00200000-002fffff : /pci@800000020000003
</snip>

Thanks-
John

Signed-off-by: John Rose <johnrose@austin.ibm.com>

diff -Nru a/kernel/resource.c b/kernel/resource.c
--- a/kernel/resource.c	Mon Jun 14 15:42:29 2004
+++ b/kernel/resource.c	Mon Jun 14 15:42:29 2004
@@ -332,8 +332,8 @@
 		if (next->sibling->start > new->end)
 			break;
 
-	/* existing resource overlaps end of new resource */
-	if (next->end > new->end) {
+	/* existing resource includes new resource */
+	if (next->end >= new->end) {
 		parent = next;
 		result = 0;
 		goto begin;

