Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVEaG0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVEaG0q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 02:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVEaG0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 02:26:45 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:62925 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261207AbVEaG0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 02:26:36 -0400
Date: Tue, 31 May 2005 08:26:27 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
Subject: [PATCH 2.6.12-rc5-mm1] fork connector: fix a compile breakage with
 gcc 2.95
Message-ID: <20050531082627.6f50e7f3@frecb000711.frec.bull.fr>
Organization: BULL SA.
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 31/05/2005 08:37:25,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 31/05/2005 08:37:30,
	Serialize complete at 31/05/2005 08:37:30
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  This patch fixes a compile breakage with gcc 2.95 due to an unnamed
struct/union that doesn't define any instances. Thank you to Adrian Bunk
for reporting the problem and testing the new patch.

Signed-off-by: guillaume.thouvenin@bull.net

---

 drivers/connector/cn_fork.c |   10 +++++-----
 include/linux/cn_fork.h     |    4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)
Index: linux-2.6.12-rc5-mm1/drivers/connector/cn_fork.c
===================================================================
--- linux-2.6.12-rc5-mm1.orig/drivers/connector/cn_fork.c	2005-05-30 09:05:43.000000000 +0200
+++ linux-2.6.12-rc5-mm1/drivers/connector/cn_fork.c	2005-05-30 13:02:36.000000000 +0200
@@ -72,10 +72,10 @@ void fork_connector(pid_t ppid, pid_t pt
 		forkmsg = (struct cn_fork_msg *)msg->data;
 		forkmsg->type = FORK_CN_MSG_P;
 		forkmsg->cpu = smp_processor_id();
-		forkmsg->ppid = ppid;
-		forkmsg->ptid = ptid;
-		forkmsg->cpid = cpid;
-		forkmsg->ctid = ctid;
+		forkmsg->u.s.ppid = ppid;
+		forkmsg->u.s.ptid = ptid;
+		forkmsg->u.s.cpid = cpid;
+		forkmsg->u.s.ctid = ctid;
 
 		put_cpu_var(fork_counts);
 
@@ -107,7 +107,7 @@ static inline void cn_fork_send_status(v
 	msg->len = CN_FORK_INFO_SIZE;
 	forkmsg = (struct cn_fork_msg *)msg->data;
 	forkmsg->type = FORK_CN_MSG_S;
-	forkmsg->status = cn_fork_enable;
+	forkmsg->u.status = cn_fork_enable;
 
 	cn_netlink_send(msg, CN_IDX_FORK, GFP_KERNEL);
 }
Index: linux-2.6.12-rc5-mm1/include/linux/cn_fork.h
===================================================================
--- linux-2.6.12-rc5-mm1.orig/include/linux/cn_fork.h	2005-05-30 09:05:51.000000000 +0200
+++ linux-2.6.12-rc5-mm1/include/linux/cn_fork.h	2005-05-30 13:07:26.000000000 +0200
@@ -55,9 +55,9 @@ struct cn_fork_msg {
 			pid_t ptid;	/* parent thread ID  */
 			pid_t cpid;	/* child process ID  */
 			pid_t ctid;	/* child thread ID   */
-		};
+		} s;
 		int status;
-	};
+	} u;
 };
 
 /* Code above is only inside the kernel */

