Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268290AbUHKWnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268290AbUHKWnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268293AbUHKWnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:43:05 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:24716 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268290AbUHKWm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:42:57 -0400
Date: Wed, 11 Aug 2004 15:42:56 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com
Subject: [PATCH 1/3] [Generic] Transition /proc/cpuinfo -> sysfs
Message-ID: <20040811224256.GA7095@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040811224117.GA6450@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811224117.GA6450@plexity.net>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Add printk to cpuinfo_open reminding user to transition to sysfs
- Add arch_cpuinfo field to struct cpu

diff -Nru a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
--- a/fs/proc/proc_misc.c	Wed Aug 11 14:46:15 2004
+++ b/fs/proc/proc_misc.c	Wed Aug 11 14:46:15 2004
@@ -258,11 +258,18 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+#define	CPUINFO_REMOVAL_DATE "September 1st, 2005"
 extern struct seq_operations cpuinfo_op;
 static int cpuinfo_open(struct inode *inode, struct file *file)
 {
+	printk(KERN_WARNING "Using depecrated /proc/cpuinfo interface\n");
+	printk(KERN_WARNING "This interface will be deleted on %s\n", 
+			CPUINFO_REMOVAL_DATE);
+	printk(KERN_WARNING "Please use syfs interface instead\n");
+
 	return seq_open(file, &cpuinfo_op);
 }
+
 static struct file_operations proc_cpuinfo_operations = {
 	.open		= cpuinfo_open,
 	.read		= seq_read,
diff -Nru a/include/linux/cpu.h b/include/linux/cpu.h
--- a/include/linux/cpu.h	Wed Aug 11 14:46:15 2004
+++ b/include/linux/cpu.h	Wed Aug 11 14:46:15 2004
@@ -28,6 +28,7 @@
 struct cpu {
 	int node_id;		/* The node which contains the CPU */
 	int no_control;		/* Should the sysfs control file be created? */
+	void *arch_cpuinfo;	/* Per-cpu arch data */
 	struct sys_device sysdev;
 };
 

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
