Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319180AbSHNDEK>; Tue, 13 Aug 2002 23:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319181AbSHNDEK>; Tue, 13 Aug 2002 23:04:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10509 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319180AbSHNDEJ>;
	Tue, 13 Aug 2002 23:04:09 -0400
Message-ID: <3D59CBFA.9CFC9FEE@zip.com.au>
Date: Tue, 13 Aug 2002 20:18:18 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, lkml <linux-kernel@vger.kernel.org>
Subject: [patch] printk from userspace
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch allows userspace to issue printk's, via sys_syslog():

	#include <sys/klog.h>

	int do_syslog(char *msg)
	{
		return klogctl(10, msg, strlen(msg));
	}

	main()
	{
		char big[2000];

		do_syslog("<1>one\n");
		do_syslog("<2>two");
		do_syslog("<3>three\n");
		memset(big, 'a', sizeof(big));
		big[1999] = 0;
		do_syslog(big);
	}


The main use of this is within hpa's klibc - initial userspace needs a
way of logging information and this API allows that information to be
captured into the printk ringbuffer.  It ends up in /var/log/messages.

Messages are truncated at 1024 characters by printk's vsprintf().

Requires CAP_SYS_ADMIN.


 printk.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+)

--- 2.5.31/kernel/printk.c~hpa-printk	Tue Aug 13 20:15:32 2002
+++ 2.5.31-akpm/kernel/printk.c	Tue Aug 13 20:15:32 2002
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>			/* For in_interrupt() */
 #include <linux/config.h>
+#include <linux/slab.h>
 #include <linux/delay.h>
 
 #include <asm/uaccess.h>
@@ -163,12 +164,15 @@ __setup("console=", console_setup);
  * 	7 -- Enable printk's to console
  *	8 -- Set level of messages printed to console
  *	9 -- Return number of unread characters in the log buffer
+ *     10 -- Printk from userspace.  Includes loglevel.  Returns number of
+ *           chars printed.
  */
 int do_syslog(int type, char * buf, int len)
 {
 	unsigned long i, j, limit, count;
 	int do_clear = 0;
 	char c;
+	char *lbuf = NULL;
 	int error = 0;
 
 	switch (type) {
@@ -283,11 +287,23 @@ int do_syslog(int type, char * buf, int 
 		error = log_end - log_start;
 		spin_unlock_irq(&logbuf_lock);
 		break;
+	case 10:
+		lbuf = kmalloc(len + 1, GFP_KERNEL);
+		error = -ENOMEM;
+		if (lbuf == NULL)
+			break;
+		error = -EFAULT;
+		if (copy_from_user(lbuf, buf, len))
+			break;
+		lbuf[len] = '\0';
+		error = printk("%s", lbuf);
+		break;
 	default:
 		error = -EINVAL;
 		break;
 	}
 out:
+	kfree(lbuf);
 	return error;
 }
 

.
