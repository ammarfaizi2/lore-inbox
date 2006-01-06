Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWAFVvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWAFVvt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbWAFVvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:51:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20883 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752487AbWAFVv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:51:27 -0500
Subject: [patch 3/4] fix cifs bugs wrt writing to f_ops
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: sfrench@us.ibm.com, akpms@Osdl.org
In-Reply-To: <1136583937.2940.90.camel@laptopd505.fenrus.org>
References: <1136583937.2940.90.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 22:49:26 +0100
Message-Id: <1136584166.2940.98.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>

patch 2ea55c01e0c5dfead8699484b0bae2a375b1f61c fixed CIFS clobbering the
global fops structure for some per mount setting, by duplicating and having
2 fops structs. However the write to the fops was left behind, which is a
NOP in practice (due to the fact that we KNOW the fops has that field set to
NULL already due to the duplication). So remove it... In addition, another
instance of the same bug was forgotten in november.

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
CC: Steve French <sfrench@us.ibm.com>

 fs/cifs/readdir.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

Index: linux-2.6.15/fs/cifs/readdir.c
===================================================================
--- linux-2.6.15.orig/fs/cifs/readdir.c
+++ linux-2.6.15/fs/cifs/readdir.c
@@ -214,8 +214,7 @@ static void fill_in_inode(struct inode *
 			tmp_inode->i_fop = &cifs_file_nobrl_ops;
 		else
 			tmp_inode->i_fop = &cifs_file_ops;
-		if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_BRL)
-			tmp_inode->i_fop->lock = NULL;
+
 		tmp_inode->i_data.a_ops = &cifs_addr_ops;
 		if((cifs_sb->tcon) && (cifs_sb->tcon->ses) &&
 		   (cifs_sb->tcon->ses->server->maxBuf <
@@ -327,12 +326,18 @@ static void unix_fill_in_inode(struct in
 	if (S_ISREG(tmp_inode->i_mode)) {
 		cFYI(1, ("File inode"));
 		tmp_inode->i_op = &cifs_file_inode_ops;
-		if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DIRECT_IO)
-			tmp_inode->i_fop = &cifs_file_direct_ops;
+
+		if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DIRECT_IO) {
+			if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_BRL)
+				tmp_inode->i_fop = &cifs_file_direct_nobrl_ops;
+			else
+				tmp_inode->i_fop = &cifs_file_direct_ops;
+		
+		} else if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_BRL)
+			tmp_inode->i_fop = &cifs_file_nobrl_ops;
 		else
 			tmp_inode->i_fop = &cifs_file_ops;
-		if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_BRL)
-			tmp_inode->i_fop->lock = NULL;
+
 		tmp_inode->i_data.a_ops = &cifs_addr_ops;
 		if((cifs_sb->tcon) && (cifs_sb->tcon->ses) &&
 		   (cifs_sb->tcon->ses->server->maxBuf < 


