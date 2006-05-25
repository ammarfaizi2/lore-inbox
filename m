Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWEYECN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWEYECN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWEYEBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:01:50 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:10387 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S964858AbWEYEBs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:01:48 -0400
From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 2/3] proc: sysctl: add _proc_do_string helper
Date: Thu, 25 May 2006 13:53:33 +1200
To: linux-kernel@vger.kernel.org
Message-Id: <20060525015333.24381.28992.stgit@localhost.localdomain>
In-Reply-To: <200605241552.k4OFqXDU021020@shell0.pdx.osdl.net>
References: <20060525015333.24381.32975.stgit@localhost.localdomain> <200605241552.k4OFqXDU021020@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The logic in proc_do_string is worth re-using without passing in a
ctl_table structure (say, we want to calculate a pointer and pass that
in instead); pass in the two fields it uses from that structure
as explicit arguments.

Cc: Serge E. Hallyn <serue@us.ibm.com>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Andrey Savochkin <saw@sw.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
Two Signed-off-by:'s...

 kernel/sysctl.c |   65 ++++++++++++++++++++++++++++++-------------------------
 1 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 618a2f8..cf053fc 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1605,32 +1605,14 @@ static ssize_t proc_writesys(struct file
 	return do_rw_proc(1, file, (char __user *) buf, count, ppos);
 }
 
-/**
- * proc_dostring - read a string sysctl
- * @table: the sysctl table
- * @write: %TRUE if this is a write to the sysctl file
- * @filp: the file structure
- * @buffer: the user buffer
- * @lenp: the size of the user buffer
- * @ppos: file position
- *
- * Reads/writes a string from/to the user buffer. If the kernel
- * buffer provided is not large enough to hold the string, the
- * string is truncated. The copied string is %NULL-terminated.
- * If the string is being read by the user process, it is copied
- * and a newline '\n' is added. It is truncated if the buffer is
- * not large enough.
- *
- * Returns 0 on success.
- */
-int proc_dostring(ctl_table *table, int write, struct file *filp,
-		  void __user *buffer, size_t *lenp, loff_t *ppos)
+int _proc_do_string(void* data, int maxlen, int write, struct file *filp,
+		    void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	size_t len;
 	char __user *p;
 	char c;
 	
-	if (!table->data || !table->maxlen || !*lenp ||
+	if (!data || !maxlen || !*lenp ||
 	    (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
@@ -1646,20 +1628,20 @@ int proc_dostring(ctl_table *table, int 
 				break;
 			len++;
 		}
-		if (len >= table->maxlen)
-			len = table->maxlen-1;
-		if(copy_from_user(table->data, buffer, len))
+		if (len >= maxlen)
+			len = maxlen-1;
+		if(copy_from_user(data, buffer, len))
 			return -EFAULT;
-		((char *) table->data)[len] = 0;
+		((char *) data)[len] = 0;
 		*ppos += *lenp;
 	} else {
-		len = strlen(table->data);
-		if (len > table->maxlen)
-			len = table->maxlen;
+		len = strlen(data);
+		if (len > maxlen)
+			len = maxlen;
 		if (len > *lenp)
 			len = *lenp;
 		if (len)
-			if(copy_to_user(buffer, table->data, len))
+			if(copy_to_user(buffer, data, len))
 				return -EFAULT;
 		if (len < *lenp) {
 			if(put_user('\n', ((char __user *) buffer) + len))
@@ -1672,6 +1654,31 @@ int proc_dostring(ctl_table *table, int 
 	return 0;
 }
 
+/**
+ * proc_dostring - read a string sysctl
+ * @table: the sysctl table
+ * @write: %TRUE if this is a write to the sysctl file
+ * @filp: the file structure
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ * @ppos: file position
+ *
+ * Reads/writes a string from/to the user buffer. If the kernel
+ * buffer provided is not large enough to hold the string, the
+ * string is truncated. The copied string is %NULL-terminated.
+ * If the string is being read by the user process, it is copied
+ * and a newline '\n' is added. It is truncated if the buffer is
+ * not large enough.
+ *
+ * Returns 0 on success.
+ */
+int proc_dostring(ctl_table *table, int write, struct file *filp,
+		  void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	return _proc_do_string(table->data, table->maxlen, write, filp,
+			       buffer, lenp, ppos);
+}
+
 /*
  *	Special case of dostring for the UTS structure. This has locks
  *	to observe. Should this be in kernel/sys.c ????

