Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbUJ1GfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbUJ1GfT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbUJ1GfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:35:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49083 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262869AbUJ1Gap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 02:30:45 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Linas Vepstas <linas@austin.ibm.com>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, anton@samba.org
Subject: Re: [PATCH] add syslog printing to xmon debugger. 
In-reply-to: Your message of "Fri, 22 Oct 2004 11:59:17 +1000."
             <16760.26997.131687.456670@cargo.ozlabs.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Oct 2004 16:30:15 +1000
Message-ID: <5227.1098945015@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004 11:59:17 +1000, 
Paul Mackerras <paulus@samba.org> wrote:
>Linas,
>
>> Andrew,
>> 
>> Please apply at least the kernel/printk.c part of the patch,
>> if you are feeling at all charitable.
>
>Did you ever get any reaction to that?

I see that the printk.c patch was lifted straight from kdb - without
any mention of kdb.  It even has the same bug as kdb, which was
corrected in kdb-v4.4-2.6.9-common-2.  The current kdb patch to
printk.c is :-

Index: linux/kernel/printk.c
===================================================================
--- linux.orig/kernel/printk.c	Tue Oct 19 07:55:35 2004
+++ linux/kernel/printk.c	Thu Oct 21 18:06:28 2004
@@ -373,6 +373,20 @@ out:
 	return error;
 }
 
+#ifdef	CONFIG_KDB
+/* kdb dmesg command needs access to the syslog buffer.  do_syslog() uses locks
+ * so it cannot be used during debugging.  Just tell kdb where the start and
+ * end of the physical and logical logs are.  This is equivalent to do_syslog(3).
+ */
+void kdb_syslog_data(char *syslog_data[4])
+{
+	syslog_data[0] = log_buf;
+	syslog_data[1] = log_buf + log_buf_len;
+	syslog_data[2] = log_buf + log_end - (logged_chars < log_buf_len ? logged_chars : log_buf_len);
+	syslog_data[3] = log_buf + log_end;
+}
+#endif	/* CONFIG_KDB */
+
 asmlinkage long sys_syslog(int type, char __user * buf, int len)
 {
 	return do_syslog(type, buf, len);

