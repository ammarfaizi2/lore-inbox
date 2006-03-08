Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWCHQd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWCHQd2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 11:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWCHQd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 11:33:28 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:33125 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751390AbWCHQd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 11:33:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=AVa0XavRQTF3XOUR7/Vc/8bVJBa2/65TjHguYTzSJfVhtecrLeRbsKpsAE6RRNITPbZgzq+tPcMfkw6uNc6Bxed43bq64a5WpauZ+lv25R09gRA9/6D0vEUuofeGl7BL7dHN/wpm8na6iB86MB+xdsO7pGg+StKVkeexfzlhxIg=
Message-ID: <440F075F.1030404@gmail.com>
Date: Thu, 09 Mar 2006 00:33:35 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [2.6.16-rc5-m3 PATCH] inotify: add the monitor for the event source
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current inotify implementation only focus on change of file system, but it doesn't
 know who results in this change, this patch adds three fields to struct inotify_event,
 tgid, uid and gid, they will save process ID, user ID and user group ID of the process
 which leads to change in the file system, such software as anti-virus can make use 
of this feature to monitor who is modifying a specific file.

Signed-off-by: Yi Yang <yang.y.yi@gmail.com>
--- a/include/linux/inotify.h.orig	2006-03-08 21:40:12.000000000 +0800
+++ b/include/linux/inotify.h	2006-03-08 23:51:54.000000000 +0800
@@ -19,6 +19,9 @@ struct inotify_event {
 	__s32		wd;		/* watch descriptor */
 	__u32		mask;		/* watch mask */
 	__u32		cookie;		/* cookie to synchronize two events */
+	__u32		tgid;		/* process ID of the event source */
+	__u32		uid;		/* user ID of the responding process */
+	__u32		gid;		/* group ID of the responding process */
 	__u32		len;		/* length (including nulls) of name */
 	char		name[0];	/* stub for possible name */
 };
--- a/fs/inotify.c.orig	2006-03-08 20:58:31.000000000 +0800
+++ b/fs/inotify.c	2006-03-09 00:05:47.000000000 +0800
@@ -219,6 +219,9 @@ static struct inotify_kernel_event * ker
 	kevent->event.wd = wd;
 	kevent->event.mask = mask;
 	kevent->event.cookie = cookie;
+	kevent->event.tgid = current->tgid;
+	kevent->event.uid = current->uid;
+	kevent->event.gid = current->gid;
 
 	INIT_LIST_HEAD(&kevent->list);
 


