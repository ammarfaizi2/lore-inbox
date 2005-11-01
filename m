Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbVKAHpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbVKAHpd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 02:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVKAHpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 02:45:33 -0500
Received: from [219.239.136.158] ([219.239.136.158]:34579 "HELO
	redflag-linux.com") by vger.kernel.org with SMTP id S964924AbVKAHpd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 02:45:33 -0500
From: Pengcheng Zou <pczou@redflag-linux.com>
Organization: Red Flag Linux
To: linux-kernel@vger.kernel.org
Subject: [PATCH] logging coredump event
Date: Tue, 1 Nov 2005 15:45:46 +0800
User-Agent: KMail/1.7
Cc: "Peter Wang" <spwang@corp.netease.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_q0xZD1A9+ysXkFg"
Message-Id: <200511011545.46402.pczou@redflag-linux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_q0xZD1A9+ysXkFg
Content-Type: text/plain;
  charset="gbk"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, 

sometimes daemon dies silently, dont know why, dont know when, dont know where 
the coredump is. attached with a patch (made by "Peter Wang" 
<spwang@corp.netease.com>) to make the sysadm's life a little bit easier, by 
logging the coredump event in syslog (if user allows). 

when enabled (sysctl -w kernel.log_sig_exit=1), some syslog message will be 
generated if a process crash:

Nov  1 15:32:54 localhost kernel: pid 4649 (coredump), uid 0: exited on signal 
11 (core dumped)

and then the sysadm can react promptly.

trivial patch, but IMHO, very useful.

cheers,
  -- Pengcheng

--Boundary-00=_q0xZD1A9+ysXkFg
Content-Type: text/x-diff;
  charset="gbk";
  name=""linux-2.6.14-log-sig-exit.patch""
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.14-log-sig-exit.patch"

diff -uprN linux-2.6.13.4.orig/fs/exec.c linux-2.6.13.4/fs/exec.c
--- linux-2.6.13.4.orig/fs/exec.c	2005-10-11 02:54:29.000000000 +0800
+++ linux-2.6.13.4/fs/exec.c	2005-11-01 13:55:50.000000000 +0800
@@ -58,6 +58,7 @@
 
 int core_uses_pid;
 char core_pattern[65] = "core";
+int log_sig_exit=0;
 int suid_dumpable = 0;
 
 EXPORT_SYMBOL(suid_dumpable);
@@ -1523,5 +1524,8 @@ fail_unlock:
 	current->fsuid = fsuid;
 	complete_all(&mm->core_done);
 fail:
+	if(log_sig_exit)
+		printk(KERN_INFO "pid %d (%s), uid %d: exited on signal %u %s\n",
+			current->pid,current->comm,current->uid,signr,retval?"(core dumped)":"");
 	return retval;
 }
diff -uprN linux-2.6.13.4.orig/include/linux/sysctl.h linux-2.6.13.4/include/linux/sysctl.h
--- linux-2.6.13.4.orig/include/linux/sysctl.h	2005-10-11 02:54:29.000000000 +0800
+++ linux-2.6.13.4/include/linux/sysctl.h	2005-11-01 13:56:47.000000000 +0800
@@ -146,6 +146,7 @@ enum
 	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
 	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
+	KERN_LOG_SIG_EXIT=71, /* int: log when task exits because of some signals */
 };
 
 
diff -uprN linux-2.6.13.4.orig/kernel/sysctl.c linux-2.6.13.4/kernel/sysctl.c
--- linux-2.6.13.4.orig/kernel/sysctl.c	2005-10-11 02:54:29.000000000 +0800
+++ linux-2.6.13.4/kernel/sysctl.c	2005-11-01 13:58:21.000000000 +0800
@@ -60,6 +60,7 @@ extern int sysrq_enabled;
 extern int core_uses_pid;
 extern int suid_dumpable;
 extern char core_pattern[];
+extern int log_sig_exit;
 extern int cad_pid;
 extern int pid_max;
 extern int min_free_kbytes;
@@ -298,6 +299,14 @@ static ctl_table kern_table[] = {
 		.strategy	= &sysctl_string,
 	},
 	{
+		.ctl_name = KERN_LOG_SIG_EXIT,
+		.procname = "log_sig_exit",
+		.data  = &log_sig_exit,
+		.maxlen  = sizeof(int),
+		.mode  = 0644,
+		.proc_handler = &proc_dointvec,
+	},
+	{
 		.ctl_name	= KERN_TAINTED,
 		.procname	= "tainted",
 		.data		= &tainted,

--Boundary-00=_q0xZD1A9+ysXkFg--
