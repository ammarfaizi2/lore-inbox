Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVGOTTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVGOTTm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 15:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVGOTTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 15:19:42 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:24982 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262001AbVGOTRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 15:17:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:x-enigmail-version:x-enigmail-supports:content-type;
        b=bfJ+SBKONgOh9dS4huDvQb67TUXEEiRGEBd/LFPDJF3lYfELMECdYMqhIQ1eE4zXpbi8g/1NSslG7hSo2nCCh98pzaGI8NYrLIZLPU8LJDMezifxEguAuef2dd0HE6CuY2FQJPLM50ZyPEhcJyEHzJoK90NBn9RUjD0ZmkXKkHg=
Message-ID: <42D80BBC.3020301@gmail.com>
Date: Fri, 15 Jul 2005 21:17:16 +0200
From: dierbro <dierbro@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050620)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] add rlimit file to /proc/PID
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030008000507030205040904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030008000507030205040904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,
with a friend i have made this patch that add rlimit file to /proc/PID
directory.
Trought this file you can set and get rlimit of a running process.

rlimit file contains:
<resource> <Soft limit> <Hard limit>

Example:
cave 5933 #  pwd
/proc/5933
cave 5933 # echo "RLIMIT_NOFILE 3 10" > rlimit
cave 5933 # cat rlimit
RLIMIT_CPU -1 -1
RLIMIT_FSIZE -1 -1
RLIMIT_DATA -1 -1
RLIMIT_STACK 8388608 -1
RLIMIT_CORE 0 -1
RLIMIT_RSS -1 -1
RLIMIT_NPROC 4095 4095
RLIMIT_NOFILE 3 10
RLIMIT_MEMLOCK 32768 32768
RLIMIT_AS -1 -1
RLIMIT_LOCKS -1 -1
RLIMIT_SIGPENDING 4095 4095
cave 5933 #


This is my first patch,i hope it will be usefull

Signed-off-by: Diego R. Brogna	<dierbro@gmail.com>
Signed-off-by: Raffaele La Brocca <raflbr@gmail.com>


--- linux-2.6.13-rc3/fs/proc/base.c	2005-07-15 20:57:25.000000000 +0200
+++ linux-2.6.13-rc3/fs/proc/base.c.rlimit	2005-07-15 20:57:05.000000000 +0200





--------------030008000507030205040904
Content-Type: text/plain;
 name="rlimit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rlimit.patch"

--- linux-2.6.13-rc3/fs/proc/base.c	2005-07-15 20:57:25.000000000 +0200
+++ linux-2.6.13-rc3/fs/proc/base.c.rlimit	2005-07-15 20:57:05.000000000 +0200
@@ -86,6 +86,7 @@
 	PROC_TGID_FD_DIR,
 	PROC_TGID_OOM_SCORE,
 	PROC_TGID_OOM_ADJUST,
+	PROC_TGID_RLIMIT,
 	PROC_TID_INO,
 	PROC_TID_STATUS,
 	PROC_TID_MEM,
@@ -123,6 +124,7 @@
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 	PROC_TID_OOM_SCORE,
 	PROC_TID_OOM_ADJUST,
+	PROC_TID_RLIMIT,
 };
 
 struct pid_entry {
@@ -166,6 +168,7 @@
 #endif
 	E(PROC_TGID_OOM_SCORE, "oom_score",S_IFREG|S_IRUGO),
 	E(PROC_TGID_OOM_ADJUST,"oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
+	E(PROC_TGID_RLIMIT,    "rlimit",  S_IFREG|S_IRUGO),
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TGID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
@@ -202,6 +205,7 @@
 #endif
 	E(PROC_TID_OOM_SCORE,  "oom_score",S_IFREG|S_IRUGO),
 	E(PROC_TID_OOM_ADJUST, "oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
+	E(PROC_TID_RLIMIT,     "rlimit",  S_IFREG|S_IRUGO),
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
@@ -582,6 +586,189 @@
 	.read		= proc_info_read,
 };
 
+static int rlimit_read(struct file * file, char __user * buf,
+		                        size_t count, loff_t *ppos)
+{
+	struct task_struct *task = proc_task(file->f_dentry->d_inode);
+	int res = 0, i;
+	unsigned long len;
+	char buffer[2048];
+	if(task){
+	
+		for(i=0; i<RLIM_NLIMITS;i++)
+			switch(i){
+				case RLIMIT_AS:
+					len = sprintf(buffer+res, "RLIMIT_AS %d %d\n",
+							(int) task->signal->rlim[i].rlim_cur,
+							(int)task->signal->rlim[i].rlim_max);
+					res+=len;
+					break;
+				case RLIMIT_CORE:
+					len = sprintf(buffer+res, "RLIMIT_CORE %d %d\n",
+							(int) task->signal->rlim[i].rlim_cur,
+							(int)task->signal->rlim[i].rlim_max);
+					res+=len;
+					break;
+				case RLIMIT_CPU:
+					len = sprintf(buffer+res, "RLIMIT_CPU %d %d\n",
+							(int) task->signal->rlim[i].rlim_cur,
+							(int)task->signal->rlim[i].rlim_max);
+					res+=len;
+					break;
+				case RLIMIT_DATA:
+					len = sprintf(buffer+res, "RLIMIT_DATA %d %d\n",
+							(int) task->signal->rlim[i].rlim_cur,
+							(int)task->signal->rlim[i].rlim_max);
+					res+=len;
+					break;
+				case RLIMIT_FSIZE:
+					len = sprintf(buffer+res, "RLIMIT_FSIZE %d %d\n",
+							(int) task->signal->rlim[i].rlim_cur,
+							(int)task->signal->rlim[i].rlim_max);
+					res+=len;
+					break;
+				case RLIMIT_LOCKS:
+					len = sprintf(buffer+res, "RLIMIT_LOCKS %d %d\n",
+							(int) task->signal->rlim[i].rlim_cur,
+							(int)task->signal->rlim[i].rlim_max);
+					res+=len;
+					break;
+				case RLIMIT_MEMLOCK:
+					len = sprintf(buffer+res, "RLIMIT_MEMLOCK %d %d\n",
+							(int) task->signal->rlim[i].rlim_cur,
+							(int)task->signal->rlim[i].rlim_max);
+					res+=len;
+					break;
+				case RLIMIT_NOFILE:
+					len = sprintf(buffer+res, "RLIMIT_NOFILE %d %d\n",
+							(int) task->signal->rlim[i].rlim_cur,
+							(int)task->signal->rlim[i].rlim_max);
+					res+=len;
+					break;
+				case RLIMIT_NPROC:
+					len = sprintf(buffer+res, "RLIMIT_NPROC %d %d\n",
+							(int) task->signal->rlim[i].rlim_cur,
+							(int)task->signal->rlim[i].rlim_max);
+					res+=len;
+					break;
+				case RLIMIT_RSS:
+					len = sprintf(buffer+res, "RLIMIT_RSS %d %d\n",
+							(int) task->signal->rlim[i].rlim_cur,
+							(int)task->signal->rlim[i].rlim_max);
+					res+=len;
+					break;
+				case RLIMIT_SIGPENDING:
+					len = sprintf(buffer+res, "RLIMIT_SIGPENDING %d %d\n",
+							(int) task->signal->rlim[i].rlim_cur,
+							(int)task->signal->rlim[i].rlim_max);
+					res+=len;
+					break;
+				case RLIMIT_STACK:
+					len = sprintf(buffer+res, "RLIMIT_STACK %d %d\n",
+							(int) task->signal->rlim[i].rlim_cur,
+							(int)task->signal->rlim[i].rlim_max);
+					res+=len;
+					break;
+			
+			}
+	}
+return simple_read_from_buffer(buf, count, ppos, buffer, res);
+}
+
+static ssize_t rlimit_write(struct file * file, const char * buffer,
+			 size_t count, loff_t *ppos)
+{
+	struct task_struct *task = proc_task(file->f_dentry->d_inode);
+	unsigned long cur,max;
+	char *c;
+	char *endptr;
+	char *buf=NULL;
+
+
+	if (((current->uid != task->euid) ||
+             (current->uid != task->suid) ||
+             (current->uid != task->uid)  ||
+             (current->gid != task->egid) ||
+             (current->gid != task->sgid) ||
+             (current->gid != task->gid)) || !capable(CAP_SYS_RESOURCE) ){
+		return -EPERM;
+	}
+
+
+	if( (buf=kmalloc(GFP_KERNEL,count))==NULL){
+		return  -ENOMEM;
+	}
+
+	memcpy(buf,buffer,count); 
+
+	
+	c=strchr(buf,' ');
+	if(!c) goto out_err;
+	
+	*c='\0';
+	int resource=-1;
+	
+	if(strcmp("RLIMIT_AS",buf)==0)
+		resource=RLIMIT_AS;
+	else if(strcmp("RLIMIT_CORE",buf)==0)
+		resource=RLIMIT_CORE;
+	else if(strcmp("RLIMIT_CPU",buf)==0)
+		resource=RLIMIT_CPU;
+	else if(strcmp("RLIMIT_DATA",buf)==0)
+		resource=RLIMIT_DATA;
+	else if(strcmp("RLIMIT_FSIZE",buf)==0)
+		resource=RLIMIT_FSIZE;
+	else if(strcmp("RLIMIT_LOCKS",buf)==0)
+		resource=RLIMIT_LOCKS;
+	else if(strcmp("RLIMIT_MEMLOCK",buf)==0)
+		resource=RLIMIT_MEMLOCK;
+	else if(strcmp("RLIMIT_NOFILE",buf)==0)
+		resource=RLIMIT_NOFILE;
+	else if(strcmp("RLIMIT_NPROC",buf)==0)
+		resource=RLIMIT_NPROC;
+	else if(strcmp("RLIMIT_RSS",buf)==0)
+		resource=RLIMIT_RSS;
+	else if(strcmp("RLIMIT_SIGPENDING",buf)==0)
+		resource=RLIMIT_SIGPENDING;
+	else if(strcmp("RLIMIT_STACK",buf)==0)
+		resource=RLIMIT_STACK;
+
+
+	if(resource==-1)
+		goto out_err;
+
+	buf=c+1;
+	
+	cur=(unsigned long)simple_strtol(buf,&endptr,10);
+	
+	buf=endptr+1;
+
+	max=(unsigned long)simple_strtol(buf,&endptr,10);
+
+
+	task->signal->rlim[resource].rlim_cur=cur;
+	task->signal->rlim[resource].rlim_max=max;
+
+
+		kfree(buf);
+		return count;
+	
+	out_err:
+		kfree(buf);
+		return EINVAL;
+
+
+
+}
+
+
+
+static struct file_operations proc_rlimit_file_operations = {
+	.read		= rlimit_read,
+	.write		= rlimit_write,
+};
+
+
 static int mem_open(struct inode* inode, struct file* file)
 {
 	file->private_data = (void*)((long)current->self_exec_id);
@@ -1520,6 +1707,10 @@
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_pid_statm;
 			break;
+		case PROC_TID_RLIMIT:
+		case PROC_TGID_RLIMIT:
+			inode->i_fop = &proc_rlimit_file_operations;
+			break;
 		case PROC_TID_MAPS:
 		case PROC_TGID_MAPS:
 			inode->i_fop = &proc_maps_operations;

--------------030008000507030205040904--
