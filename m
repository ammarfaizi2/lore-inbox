Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbTDIFam (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 01:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbTDIFam (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 01:30:42 -0400
Received: from palrel12.hp.com ([156.153.255.237]:48603 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262785AbTDIFak (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 01:30:40 -0400
Date: Tue, 8 Apr 2003 22:42:17 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200304090542.h395gHF5004000@napali.hpl.hp.com>
To: neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: NFSD binary compatibility breakage
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil,

The removal of "struct nfsctl_uidmap" from "nfsctl_fdparm" broke
binary compatiblity on 64-bit platforms (strictly speaking: on all
platforms with alignof(void *) > alignof(int)).  The problem is that
nfsctl_uidmap contained a "char *", which forced the alignment of the
entire union to be 64 bits.  With the removal of the uidmap, the
required alignment drops to 32 bits.  Since the first member is only
32 bits in size, this breaks compatibility with user-space.  Patch
below fixes the problem.

Thanks,

	--david

===== include/linux/nfsd/syscall.h 1.4 vs edited =====
--- 1.4/include/linux/nfsd/syscall.h	Sun Mar 23 14:35:20 2003
+++ edited/include/linux/nfsd/syscall.h	Tue Apr  8 22:36:59 2003
@@ -91,6 +91,13 @@
 		struct nfsctl_export	u_export;
 		struct nfsctl_fdparm	u_getfd;
 		struct nfsctl_fsparm	u_getfs;
+		/*
+		 * The following dummy member is needed to preserve binary compatibility
+		 * on platforms where alignof(void*)>alignof(int).  It's needed because
+		 * this union used to contain a member (u_umap) which contained a
+		 * pointer.
+		 */
+		void *u_ptr;
 	} u;
 #define ca_svc		u.u_svc
 #define ca_client	u.u_client
