Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWINPhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWINPhG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWINPhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:37:06 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:45723 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750822AbWINPhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:37:04 -0400
Message-ID: <4509771B.9070204@fr.ibm.com>
Date: Thu, 14 Sep 2006 17:36:59 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Linux Containers <containers@lists.osdl.org>
Subject: [patch -mm] utsname namespace : fix unshare when CONFIG_UTS_NS is
 not set
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel is not configured with the CONFIG_UTS_NS, unshare of
ipc namespace will fail and return -EINVAL.

The patch changes the dummy unshare_utsname() to check the clone flags
before returning.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Serge E. Hallyn <serue@us.ibm.com>
Cc: Linux Containers <containers@lists.osdl.org>

---
 include/linux/utsname.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: 2.6.18-rc6-mm2/include/linux/utsname.h
===================================================================
--- 2.6.18-rc6-mm2.orig/include/linux/utsname.h
+++ 2.6.18-rc6-mm2/include/linux/utsname.h
@@ -60,8 +60,12 @@ static inline void put_uts_ns(struct uts
 static inline int unshare_utsname(unsigned long unshare_flags,
 			struct uts_namespace **new_uts)
 {
-	return -EINVAL;
+	if (unshare_flags & CLONE_NEWUTS)
+		return -EINVAL;
+
+	return 0;
 }
+
 static inline int copy_utsname(int flags, struct task_struct *tsk)
 {
 	return 0;
