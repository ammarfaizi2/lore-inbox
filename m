Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTJ2Ant (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 19:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTJ2Ant
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 19:43:49 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:23998 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261868AbTJ2Anq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 19:43:46 -0500
Message-ID: <3F9F03C4.3020808@us.ibm.com>
Date: Tue, 28 Oct 2003 16:03:16 -0800
From: Janet Morgan <janetmor@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, suparna@in.ibm.com
Subject: aio sysctl parms
Content-Type: multipart/mixed;
 boundary="------------010808000905090000040000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010808000905090000040000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

It looks like aio_nr and aio_max_nr were intended to be sysctl parameters. 
Here's the patch for it:


--------------010808000905090000040000
Content-Type: text/plain;
 name="sysctl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysctl.patch"

--- linux-2.6.0-test7/Documentation/sysctl/fs.txt	2003-10-08 12:24:00.000000000 -0700
+++ aio-sysctl/Documentation/sysctl/fs.txt	2003-10-17 12:55:30.039905816 -0700
@@ -138,3 +138,13 @@ thus the maximum number of mounted files
 can have. You only need to increase super-max if you need to
 mount more filesystems than the current value in super-max
 allows you to.
+
+==============================================================
+
+aio-nr & aio-max-nr:
+
+aio-nr shows the current system-wide number of asynchronous io 
+requests.  aio-max-nr allows you to change the maximum value 
+aio-nr can grow to.
+
+==============================================================
--- linux-2.6.0-test7/Documentation/filesystems/proc.txt	2003-10-08 12:24:03.000000000 -0700
+++ aio-sysctl/Documentation/filesystems/proc.txt	2003-10-17 13:45:12.036573416 -0700
@@ -900,6 +900,15 @@ super-nr shows the number of currently a
 Every mounted file system needs a super block, so if you plan to mount lots of
 file systems, you may want to increase these numbers.
 
+aio-nr and aio-max-nr
+---------------------
+
+aio-nr is the running total of the number of events specified on the 
+io_setup system call for all currently active aio contexts.  If aio-nr
+reaches aio-max-nr then io_setup will fail with EAGAIN.  Note that 
+raising aio-max-nr does not result in the pre-allocation or re-sizing 
+of any kernel data structures.
+
 2.2 /proc/sys/fs/binfmt_misc - Miscellaneous binary formats
 -----------------------------------------------------------
 
--- linux-2.6.0-test7/include/linux/aio.h	2003-10-08 12:24:01.000000000 -0700
+++ aio-sysctl/include/linux/aio.h	2003-10-17 12:27:01.574632016 -0700
@@ -167,6 +167,7 @@ static inline struct kiocb *list_kiocb(s
 }
 
 /* for sysctl: */
-extern unsigned aio_max_nr, aio_max_size, aio_max_pinned;
+extern atomic_t aio_nr;
+extern unsigned aio_max_nr;
 
 #endif /* __LINUX__AIO_H */
--- linux-2.6.0-test7/include/linux/sysctl.h	2003-10-08 12:24:07.000000000 -0700
+++ aio-sysctl/include/linux/sysctl.h	2003-10-17 12:38:35.115197824 -0700
@@ -600,6 +600,8 @@ enum
 	FS_LEASE_TIME=15,	/* int: maximum time to wait for a lease break */
 	FS_DQSTATS=16,	/* disc quota usage statistics */
 	FS_XFS=17,	/* struct: control xfs parameters */
+	FS_AIO_NR=18,	/* current system-wide number of aio requests */ 
+	FS_AIO_MAX_NR=19,	/* system-wide maximum number of aio requests */
 };
 
 /* /proc/sys/fs/quota/ */
--- linux-2.6.0-test7/kernel/sysctl.c	2003-10-08 12:24:02.000000000 -0700
+++ aio-sysctl/kernel/sysctl.c	2003-10-17 12:32:27.777041712 -0700
@@ -794,6 +794,22 @@ static ctl_table fs_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= FS_AIO_NR,
+		.procname	= "aio-nr",
+		.data		= &aio_nr,
+		.maxlen		= sizeof(aio_nr),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_AIO_MAX_NR,
+		.procname	= "aio-max-nr",
+		.data		= &aio_max_nr,
+		.maxlen		= sizeof(aio_max_nr),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 

--------------010808000905090000040000--

