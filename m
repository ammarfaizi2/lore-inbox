Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSGJBIH>; Tue, 9 Jul 2002 21:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317464AbSGJBIG>; Tue, 9 Jul 2002 21:08:06 -0400
Received: from ns.tzone.it ([212.97.49.90]:48653 "HELO tzone.it")
	by vger.kernel.org with SMTP id <S317463AbSGJBIF>;
	Tue, 9 Jul 2002 21:08:05 -0400
Message-ID: <20020710011032.38197.qmail@tzone.it>
From: elv@openbeer.it
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fwd from bugtraq: Linux kernels DoSable by file-max limit
Date: Wed, 10 Jul 2002 01:10:31 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all, 

a couple of days ago Paul Starzetz pointed on bugtraq a problem in the linux 
kernel regarding a possible DoS: 

struct file * get_empty_filp(void)
{
   static int old_max = 0;
   struct file * f; 

   file_list_lock();
   if (files_stat.nr_free_files > NR_RESERVED_FILES) {
   used_one:
       f = list_entry(free_list.next, struct file, f_list); 

[...] 

   /*
    * Use a reserved one if we're the superuser
    */
[*]  if (files_stat.nr_free_files && !current->euid)
       goto used_one; 

if free fds are == NR_RESERVED_FILES only root can open new files .. but 
suid binaries are euid == 0 so an attacker can eat off this reserved fds.
for more information see
http://online.securityfocus.com/archive/1/281100/2002-07-07/2002-07-13/0
and the other posts. 

i attached two possible patches: 

 --- /usr/src/linux/fs/file_table.c	Mon Sep 17 20:16:30 2001
+++ /usr/src/linux/fs/file_table.c	Mon Jul  8 23:42:01 2002
@@ -51,9 +51,12 @@
		return f;
	}
	/*
 -	 * Use a reserved one if we're the superuser
+	 * Use one of the first 16 reserved fds if we have euid == 0
+	 * and one of the second 16 reserved fds if we're the superuser
	 */
 -	if (files_stat.nr_free_files && !current->euid)
+	if (files_stat.nr_free_files > (NR_RESERVED_FILES/2) && !current->euid)
+		goto used_one;
+	else if (files_stat.nr_free_files <= (NR_RESERVED_FILES/2) && 
!current->uid)
		goto used_one;
	/*
	 * Allocate a new one if we're below the limit. 


 --- /usr/src/linux/include/linux/fs.h	Mon Jul  1 14:48:44 2002
+++ /usr/src/linux/include/linux/fs.h	Tue Jul  9 00:07:06 2002
@@ -65,7 +65,7 @@
extern int leases_enable, dir_notify_enable, lease_break_time; 

#define NR_FILE  8192	/* this can well be larger on a larger system */
 -#define NR_RESERVED_FILES 10 /* reserved for root */
+#define NR_RESERVED_FILES 32 /* first 16 for euid == 0 processes and second 
16 only for root */
#define NR_SUPER 256 

#define MAY_EXEC 1 


excuse me if another patch was submitted but i didnt see it 

cheers, elv
