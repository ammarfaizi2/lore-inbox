Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVCABDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVCABDC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 20:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVCABBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 20:01:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6114 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261176AbVCABA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 20:00:28 -0500
Date: Mon, 28 Feb 2005 17:00:16 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: <brugolsky@telemetry-investments.com>
Cc: zaitcev@redhat.com, SteveD@redhat.com, linux-kernel@vger.kernel.org,
       <torvalds@osdl.org>
Subject: Re: [PATCH] nfs client O_DIRECT oops
Message-ID: <20050228170016.0c26a109@localhost.localdomain>
In-Reply-To: <42236AC6.6000609@RedHat.com>
References: <42236AC6.6000609@RedHat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2005 14:02:30 -0500, Steve Dickson <SteveD@redhat.com> wrote:

> Discovered using AKPM's ext3-tools: odwrite -ko 0 16385 foo

> Signed-off-by: Bill Rugolsky <brugolsky@telemetry-investments.com>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>

The root cause of the bug is that the code violates the principle of the
least surprise, which in this case is: if a function fails, you do not have
to clean up for that function. Therefore, Bill's fix papers over instead
of fixing.

This is how I think it should have been fixed:

--- linux-2.6.9-5.EL/fs/nfs/direct.c	2004-10-18 14:55:07.000000000 -0700
+++ linux-2.6.9-5.EL-nfs/fs/nfs/direct.c	2005-02-28 16:48:54.000000000 -0800
@@ -86,6 +86,8 @@
 					page_count, (rw == READ), 0,
 					*pages, NULL);
 		up_read(&current->mm->mmap_sem);
+		if (result < 0)
+			kfree(*pages);
 	}
 	return result;
 }
@@ -211,7 +213,6 @@
 
                 page_count = nfs_get_user_pages(READ, user_addr, size, &pages);
                 if (page_count < 0) {
-                        nfs_free_user_pages(pages, 0, 0);
 			if (tot_bytes > 0)
 				break;
                         return page_count;
@@ -377,7 +378,6 @@
 
                 page_count = nfs_get_user_pages(WRITE, user_addr, size, &pages);
                 if (page_count < 0) {
-                        nfs_free_user_pages(pages, 0, 0);
 			if (tot_bytes > 0)
 				break;
                         return page_count;

Best wishes,
-- Pete
