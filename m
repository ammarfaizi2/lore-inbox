Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265555AbTL3HLF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 02:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265558AbTL3HLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 02:11:04 -0500
Received: from bay13-dav17.bay13.hotmail.com ([64.4.31.191]:2319 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265555AbTL3HK7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 02:10:59 -0500
X-Originating-IP: [67.195.216.52]
X-Originating-Email: [james_mcmechan@hotmail.com]
From: "James McMechan" <James_McMechan@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] text backport of fix for tmpfs oops from 2.6.0 final to 2.4.23
Date: Mon, 29 Dec 2003 23:05:01 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY13-DAV17oybY9epA0000d4e9@hotmail.com>
X-OriginalArrivalTime: 30 Dec 2003 07:10:58.0704 (UTC) FILETIME=[131B9900:01C3CEA4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stupid free mail program appears to have converted
my message into a octet stream, this should work
even if it is kind of strange. Travel without a good
connection is painful, Hopefully this is readable.

Ok, here is a backport of the patch that went into 2.6.0
to fix the problem where the tmpfs/shmfs dcache could be
oopsed by any user doing a dirseek to offset 2.
This occurs because the when the seek is at the cursor
and then the cursor is deleted, the list_add_tail
tries to attach to the end of the list and gets the
old pointers (poisoned on 2.6) from the list_del.
This fix just deletes the cursor before going over the
list since it can not be a member of the list and should
not be counted, delete it before counting over the list.

--- linux-2.4.23/fs/readdir.c 2002-08-02 17:39:45.000000000 -0700
+++ build-2.4.23-skas/fs/readdir.c 2003-12-23 17:18:37.000000000 -0800
@@ -69,6 +69,7 @@
    loff_t n = file->f_pos - 2;
 
    spin_lock(&dcache_lock);
+   list_del(&cursor->d_child);
    p = file->f_dentry->d_subdirs.next;
    while (n && p != &file->f_dentry->d_subdirs) {
     struct dentry *next;
@@ -77,7 +78,6 @@
      n--;
     p = p->next;
    }
-   list_del(&cursor->d_child);
    list_add_tail(&cursor->d_child, p);
    spin_unlock(&dcache_lock);
   }
