Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVBPXeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVBPXeL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 18:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVBPXeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 18:34:10 -0500
Received: from mx1.mail.ru ([194.67.23.121]:28033 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S262127AbVBPXcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 18:32:45 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH] fs/cifs/cifssmb.c: fix endianness warnings
Date: Thu, 17 Feb 2005 02:32:42 +0200
User-Agent: KMail/1.6.2
Cc: Steve French <sfrench@samba.org>, linux-kernel@vger.kernel.org,
       samba-technical@lists.samba.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200502170232.42363.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/cifs/cifssmb.c: fix endianness warnings brought by __le'ifying
posix_acl_xattr_entry.

Patch for posix_acl_xattr_entry is at:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=110858530106333&q=raw

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

Index: linux-warnings/fs/cifs/cifssmb.c
===================================================================
--- linux-warnings/fs/cifs/cifssmb.c	(revision 9)
+++ linux-warnings/fs/cifs/cifssmb.c	(revision 10)
@@ -1764,9 +1764,9 @@
 static void cifs_convert_ace(posix_acl_xattr_entry * ace, struct cifs_posix_ace * cifs_ace)
 {
 	/* u8 cifs fields do not need le conversion */
-	ace->e_perm = (__u16)cifs_ace->cifs_e_perm; 
-	ace->e_tag  = (__u16)cifs_ace->cifs_e_tag;
-	ace->e_id   = (__u32)le64_to_cpu(cifs_ace->cifs_uid);
+	ace->e_perm = cpu_to_le16((__u16)cifs_ace->cifs_e_perm);
+	ace->e_tag  = cpu_to_le16((__u16)cifs_ace->cifs_e_tag);
+	ace->e_id   = cpu_to_le32((__u32)le64_to_cpu(cifs_ace->cifs_uid));
 	/* cFYI(1,("perm %d tag %d id %d",ace->e_perm,ace->e_tag,ace->e_id)); */
 
 	return;
@@ -1817,7 +1817,7 @@
 	} else if(size > buflen) {
 		return -ERANGE;
 	} else /* buffer big enough */ {
-		local_acl->a_version = POSIX_ACL_XATTR_VERSION;
+		local_acl->a_version = cpu_to_le32(POSIX_ACL_XATTR_VERSION);
 		for(i = 0;i < count ;i++) {
 			cifs_convert_ace(&local_acl->a_entries[i],pACE);
 			pACE ++;
@@ -1831,14 +1831,15 @@
 {
 	__u16 rc = 0; /* 0 = ACL converted ok */
 
-	cifs_ace->cifs_e_perm = (__u8)cpu_to_le16(local_ace->e_perm);
-	cifs_ace->cifs_e_tag =  (__u8)cpu_to_le16(local_ace->e_tag);
+	cifs_ace->cifs_e_perm = (__u8)le16_to_cpu(local_ace->e_perm);
+	cifs_ace->cifs_e_tag = (__u8)le16_to_cpu(local_ace->e_tag);
 	/* BB is there a better way to handle the large uid? */
-	if(local_ace->e_id == -1) {
+	if(local_ace->e_id == cpu_to_le32(-1)) {
 	/* Probably no need to le convert -1 on any arch but can not hurt */
 		cifs_ace->cifs_uid = cpu_to_le64(-1);
 	} else 
-		cifs_ace->cifs_uid = (__u64)cpu_to_le32(local_ace->e_id);
+		cifs_ace->cifs_uid =
+			cpu_to_le64((__u64)le32_to_cpu(local_ace->e_id));
         /*cFYI(1,("perm %d tag %d id %d",ace->e_perm,ace->e_tag,ace->e_id));*/
 	return rc;
 }
@@ -1859,15 +1860,15 @@
 	count = posix_acl_xattr_count((size_t)buflen);
 	cFYI(1,("setting acl with %d entries from buf of length %d and version of %d",
 		count,buflen,local_acl->a_version));
-	if(local_acl->a_version != 2) {
+	if(local_acl->a_version != cpu_to_le32(POSIX_ACL_XATTR_VERSION)) {
 		cFYI(1,("unknown POSIX ACL version %d",local_acl->a_version));
 		return 0;
 	}
 	cifs_acl->version = cpu_to_le16(1);
 	if(acl_type == ACL_TYPE_ACCESS) 
-		cifs_acl->access_entry_count = count;
+		cifs_acl->access_entry_count = cpu_to_le16(count);
 	else if(acl_type == ACL_TYPE_DEFAULT)
-		cifs_acl->default_entry_count = count;
+		cifs_acl->default_entry_count = cpu_to_le16(count);
 	else {
 		cFYI(1,("unknown ACL type %d",acl_type));
 		return 0;
