Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263688AbUECRYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbUECRYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 13:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbUECRYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 13:24:41 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:215 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263688AbUECRYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 13:24:38 -0400
Date: Mon, 3 May 2004 19:24:37 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Subject: ATTR_ATTR_FLAG
Message-ID: <20040503172437.GA23521@MAIL.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks!

stumbled about ATTR_ATTR_FLAG, and asked myself,
shouldn't this be handled in *_setattr() too?

maybe something like this:
(of course it would need some modifications for
filesystems handling *_setattr special)

best,
Herbert

--- linux/fs/attr.c	2002-02-25 20:38:07.000000000 +0100
+++ linux.new/fs/attr.c	2004-04-30 23:55:01.000000000 +0200
@@ -58,6 +58,?? @@ error:
 	return retval;
 }
 
+
+int inode_setattr_flags(struct inode *inode, unsigned int flags)
+{
+	unsigned int oldflags, newflags;
+
+	oldflags = inode->i_flags;
+	newflags = oldflags & ~(S_SYNC | S_NOATIME | S_APPEND | S_IMMUTABLE);
+	if (flags & ATTR_FLAG_SYNCRONOUS)
+		newflags |= S_SYNC;
+	if (flags & ATTR_FLAG_NOATIME || flags & ATTR_FLAG_NODIRATIME)
+		newflags |= S_NOATIME;
+	if (flags & ATTR_FLAG_APPEND)
+		newflags |= S_APPEND;
+	if (flags & ATTR_FLAG_IMMUTABLE)
+		newflags |= S_IMMUTABLE;
+
+	if (oldflags ^ newflags) {
+		inode->i_flags = newflags;
+	}
+	return 0;
+}
+
+
 int inode_setattr(struct inode * inode, struct iattr * attr)
 {
 	unsigned int ia_valid = attr->ia_valid;
@@ -84,6 +112,8 @@ int inode_setattr(struct inode * inode, 
 		if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
 			inode->i_mode &= ~S_ISGID;
 	}
+	if (ia_valid & ATTR_ATTR_FLAG)
+		inode_setattr_flags(inode, attr->ia_attr_flags);
 	mark_inode_dirty(inode);
 out:
 	return error;

