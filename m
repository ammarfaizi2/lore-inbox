Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbVIAQ1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbVIAQ1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 12:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbVIAQ1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 12:27:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58851 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030232AbVIAQ1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 12:27:20 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE LINUX Products GMBH
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [patch] nfsacl: Solaris VxFS compatibility fix
Date: Thu, 1 Sep 2005 18:27:17 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, okir@suse.de,
       Neil Brown <neilb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509011827.18437.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond,

here is a compatibility fix between Linux and Solaris when used with VxFS filesystems: Solaris
usually accepts acl entries in any order, but with VxFS it replies with NFSERR_INVAL when it
sees a four-entry acl that is not in canonical form. It may also fail with other non-canonical
acls -- I can't tell, because that case never triggers: We only send non-canonical acls
when we fake up an ACL_MASK entry.

Instead of adding fake ACL_MASK entries at the end, inserting them in the correct position makes
Solaris+VxFS happy. The Linux client and server sides don't care about entry order. The three-entry-acl
special case in which we need a fake ACL_MASK entry was handled in xdr_nfsace_encode. The patch
moves this into nfsacl_encode.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.13-nfsacl-fix/fs/nfs_common/nfsacl.c
===================================================================
--- linux-2.6.13-nfsacl-fix.orig/fs/nfs_common/nfsacl.c
+++ linux-2.6.13-nfsacl-fix/fs/nfs_common/nfsacl.c
@@ -48,43 +48,26 @@ xdr_nfsace_encode(struct xdr_array2_desc
 		(struct nfsacl_encode_desc *) desc;
 	u32 *p = (u32 *) elem;
 
-	if (nfsacl_desc->count < nfsacl_desc->acl->a_count) {
-		struct posix_acl_entry *entry =
-			&nfsacl_desc->acl->a_entries[nfsacl_desc->count++];
+	struct posix_acl_entry *entry =
+		&nfsacl_desc->acl->a_entries[nfsacl_desc->count++];
 
-		*p++ = htonl(entry->e_tag | nfsacl_desc->typeflag);
-		switch(entry->e_tag) {
-			case ACL_USER_OBJ:
-				*p++ = htonl(nfsacl_desc->uid);
-				break;
-			case ACL_GROUP_OBJ:
-				*p++ = htonl(nfsacl_desc->gid);
-				break;
-			case ACL_USER:
-			case ACL_GROUP:
-				*p++ = htonl(entry->e_id);
-				break;
-			default:  /* Solaris depends on that! */
-				*p++ = 0;
-				break;
-		}
-		*p++ = htonl(entry->e_perm & S_IRWXO);
-	} else {
-		const struct posix_acl_entry *pa, *pe;
-		int group_obj_perm = ACL_READ|ACL_WRITE|ACL_EXECUTE;
-
-		FOREACH_ACL_ENTRY(pa, nfsacl_desc->acl, pe) {
-			if (pa->e_tag == ACL_GROUP_OBJ) {
-				group_obj_perm = pa->e_perm & S_IRWXO;
-				break;
-			}
-		}
-		/* fake up ACL_MASK entry */
-		*p++ = htonl(ACL_MASK | nfsacl_desc->typeflag);
-		*p++ = htonl(0);
-		*p++ = htonl(group_obj_perm);
+	*p++ = htonl(entry->e_tag | nfsacl_desc->typeflag);
+	switch(entry->e_tag) {
+		case ACL_USER_OBJ:
+			*p++ = htonl(nfsacl_desc->uid);
+			break;
+		case ACL_GROUP_OBJ:
+			*p++ = htonl(nfsacl_desc->gid);
+			break;
+		case ACL_USER:
+		case ACL_GROUP:
+			*p++ = htonl(entry->e_id);
+			break;
+		default:  /* Solaris depends on that! */
+			*p++ = 0;
+			break;
 	}
-
+	*p++ = htonl(entry->e_perm & S_IRWXO);
 	return 0;
 }
 
@@ -105,11 +88,28 @@ nfsacl_encode(struct xdr_buf *buf, unsig
 		.gid = inode->i_gid,
 	};
 	int err;
+	struct posix_acl *acl2 = NULL;
 
 	if (entries > NFS_ACL_MAX_ENTRIES ||
 	    xdr_encode_word(buf, base, entries))
 		return -EINVAL;
+	if (encode_entries && acl && acl->a_count == 3) {
+		/* Fake up an ACL_MASK entry. */
+		acl2 = posix_acl_alloc(4, GFP_KERNEL);
+		if (!acl2)
+			return -ENOMEM;
+		/* Insert entries in canonical order: other orders seem
+		 to confuse Solaris VxFS. */
+		acl2->a_entries[0] = acl->a_entries[0];  /* ACL_USER_OBJ */
+		acl2->a_entries[1] = acl->a_entries[1];  /* ACL_GROUP_OBJ */
+		acl2->a_entries[2] = acl->a_entries[1];  /* ACL_MASK */
+		acl2->a_entries[2].e_tag = ACL_MASK;
+		acl2->a_entries[3] = acl->a_entries[2];  /* ACL_OTHER */
+		nfsacl_desc.acl = acl2;
+	}
 	err = xdr_encode_array2(buf, base + 4, &nfsacl_desc.desc);
+	if (acl2)
+		posix_acl_release(acl2);
 	if (!err)
 		err = 8 + nfsacl_desc.desc.elem_size *
 			  nfsacl_desc.desc.array_len;
