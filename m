Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbUENT1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUENT1C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 15:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUENT1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 15:27:02 -0400
Received: from outmx013.isp.belgacom.be ([195.238.3.64]:22466 "EHLO
	outmx013.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S262256AbUENT06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 15:26:58 -0400
Subject: [PATCH 2.6.6-mm2] vfs iput in inode critical region
From: FabF <Fabian.Frederick@skynet.be>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Tta9gu/ry2a73R9IodTM"
Message-Id: <1084476395.7979.10.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 13 May 2004 21:26:36 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx013.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Tta9gu/ry2a73R9IodTM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

	AFAICS, block_dev.c : do_open calls bdput after an unlock_kernel.bdput
calls iput and iput plays with some parameters and locks in iput final
case only.Here's a patch to have a spinlock around the whole iput.

Regards,
FabF 

--=-Tta9gu/ry2a73R9IodTM
Content-Disposition: attachment; filename=inodeputspin1.diff
Content-Type: text/x-patch; name=inodeputspin1.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/fs/inode.c edited/fs/inode.c
--- orig/fs/inode.c	2004-05-11 10:13:15.000000000 +0200
+++ edited/fs/inode.c	2004-05-13 21:10:48.000000000 +0200
@@ -1081,16 +1081,20 @@
 void iput(struct inode *inode)
 {
 	if (inode) {
+		spin_lock(&inode_lock);
 		struct super_operations *op = inode->i_sb->s_op;
 
 		if (inode->i_state == I_CLEAR)
 			BUG();
 
+		/*Calling fs relevant put_inode*/
 		if (op && op->put_inode)
 			op->put_inode(inode);
 
-		if (atomic_dec_and_lock(&inode->i_count, &inode_lock))
+		/*finalize if inode is unused*/
+		if (atomic_dec_and_test(&inode->i_count))
 			iput_final(inode);
+		spin_unlock(&inode_lock);
 	}
 }
 

--=-Tta9gu/ry2a73R9IodTM--

