Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTIQFJJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 01:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTIQFJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 01:09:08 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:57804 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261969AbTIQFJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 01:09:03 -0400
Date: Wed, 17 Sep 2003 14:08:59 +0900
From: NIWA Hideyuki <niwa.hideyuki@soft.fujitsu.com>
Subject: Re: [RFC] Class-based Kernel Resource Management
In-reply-to: <3F563F01.3030207@watson.ibm.com>
To: linux-kernel@vger.kernel.org
Message-id: <20030917140859.77502e69.niwa.hideyuki@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
References: <1062186708.15245.832.camel@elinux05.watson.ibm.com>
 <20030903105409.0c341574.niwa.hideyuki@soft.fujitsu.com>
 <3F563F01.3030207@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried ckcpu patch. 
However, echo command did not return from the kernel 
when trying to create a new class through /proc I/F. 

	ex. echo 1 1 10 class1 > /proc/classes

Moreover, this process kept using CPU for a long time. 

And, I cannot put a process into the class. 

	ex. echo 1 5560 > /proc/classes

I checked the source of ckcpu(ckcpu-A01-2.6.0-test2) and 
made a simple patch as a workaround. 

This patch is quick Hack.:-)

best regards,
NIWA


diff -Nru linux-2.6.0-test2/kernel/class.c linux-2.6.0-test2-ckcpu/kernel/class.c
--- linux-2.6.0-test2/kernel/class.c	2003-09-17 10:27:30.137358992 +0900
+++ linux-2.6.0-test2-ckcpu/kernel/class.c	2003-09-17 10:29:15.844289096 +0900
@@ -825,6 +825,7 @@
 //	kfree(arg);
 }
 
+
 struct seq_operations classes_op = {
 	.start	= classes_start,
 	.next	= classes_next,
@@ -846,27 +847,39 @@
 {
 	char kbuf[MAX_CLASSES_WRITE+1];
 	char name[MAX_CLASSNAME_LEN];
-	int classid,weight;
+	int classid,weight,pid;
 	int cmd;
 	
 	if (count > MAX_CLASSES_WRITE)
 		return -EINVAL;
+
 	if (copy_from_user(&kbuf, buffer, count))
 		return -EFAULT;
-	kbuf[MAX_CLASSES_WRITE] = '\0'; 
 
-	if (sscanf(kbuf, "%d %d %d %s", &cmd, &classid, &weight, name) != 4)
-		return -EINVAL;
+	kbuf[MAX_CLASSES_WRITE] = '\0'; 
 
-	if (cmd == 1) {
-		__create_class(classid,name,weight,0);
-		return 0;
-	} 
+	sscanf(kbuf, "%d", &cmd);
 
-	if (cmd == 2) {
-		set_class(weight, classid);
+	switch (cmd) {
+	case 1:
+		if (sscanf(kbuf, "%d %d %d %s", &cmd, &classid, &weight, name) 
+								== 4) {
+			__create_class(classid,name,weight,0);
+			return strlen(kbuf);
+		} else {
+			return -EINVAL;
+		}
+	case 2:
+		if (sscanf(kbuf, "%d %d %d", &cmd, &classid, &pid) == 3) {
+			set_class(pid, classid);
+			return strlen(kbuf);
+		} else {
+			return -EINVAL;
+		}
+	default: 
+		return -EINVAL;
 	}
-
+		
 	return -1;
 }
 
@@ -951,6 +964,9 @@
 								
 void ckrm_cpu_change_class(struct task_struct *tsk,				
                                struct ckrm_cpu_class *cls) {		
+	if (cls == NULL) {
+		return;
+	}
 	set_class(tsk->pid,cls->class_id);
         tsk->cpu_class = cls;
 }							
@@ -960,3 +976,5 @@
 EXPORT_SYMBOL(ckrm_cpu_set_share);						
 EXPORT_SYMBOL(ckrm_cpu_get_usage);					
 EXPORT_SYMBOL(ckrm_dflt_cpu_class);
+EXPORT_SYMBOL(ckrm_cpu_change_class);
+

