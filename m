Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263009AbVAFUDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbVAFUDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbVAFUBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:01:44 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:43517 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262974AbVAFT6O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 14:58:14 -0500
Date: Thu, 6 Jan 2005 13:58:12 -0600
To: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] kernel/printk.c  lockless access
Message-ID: <20050106195812.GL22274@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Linus, Andrew,

I was wondering if you could see your way to accepting the attached
patch, which provides access to the syslog buffer pointers.

The basic idea is that if a system has crashed, it can be handy to
be able to view the contents of the syslog buffer.  Unfortunately,
this is currently hard to do.

 --  char __log_buf[] is declared static in printk.c, so it cannot
     be found in the ksyms table.

 -- do_syslog() uses spinlocks to protect the data structure, and
    so will typically deadlock if called.

The 'fix' is to provide a routine that simply returns the pointers
to the log buffer.  

I'd be thrilled to have this patch accepted ... 

--linas

Signed-off-by: Linas Vepstas <linas@linas.org>



--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="printk.patch"

===== kernel/printk.c 1.47 vs edited =====
--- 1.47/kernel/printk.c	2004-11-19 01:03:10 -06:00
+++ edited/kernel/printk.c	2005-01-06 13:44:36 -06:00
@@ -380,6 +380,23 @@ asmlinkage long sys_syslog(int type, cha
 	return do_syslog(type, buf, len);
 }
 
+#ifdef   CONFIG_DEBUG_KERNEL
+/**
+ * Its very handy to be able to view the syslog buffer during debug.
+ * But do_syslog() uses locks and so it will deadlock if called during 
+ * a debugging session. The routine provides the start and end of the 
+ * physical and logical logs, and is equivalent to do_syslog(3).
+ */
+
+void debugger_syslog_data(char *syslog_data[4])
+{
+	syslog_data[0] = log_buf;
+	syslog_data[1] = log_buf + __LOG_BUF_LEN;
+	syslog_data[2] = log_buf + log_end - (logged_chars < __LOG_BUF_LEN ? logged_chars : __LOG_BUF_LEN);
+	syslog_data[3] = log_buf + log_end;
+}
+#endif   /* CONFIG_DEBUG_KERNEL */
+
 /*
  * Call the console drivers on a range of log_buf
  */

--Yylu36WmvOXNoKYn--
