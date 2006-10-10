Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWJJSVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWJJSVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWJJSVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:21:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:20705 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965008AbWJJSVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:21:04 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, Joel.Becker@oracle.com
Cc: linux-kernel@vger.kernel.org, Chandra Seetharaman <sekharan@us.ibm.com>,
       ckrm-tech@lists.sourceforge.net
Date: Tue, 10 Oct 2006 11:20:49 -0700
Message-Id: <20061010182049.20990.84496.sendpatchset@localhost.localdomain>
In-Reply-To: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
Subject: [PATCH 1/5] Fix a module count leak.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

check_perm() does not drop the reference to the module when kmalloc()
failure occurs. This patch fixes the problem.

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
--

 fs/configfs/file.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

Index: linux-2.6.18/fs/configfs/file.c
===================================================================
--- linux-2.6.18.orig/fs/configfs/file.c
+++ linux-2.6.18/fs/configfs/file.c
@@ -275,14 +275,15 @@ static int check_perm(struct inode * ino
 	 * it in file->private_data for easy access.
 	 */
 	buffer = kmalloc(sizeof(struct configfs_buffer),GFP_KERNEL);
-	if (buffer) {
-		memset(buffer,0,sizeof(struct configfs_buffer));
-		init_MUTEX(&buffer->sem);
-		buffer->needs_read_fill = 1;
-		buffer->ops = ops;
-		file->private_data = buffer;
-	} else
+	if (!buffer) {
 		error = -ENOMEM;
+		goto Enomem;
+	}
+	memset(buffer,0,sizeof(struct configfs_buffer));
+	init_MUTEX(&buffer->sem);
+	buffer->needs_read_fill = 1;
+	buffer->ops = ops;
+	file->private_data = buffer;
 	goto Done;
 
  Einval:
@@ -290,6 +291,7 @@ static int check_perm(struct inode * ino
 	goto Done;
  Eaccess:
 	error = -EACCES;
+ Enomem:
 	module_put(attr->ca_owner);
  Done:
 	if (error && item)

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
