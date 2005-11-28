Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbVK1Xlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVK1Xlw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 18:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVK1Xlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 18:41:52 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:53925 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932271AbVK1Xlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 18:41:51 -0500
Subject: [BUG][PATCH] process events connector - uid_t gid_t size issues
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Jay Lan <jlan@engr.sgi.com>, Erik Jacobson <erikj@sgi.com>,
       Jack Steiner <steiner@sgi.com>, larva@linux.ucla.edu
Content-Type: text/plain
Date: Mon, 28 Nov 2005 15:35:39 -0800
Message-Id: <1133220939.25202.902.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

	I noticed this follow up patch did not make it's way into -mm and
subsequently to 2.6.15-rc2. The uid_t and gid_t fields appear to present
a 32/64-bit userspace/kernel problem for some archs.

	This patch addresses the problem by fixing the size to the largest
size for uid_t/gid_t used in the kernel. This preserves the total size of
the event structure while ensuring that the layouts of the ID change event
match in 32 and 64-bit kernels and applications.

	Please apply.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

---

Index: linux-2.6.15-rc2/include/linux/cn_proc.h
===================================================================
--- linux-2.6.15-rc2.orig/include/linux/cn_proc.h
+++ linux-2.6.15-rc2/include/linux/cn_proc.h
@@ -84,16 +84,16 @@ struct proc_event {
 
 		struct id_proc_event {
 			pid_t process_pid;
 			pid_t process_tgid;
 			union {
-				uid_t ruid; /* current->uid */
-				gid_t rgid; /* current->gid */
+				__u32 ruid; /* task uid */
+				__u32 rgid; /* task gid */
 			} r;
 			union {
-				uid_t euid;
-				gid_t egid;
+				__u32 euid;
+				__u32 egid;
 			} e;
 		} id;
 
 		struct exit_proc_event {
 			pid_t process_pid;


