Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbUCYOxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 09:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbUCYOxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 09:53:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20204 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263169AbUCYOxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 09:53:35 -0500
Date: Thu, 25 Mar 2004 09:53:34 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: linux-kernel@vger.kernel.org
Subject: [SELINUX] check return value for receive node permission (fwd)
Message-ID: <Xine.LNX.4.44.0403250952540.32174-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this got lost while lkml was down.

---------- Forwarded message ----------
Date: Thu, 25 Mar 2004 00:56:02 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org
Subject: [SELINUX] check return value for receive node permission

This patch fixes a bug where the return value for a permission call is not 
checked.

The bug was introduced when I added some code in the following changeset:

<http://linux.bkbits.net:8080/linux-2.5/diffs/security/selinux/hooks.c@1.19?nav=index.html|src/|src/security|src/security/selinux|hist/security/selinux/hooks.c>

Code was added after this line:

	err = avc_has_perm(isec->sid, node_sid, SECCLASS_NODE, node_perm, NULL, &ad);

without adding an explicit check of 'err', which was previously returned 
from the function rather than being checked.  i.e. it would drop through 
to:

	out:	
 		return err;

 	}

With the new code added, err can (and typically would) be overwritten with 
a successful value, causing the permission check to not deny permission if 
needed.  The intended denial would have been logged.

The patch below fixes this problem.

Please apply.

- James
-- 
James Morris
<jmorris@redhat.com>


diff -urN -X dontdiff linux-2.6.5-rc2-mm2.o/security/selinux/hooks.c linux-2.6.5-rc2-mm2.w2/security/selinux/hooks.c
--- linux-2.6.5-rc2-mm2.o/security/selinux/hooks.c	2004-03-24 23:06:30.000000000 -0500
+++ linux-2.6.5-rc2-mm2.w2/security/selinux/hooks.c	2004-03-25 00:46:49.582735736 -0500
@@ -3040,6 +3040,8 @@
 		goto out;
 	
 	err = avc_has_perm(isec->sid, node_sid, SECCLASS_NODE, node_perm, NULL, &ad);
+	if (err)
+		goto out;
 
 	if (recv_perm) {
 		u32 port_sid;


