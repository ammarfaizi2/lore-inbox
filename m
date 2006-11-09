Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424130AbWKIRBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424130AbWKIRBY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 12:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424129AbWKIRBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 12:01:24 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:22705 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1424130AbWKIRBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 12:01:23 -0500
Message-ID: <455360C2.1070900@sw.ru>
Date: Thu, 09 Nov 2006 20:09:22 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, xemul@openvz.org, devel@openvz.org,
       oleg@tv-sign.ru, hch@infradead.org, matthltc@us.ibm.com,
       ckrm-tech@lists.sourceforge.net
Subject: [PATCH 12/13] BC: numtasks accounting
References: <45535C18.4040000@sw.ru>
In-Reply-To: <45535C18.4040000@sw.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Beautifull tasks accounting/limiting beancounter control.

Signed-off-by: Pavel Emelianov <xemul@sw.ru>
Signed-off-by: Kirill Korotaev <dev@sw.ru>

---

 include/linux/sched.h |    1 +
 kernel/bc/misc.c      |   31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

--- ./include/linux/sched.h.bctasks	2006-11-03 17:47:38.000000000 +0300
+++ ./include/linux/sched.h	2006-11-03 17:51:57.000000000 +0300
@@ -1068,6 +1068,7 @@ int copy_beancounter(struct task_struct 
 #endif
 #ifdef CONFIG_BEANCOUNTERS
 	struct beancounter *exec_bc;
+	struct beancounter *task_bc;
 #endif
 };
 
--- ./kernel/bc/misc.c.bctasks	2006-11-03 17:47:38.000000000 +0300
+++ ./kernel/bc/misc.c	2006-11-03 17:51:57.000000000 +0300
@@ -17,6 +17,10 @@ int copy_beancounter(struct task_struct 
 	struct beancounter *bc;
 
 	bc = parent->exec_bc;
+	if (bc_charge(bc, BC_NUMTASKS, 1, BC_LIMIT))
+		return -ENOMEM;
+
+	tsk->task_bc = bc_get(bc);
 	tsk->exec_bc = bc_get(bc);
 	return 0;
 }
@@ -25,6 +29,10 @@ void free_beancounter(struct task_struct
 {
 	struct beancounter *bc;
 
+	bc = tsk->task_bc;
+	bc_uncharge(bc, BC_NUMTASKS, 1);
+	bc_put(bc);
+
 	bc = tsk->exec_bc;
 	bc_put(bc);
 }
@@ -86,3 +94,26 @@ int bc_task_move(struct task_struct *tsk
 	return err;
 }
 EXPORT_SYMBOL(bc_task_move);
+
+#define BC_NUMTASKS_BARRIER	128
+#define BC_NUMTASKS_LIMIT	128
+
+static int bc_task_init(struct beancounter *bc, int i)
+{
+	bc_init_resource(&bc->bc_parms[BC_NUMTASKS],
+			BC_NUMTASKS_BARRIER, BC_NUMTASKS_LIMIT);
+	return 0;
+}
+
+static struct bc_resource bc_task_resource = {
+	.bcr_name = "numtasks",
+	.bcr_init = bc_task_init,
+};
+
+static int __init bc_misc_init_resource(void)
+{
+	bc_register_resource(BC_NUMTASKS, &bc_task_resource);
+	return 0;
+}
+
+__initcall(bc_misc_init_resource);
