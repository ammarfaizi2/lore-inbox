Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWBCRGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWBCRGB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWBCRGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:06:00 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:843 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751246AbWBCRF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:05:59 -0500
Message-ID: <43E38DA9.9040606@sw.ru>
Date: Fri, 03 Feb 2006 20:06:49 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@openvz.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org
Subject: [RFC][PATCH 3/5] Virtualization/containers: UTSNAME
References: <43E38BD1.4070707@openvz.org>
In-Reply-To: <43E38BD1.4070707@openvz.org>
Content-Type: multipart/mixed;
 boundary="------------010007090704000409080702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010007090704000409080702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Virtualization of UTSNAME.
As simple as UID hashes, just virtualizes system_utsname variable 
(diff-vps-uts-name-core) and replaces access to it with vps_utsname in 
required places (diff-vps-uts-name-kern).

Kirill

--------------010007090704000409080702
Content-Type: text/plain;
 name="diff-vps-uts-name-core"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-vps-uts-name-core"

--- ./include/linux/vps_info.h.vps_uts_core	2006-02-03 16:49:51.000000000 +0300
+++ ./include/linux/vps_info.h	2006-02-03 16:50:39.000000000 +0300
@@ -6,6 +6,7 @@
 
 struct task_struct;
 struct list_head;
+struct new_utsname;
 
 struct vps_info {
 	u32 id;
@@ -13,6 +14,7 @@
 	atomic_t refcnt;
 
 	struct list_head *vps_uid_hash;
+	struct new_utsname *vps_uts_name;
 };
 
 extern struct vps_info host_vps_info;
--- ./include/linux/utsname.h.vps_uts_core	2006-02-03 16:38:17.000000000 +0300
+++ ./include/linux/utsname.h	2006-02-03 16:50:26.000000000 +0300
@@ -1,6 +1,8 @@
 #ifndef _LINUX_UTSNAME_H
 #define _LINUX_UTSNAME_H
 
+#include <linux/vps_info.h>
+
 #define __OLD_UTS_LEN 8
 
 struct oldold_utsname {
@@ -31,6 +33,7 @@
 };
 
 extern struct new_utsname system_utsname;
+#define vps_utsname	(*(current_vps()->vps_uts_name))
 
 extern struct rw_semaphore uts_sem;
 #endif
--- ./init/main.c.vps_uts_core	2006-02-03 16:43:18.000000000 +0300
+++ ./init/main.c	2006-02-03 16:50:26.000000000 +0300
@@ -439,6 +439,7 @@
 	.id		= 0,
 	.init_task	= &init_task,
 	.refcnt		= ATOMIC_INIT(1),
+	.vps_uts_name	= &system_utsname,
 };
 
 EXPORT_SYMBOL(host_vps_info);

--------------010007090704000409080702
Content-Type: text/plain;
 name="diff-vps-uts-name-kern"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-vps-uts-name-kern"

--- ./arch/alpha/kernel/osf_sys.c.vps_uts	2006-02-03 11:56:22.000000000 +0300
+++ ./arch/alpha/kernel/osf_sys.c	2006-02-03 13:35:25.000000000 +0300
@@ -402,15 +402,15 @@
 
 	down_read(&uts_sem);
 	error = -EFAULT;
-	if (copy_to_user(name + 0, system_utsname.sysname, 32))
+	if (copy_to_user(name + 0, vps_utsname.sysname, 32))
 		goto out;
-	if (copy_to_user(name + 32, system_utsname.nodename, 32))
+	if (copy_to_user(name + 32, vps_utsname.nodename, 32))
 		goto out;
-	if (copy_to_user(name + 64, system_utsname.release, 32))
+	if (copy_to_user(name + 64, vps_utsname.release, 32))
 		goto out;
-	if (copy_to_user(name + 96, system_utsname.version, 32))
+	if (copy_to_user(name + 96, vps_utsname.version, 32))
 		goto out;
-	if (copy_to_user(name + 128, system_utsname.machine, 32))
+	if (copy_to_user(name + 128, vps_utsname.machine, 32))
 		goto out;
 
 	error = 0;
@@ -449,8 +449,8 @@
 
 	down_read(&uts_sem);
 	for (i = 0; i < len; ++i) {
-		__put_user(system_utsname.domainname[i], name + i);
-		if (system_utsname.domainname[i] == '\0')
+		__put_user(vps_utsname.domainname[i], name + i);
+		if (vps_utsname.domainname[i] == '\0')
 			break;
 	}
 	up_read(&uts_sem);
@@ -608,11 +608,11 @@
 osf_sysinfo(int command, char __user *buf, long count)
 {
 	static char * sysinfo_table[] = {
-		system_utsname.sysname,
-		system_utsname.nodename,
-		system_utsname.release,
-		system_utsname.version,
-		system_utsname.machine,
+		vps_utsname.sysname,
+		vps_utsname.nodename,
+		vps_utsname.release,
+		vps_utsname.version,
+		vps_utsname.machine,
 		"alpha",	/* instruction set architecture */
 		"dummy",	/* hardware serial number */
 		"dummy",	/* hardware manufacturer */
--- ./arch/i386/kernel/sys_i386.c.vps_uts	2006-01-03 06:21:10.000000000 +0300
+++ ./arch/i386/kernel/sys_i386.c	2006-02-03 13:35:25.000000000 +0300
@@ -217,7 +217,7 @@
 	if (!name)
 		return -EFAULT;
 	down_read(&uts_sem);
-	err=copy_to_user(name, &system_utsname, sizeof (*name));
+	err=copy_to_user(name, &vps_utsname, sizeof (*name));
 	up_read(&uts_sem);
 	return err?-EFAULT:0;
 }
@@ -233,15 +233,15 @@
   
   	down_read(&uts_sem);
 	
-	error = __copy_to_user(&name->sysname,&system_utsname.sysname,__OLD_UTS_LEN);
+	error = __copy_to_user(&name->sysname,&vps_utsname.sysname,__OLD_UTS_LEN);
 	error |= __put_user(0,name->sysname+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->nodename,&system_utsname.nodename,__OLD_UTS_LEN);
+	error |= __copy_to_user(&name->nodename,&vps_utsname.nodename,__OLD_UTS_LEN);
 	error |= __put_user(0,name->nodename+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->release,&system_utsname.release,__OLD_UTS_LEN);
+	error |= __copy_to_user(&name->release,&vps_utsname.release,__OLD_UTS_LEN);
 	error |= __put_user(0,name->release+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->version,&system_utsname.version,__OLD_UTS_LEN);
+	error |= __copy_to_user(&name->version,&vps_utsname.version,__OLD_UTS_LEN);
 	error |= __put_user(0,name->version+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->machine,&system_utsname.machine,__OLD_UTS_LEN);
+	error |= __copy_to_user(&name->machine,&vps_utsname.machine,__OLD_UTS_LEN);
 	error |= __put_user(0,name->machine+__OLD_UTS_LEN);
 	
 	up_read(&uts_sem);
--- ./arch/m32r/kernel/sys_m32r.c.vps_uts	2006-01-03 06:21:10.000000000 +0300
+++ ./arch/m32r/kernel/sys_m32r.c	2006-02-03 13:35:25.000000000 +0300
@@ -199,7 +199,7 @@
 	if (!name)
 		return -EFAULT;
 	down_read(&uts_sem);
-	err=copy_to_user(name, &system_utsname, sizeof (*name));
+	err=copy_to_user(name, &vps_utsname, sizeof (*name));
 	up_read(&uts_sem);
 	return err?-EFAULT:0;
 }
--- ./arch/mips/kernel/linux32.c.vps_uts	2006-02-03 11:56:03.000000000 +0300
+++ ./arch/mips/kernel/linux32.c	2006-02-03 13:35:25.000000000 +0300
@@ -1150,7 +1150,7 @@
 	int ret = 0;
 
 	down_read(&uts_sem);
-	if (copy_to_user(name,&system_utsname,sizeof *name))
+	if (copy_to_user(name,&vps_utsname,sizeof *name))
 		ret = -EFAULT;
 	up_read(&uts_sem);
 
--- ./arch/mips/kernel/syscall.c.vps_uts	2006-02-03 11:56:03.000000000 +0300
+++ ./arch/mips/kernel/syscall.c	2006-02-03 13:35:25.000000000 +0300
@@ -229,7 +229,7 @@
  */
 asmlinkage int sys_uname(struct old_utsname * name)
 {
-	if (name && !copy_to_user(name, &system_utsname, sizeof (*name)))
+	if (name && !copy_to_user(name, &vps_utsname, sizeof (*name)))
 		return 0;
 	return -EFAULT;
 }
@@ -246,15 +246,15 @@
 	if (!access_ok(VERIFY_WRITE,name,sizeof(struct oldold_utsname)))
 		return -EFAULT;
 
-	error = __copy_to_user(&name->sysname,&system_utsname.sysname,__OLD_UTS_LEN);
+	error = __copy_to_user(&name->sysname,&vps_utsname.sysname,__OLD_UTS_LEN);
 	error -= __put_user(0,name->sysname+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->nodename,&system_utsname.nodename,__OLD_UTS_LEN);
+	error -= __copy_to_user(&name->nodename,&vps_utsname.nodename,__OLD_UTS_LEN);
 	error -= __put_user(0,name->nodename+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->release,&system_utsname.release,__OLD_UTS_LEN);
+	error -= __copy_to_user(&name->release,&vps_utsname.release,__OLD_UTS_LEN);
 	error -= __put_user(0,name->release+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->version,&system_utsname.version,__OLD_UTS_LEN);
+	error -= __copy_to_user(&name->version,&vps_utsname.version,__OLD_UTS_LEN);
 	error -= __put_user(0,name->version+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->machine,&system_utsname.machine,__OLD_UTS_LEN);
+	error -= __copy_to_user(&name->machine,&vps_utsname.machine,__OLD_UTS_LEN);
 	error = __put_user(0,name->machine+__OLD_UTS_LEN);
 	error = error ? -EFAULT : 0;
 
@@ -290,10 +290,10 @@
 			return -EFAULT;
 
 		down_write(&uts_sem);
-		strncpy(system_utsname.nodename, nodename, len);
+		strncpy(vps_utsname.nodename, nodename, len);
 		nodename[__NEW_UTS_LEN] = '\0';
-		strlcpy(system_utsname.nodename, nodename,
-		        sizeof(system_utsname.nodename));
+		strlcpy(vps_utsname.nodename, nodename,
+		        sizeof(vps_utsname.nodename));
 		up_write(&uts_sem);
 		return 0;
 	}
--- ./arch/mips/kernel/sysirix.c.vps_uts	2006-02-03 11:56:03.000000000 +0300
+++ ./arch/mips/kernel/sysirix.c	2006-02-03 13:35:25.000000000 +0300
@@ -904,7 +904,7 @@
 	down_read(&uts_sem);
 	if (len > __NEW_UTS_LEN)
 		len = __NEW_UTS_LEN;
-	err = copy_to_user(name, system_utsname.domainname, len) ? -EFAULT : 0;
+	err = copy_to_user(name, vps_utsname.domainname, len) ? -EFAULT : 0;
 	up_read(&uts_sem);
 
 	return err;
@@ -1147,11 +1147,11 @@
 asmlinkage int irix_uname(struct iuname __user *buf)
 {
 	down_read(&uts_sem);
-	if (copy_from_user(system_utsname.sysname, buf->sysname, 65)
-	    || copy_from_user(system_utsname.nodename, buf->nodename, 65)
-	    || copy_from_user(system_utsname.release, buf->release, 65)
-	    || copy_from_user(system_utsname.version, buf->version, 65)
-	    || copy_from_user(system_utsname.machine, buf->machine, 65)) {
+	if (copy_from_user(vps_utsname.sysname, buf->sysname, 65)
+	    || copy_from_user(vps_utsname.nodename, buf->nodename, 65)
+	    || copy_from_user(vps_utsname.release, buf->release, 65)
+	    || copy_from_user(vps_utsname.version, buf->version, 65)
+	    || copy_from_user(vps_utsname.machine, buf->machine, 65)) {
 		return -EFAULT;
 	}
 	up_read(&uts_sem);
--- ./arch/parisc/hpux/sys_hpux.c.vps_uts	2006-02-03 11:56:03.000000000 +0300
+++ ./arch/parisc/hpux/sys_hpux.c	2006-02-03 13:35:25.000000000 +0300
@@ -266,15 +266,15 @@
 
 	down_read(&uts_sem);
 
-	error = __copy_to_user(&name->sysname,&system_utsname.sysname,HPUX_UTSLEN-1);
+	error = __copy_to_user(&name->sysname,&vps_utsname.sysname,HPUX_UTSLEN-1);
 	error |= __put_user(0,name->sysname+HPUX_UTSLEN-1);
-	error |= __copy_to_user(&name->nodename,&system_utsname.nodename,HPUX_UTSLEN-1);
+	error |= __copy_to_user(&name->nodename,&vps_utsname.nodename,HPUX_UTSLEN-1);
 	error |= __put_user(0,name->nodename+HPUX_UTSLEN-1);
-	error |= __copy_to_user(&name->release,&system_utsname.release,HPUX_UTSLEN-1);
+	error |= __copy_to_user(&name->release,&vps_utsname.release,HPUX_UTSLEN-1);
 	error |= __put_user(0,name->release+HPUX_UTSLEN-1);
-	error |= __copy_to_user(&name->version,&system_utsname.version,HPUX_UTSLEN-1);
+	error |= __copy_to_user(&name->version,&vps_utsname.version,HPUX_UTSLEN-1);
 	error |= __put_user(0,name->version+HPUX_UTSLEN-1);
-	error |= __copy_to_user(&name->machine,&system_utsname.machine,HPUX_UTSLEN-1);
+	error |= __copy_to_user(&name->machine,&vps_utsname.machine,HPUX_UTSLEN-1);
 	error |= __put_user(0,name->machine+HPUX_UTSLEN-1);
 
 	up_read(&uts_sem);
@@ -373,8 +373,8 @@
 		/*  TODO:  print a warning about using this?  */
 		down_write(&uts_sem);
 		error = -EFAULT;
-		if (!copy_from_user(system_utsname.sysname, ubuf, len)) {
-			system_utsname.sysname[len] = 0;
+		if (!copy_from_user(vps_utsname.sysname, ubuf, len)) {
+			vps_utsname.sysname[len] = 0;
 			error = 0;
 		}
 		up_write(&uts_sem);
@@ -400,8 +400,8 @@
 		/*  TODO:  print a warning about this?  */
 		down_write(&uts_sem);
 		error = -EFAULT;
-		if (!copy_from_user(system_utsname.release, ubuf, len)) {
-			system_utsname.release[len] = 0;
+		if (!copy_from_user(vps_utsname.release, ubuf, len)) {
+			vps_utsname.release[len] = 0;
 			error = 0;
 		}
 		up_write(&uts_sem);
@@ -422,13 +422,13 @@
  	
  	down_read(&uts_sem);
  	
-	nlen = strlen(system_utsname.domainname) + 1;
+	nlen = strlen(vps_utsname.domainname) + 1;
 
 	if (nlen < len)
 		len = nlen;
 	if(len > __NEW_UTS_LEN)
 		goto done;
-	if(copy_to_user(name, system_utsname.domainname, len))
+	if(copy_to_user(name, vps_utsname.domainname, len))
 		goto done;
 	err = 0;
 done:
--- ./arch/powerpc/kernel/syscalls.c.vps_uts	2006-02-03 11:56:03.000000000 +0300
+++ ./arch/powerpc/kernel/syscalls.c	2006-02-03 13:35:25.000000000 +0300
@@ -259,7 +259,7 @@
 	int err = 0;
 
 	down_read(&uts_sem);
-	if (copy_to_user(name, &system_utsname, sizeof(*name)))
+	if (copy_to_user(name, &vps_utsname, sizeof(*name)))
 		err = -EFAULT;
 	up_read(&uts_sem);
 	if (!err)
@@ -272,7 +272,7 @@
 	int err = 0;
 	
 	down_read(&uts_sem);
-	if (copy_to_user(name, &system_utsname, sizeof(*name)))
+	if (copy_to_user(name, &vps_utsname, sizeof(*name)))
 		err = -EFAULT;
 	up_read(&uts_sem);
 	if (!err)
@@ -288,19 +288,19 @@
 		return -EFAULT;
   
 	down_read(&uts_sem);
-	error = __copy_to_user(&name->sysname, &system_utsname.sysname,
+	error = __copy_to_user(&name->sysname, &vps_utsname.sysname,
 			       __OLD_UTS_LEN);
 	error |= __put_user(0, name->sysname + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->nodename, &system_utsname.nodename,
+	error |= __copy_to_user(&name->nodename, &vps_utsname.nodename,
 				__OLD_UTS_LEN);
 	error |= __put_user(0, name->nodename + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->release, &system_utsname.release,
+	error |= __copy_to_user(&name->release, &vps_utsname.release,
 				__OLD_UTS_LEN);
 	error |= __put_user(0, name->release + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->version, &system_utsname.version,
+	error |= __copy_to_user(&name->version, &vps_utsname.version,
 				__OLD_UTS_LEN);
 	error |= __put_user(0, name->version + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->machine, &system_utsname.machine,
+	error |= __copy_to_user(&name->machine, &vps_utsname.machine,
 				__OLD_UTS_LEN);
 	error |= override_machine(name->machine);
 	up_read(&uts_sem);
--- ./arch/sh/kernel/setup.c.vps_uts	2006-02-03 11:56:22.000000000 +0300
+++ ./arch/sh/kernel/setup.c	2006-02-03 13:35:25.000000000 +0300
@@ -485,7 +485,7 @@
 		seq_printf(m, "machine\t\t: %s\n", get_system_type());
 
 	seq_printf(m, "processor\t: %d\n", cpu);
-	seq_printf(m, "cpu family\t: %s\n", system_utsname.machine);
+	seq_printf(m, "cpu family\t: %s\n", vps_utsname.machine);
 	seq_printf(m, "cpu type\t: %s\n", get_cpu_subtype());
 
 	show_cpuflags(m);
--- ./arch/sh/kernel/sys_sh.c.vps_uts	2006-01-03 06:21:10.000000000 +0300
+++ ./arch/sh/kernel/sys_sh.c	2006-02-03 13:35:25.000000000 +0300
@@ -267,7 +267,7 @@
 	if (!name)
 		return -EFAULT;
 	down_read(&uts_sem);
-	err=copy_to_user(name, &system_utsname, sizeof (*name));
+	err=copy_to_user(name, &vps_utsname, sizeof (*name));
 	up_read(&uts_sem);
 	return err?-EFAULT:0;
 }
--- ./arch/sh64/kernel/sys_sh64.c.vps_uts	2006-01-03 06:21:10.000000000 +0300
+++ ./arch/sh64/kernel/sys_sh64.c	2006-02-03 13:35:25.000000000 +0300
@@ -279,7 +279,7 @@
 	if (!name)
 		return -EFAULT;
 	down_read(&uts_sem);
-	err=copy_to_user(name, &system_utsname, sizeof (*name));
+	err=copy_to_user(name, &vps_utsname, sizeof (*name));
 	up_read(&uts_sem);
 	return err?-EFAULT:0;
 }
--- ./arch/sparc/kernel/sys_sparc.c.vps_uts	2006-01-03 06:21:10.000000000 +0300
+++ ./arch/sparc/kernel/sys_sparc.c	2006-02-03 13:35:25.000000000 +0300
@@ -470,13 +470,13 @@
  	
  	down_read(&uts_sem);
  	
-	nlen = strlen(system_utsname.domainname) + 1;
+	nlen = strlen(vps_utsname.domainname) + 1;
 
 	if (nlen < len)
 		len = nlen;
 	if (len > __NEW_UTS_LEN)
 		goto done;
-	if (copy_to_user(name, system_utsname.domainname, len))
+	if (copy_to_user(name, vps_utsname.domainname, len))
 		goto done;
 	err = 0;
 done:
--- ./arch/sparc/kernel/sys_sunos.c.vps_uts	2006-02-03 11:56:03.000000000 +0300
+++ ./arch/sparc/kernel/sys_sunos.c	2006-02-03 13:35:25.000000000 +0300
@@ -483,13 +483,13 @@
 {
 	int ret;
 	down_read(&uts_sem);
-	ret = copy_to_user(&name->sname[0], &system_utsname.sysname[0], sizeof(name->sname) - 1);
+	ret = copy_to_user(&name->sname[0], &vps_utsname.sysname[0], sizeof(name->sname) - 1);
 	if (!ret) {
-		ret |= __copy_to_user(&name->nname[0], &system_utsname.nodename[0], sizeof(name->nname) - 1);
+		ret |= __copy_to_user(&name->nname[0], &vps_utsname.nodename[0], sizeof(name->nname) - 1);
 		ret |= __put_user('\0', &name->nname[8]);
-		ret |= __copy_to_user(&name->rel[0], &system_utsname.release[0], sizeof(name->rel) - 1);
-		ret |= __copy_to_user(&name->ver[0], &system_utsname.version[0], sizeof(name->ver) - 1);
-		ret |= __copy_to_user(&name->mach[0], &system_utsname.machine[0], sizeof(name->mach) - 1);
+		ret |= __copy_to_user(&name->rel[0], &vps_utsname.release[0], sizeof(name->rel) - 1);
+		ret |= __copy_to_user(&name->ver[0], &vps_utsname.version[0], sizeof(name->ver) - 1);
+		ret |= __copy_to_user(&name->mach[0], &vps_utsname.machine[0], sizeof(name->mach) - 1);
 	}
 	up_read(&uts_sem);
 	return ret ? -EFAULT : 0;
--- ./arch/sparc64/kernel/sys_sparc.c.vps_uts	2006-01-03 06:21:10.000000000 +0300
+++ ./arch/sparc64/kernel/sys_sparc.c	2006-02-03 13:35:25.000000000 +0300
@@ -476,13 +476,13 @@
 
  	down_read(&uts_sem);
  	
-	nlen = strlen(system_utsname.domainname) + 1;
+	nlen = strlen(vps_utsname.domainname) + 1;
 
         if (nlen < len)
                 len = nlen;
 	if (len > __NEW_UTS_LEN)
 		goto done;
-	if (copy_to_user(name, system_utsname.domainname, len))
+	if (copy_to_user(name, vps_utsname.domainname, len))
 		goto done;
 	err = 0;
 done:
--- ./arch/sparc64/kernel/sys_sunos32.c.vps_uts	2006-02-03 11:56:03.000000000 +0300
+++ ./arch/sparc64/kernel/sys_sunos32.c	2006-02-03 13:35:25.000000000 +0300
@@ -439,16 +439,16 @@
 	int ret;
 
 	down_read(&uts_sem);
-	ret = copy_to_user(&name->sname[0], &system_utsname.sysname[0],
+	ret = copy_to_user(&name->sname[0], &vps_utsname.sysname[0],
 			   sizeof(name->sname) - 1);
-	ret |= copy_to_user(&name->nname[0], &system_utsname.nodename[0],
+	ret |= copy_to_user(&name->nname[0], &vps_utsname.nodename[0],
 			    sizeof(name->nname) - 1);
 	ret |= put_user('\0', &name->nname[8]);
-	ret |= copy_to_user(&name->rel[0], &system_utsname.release[0],
+	ret |= copy_to_user(&name->rel[0], &vps_utsname.release[0],
 			    sizeof(name->rel) - 1);
-	ret |= copy_to_user(&name->ver[0], &system_utsname.version[0],
+	ret |= copy_to_user(&name->ver[0], &vps_utsname.version[0],
 			    sizeof(name->ver) - 1);
-	ret |= copy_to_user(&name->mach[0], &system_utsname.machine[0],
+	ret |= copy_to_user(&name->mach[0], &vps_utsname.machine[0],
 			    sizeof(name->mach) - 1);
 	up_read(&uts_sem);
 	return (ret ? -EFAULT : 0);
--- ./arch/sparc64/solaris/misc.c.vps_uts	2006-01-03 06:21:10.000000000 +0300
+++ ./arch/sparc64/solaris/misc.c	2006-02-03 13:35:25.000000000 +0300
@@ -239,7 +239,7 @@
 		/* Let's cheat */
 		err  = set_utsfield(v->sysname, "SunOS", 1, 0);
 		down_read(&uts_sem);
-		err |= set_utsfield(v->nodename, system_utsname.nodename,
+		err |= set_utsfield(v->nodename, vps_utsname.nodename,
 				    1, 1);
 		up_read(&uts_sem);
 		err |= set_utsfield(v->release, "2.6", 0, 0);
@@ -263,7 +263,7 @@
 	/* Why should we not lie a bit? */
 	down_read(&uts_sem);
 	err  = set_utsfield(v->sysname, "SunOS", 0, 0);
-	err |= set_utsfield(v->nodename, system_utsname.nodename, 1, 1);
+	err |= set_utsfield(v->nodename, vps_utsname.nodename, 1, 1);
 	err |= set_utsfield(v->release, "5.6", 0, 0);
 	err |= set_utsfield(v->version, "Generic", 0, 0);
 	err |= set_utsfield(v->machine, machine(), 0, 0);
@@ -295,7 +295,7 @@
 	case SI_HOSTNAME:
 		r = buffer + 256;
 		down_read(&uts_sem);
-		for (p = system_utsname.nodename, q = buffer; 
+		for (p = vps_utsname.nodename, q = buffer; 
 		     q < r && *p && *p != '.'; *q++ = *p++);
 		up_read(&uts_sem);
 		*q = 0;
--- ./arch/um/kernel/syscall_kern.c.vps_uts	2006-01-03 06:21:10.000000000 +0300
+++ ./arch/um/kernel/syscall_kern.c	2006-02-03 13:35:25.000000000 +0300
@@ -110,7 +110,7 @@
 	if (!name)
 		return -EFAULT;
 	down_read(&uts_sem);
-	err=copy_to_user(name, &system_utsname, sizeof (*name));
+	err=copy_to_user(name, &vps_utsname, sizeof (*name));
 	up_read(&uts_sem);
 	return err?-EFAULT:0;
 }
@@ -126,19 +126,19 @@
   
   	down_read(&uts_sem);
 	
-	error = __copy_to_user(&name->sysname,&system_utsname.sysname,
+	error = __copy_to_user(&name->sysname,&vps_utsname.sysname,
 			       __OLD_UTS_LEN);
 	error |= __put_user(0,name->sysname+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->nodename,&system_utsname.nodename,
+	error |= __copy_to_user(&name->nodename,&vps_utsname.nodename,
 				__OLD_UTS_LEN);
 	error |= __put_user(0,name->nodename+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->release,&system_utsname.release,
+	error |= __copy_to_user(&name->release,&vps_utsname.release,
 				__OLD_UTS_LEN);
 	error |= __put_user(0,name->release+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->version,&system_utsname.version,
+	error |= __copy_to_user(&name->version,&vps_utsname.version,
 				__OLD_UTS_LEN);
 	error |= __put_user(0,name->version+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->machine,&system_utsname.machine,
+	error |= __copy_to_user(&name->machine,&vps_utsname.machine,
 				__OLD_UTS_LEN);
 	error |= __put_user(0,name->machine+__OLD_UTS_LEN);
 	
--- ./arch/um/sys-x86_64/syscalls.c.vps_uts	2006-01-03 06:21:10.000000000 +0300
+++ ./arch/um/sys-x86_64/syscalls.c	2006-02-03 13:35:25.000000000 +0300
@@ -21,7 +21,7 @@
 {
 	int err;
 	down_read(&uts_sem);
-	err = copy_to_user(name, &system_utsname, sizeof (*name));
+	err = copy_to_user(name, &vps_utsname, sizeof (*name));
 	up_read(&uts_sem);
 	if (personality(current->personality) == PER_LINUX32)
 		err |= copy_to_user(&name->machine, "i686", 5);
--- ./arch/x86_64/ia32/sys_ia32.c.vps_uts	2006-02-03 11:56:04.000000000 +0300
+++ ./arch/x86_64/ia32/sys_ia32.c	2006-02-03 13:35:25.000000000 +0300
@@ -868,13 +868,13 @@
   
   	down_read(&uts_sem);
 	
-	error = __copy_to_user(&name->sysname,&system_utsname.sysname,__OLD_UTS_LEN);
+	error = __copy_to_user(&name->sysname,&vps_utsname.sysname,__OLD_UTS_LEN);
 	 __put_user(0,name->sysname+__OLD_UTS_LEN);
-	 __copy_to_user(&name->nodename,&system_utsname.nodename,__OLD_UTS_LEN);
+	 __copy_to_user(&name->nodename,&vps_utsname.nodename,__OLD_UTS_LEN);
 	 __put_user(0,name->nodename+__OLD_UTS_LEN);
-	 __copy_to_user(&name->release,&system_utsname.release,__OLD_UTS_LEN);
+	 __copy_to_user(&name->release,&vps_utsname.release,__OLD_UTS_LEN);
 	 __put_user(0,name->release+__OLD_UTS_LEN);
-	 __copy_to_user(&name->version,&system_utsname.version,__OLD_UTS_LEN);
+	 __copy_to_user(&name->version,&vps_utsname.version,__OLD_UTS_LEN);
 	 __put_user(0,name->version+__OLD_UTS_LEN);
 	 { 
 		 char *arch = "x86_64";
@@ -897,7 +897,7 @@
 	if (!name)
 		return -EFAULT;
 	down_read(&uts_sem);
-	err=copy_to_user(name, &system_utsname, sizeof (*name));
+	err=copy_to_user(name, &vps_utsname, sizeof (*name));
 	up_read(&uts_sem);
 	if (personality(current->personality) == PER_LINUX32) 
 		err |= copy_to_user(&name->machine, "i686", 5);
--- ./arch/x86_64/kernel/sys_x86_64.c.vps_uts	2006-01-03 06:21:10.000000000 +0300
+++ ./arch/x86_64/kernel/sys_x86_64.c	2006-02-03 13:35:25.000000000 +0300
@@ -148,7 +148,7 @@
 {
 	int err;
 	down_read(&uts_sem);
-	err = copy_to_user(name, &system_utsname, sizeof (*name));
+	err = copy_to_user(name, &vps_utsname, sizeof (*name));
 	up_read(&uts_sem);
 	if (personality(current->personality) == PER_LINUX32) 
 		err |= copy_to_user(&name->machine, "i686", 5); 		
--- ./arch/xtensa/kernel/syscalls.c.vps_uts	2006-01-03 06:21:10.000000000 +0300
+++ ./arch/xtensa/kernel/syscalls.c	2006-02-03 13:35:25.000000000 +0300
@@ -129,7 +129,7 @@
 
 int sys_uname(struct old_utsname * name)
 {
-	if (name && !copy_to_user(name, &system_utsname, sizeof (*name)))
+	if (name && !copy_to_user(name, &vps_utsname, sizeof (*name)))
 		return 0;
 	return -EFAULT;
 }
--- ./include/asm-i386/elf.h.vps_uts	2006-01-03 06:21:10.000000000 +0300
+++ ./include/asm-i386/elf.h	2006-02-03 13:35:25.000000000 +0300
@@ -108,7 +108,7 @@
    For the moment, we have only optimizations for the Intel generations,
    but that could change... */
 
-#define ELF_PLATFORM  (system_utsname.machine)
+#define ELF_PLATFORM  (vps_utsname.machine)
 
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) do { } while (0)
--- ./kernel/sys.c.vps_uts	2006-02-03 11:56:24.000000000 +0300
+++ ./kernel/sys.c	2006-02-03 13:35:25.000000000 +0300
@@ -1518,7 +1518,7 @@
 	int errno = 0;
 
 	down_read(&uts_sem);
-	if (copy_to_user(name,&system_utsname,sizeof *name))
+	if (copy_to_user(name,&vps_utsname,sizeof *name))
 		errno = -EFAULT;
 	up_read(&uts_sem);
 	return errno;
@@ -1536,8 +1536,8 @@
 	down_write(&uts_sem);
 	errno = -EFAULT;
 	if (!copy_from_user(tmp, name, len)) {
-		memcpy(system_utsname.nodename, tmp, len);
-		system_utsname.nodename[len] = 0;
+		memcpy(vps_utsname.nodename, tmp, len);
+		vps_utsname.nodename[len] = 0;
 		errno = 0;
 	}
 	up_write(&uts_sem);
@@ -1553,11 +1553,11 @@
 	if (len < 0)
 		return -EINVAL;
 	down_read(&uts_sem);
-	i = 1 + strlen(system_utsname.nodename);
+	i = 1 + strlen(vps_utsname.nodename);
 	if (i > len)
 		i = len;
 	errno = 0;
-	if (copy_to_user(name, system_utsname.nodename, i))
+	if (copy_to_user(name, vps_utsname.nodename, i))
 		errno = -EFAULT;
 	up_read(&uts_sem);
 	return errno;
@@ -1582,8 +1582,8 @@
 	down_write(&uts_sem);
 	errno = -EFAULT;
 	if (!copy_from_user(tmp, name, len)) {
-		memcpy(system_utsname.domainname, tmp, len);
-		system_utsname.domainname[len] = 0;
+		memcpy(vps_utsname.domainname, tmp, len);
+		vps_utsname.domainname[len] = 0;
 		errno = 0;
 	}
 	up_write(&uts_sem);

--------------010007090704000409080702--

