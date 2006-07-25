Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWGYOQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWGYOQS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 10:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWGYOQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 10:16:18 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:8644 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932157AbWGYOQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 10:16:16 -0400
In-Reply-To: <1153763509.5171.20.camel@localhost.localdomain>
Subject: Re: [RFC][PATCH 6/6] SLIM: debug output
To: kjhall@us.ibm.com
Cc: David Safford <safford@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Serge E Hallyn <sergeh@us.ibm.com>
X-Mailer: Lotus Notes Release 7.0.1 Beta3NP May 09, 2006
Message-ID: <OFA82C2034.B8998909-ON852571B6.004E26A4-852571B6.004ECF85@us.ibm.com>
From: Mimi Zohar <zohar@us.ibm.com>
Date: Tue, 25 Jul 2006 10:16:14 -0400
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0.1HF269 | June 22, 2006) at
 07/25/2006 10:16:15
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kylie,

This patch doesn't apply properly.  It seems that most of the debugging was
added in the base slim.  The parts
that weren't added are listed below.

Mimi

Index: linux-2.6.17.7/security/slim/slm_main.c
===================================================================
--- linux-2.6.17.7.orig/security/slim/slm_main.c
+++ linux-2.6.17.7/security/slim/slm_main.c
@@ -1563,6 +1563,7 @@ static void enforce_guard_integrity_exec
 {
      struct slm_tsec_data *cur_tsec = current->security;
      struct task_struct *parent_tsk = current->parent;
+     struct slm_tsec_data *parent_tsec = parent_tsk->security;

      if ((strcmp(bprm->filename, bprm->interp) != 0)
          && (level->guard.unlimited)) {
@@ -1588,6 +1589,35 @@ static void enforce_guard_integrity_exec
            cur_tsec->iac_wx = level->guard.iac_wx;
            spin_unlock(&cur_tsec->lock);
      } else {
+           if (!parent_tsec) {
+                 dprintk(SLM_SECRECY,
+                       "%s: pid %d(%s %d-%s) %s "
+                       " executing, promoting secrecy to sac=%d-%s\n",
+                       __FUNCTION__, current->pid,
+                       current->comm, cur_tsec->sac_rx,
+                       (cur_tsec->sac_w != cur_tsec->sac_rx)
+                       ? "GUARD" : slm_sac_str[cur_tsec->
+                                         sac_rx],
+                       bprm->filename, level->sac_level,
+                       slm_sac_str[level->sac_level]);
+           } else
+                 dprintk(SLM_SECRECY,
+                       "%s: ppid %d(%s %d-%s) pid %d(%s %d-%s) %s"
+                       "executing, promoting secrecy to sac=%d-%s\n",
+                       __FUNCTION__, parent_tsk->pid,
+                       parent_tsk->comm,
+                       parent_tsec->sac_rx,
+                       (parent_tsec->sac_w != parent_tsec->sac_rx)
+                       ? "GUARD" :
+                       slm_sac_str[parent_tsec->sac_rx],
+                       current->pid, current->comm,
+                       cur_tsec->sac_rx,
+                       (cur_tsec->sac_w != cur_tsec->sac_rx)
+                       ? "GUARD" : slm_sac_str[cur_tsec->
+                                         sac_rx],
+                       bprm->filename, level->sac_level,
+                       slm_sac_str[level->sac_level]);
+
            spin_lock(&cur_tsec->lock);
            if (cur_tsec->iac_r > level->guard.iac_r)
                  cur_tsec->iac_r = level->guard.iac_r;
Index: linux-2.6.17.7/security/slim/slim.h
===================================================================
--- linux-2.6.17.7.orig/security/slim/slim.h
+++ linux-2.6.17.7/security/slim/slim.h
@@ -100,3 +100,19 @@ extern int slm_init_config(void);

 extern __init int slm_init_secfs(void);
 extern __exit void slm_cleanup_secfs(void);
+
+extern __init int slm_init_debugfs(void);
+extern __exit void slm_cleanup_debugfs(void);
+
+extern unsigned int slm_debug;
+enum slm_debug_level {
+     SLM_BASE = 1,
+     SLM_INTEGRITY = 2,
+     SLM_SECRECY = 4,
+     SLM_VERBOSE = 8,
+};
+
+#undef dprintk
+#define dprintk(level, format, a...) \
+     if (slm_debug & level) \
+           printk(KERN_INFO format, ##a)
Index: linux-2.6.17.7/security/slim/slm_secfs.c
===================================================================
--- linux-2.6.17.7.orig/security/slim/slm_secfs.c
+++ linux-2.6.17.7/security/slim/slm_secfs.c
@@ -19,6 +19,8 @@
 #include "slim.h"

 static struct dentry *slim_sec_dir, *slim_level;
+static struct dentry *slim_debug_dir, *slim_integrity, *slim_secrecy,
+    *slim_verbose;

 static ssize_t slm_read_level(struct file *file, char __user *buf,
                        size_t buflen, loff_t *ppos)
@@ -42,10 +44,85 @@ static ssize_t slm_read_level(struct fil
      return simple_read_from_buffer(buf, buflen, ppos, data, len);
 }

+static int slm_open_debug(struct inode *inode, struct file *file)
+{
+     if (inode->u.generic_ip)
+           file->private_data = inode->u.generic_ip;
+     return 0;
+}
+
+static ssize_t slm_read_debug(struct file *file, char __user * buf,
+                       size_t buflen, loff_t * ppos)
+{
+     ssize_t len = 0;
+     enum slm_debug_level type = (enum slm_debug_level)file->private_data;
+     char *page = (char *)__get_free_page(GFP_KERNEL);
+
+     if (!page)
+           return -ENOMEM;
+
+     switch(type) {
+     case SLM_INTEGRITY:
+           len = sprintf(page, "slm_debug: integrity %s\n",
+                       ((slm_debug & SLM_INTEGRITY) == SLM_INTEGRITY)
+                       ? "ON" : "OFF");
+           break;
+     case SLM_SECRECY:
+           len = sprintf(page, "slm_debug: secrecy %s\n",
+                       ((slm_debug & SLM_SECRECY) == SLM_SECRECY)
+                       ? "ON" : "OFF");
+           break;
+     case SLM_VERBOSE:
+           len = sprintf(page, "evm_debug: verbose %s\n",
+                       ((slm_debug & SLM_VERBOSE) == SLM_VERBOSE)
+                       ? "ON" : "OFF");
+           break;
+     default:
+           break;
+     }
+     len = simple_read_from_buffer(buf, buflen, ppos, page, len);
+     free_page((unsigned long)page);
+     return len;
+}
+
+static ssize_t slm_write_debug(struct file *file, const char __user * buf,
+                        size_t buflen, loff_t * ppos)
+{
+     char flag;
+     enum slm_debug_level type = (enum slm_debug_level)file->private_data;
+
+     if (copy_from_user(&flag, buf, 1))
+           return -EFAULT;
+
+     switch(type) {
+     case SLM_INTEGRITY:
+           slm_debug = (flag == '0') ? slm_debug & ~SLM_INTEGRITY :
+               slm_debug | SLM_INTEGRITY;
+           break;
+     case SLM_SECRECY:
+           slm_debug = (flag == '0') ? slm_debug & ~SLM_SECRECY :
+               slm_debug | SLM_SECRECY;
+           break;
+     case SLM_VERBOSE:
+           slm_debug = (flag == '0') ? slm_debug & ~SLM_VERBOSE :
+               slm_debug | SLM_VERBOSE;
+           break;
+     default:
+           break;
+     }
+     return buflen;
+}
+
 static struct file_operations slm_level_ops = {
      .read = slm_read_level,
 };

+static struct file_operations slm_debug_ops = {
+     .read = slm_read_debug,
+     .write = slm_write_debug,
+     .open = slm_open_debug,
+};
+
 int __init slm_init_secfs(void)
 {
      slim_sec_dir = securityfs_create_dir("slim", NULL);
@@ -60,8 +137,48 @@ int __init slm_init_secfs(void)
      return 0;
 }

+int __init slm_init_debugfs(void)
+{
+     slim_debug_dir = debugfs_create_dir("slim", NULL);
+     if (!slim_debug_dir || IS_ERR(slim_debug_dir))
+           return -EFAULT;
+
+     slim_integrity = debugfs_create_file("integrity", S_IRUSR | S_IRGRP,
+                                  slim_debug_dir, (void *)SLM_INTEGRITY,
+                                  &slm_debug_ops);
+     if (!slim_integrity || IS_ERR(slim_integrity))
+           goto out_del_debugdir;
+     slim_secrecy = debugfs_create_file("secrecy", S_IRUSR | S_IRGRP,
+                                slim_debug_dir, (void *)SLM_SECRECY,
+                                &slm_debug_ops);
+     if (!slim_secrecy || IS_ERR(slim_secrecy))
+           goto out_del_integrity;
+     slim_verbose = debugfs_create_file("verbose", S_IRUSR | S_IRGRP,
+                                slim_debug_dir, (void *)SLM_VERBOSE,
+                                &slm_debug_ops);
+     if (!slim_verbose || IS_ERR(slim_verbose))
+           goto out_del_secrecy;
+     return 0;
+
+out_del_secrecy:
+     debugfs_remove(slim_secrecy);
+out_del_integrity:
+     debugfs_remove(slim_integrity);
+out_del_debugdir:
+     debugfs_remove(slim_debug_dir);
+     return -EFAULT;
+}
+
 void __exit slm_cleanup_secfs(void)
 {
      securityfs_remove(slim_level);
      securityfs_remove(slim_sec_dir);
 }
+
+void __exit slm_cleanup_debugfs(void)
+{
+     debugfs_remove(slim_verbose);
+     debugfs_remove(slim_secrecy);
+     debugfs_remove(slim_integrity);
+     debugfs_remove(slim_debug_dir);
+}

Mimi

