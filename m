Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317864AbSGKRJK>; Thu, 11 Jul 2002 13:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317866AbSGKRJJ>; Thu, 11 Jul 2002 13:09:09 -0400
Received: from ns.tzone.it ([212.97.49.90]:21515 "HELO tzone.it")
	by vger.kernel.org with SMTP id <S317864AbSGKRJI>;
	Thu, 11 Jul 2002 13:09:08 -0400
Message-ID: <20020711171157.97045.qmail@tzone.it>
From: elv@openbeer.it
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Linux kernels DoSable by file-max limit
Date: Thu, 11 Jul 2002 17:11:57 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, 

in the previous patch a line was missed 

 --- ../patches/linux/fs/file_table.c	Mon Sep 17 20:16:30 2001
+++ fs/file_table.c	Thu Jul 11 19:01:40 2002
@@ -51,9 +51,13 @@
		return f;
	}
	/*
 -	 * Use a reserved one if we're the superuser
+	 * Use one of the first 16 reserved fds if we have euid == 0
+	 * and one of the second 16 reserved fds if we're the superuser
	 */
 -	if (files_stat.nr_free_files && !current->euid)
+	if (files_stat.nr_free_files > NR_RESERVED_FILES/2 && !current->euid)
+		goto used_one;
+	else if (files_stat.nr_free_files <= NR_RESERVED_FILES/2 && !current->uid
+		&& files_stat.nr_free_files != 0)
		goto used_one;
	/*
	 * Allocate a new one if we're below the limit. 


 --- /usr/src/linux/include/linux/fs.h   Mon Jul  1 14:48:44 2002
+++ /usr/src/linux/include/linux/fs.h   Tue Jul  9 00:07:06 2002
@@ -65,7 +65,7 @@
extern int leases_enable, dir_notify_enable, lease_break_time; 

#define NR_FILE  8192   /* this can well be larger on a larger system */
 -#define NR_RESERVED_FILES 10 /* reserved for root */
+#define NR_RESERVED_FILES 32 /* first 16 for euid == 0 processes and second 
16 only for root */
#define NR_SUPER 256 

#define MAY_EXEC 1 


elv
