Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbVGHKc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVGHKc2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbVGHK15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:27:57 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5079 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262471AbVGHK0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:26:09 -0400
Subject: [RFC PATCH 6/8] clone a namespace containing
	shared/private/slave/unclone tree
From: Ram <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@osdl.org>, mike@waychison.com, bfields@fieldses.org,
       Miklos Szeredi <miklos@szeredi.hu>
In-Reply-To: <1120816720.30164.28.camel@localhost>
References: <1120816072.30164.10.camel@localhost>
	 <1120816229.30164.13.camel@localhost> <1120816355.30164.16.camel@localhost>
	 <1120816436.30164.19.camel@localhost> <1120816521.30164.22.camel@localhost>
	 <1120816600.30164.25.camel@localhost> <1120816720.30164.28.camel@localhost>
Content-Type: multipart/mixed; boundary="=-j+Qw4fNk16tDXac2sTXO"
Organization: IBM 
Message-Id: <1120817785.30164.54.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Jul 2005 03:26:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-j+Qw4fNk16tDXac2sTXO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Adds ability to clone a namespace that has shared/private/slave/unclone
subtrees in it.

RP


--=-j+Qw4fNk16tDXac2sTXO
Content-Disposition: attachment; filename=namespace.patch
Content-Type: text/x-patch; name=namespace.patch
Content-Transfer-Encoding: 7bit

Adds ability to clone a namespace that has shared/private/slave/unclone
subtrees in it.

RP


Signed by Ram Pai (linuxram@us.ibm.com)

 namespace.c |    9 +++++++++
 1 files changed, 9 insertions(+)

Index: 2.6.12/fs/namespace.c
===================================================================
--- 2.6.12.orig/fs/namespace.c
+++ 2.6.12/fs/namespace.c
@@ -1685,6 +1685,12 @@ int copy_namespace(int flags, struct tas
 	q = new_ns->root;
 	while (p) {
 		q->mnt_namespace = new_ns;
+
+		if (IS_MNT_SHARED(q))
+			pnode_add_member_mnt(q->mnt_pnode, q);
+		else if (IS_MNT_SLAVE(q))
+			SET_MNT_PRIVATE(q);
+
 		if (fs) {
 			if (p == fs->rootmnt) {
 				rootmnt = p;
@@ -2054,6 +2060,8 @@ void __put_namespace(struct namespace *n
 	spin_lock(&vfsmount_lock);
 
 	list_for_each_entry(mnt, &namespace->list, mnt_list) {
+		if (mnt->mnt_pnode)
+			pnode_disassociate_mnt(mnt);
 		mnt->mnt_namespace = NULL;
 	}
 

--=-j+Qw4fNk16tDXac2sTXO--

