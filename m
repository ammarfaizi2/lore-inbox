Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161224AbWBULay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161224AbWBULay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 06:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbWBULay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 06:30:54 -0500
Received: from linuxhacker.ru ([217.76.32.60]:934 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S1161219AbWBULax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 06:30:53 -0500
Date: Tue, 21 Feb 2006 13:30:55 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: FMODE_EXEC or alike?
Message-ID: <20060221113055.GF5733@linuxhacker.ru>
References: <20060220221948.GC5733@linuxhacker.ru> <20060220215122.7aa8bbe5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220215122.7aa8bbe5.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

  Introduce FMODE_EXEC file flag, to indicate that file is being opened for
  execution. This is useful for distributed filesystems to maintain consistent
  behavior for returning ETXTBUSY when opening for write and execution
  happens on different nodes.

Signed-off-by: Oleg Drokin <green@linuxhacker.ru>

--- linux-2.6.16-rc4/include/linux/fs.h.orig	2006-02-21 11:26:43.000000000 +0200
+++ linux-2.6.16-rc4/include/linux/fs.h	2006-02-21 11:30:16.000000000 +0200
@@ -65,6 +65,11 @@ extern int dir_notify_enable;
 #define FMODE_PREAD	8
 #define FMODE_PWRITE	FMODE_PREAD	/* These go hand in hand */
 
+/* File is being opened for execution. Primary users of this flag are
+   distributed filesystems that can use it to achieve correct ETXTBUSY
+   behavior for cross-node execution/opening_for_writing of files */
+#define FMODE_EXEC	16
+
 #define RW_MASK		1
 #define RWA_MASK	2
 #define READ 0
--- linux-2.6.16-rc4/fs/exec.c.orig	2006-02-19 20:34:06.000000000 +0200
+++ linux-2.6.16-rc4/fs/exec.c	2006-02-21 13:06:42.000000000 +0200
@@ -127,7 +127,7 @@ asmlinkage long sys_uselib(const char __
 	struct nameidata nd;
 	int error;
 
-	error = __user_path_lookup_open(library, LOOKUP_FOLLOW, &nd, FMODE_READ);
+	error = __user_path_lookup_open(library, LOOKUP_FOLLOW, &nd, FMODE_READ|FMODE_EXEC);
 	if (error)
 		goto out;
 
@@ -477,7 +477,7 @@ struct file *open_exec(const char *name)
 	int err;
 	struct file *file;
 
-	err = path_lookup_open(AT_FDCWD, name, LOOKUP_FOLLOW, &nd, FMODE_READ);
+	err = path_lookup_open(AT_FDCWD, name, LOOKUP_FOLLOW, &nd, FMODE_READ|FMODE_EXEC);
 	file = ERR_PTR(err);
 
 	if (!err) {
