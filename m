Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWEPTUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWEPTUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWEPTUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:20:31 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:25522 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751079AbWEPTUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:20:30 -0400
Date: Tue, 16 May 2006 21:20:29 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] openpromfs: factorize out
Message-ID: <Pine.LNX.4.61.0605162119060.26647@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Move" "common code" out to PTR_NOD, which does the conversion from private 
pointer to node number. This is to reduce potential casting/conversion 
errors due to redundancy. (The naming PTR_NOD follows PTR_ERR, turning a 
pointer into xyz.)

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

diff --fast -Ndpru linux-2.6.17-rc4~/fs/openpromfs/inode.c linux-2.6.17-rc4+/fs/openpromfs/inode.c
--- linux-2.6.17-rc4~/fs/openpromfs/inode.c	2006-05-16 21:00:09.445807000 +0200
+++ linux-2.6.17-rc4+/fs/openpromfs/inode.c	2006-05-16 20:59:53.845807000 +0200
@@ -64,6 +64,10 @@ static int openpromfs_readdir(struct fil
 static struct dentry *openpromfs_lookup(struct inode *, struct dentry *dentry, struct nameidata *nd);
 static int openpromfs_unlink (struct inode *, struct dentry *dentry);
 
+static inline u16 PTR_NOD(void *p) {
+    return (long)p & 0xFFFF;
+}
+
 static ssize_t nodenum_read(struct file *file, char __user *buf,
 			    size_t count, loff_t *ppos)
 {
@@ -95,9 +99,9 @@ static ssize_t property_read(struct file
 	char buffer[64];
 	
 	if (!filp->private_data) {
-		node = nodes[(u16)((long)inode->u.generic_ip)].node;
+		node = nodes[PTR_NOD(inode->u.generic_ip)].node;
 		i = ((u32)(long)inode->u.generic_ip) >> 16;
-		if ((u16)((long)inode->u.generic_ip) == aliases) {
+		if (PTR_NOD(inode->u.generic_ip) == aliases) {
 			if (i >= aliases_nodes)
 				p = NULL;
 			else
@@ -111,7 +115,7 @@ static ssize_t property_read(struct file
 			return -EIO;
 		i = prom_getproplen (node, p);
 		if (i < 0) {
-			if ((u16)((long)inode->u.generic_ip) == aliases)
+			if (PTR_NOD(inode->u.generic_ip) == aliases)
 				i = 0;
 			else
 				return -EIO;
@@ -540,8 +544,8 @@ int property_release (struct inode *inod
 	if (!op)
 		return 0;
 	lock_kernel();
-	node = nodes[(u16)((long)inode->u.generic_ip)].node;
-	if ((u16)((long)inode->u.generic_ip) == aliases) {
+	node = nodes[PTR_NOD(inode->u.generic_ip)].node;
+	if (PTR_NOD(inode->u.generic_ip) == aliases) {
 		if ((op->flag & OPP_DIRTY) && (op->flag & OPP_STRING)) {
 			char *p = op->name;
 			int i = (op->value - op->name) - strlen (op->name) - 1;
#<<eof>>

Jan Engelhardt
-- 
