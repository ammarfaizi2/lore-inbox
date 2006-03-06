Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752043AbWCFXw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbWCFXw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbWCFXw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:52:59 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:62938 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752043AbWCFXw6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:52:58 -0500
Subject: [RFC][PATCH 1/6] prepare sysctls for containers
To: linux-kernel@vger.kernel.org
Cc: serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       Herbert Poetzl <herbert@13thfloor.at>, Sam Vilain <sam@vilain.net>,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 06 Mar 2006 15:52:49 -0800
References: <20060306235248.20842700@localhost.localdomain>
In-Reply-To: <20060306235248.20842700@localhost.localdomain>
Message-Id: <20060306235249.880CB28A@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Right now, sysctls can only deal with global variables.  This
patch makes them a _little_ more flexible by allowing there to
be an accessor function to get at the variable being changed,
instead of it being global.

This allows the sysctls to be backed by variables that are,
for instance, dynamically allocated and not available at
compile-time.

This also provides a very simple mechanism to take things that
are currently global and containerize them.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 work-dave/include/linux/sysctl.h |    8 ++++
 work-dave/kernel/sysctl.c        |   65 ++++++++++++++++++++++++++-------------
 2 files changed, 52 insertions(+), 21 deletions(-)

diff -puN include/linux/sysctl.h~sysctls-for-containers include/linux/sysctl.h
--- work/include/linux/sysctl.h~sysctls-for-containers	2006-03-06 15:41:55.000000000 -0800
+++ work-dave/include/linux/sysctl.h	2006-03-06 15:41:55.000000000 -0800
@@ -872,6 +872,7 @@ extern void sysctl_init(void);
 
 typedef struct ctl_table ctl_table;
 
+typedef void *ctl_data_access (void);
 typedef int ctl_handler (ctl_table *table, int __user *name, int nlen,
 			 void __user *oldval, size_t __user *oldlenp,
 			 void __user *newval, size_t newlen, 
@@ -957,6 +958,13 @@ struct ctl_table 
 	int ctl_name;			/* Binary ID */
 	const char *procname;		/* Text ID for /proc/sys, or zero */
 	void *data;
+	ctl_data_access *data_access;	/* set this to a function if you
+					 * don't have a static place to point
+					 * ->data at compile-time.  This
+					 * function will be called to dynamically
+					 * figure out a ->data pointer.  Do not
+					 * set this and ->data at once.
+					 */
 	int maxlen;
 	mode_t mode;
 	ctl_table *child;
diff -puN kernel/sysctl.c~sysctls-for-containers kernel/sysctl.c
--- work/kernel/sysctl.c~sysctls-for-containers	2006-03-06 15:41:55.000000000 -0800
+++ work-dave/kernel/sysctl.c	2006-03-06 15:41:55.000000000 -0800
@@ -1197,6 +1197,24 @@ repeat:
 	return -ENOTDIR;
 }
 
+void *sysctl_table_data(ctl_table *table)
+{
+	void *data;
+
+	if (table->data && table->data_access) {
+		printk(KERN_WARNING
+			"sysctl: data and accessor function set for: '%s'\n",
+			table->procname);
+		table->data = NULL;
+	}
+
+	data = table->data;
+	if (!data && table->data_access)
+		data = table->data_access();
+
+	return data;
+}
+
 /* Perform the actual read/write of a sysctl table entry. */
 int do_sysctl_strategy (ctl_table *table, 
 			int __user *name, int nlen,
@@ -1205,6 +1223,7 @@ int do_sysctl_strategy (ctl_table *table
 {
 	int op = 0, rc;
 	size_t len;
+	void *data;
 
 	if (oldval)
 		op |= 004;
@@ -1224,14 +1243,15 @@ int do_sysctl_strategy (ctl_table *table
 
 	/* If there is no strategy routine, or if the strategy returns
 	 * zero, proceed with automatic r/w */
-	if (table->data && table->maxlen) {
+	data = sysctl_table_data(table);
+	if (data && table->maxlen) {
 		if (oldval && oldlenp) {
 			if (get_user(len, oldlenp))
 				return -EFAULT;
 			if (len) {
 				if (len > table->maxlen)
 					len = table->maxlen;
-				if(copy_to_user(oldval, table->data, len))
+				if(copy_to_user(oldval, data, len))
 					return -EFAULT;
 				if(put_user(len, oldlenp))
 					return -EFAULT;
@@ -1241,7 +1261,7 @@ int do_sysctl_strategy (ctl_table *table
 			len = newlen;
 			if (len > table->maxlen)
 				len = table->maxlen;
-			if(copy_from_user(table->data, newval, len))
+			if(copy_from_user(data, newval, len))
 				return -EFAULT;
 		}
 	}
@@ -1539,7 +1559,7 @@ int proc_dostring(ctl_table *table, int 
 	char __user *p;
 	char c;
 	
-	if (!table->data || !table->maxlen || !*lenp ||
+	if (!sysctl_table_data(table) || !table->maxlen || !*lenp ||
 	    (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
@@ -1557,18 +1577,18 @@ int proc_dostring(ctl_table *table, int 
 		}
 		if (len >= table->maxlen)
 			len = table->maxlen-1;
-		if(copy_from_user(table->data, buffer, len))
+		if(copy_from_user(sysctl_table_data(table), buffer, len))
 			return -EFAULT;
-		((char *) table->data)[len] = 0;
+		((char *) sysctl_table_data(table))[len] = 0;
 		*ppos += *lenp;
 	} else {
-		len = strlen(table->data);
+		len = strlen(sysctl_table_data(table));
 		if (len > table->maxlen)
 			len = table->maxlen;
 		if (len > *lenp)
 			len = *lenp;
 		if (len)
-			if(copy_to_user(buffer, table->data, len))
+			if(copy_to_user(buffer, sysctl_table_data(table), len))
 				return -EFAULT;
 		if (len < *lenp) {
 			if(put_user('\n', ((char __user *) buffer) + len))
@@ -1636,13 +1656,13 @@ static int do_proc_dointvec(ctl_table *t
 	char buf[TMPBUFLEN], *p;
 	char __user *s = buffer;
 	
-	if (!table->data || !table->maxlen || !*lenp ||
+	if (!sysctl_table_data(table) || !table->maxlen || !*lenp ||
 	    (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
 	}
 	
-	i = (int *) table->data;
+	i = (int *) sysctl_table_data(table);
 	vleft = table->maxlen / sizeof(*i);
 	left = *lenp;
 
@@ -1878,13 +1898,13 @@ static int do_proc_doulongvec_minmax(ctl
 	char buf[TMPBUFLEN], *p;
 	char __user *s = buffer;
 	
-	if (!table->data || !table->maxlen || !*lenp ||
+	if (!sysctl_table_data(table) || !table->maxlen || !*lenp ||
 	    (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
 	}
 	
-	i = (unsigned long *) table->data;
+	i = (unsigned long *) sysctl_table_data(table);
 	min = (unsigned long *) table->extra1;
 	max = (unsigned long *) table->extra2;
 	vleft = table->maxlen / sizeof(unsigned long);
@@ -2230,7 +2250,9 @@ int sysctl_string(ctl_table *table, int 
 		  void __user *oldval, size_t __user *oldlenp,
 		  void __user *newval, size_t newlen, void **context)
 {
-	if (!table->data || !table->maxlen) 
+	char *data = sysctl_table_data(table);
+
+	if (!data || !table->maxlen)
 		return -ENOTDIR;
 	
 	if (oldval && oldlenp) {
@@ -2238,7 +2260,7 @@ int sysctl_string(ctl_table *table, int 
 		if (get_user(bufsize, oldlenp))
 			return -EFAULT;
 		if (bufsize) {
-			size_t len = strlen(table->data), copied;
+			size_t len = strlen(data), copied;
 
 			/* This shouldn't trigger for a well-formed sysctl */
 			if (len > table->maxlen)
@@ -2247,7 +2269,7 @@ int sysctl_string(ctl_table *table, int 
 			/* Copy up to a max of bufsize-1 bytes of the string */
 			copied = (len >= bufsize) ? bufsize - 1 : len;
 
-			if (copy_to_user(oldval, table->data, copied) ||
+			if (copy_to_user(oldval, data, copied) ||
 			    put_user(0, (char __user *)(oldval + copied)))
 				return -EFAULT;
 			if (put_user(len, oldlenp))
@@ -2258,11 +2280,11 @@ int sysctl_string(ctl_table *table, int 
 		size_t len = newlen;
 		if (len > table->maxlen)
 			len = table->maxlen;
-		if(copy_from_user(table->data, newval, len))
+		if(copy_from_user(data, newval, len))
 			return -EFAULT;
 		if (len == table->maxlen)
 			len--;
-		((char *) table->data)[len] = 0;
+		data[len] = 0;
 	}
 	return 1;
 }
@@ -2320,7 +2342,7 @@ int sysctl_jiffies(ctl_table *table, int
 			if (olen!=sizeof(int))
 				return -EINVAL; 
 		}
-		if (put_user(*(int *)(table->data)/HZ, (int __user *)oldval) ||
+		if (put_user(*(int *)(sysctl_table_data(table))/HZ, (int __user *)oldval) ||
 		    (oldlenp && put_user(sizeof(int),oldlenp)))
 			return -EFAULT;
 	}
@@ -2330,7 +2352,7 @@ int sysctl_jiffies(ctl_table *table, int
 			return -EINVAL; 
 		if (get_user(new, (int __user *)newval))
 			return -EFAULT;
-		*(int *)(table->data) = new*HZ; 
+		*(int *)(sysctl_table_data(table)) = new*HZ;
 	}
 	return 1;
 }
@@ -2340,6 +2362,7 @@ int sysctl_ms_jiffies(ctl_table *table, 
 		void __user *oldval, size_t __user *oldlenp,
 		void __user *newval, size_t newlen, void **context)
 {
+	int *jiffies_ptr = sysctl_table_data(table);
 	if (oldval) {
 		size_t olen;
 		if (oldlenp) { 
@@ -2348,7 +2371,7 @@ int sysctl_ms_jiffies(ctl_table *table, 
 			if (olen!=sizeof(int))
 				return -EINVAL; 
 		}
-		if (put_user(jiffies_to_msecs(*(int *)(table->data)), (int __user *)oldval) ||
+		if (put_user(jiffies_to_msecs(*jiffies_ptr), (int __user *)oldval) ||
 		    (oldlenp && put_user(sizeof(int),oldlenp)))
 			return -EFAULT;
 	}
@@ -2358,7 +2381,7 @@ int sysctl_ms_jiffies(ctl_table *table, 
 			return -EINVAL; 
 		if (get_user(new, (int __user *)newval))
 			return -EFAULT;
-		*(int *)(table->data) = msecs_to_jiffies(new);
+		*jiffies_ptr = msecs_to_jiffies(new);
 	}
 	return 1;
 }
_
