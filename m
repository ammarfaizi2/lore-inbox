Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVAUCUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVAUCUH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 21:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVAUCUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 21:20:07 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:36238 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S262231AbVAUCTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 21:19:54 -0500
Date: Thu, 20 Jan 2005 21:19:53 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Jan Knutar <jk-lkml@sci.fi>
Subject: Re: [RFC][PATCH] /proc/<pid>/rlimit
Message-ID: <20050121021953.GA6797@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	Chris Wright <chrisw@osdl.org>, Jan Knutar <jk-lkml@sci.fi>
References: <20050118204457.GA7824@ti64.telemetry-investments.com> <20050120144358.GI476@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120144358.GI476@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 03:43:58PM +0100, Pavel Machek wrote:
> It would be nice if you could make it "value-per-file". That way,
> it could become writable in future. If "max nice level" ever becomes rlimit,
> this would be very usefull.

Agreed, though write support present difficulties.

My principal concern is that we don't want users changing resource limits
of privileged processes.  If we want an ordinary user to be allowed to
change limits, the rules would have to be similar to those allowed for
ptrace(), e.g., no-setuid processes, etc.  [With ptrace(), one can of
course attach to the process and invoke the setrlimit() syscall directly].
Additionally, sys_setrlimit() has an LSM hook:

	security_task_setrlimit(unsigned int resource, struct rlimit *)

One would need to take account of changing the limit from a different
context.  It's a bit of a mess, and outside of the standard API; that's
why I didn't bother.

Anyway, for Jan, here's my incomplete and unmergeable cut-n-paste hack
to implement write on top of my previous patch.  Format is as was
suggested by Jan:

	<name|[rlimit-]%u> <%u|unlimited> <%u|unlimited>

E.g.,
	echo  memlock 65536 65536 > /proc/1/rlimit

Writing is limited to root (i.e. CAP_SYS_PTRACE), though see
fs/proc/base.c:may_ptrace_attach() for an idea of how to change that.

	-Bill


--- linux-2.6.11-rc1-bk6/fs/proc/base.c.proc-pid-rlimit-write
+++ linux-2.6.11-rc1-bk6/fs/proc/base.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/file.h>
 #include <linux/string.h>
+#include <linux/ctype.h>
 #include <linux/seq_file.h>
 #include <linux/namei.h>
 #include <linux/namespace.h>
@@ -127,7 +128,7 @@
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
-	E(PROC_TGID_RLIMIT,    "rlimit",  S_IFREG|S_IRUGO),
+	E(PROC_TGID_RLIMIT,    "rlimit",  S_IFREG|S_IRUGO|S_IWUSR),
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -153,7 +154,7 @@
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
-	E(PROC_TID_RLIMIT,     "rlimit",  S_IFREG|S_IRUGO),
+	E(PROC_TID_RLIMIT,     "rlimit",  S_IFREG|S_IRUGO|S_IWUSR),
 #ifdef CONFIG_SECURITY
 	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -595,9 +596,99 @@
 	return single_release(inode, file);
 }
 
+static inline char *skip_ws(char *s)
+{
+	while (isspace(*s))
+		s++;
+	return s;
+}
+
+static inline char *find_ws(char *s)
+{
+	while (!isspace(*s) && *s != '\0')
+		s++;
+	return s;
+}
+
+#define MAX_RLIMIT_WRITE 79
+static ssize_t rlimit_write(struct file * file, const char * buf,
+                         size_t count, loff_t *ppos)
+{
+	struct task_struct *task = proc_task(file->f_dentry->d_inode);
+	struct rlimit new_rlim, *old_rlim;
+	unsigned int i;
+	char *s, *t, kbuf[MAX_RLIMIT_WRITE+1];
+
+	/* changing resources limits can crash or subvert a process */
+	if (!capable(CAP_SYS_PTRACE) || security_ptrace(current,task))
+		return -ESRCH;
+
+        if (count > MAX_RLIMIT_WRITE)
+                return -EINVAL;
+        if (copy_from_user(&kbuf, buf, count))
+                return -EFAULT;
+        kbuf[MAX_RLIMIT_WRITE] = '\0'; 
+
+	/* parse the resource id */
+	s = skip_ws(kbuf);
+	t = find_ws(s);
+	if (*t == '\0')
+		return -EINVAL;
+	*t++ = '\0';
+	for (i = 0 ; i < RLIM_NLIMITS ; i++)
+		if (rlim_name[i] && !strcmp(s,rlim_name[i]))
+			break;
+	if (i >= RLIM_NLIMITS) {
+		if (!strncmp(s, "rlimit-",7))
+			s += 7;
+		if (sscanf(s, "%u", &i) != 1 || i >= RLIM_NLIMITS)
+			return -EINVAL;
+	}
+
+	/* parse the soft limit */
+	s = skip_ws(t);
+	t = find_ws(s);
+	if (*t == '\0')
+		return -EINVAL;
+	*t++ = '\0';
+	if (!strcmp(s, "unlimited")) 
+		new_rlim.rlim_cur = RLIM_INFINITY;
+	else if (sscanf(s, "%lu", &new_rlim.rlim_cur) != 1)
+		return -EINVAL;
+
+	/* parse the hard limit */
+	s = skip_ws(t);
+	t = find_ws(s);
+	*t = '\0';
+	if (!strcmp(s, "unlimited")) 
+		new_rlim.rlim_max = RLIM_INFINITY;
+	else if (sscanf(s, "%lu", &new_rlim.rlim_max) != 1)
+		return -EINVAL;
+
+	/* validate the values; copied from sys_setrlimit() */
+	if (new_rlim.rlim_cur > new_rlim.rlim_max)
+		return -EINVAL;
+        old_rlim = task->signal->rlim + i;
+	if ((new_rlim.rlim_max > old_rlim->rlim_max) &&
+	    !capable(CAP_SYS_RESOURCE))
+		return -EPERM;
+	if (i == RLIMIT_NOFILE && new_rlim.rlim_max > NR_OPEN)
+		return -EPERM;
+
+	/* SECURITY: missing security_task_setrlimit() equivalent */
+
+	/* set the limits */
+        task_lock(task->group_leader);
+        *old_rlim = new_rlim;
+        task_unlock(task->group_leader);
+
+	return count;
+}
+
 static struct file_operations proc_rlimit_operations = {
 	.open		= rlimit_open,
 	.read		= seq_read,
+	.write		= rlimit_write,
 	.llseek		= seq_lseek,
 	.release	= rlimit_release,
 };
