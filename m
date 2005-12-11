Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161092AbVLKFkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbVLKFkU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 00:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbVLKFkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 00:40:20 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:6575 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161092AbVLKFkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 00:40:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=KxRTOc2799oNs6MIIkl3T8mT3jw7vYwwDF0WRuqcTvf0l4sPX3gaJFPjsLqCEfr9ysOHeMeHL2adf8P4RSA/BqcvRD8lDFKstyab5GdrncLB63746FpvUFDrbSyBc/2ROjjnuKiBLaefKSM7akbArB8Uw0r6QfrX6uXexQ3xL2M=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Reduce nr of ptr derefs in fs/jffs2/summary.c
Date: Sun, 11 Dec 2005 06:40:48 +0100
User-Agent: KMail/1.9
Cc: David Woodhouse <dwmw2@infradead.org>, jffs-dev@axis.com,
       Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512110640.48356.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small patch to reduce the nr. of pointer dereferences in
fs/jffs2/summary.c

Benefits:
 - micro speed optimization due to fewer pointer derefs
 - generated code is slightly smaller
 - better readability

Please consider applying...


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/jffs2/summary.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

orig:
   text    data     bss     dec     hex filename
   5033       0       0    5033    13a9 fs/jffs2/summary.o
patched:
   text    data     bss     dec     hex filename
   4935       0       0    4935    1347 fs/jffs2/summary.o

--- linux-2.6.15-rc5-git1-orig/fs/jffs2/summary.c	2005-12-04 18:48:38.000000000 +0100
+++ linux-2.6.15-rc5-git1/fs/jffs2/summary.c	2005-12-11 06:01:51.000000000 +0100
@@ -581,16 +581,17 @@ static int jffs2_sum_write_data(struct j
 	wpage = c->summary->sum_buf;
 
 	while (c->summary->sum_num) {
+		temp = c->summary->sum_list_head;
 
-		switch (je16_to_cpu(c->summary->sum_list_head->u.nodetype)) {
+		switch (je16_to_cpu(temp->u.nodetype)) {
 			case JFFS2_NODETYPE_INODE: {
 				struct jffs2_sum_inode_flash *sino_ptr = wpage;
 
-				sino_ptr->nodetype = c->summary->sum_list_head->i.nodetype;
-				sino_ptr->inode = c->summary->sum_list_head->i.inode;
-				sino_ptr->version = c->summary->sum_list_head->i.version;
-				sino_ptr->offset = c->summary->sum_list_head->i.offset;
-				sino_ptr->totlen = c->summary->sum_list_head->i.totlen;
+				sino_ptr->nodetype = temp->i.nodetype;
+				sino_ptr->inode = temp->i.inode;
+				sino_ptr->version = temp->i.version;
+				sino_ptr->offset = temp->i.offset;
+				sino_ptr->totlen = temp->i.totlen;
 
 				wpage += JFFS2_SUMMARY_INODE_SIZE;
 
@@ -600,19 +601,19 @@ static int jffs2_sum_write_data(struct j
 			case JFFS2_NODETYPE_DIRENT: {
 				struct jffs2_sum_dirent_flash *sdrnt_ptr = wpage;
 
-				sdrnt_ptr->nodetype = c->summary->sum_list_head->d.nodetype;
-				sdrnt_ptr->totlen = c->summary->sum_list_head->d.totlen;
-				sdrnt_ptr->offset = c->summary->sum_list_head->d.offset;
-				sdrnt_ptr->pino = c->summary->sum_list_head->d.pino;
-				sdrnt_ptr->version = c->summary->sum_list_head->d.version;
-				sdrnt_ptr->ino = c->summary->sum_list_head->d.ino;
-				sdrnt_ptr->nsize = c->summary->sum_list_head->d.nsize;
-				sdrnt_ptr->type = c->summary->sum_list_head->d.type;
+				sdrnt_ptr->nodetype = temp->d.nodetype;
+				sdrnt_ptr->totlen = temp->d.totlen;
+				sdrnt_ptr->offset = temp->d.offset;
+				sdrnt_ptr->pino = temp->d.pino;
+				sdrnt_ptr->version = temp->d.version;
+				sdrnt_ptr->ino = temp->d.ino;
+				sdrnt_ptr->nsize = temp->d.nsize;
+				sdrnt_ptr->type = temp->d.type;
 
-				memcpy(sdrnt_ptr->name, c->summary->sum_list_head->d.name,
-							c->summary->sum_list_head->d.nsize);
+				memcpy(sdrnt_ptr->name, temp->d.name,
+							temp->d.nsize);
 
-				wpage += JFFS2_SUMMARY_DIRENT_SIZE(c->summary->sum_list_head->d.nsize);
+				wpage += JFFS2_SUMMARY_DIRENT_SIZE(temp->d.nsize);
 
 				break;
 			}
@@ -622,8 +623,7 @@ static int jffs2_sum_write_data(struct j
 			}
 		}
 
-		temp = c->summary->sum_list_head;
-		c->summary->sum_list_head = c->summary->sum_list_head->u.next;
+		c->summary->sum_list_head = temp->u.next;
 		kfree(temp);
 
 		c->summary->sum_num--;



