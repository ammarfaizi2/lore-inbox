Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVC1Rzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVC1Rzb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVC1Rpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:45:51 -0500
Received: from fep19.inet.fi ([194.251.242.244]:9887 "EHLO fep19.inet.fi")
	by vger.kernel.org with ESMTP id S261972AbVC1Rl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:41:58 -0500
Subject: [PATCH 5/9] isofs: convert macro to function in rock.c
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ie2p4s.1rtfc3.1osta177x31dpyo6jw6k30rf8.refire@cs.helsinki.fi>
In-Reply-To: <ie2p4k.4drbt3.auj0ip4uwd2grudve6958nc1i.refire@cs.helsinki.fi>
Date: Mon, 28 Mar 2005 20:41:57 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the SETUP_ROCK_RIDGE macro to a proper function in
fs/isofs/rock.c.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 rock.c |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

Index: 2.6/fs/isofs/rock.c
===================================================================
--- 2.6.orig/fs/isofs/rock.c	2005-03-28 16:31:53.000000000 +0300
+++ 2.6/fs/isofs/rock.c	2005-03-28 16:32:13.000000000 +0300
@@ -38,18 +38,22 @@
    same thing in certain places.  We use the macros to ensure that everything
    is done correctly */
 
-#define SETUP_ROCK_RIDGE(DE,CHR,LEN)	      		      	\
-  {LEN= sizeof(struct iso_directory_record) + DE->name_len[0];	\
-  if(LEN & 1) LEN++;						\
-  CHR = ((unsigned char *) DE) + LEN;				\
-  LEN = *((unsigned char *) DE) - LEN;                          \
-  if (LEN<0) LEN=0;                                             \
-  if (ISOFS_SB(inode->i_sb)->s_rock_offset!=-1)                \
-  {                                                             \
-     LEN-=ISOFS_SB(inode->i_sb)->s_rock_offset;                \
-     CHR+=ISOFS_SB(inode->i_sb)->s_rock_offset;                \
-     if (LEN<0) LEN=0;                                          \
-  }                                                             \
+static int setup_rock_ridge(struct iso_directory_record *de, struct inode *inode, unsigned char ** chr)
+{
+	int len = sizeof(struct iso_directory_record) + de->name_len[0];
+	if (len & 1)
+		len++;
+	*chr = ((unsigned char *) de) + len;
+	len = *((unsigned char *) de) - len;
+	if (len < 0)
+		len = 0;
+	if (ISOFS_SB(inode->i_sb)->s_rock_offset != -1) {
+		len -= ISOFS_SB(inode->i_sb)->s_rock_offset;
+		*chr += ISOFS_SB(inode->i_sb)->s_rock_offset;
+		if (len < 0)
+			len = 0;
+	}
+	return len;
 }
 
 /* return length of name field; 0: not found, -1: to be ignored */
@@ -66,7 +70,7 @@
 		return 0;
 	*retname = 0;
 
-	SETUP_ROCK_RIDGE(de, chr, len);
+	len = setup_rock_ridge(de, inode, &chr);
       repeat:
 	{
 		struct rock_ridge *rr;
@@ -187,7 +191,7 @@
 	if (!ISOFS_SB(inode->i_sb)->s_rock)
 		return 0;
 
-	SETUP_ROCK_RIDGE(de, chr, len);
+	len = setup_rock_ridge(de, inode, &chr);
 	if (regard_xa) {
 		chr += 14;
 		len -= 14;
@@ -589,7 +593,7 @@
 	/* Now test for possible Rock Ridge extensions which will override
 	   some of these numbers in the inode structure. */
 
-	SETUP_ROCK_RIDGE(raw_inode, chr, len);
+	len = setup_rock_ridge(raw_inode, inode, &chr);
 
       repeat:
 	while (len > 2) {	/* There may be one byte for padding somewhere */
