Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVAEPwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVAEPwg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVAEPwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:52:32 -0500
Received: from main.gmane.org ([80.91.229.2]:7603 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261627AbVAEPjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:39:43 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Vincent Pelletier <subdino2004@yahoo.fr>
Subject: [PATCH] Re: 2.6.10 : fs/openpromfs/inode.c : small mistakes makes
 module oops   when writing
Date: Wed, 05 Jan 2005 16:39:21 +0100
Message-ID: <crh1ni$v8$1@sea.gmane.org>
References: <crbg4j$vbr$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA8A18A0459F3274E65B7733C"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adijon-152-1-53-74.w83-194.abo.wanadoo.fr
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: fr, en
In-Reply-To: <crbg4j$vbr$1@sea.gmane.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA8A18A0459F3274E65B7733C
Content-Type: multipart/mixed;
 boundary="------------050802080307020805050502"

This is a multi-part message in MIME format.
--------------050802080307020805050502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Here is the patch.

Changelog:
	2005/01/05  Vincent Pelletier  <subdino2004@yahoo.fr>
	inode.c: (nodenum_read, property_read, property_write):
	Protected against NULL parameters. property_read: Returns 0 when
	called with a 0-length buffer. (property_write): Don't expect an
	hex list to begin with a dot.

Vincent Pelletier


--------------050802080307020805050502
Content-Type: text/plain;
 name="openpromfs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openpromfs.diff"

--- linux-2.6.10/fs/openpromfs/inode.c	2004-12-24 22:34:44.000000000 +0100
+++ linux-2.6.10-openpromfs/fs/openpromfs/inode.c	2005-01-05 16:35:46.345978153 +0100
@@ -67,14 +67,15 @@
 static ssize_t nodenum_read(struct file *file, char __user *buf,
 			    size_t count, loff_t *ppos)
 {
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode;
 	char buffer[10];
 	
-	if (count < 0 || !inode->u.generic_ip)
+	if (!file || !buf || !ppos || !file->f_dentry || !file->f_dentry->d_inode)
 		return -EINVAL;
-	sprintf (buffer, "%8.8x\n", (u32)(long)(inode->u.generic_ip));
 	if (file->f_pos >= 9)
 		return 0;
+	inode = file->f_dentry->d_inode;
+	sprintf (buffer, "%8.8x\n", (u32)(long)(inode->u.generic_ip));
 	if (count > 9 - file->f_pos)
 		count = 9 - file->f_pos;
 	if (copy_to_user(buf, buffer + file->f_pos, count))
@@ -86,7 +87,7 @@
 static ssize_t property_read(struct file *filp, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode;
 	int i, j, k;
 	u32 node;
 	char *p, *s;
@@ -94,9 +95,12 @@
 	openprom_property *op;
 	char buffer[64];
 	
-	if (*ppos >= 0xffffff || count >= 0xffffff)
+	if (!filp || count >= 0xffffff || (count && !buf) || (ppos && *ppos >= 0xffffff) || !filp->f_dentry || !filp->f_dentry->d_inode)
 		return -EINVAL;
+	inode = filp->f_dentry->d_inode;
 	if (!filp->private_data) {
+		if(!nodes)
+			return -EIO;
 		node = nodes[(u16)((long)inode->u.generic_ip)].node;
 		i = ((u32)(long)inode->u.generic_ip) >> 16;
 		if ((u16)((long)inode->u.generic_ip) == aliases) {
@@ -166,7 +170,7 @@
 		}
 	} else
 		op = (openprom_property *)filp->private_data;
-	if (!count || !(op->len || (op->flag & OPP_ASCIIZ)))
+	if (!ppos || !count || !(op->len || (op->flag & OPP_ASCIIZ)))
 		return 0;
 	if (op->flag & OPP_STRINGLIST) {
 		for (k = 0, p = op->value; p < op->value + op->len; p++)
@@ -327,7 +331,7 @@
 	void *b;
 	openprom_property *op;
 	
-	if (*ppos >= 0xffffff || count >= 0xffffff)
+	if (!filp || !ppos || *ppos >= 0xffffff || count >= 0xffffff || (count && !buf))
 		return -EINVAL;
 	if (!filp->private_data) {
 		i = property_read (filp, NULL, 0, NULL);
@@ -343,13 +347,11 @@
 		char tmp [9];
 		int forcelen = 0;
 		
-		j = k % 9;
-		for (i = 0; i < count; i++, j++) {
-			if (j == 9) j = 0;
-			if (!j) {
-				char ctmp;
-				if (get_user(ctmp, &buf[i]))
-					return -EFAULT;
+		for (i = 0,j = k; i < count; i++,j++) {
+			char ctmp;
+			if (get_user(ctmp, &buf[i]))
+				return -EFAULT;
+			if (j && !((j+1)%9)) { /* every 9 char exept first of the file */
 				if (ctmp != '.') {
 					if (ctmp != '\n') {
 						if (op->flag & OPP_BINARY)
@@ -363,9 +365,6 @@
 					}
 				}
 			} else {
-				char ctmp;
-				if (get_user(ctmp, &buf[i]))
-					return -EFAULT;
 				if (ctmp < '0' || 
 				    (ctmp > '9' && ctmp < 'A') ||
 				    (ctmp > 'F' && ctmp < 'a') ||

--------------050802080307020805050502--

--------------enigA8A18A0459F3274E65B7733C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFB3Ao3ibN+MXHkAogRAuVwAKCEWkxBDIr2ZDVbsHvEGdZi8fXcawCXRjwJ
7hNpXDbf2ijqmCwbUHwR2w==
=Sgck
-----END PGP SIGNATURE-----

--------------enigA8A18A0459F3274E65B7733C--

