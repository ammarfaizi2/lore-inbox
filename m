Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265703AbUFOPnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265703AbUFOPnr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 11:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265706AbUFOPnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 11:43:47 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:36810 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265703AbUFOPnj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 11:43:39 -0400
Subject: [PATCH] insert_resource fix
From: John Rose <johnrose@austin.ibm.com>
To: torvalds@osdl.org
Cc: greg@kroah.org, lkml <linux-kernel@vger.kernel.org>,
       Mike Wortman <wortman@us.ibm.com>
Content-Type: text/plain
Message-Id: <1087314094.3094.9.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Jun 2004 10:41:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Greg-

I sent this yesterday to lkml, but forgot to copy Linus and forgot to
sign off.  And I used the wrong address for Greg :)

Noticed that insert_resource() incorrectly handles the case of an existing
parent resource with the same ending address as a newly added child.  This
results in incorrect nesting, like the following:

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

