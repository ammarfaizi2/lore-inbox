Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262515AbTDANHI>; Tue, 1 Apr 2003 08:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262517AbTDANHH>; Tue, 1 Apr 2003 08:07:07 -0500
Received: from asplinux.ru ([195.133.213.194]:50705 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id <S262515AbTDANGs>;
	Tue, 1 Apr 2003 08:06:48 -0500
From: "Denis V. Lunev" <den@asplinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16009.37173.42789.497595@artemis.asplinux.ru>
Date: Tue, 1 Apr 2003 17:16:37 +0400
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [PATCH] memory leak in mem_read(fs/proc/base.c), 2.4.20
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

- memory leak found if error occured, allocated page is not freed

Regards,
	Denis V. Lunev

--- linux/fs/proc/base.c~	Thu Mar 27 12:18:36 2003
+++ linux/fs/proc/base.c	Tue Apr  1 15:16:49 2003
@@ -311,10 +311,13 @@
 	if (mm)
 		atomic_inc(&mm->mm_users);
 	task_unlock(task);
-	if (!mm)
+	if (!mm) {
+		free_page((unsigned long)page);
 		return 0;
+	}
 
 	if (file->private_data != (void*)((long)current->self_exec_id) ) {
+		free_page((unsigned long)page);
 		mmput(mm);
 		return -EIO;
 	}
