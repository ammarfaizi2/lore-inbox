Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130300AbQLES0m>; Tue, 5 Dec 2000 13:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130299AbQLES0c>; Tue, 5 Dec 2000 13:26:32 -0500
Received: from 194-73-188-168.btconnect.com ([194.73.188.168]:54790 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130292AbQLES0Z>;
	Tue, 5 Dec 2000 13:26:25 -0500
Date: Tue, 5 Dec 2000 17:57:53 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.0-test12-pre5] optimized get_empty_filp()
Message-ID: <Pine.LNX.4.21.0012051754450.1493-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

It is quite clear that dropping and retaking the files_lock in
fs/file_table.c:get_empty_filp() at the label new_one is absolutely
unnecessary. The only reason one could think of was to "hold the lock for
as short time as possible" but a minute's thought reveals that such reason
is invalid (i.e. one is more likely to waste time spinning on the lock
than to save it by dropping/retaking it, given the relative duration of
the instructions we execute there without the lock).

So, the patch (tested under 2.4.0-test12-pre5) is below.

Regards,
Tigran

--- linux/fs/file_table.c	Fri Nov 17 19:36:27 2000
+++ work/fs/file_table.c	Tue Dec  5 16:52:06 2000
@@ -40,13 +40,11 @@
 		list_del(&f->f_list);
 		files_stat.nr_free_files--;
 	new_one:
-		file_list_unlock();
 		memset(f, 0, sizeof(*f));
 		atomic_set(&f->f_count,1);
 		f->f_version = ++event;
 		f->f_uid = current->fsuid;
 		f->f_gid = current->fsgid;
-		file_list_lock();
 		list_add(&f->f_list, &anon_list);
 		file_list_unlock();
 		return f;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
