Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265101AbUGGMzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbUGGMzJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 08:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbUGGMwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 08:52:17 -0400
Received: from linuxhacker.ru ([217.76.32.60]:17367 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265101AbUGGMtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:49:52 -0400
Date: Wed, 7 Jul 2004 15:47:33 +0300
From: Oleg Drokin <green@clusterfs.com>
To: linux-kernel@vger.kernel.org, braam@clusterfs.com
Subject: [9/9] Lustre VFS patches for 2.6
Message-ID: <20040707124733.GA25995@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lustre needs to differentiate plain opens from opens for exec, in the latter
case it is possible that client will decide that it cannot execute a file
(after succesful open intent completion) e.g. due to wrong permissions and
that may cause server to leak open file reference as close will never be called.

 fs/exec.c          |    4 ++--
 include/linux/fs.h |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

--- linus-2.6.7-bk-latest/include/linux/fs.h.orig	2004-07-07 12:33:21.246507224 +0300
+++ linus-2.6.7-bk-latest/include/linux/fs.h	2004-07-07 12:33:55.069365368 +0300
@@ -74,6 +74,7 @@ extern int leases_enable, dir_notify_ena
 
 #define FMODE_READ 1
 #define FMODE_WRITE 2
+#define FMODE_EXEC 4
 
 #define RW_MASK		1
 #define RWA_MASK	2
--- linus-2.6.7-bk-latest/fs/exec.c.orig	2004-07-07 12:33:05.466906088 +0300
+++ linus-2.6.7-bk-latest/fs/exec.c	2004-07-07 12:33:38.127940856 +0300
@@ -122,7 +122,7 @@ asmlinkage long sys_uselib(const char __
 	int error;
 
 	intent_init(&nd.intent.open, IT_OPEN);
-	nd.intent.open.flags = FMODE_READ;
+	nd.intent.open.flags = FMODE_READ|FMODE_EXEC;
 	error = user_path_walk_it(library, &nd);
 	if (error)
 		goto out;
@@ -476,7 +476,7 @@ struct file *open_exec(const char *name)
 	struct file *file;
 
 	intent_init(&nd.intent.open, IT_OPEN);
-	nd.intent.open.flags = FMODE_READ;
+	nd.intent.open.flags = FMODE_READ|FMODE_EXEC;
 	err = path_lookup_it(name, LOOKUP_FOLLOW, &nd);
 	file = ERR_PTR(err);
 
