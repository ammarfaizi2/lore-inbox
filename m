Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265269AbUGZNLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUGZNLn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 09:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUGZNLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 09:11:43 -0400
Received: from services.exanet.com ([212.143.73.102]:47753 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S265269AbUGZNLa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 09:11:30 -0400
Message-ID: <41050300.90800@exanet.com>
Date: Mon, 26 Jul 2004 16:11:28 +0300
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Deadlock during heavy write activity to userspace NFS server
 on local NFS mount
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jul 2004 13:11:28.0558 (UTC) FILETIME=[0FD724E0:01C47312]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On heavy write activity, allocators wait synchronously for kswapd to
free some memory. But if kswapd is freeing memory via a userspace NFS
server, that server could be waiting for kswapd, and the system seizes
instantly.

This patch (against RHEL 2.4.21-15EL, but should apply either literally
or conceptually to other kernels) allows a process to declare itself as
kswapd's little helper, and thus will not have to wait on kswapd.

--- a/include/linux/prctl.h	2003-10-23 09:00:00.000000000 +0200
+++ b/include/linux/prctl.h	2004-07-21 13:43:01.000000000 +0300
@@ -43,5 +43,10 @@
  # define PR_TIMING_TIMESTAMP	1	/* Accurate timestamp based
  						   process timing */

+/* Get/set PF_MEMALLOC task flag bit */
+#define PR_GET_KSWAPD_HELPER 15
+#define PR_SET_KSWAPD_HELPER 16
+
+
  #endif /* _LINUX_PRCTL_H */
--- a/kernel/sys.c	2003-10-23 09:00:00.000000000 +0200
+++ b/kernel/sys.c	2004-07-21 13:42:59.000000000 +0300
@@ -1400,6 +1400,22 @@ asmlinkage long sys_prctl(int option, un
  			}
  			current->keep_capabilities = arg2;
  			break;
+		case PR_GET_KSWAPD_HELPER:
+			if (current->flags & PF_MEMALLOC)
+				error = 1;
+			break;
+		case PR_SET_KSWAPD_HELPER:
+			switch (arg2) {
+				case 0:
+					current->flags &= ~PF_MEMALLOC;
+					break;
+				case 1:
+					current->flags |= PF_MEMALLOC;
+					break;
+				default:
+					error = -EINVAL;
+			}
+			break;
  		default:
  			error = -EINVAL;
  			break;


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.



