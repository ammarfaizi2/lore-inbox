Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268210AbRGWMTV>; Mon, 23 Jul 2001 08:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268212AbRGWMTL>; Mon, 23 Jul 2001 08:19:11 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:22931 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S268210AbRGWMTG>; Mon, 23 Jul 2001 08:19:06 -0400
Message-ID: <3B5B8A2E.CFD6F118@uow.edu.au>
Date: Mon, 23 Jul 2001 12:21:34 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] rootfstype= and rootcd= boot options.
In-Reply-To: <Pine.LNX.4.21.0107231107350.612-100000@penguin.homenet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Tigran Aivazian wrote:
> 
> Hi Linus,
> 
> This patch adds two boot options: rootfstype= and rootcd=.
> 

That would be useful for ext2/ext3 interoperability too.

ext3 also need to ability to pass mount options to the
root fs.  Any chance of munging these two things together?



--- linux-2.4.7/fs/super.c	Wed Jul  4 18:21:31 2001
+++ lk-ext3/fs/super.c	Fri Jun 29 02:09:31 2001
@@ -1467,6 +1467,17 @@ out1:
 	return retval;
 }
 
+static char *root_mount_data;
+static int __init root_data_setup(char *line)
+{
+	static char buffer[128];
+
+	strcpy(buffer, line);
+	root_mount_data = buffer;
+	return 1;
+}
+__setup("rootflags=", root_data_setup);
+
 void __init mount_root(void)
 {
 	struct file_system_type * fs_type;
@@ -1594,7 +1605,8 @@ skip_nfs:
 		if (!try_inc_mod_count(fs_type->owner))
 			continue;
 		read_unlock(&file_systems_lock);
-  		sb = read_super(ROOT_DEV,bdev,fs_type,root_mountflags,NULL,1);
+  		sb = read_super(ROOT_DEV,bdev,fs_type,root_mountflags,
+				root_mount_data,1);
 		if (sb) 
 			goto mount_it;
 		read_lock(&file_systems_lock);
