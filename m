Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWE0Hg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWE0Hg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 03:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWE0Hg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 03:36:27 -0400
Received: from xenotime.net ([66.160.160.81]:19331 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751438AbWE0Hg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 03:36:26 -0400
Date: Sat, 27 May 2006 00:36:23 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>, drepper@redhat.com,
       akpm <akpm@osdl.org>, serue@us.ibm.com, sam@vilain.net, clg@fr.ibm.com,
       dev@sw.ru
Subject: Re: [PATCH] POSIX-hostname up to 255 characters
In-Reply-To: <Pine.LNX.4.58.0605261758001.13225@shark.he.net>
Message-ID: <Pine.LNX.4.58.0605270027070.29434@shark.he.net>
References: <20060525204534.4068e730.rdunlap@xenotime.net>
 <m1zmh5b129.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0605261758001.13225@shark.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > "Randy.Dunlap" <rdunlap@xenotime.net> writes:
> >
> > > This patch is against 2.6.17-rc5, for review/comments, please.
> > > It won't apply to -mm since Andrew has merged the uts-namespace patches.
> > > I'll see about merging it with those patches next.
> > > ---

Per Eric's comments:

1.  use existing sys_gethostname() and sys_sethostname().

2.  add sys_uname_long() to read struct long_utsname;

3.  removed EXPORT_SYMBOL()s

~~~
Rev. 2 of the patch (caveat: I don't know if the version of pine that
I am using here [while traveling] preserves whitespace or not.)  :{


From: Randy Dunlap <rdunlap@xenotime.net>

Implement POSIX-defined length for 'hostname' so that hostnames
can be longer than 64 characters (max. 255 characters plus
terminating NULL character).

Consolidates many open-coded copiers of system_utsname into
functions in lib/utsname.c::put_oldold_uname(), put_old_uname(),
put_new_uname(). and put_long_uname().

Current sys_sethostname() accepts a hostname (nodename) up to 255
characters.
Adds one new syscall, sys_uname_long(), to read the long_utsname
data structure.
Test program is at http://www.xenotime.net/linux/src/hostnamelong.c .

gethostname:
http://www.opengroup.org/onlinepubs/009695399/functions/gethostname.html
sysconf:
http://www.opengroup.org/onlinepubs/009695399/functions/sysconf.html
unistd.h:
http://www.opengroup.org/onlinepubs/009695399/basedefs/unistd.h.html
limits.h:
http://www.opengroup.org/onlinepubs/009695399/basedefs/limits.h.html


Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/kernel/sys_i386.c      |   37 +-------
 arch/i386/kernel/syscall_table.S |    2
 arch/m32r/kernel/sys_m32r.c      |   12 --
 arch/mips/kernel/linux32.c       |    4
 arch/mips/kernel/syscall.c       |   25 -----
 arch/powerpc/kernel/syscalls.c   |   37 +-------
 arch/sh/kernel/sys_sh.c          |   11 --
 arch/sh64/kernel/sys_sh64.c      |   11 --
 arch/um/kernel/syscall_kern.c    |    9 -
 arch/x86_64/ia32/sys_ia32.c      |   39 +-------
 arch/x86_64/kernel/sys_x86_64.c  |    8 -
 arch/xtensa/kernel/syscalls.c    |    8 -
 drivers/char/random.c            |    2
 include/asm-i386/unistd.h        |    5 -
 include/asm-m32r/unistd.h        |    1
 include/asm-mips/unistd.h        |    3
 include/asm-powerpc/unistd.h     |    2
 include/asm-sh/unistd.h          |    1
 include/asm-sh64/unistd.h        |    1
 include/asm-um/unistd.h          |    2
 include/asm-x86_64/unistd.h      |    6 +
 include/asm-xtensa/unistd.h      |    1
 include/linux/syscalls.h         |    2
 include/linux/utsname.h          |   23 ++++
 init/version.c                   |    3
 kernel/power/power.h             |    2
 kernel/sys.c                     |   23 ++--
 lib/Makefile                     |    2
 lib/utsname.c                    |  180 +++++++++++++++++++++++++++++++++++++++
 net/ipv4/ipconfig.c              |    3
 30 files changed, 295 insertions(+), 170 deletions(-)

--- linux-2617-rc5-hostname.orig/include/asm-i386/unistd.h
+++ linux-2617-rc5-hostname/include/asm-i386/unistd.h
@@ -322,8 +322,9 @@
 #define __NR_sync_file_range	314
 #define __NR_tee		315
 #define __NR_vmsplice		316
+#define __NR_uname_long		317

-#define NR_syscalls 317
+#define NR_syscalls 318

 /*
  * user-visible error numbers are in the range -1 - -128: see
@@ -429,6 +430,8 @@ __syscall_return(type,__res); \
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_OLD_UNAME
+#define __ARCH_WANT_OLDOLD_UNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_SGETMASK
 #define __ARCH_WANT_SYS_SIGNAL
--- linux-2617-rc5-hostname.orig/include/linux/utsname.h
+++ linux-2617-rc5-hostname/include/linux/utsname.h
@@ -30,7 +30,28 @@ struct new_utsname {
 	char domainname[65];
 };

-extern struct new_utsname system_utsname;
+/* for (POSIX) IEEE Std. 1003.1, 2004 edition */
+#define __POSIX_HOST_NAME_MAX	255	/* not including terminating NUL char */

+struct long_utsname {
+	char sysname[__NEW_UTS_LEN + 1];	/* O/S name */
+	char nodename[__POSIX_HOST_NAME_MAX + 1]; /* hostname, but keep field
+					* name same as other structs here */
+	char release[__NEW_UTS_LEN + 1];	/* O/S release level */
+	char version[__NEW_UTS_LEN + 1];	/* version level of release */
+	char machine[__NEW_UTS_LEN + 1];	/* machine hardware type */
+	char domainname[__NEW_UTS_LEN + 1];
+};
+
+extern struct long_utsname system_utsname;
 extern struct rw_semaphore uts_sem;
+
+int put_oldold_uname(struct oldold_utsname __user *name);
+int __put_oldold_uname(struct oldold_utsname __user *name);
+int put_old_uname(struct old_utsname __user *name);
+int __put_old_uname(struct old_utsname __user *name);
+int put_new_uname(struct new_utsname __user *name);
+int __put_new_uname(struct new_utsname __user *name);
+int put_long_uname(struct long_utsname __user *name);
+int __put_long_uname(struct long_utsname __user *name);
 #endif
--- linux-2617-rc5-hostname.orig/init/version.c
+++ linux-2617-rc5-hostname/init/version.c
@@ -17,7 +17,7 @@

 int version_string(LINUX_VERSION_CODE);

-struct new_utsname system_utsname = {
+struct long_utsname system_utsname = {
 	.sysname	= UTS_SYSNAME,
 	.nodename	= UTS_NODENAME,
 	.release	= UTS_RELEASE,
@@ -25,7 +25,6 @@ struct new_utsname system_utsname = {
 	.machine	= UTS_MACHINE,
 	.domainname	= UTS_DOMAINNAME,
 };
-
 EXPORT_SYMBOL(system_utsname);

 const char linux_banner[] =
--- linux-2617-rc5-hostname.orig/kernel/sys.c
+++ linux-2617-rc5-hostname/kernel/sys.c
@@ -1666,25 +1666,32 @@ DECLARE_RWSEM(uts_sem);

 EXPORT_SYMBOL(uts_sem);

-asmlinkage long sys_newuname(struct new_utsname __user * name)
+asmlinkage long sys_newuname(struct new_utsname __user *name)
 {
 	int errno = 0;

-	down_read(&uts_sem);
-	if (copy_to_user(name,&system_utsname,sizeof *name))
+	if (put_new_uname(name))
+		errno = -EFAULT;
+	return errno;
+}
+
+asmlinkage long sys_uname_long(struct long_utsname __user *name)
+{
+	int errno = 0;
+
+	if (put_long_uname(name))
 		errno = -EFAULT;
-	up_read(&uts_sem);
 	return errno;
 }

 asmlinkage long sys_sethostname(char __user *name, int len)
 {
 	int errno;
-	char tmp[__NEW_UTS_LEN];
+	char tmp[__POSIX_HOST_NAME_MAX + 1];

 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	if (len < 0 || len > __NEW_UTS_LEN)
+	if (len < 0 || len > __POSIX_HOST_NAME_MAX)
 		return -EINVAL;
 	down_write(&uts_sem);
 	errno = -EFAULT;
@@ -1697,8 +1704,6 @@ asmlinkage long sys_sethostname(char __u
 	return errno;
 }

-#ifdef __ARCH_WANT_SYS_GETHOSTNAME
-
 asmlinkage long sys_gethostname(char __user *name, int len)
 {
 	int i, errno;
@@ -1716,8 +1721,6 @@ asmlinkage long sys_gethostname(char __u
 	return errno;
 }

-#endif
-
 /*
  * Only setdomainname; getdomainname can be implemented by calling
  * uname()
--- linux-2617-rc5-hostname.orig/kernel/power/power.h
+++ linux-2617-rc5-hostname/kernel/power/power.h
@@ -2,7 +2,7 @@
 #include <linux/utsname.h>

 struct swsusp_info {
-	struct new_utsname	uts;
+	struct long_utsname	uts;
 	u32			version_code;
 	unsigned long		num_physpages;
 	int			cpus;
--- linux-2617-rc5-hostname.orig/net/ipv4/ipconfig.c
+++ linux-2617-rc5-hostname/net/ipv4/ipconfig.c
@@ -806,7 +806,8 @@ static void __init ic_do_bootp_ext(u8 *e
 			}
 			break;
 		case 12:	/* Host name */
-			ic_bootp_string(system_utsname.nodename, ext+1, *ext, __NEW_UTS_LEN);
+			ic_bootp_string(system_utsname.nodename, ext+1, *ext,
+				sizeof(system_utsname.nodename));
 			ic_host_name_set = 1;
 			break;
 		case 15:	/* Domain name (DNS) */
--- linux-2617-rc5-hostname.orig/arch/mips/kernel/syscall.c
+++ linux-2617-rc5-hostname/arch/mips/kernel/syscall.c
@@ -232,9 +232,9 @@ out:
  */
 asmlinkage int sys_uname(struct old_utsname __user * name)
 {
-	if (name && !copy_to_user(name, &system_utsname, sizeof (*name)))
-		return 0;
-	return -EFAULT;
+	if (put_old_uname(name))
+		return -EFAULT;
+	return 0;
 }

 /*
@@ -242,24 +242,7 @@ asmlinkage int sys_uname(struct old_utsn
  */
 asmlinkage int sys_olduname(struct oldold_utsname __user * name)
 {
-	int error;
-
-	if (!name)
-		return -EFAULT;
-	if (!access_ok(VERIFY_WRITE,name,sizeof(struct oldold_utsname)))
-		return -EFAULT;
-
-	error = __copy_to_user(&name->sysname,&system_utsname.sysname,__OLD_UTS_LEN);
-	error -= __put_user(0,name->sysname+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->nodename,&system_utsname.nodename,__OLD_UTS_LEN);
-	error -= __put_user(0,name->nodename+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->release,&system_utsname.release,__OLD_UTS_LEN);
-	error -= __put_user(0,name->release+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->version,&system_utsname.version,__OLD_UTS_LEN);
-	error -= __put_user(0,name->version+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->machine,&system_utsname.machine,__OLD_UTS_LEN);
-	error = __put_user(0,name->machine+__OLD_UTS_LEN);
-	error = error ? -EFAULT : 0;
+	int error = put_oldold_uname(name);

 	return error;
 }
--- /dev/null
+++ linux-2617-rc5-hostname/lib/utsname.c
@@ -0,0 +1,180 @@
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/rwsem.h>
+#include <linux/utsname.h>
+#include <asm/uaccess.h>
+
+#ifdef __ARCH_WANT_OLDOLD_UNAME
+
+int __put_oldold_uname(struct oldold_utsname __user *name)
+{
+	int error;
+
+	if (!name)
+		return -EFAULT;
+	if (!access_ok(VERIFY_WRITE, name, sizeof(struct oldold_utsname)))
+		return -EFAULT;
+
+	error = __copy_to_user(&name->sysname, &system_utsname.sysname,
+				__OLD_UTS_LEN);
+	error |= __put_user(0, name->sysname + __OLD_UTS_LEN);
+	error |= __copy_to_user(&name->nodename, &system_utsname.nodename,
+				__OLD_UTS_LEN);
+	error |= __put_user(0, name->nodename + __OLD_UTS_LEN);
+	error |= __copy_to_user(&name->release, &system_utsname.release,
+				__OLD_UTS_LEN);
+	error |= __put_user(0, name->release + __OLD_UTS_LEN);
+	error |= __copy_to_user(&name->version, &system_utsname.version,
+				__OLD_UTS_LEN);
+	error |= __put_user(0, name->version + __OLD_UTS_LEN);
+	error |= __copy_to_user(&name->machine, &system_utsname.machine,
+				__OLD_UTS_LEN);
+	error |= __put_user(0, name->machine + __OLD_UTS_LEN);
+
+	return error;
+}
+
+int put_oldold_uname(struct oldold_utsname __user *name)
+{
+	int error;
+
+	down_read(&uts_sem);
+	error = __put_oldold_uname(name);
+	up_read(&uts_sem);
+
+	error = error ? -EFAULT : 0;
+	return error;
+}
+
+#endif
+
+#ifdef __ARCH_WANT_OLD_UNAME
+
+int __put_old_uname(struct old_utsname __user *name)
+{
+	int error;
+
+	if (!name)
+		return -EFAULT;
+	if (!access_ok(VERIFY_WRITE, name, sizeof(struct old_utsname)))
+		return -EFAULT;
+
+	error = __copy_to_user(&name->sysname, &system_utsname.sysname,
+				__NEW_UTS_LEN);
+	error |= __put_user(0, name->sysname + __NEW_UTS_LEN);
+	error |= __copy_to_user(&name->nodename, &system_utsname.nodename,
+				__NEW_UTS_LEN);
+	error |= __put_user(0, name->nodename + __NEW_UTS_LEN);
+	error |= __copy_to_user(&name->release, &system_utsname.release,
+				__NEW_UTS_LEN);
+	error |= __put_user(0, name->release + __NEW_UTS_LEN);
+	error |= __copy_to_user(&name->version, &system_utsname.version,
+				__NEW_UTS_LEN);
+	error |= __put_user(0, name->version + __NEW_UTS_LEN);
+	error |= __copy_to_user(&name->machine, &system_utsname.machine,
+				__NEW_UTS_LEN);
+	error |= __put_user(0, name->machine + __NEW_UTS_LEN);
+
+	return error;
+}
+
+int put_old_uname(struct old_utsname __user *name)
+{
+	int error;
+
+	down_read(&uts_sem);
+	error = __put_old_uname(name);
+	up_read(&uts_sem);
+
+	error = error ? -EFAULT : 0;
+	return error;
+}
+
+#endif
+
+int __put_new_uname(struct new_utsname __user *name)
+{
+	int error;
+
+	if (!name)
+		return -EFAULT;
+	if (!access_ok(VERIFY_WRITE, name, sizeof(struct new_utsname)))
+		return -EFAULT;
+
+	error = __copy_to_user(&name->sysname, &system_utsname.sysname,
+				__NEW_UTS_LEN);
+	error |= __put_user(0, name->sysname + __NEW_UTS_LEN);
+	error |= __copy_to_user(&name->nodename, &system_utsname.nodename,
+				__NEW_UTS_LEN);
+	error |= __put_user(0, name->nodename + __NEW_UTS_LEN);
+	error |= __copy_to_user(&name->release, &system_utsname.release,
+				__NEW_UTS_LEN);
+	error |= __put_user(0, name->release + __NEW_UTS_LEN);
+	error |= __copy_to_user(&name->version, &system_utsname.version,
+				__NEW_UTS_LEN);
+	error |= __put_user(0, name->version + __NEW_UTS_LEN);
+	error |= __copy_to_user(&name->machine, &system_utsname.machine,
+				__NEW_UTS_LEN);
+	error |= __put_user(0, name->machine + __NEW_UTS_LEN);
+	error |= __copy_to_user(&name->domainname, &system_utsname.domainname,
+				__NEW_UTS_LEN);
+	error |= __put_user(0, name->domainname + __NEW_UTS_LEN);
+
+	return error;
+}
+
+int put_new_uname(struct new_utsname __user *name)
+{
+	int error;
+
+	down_read(&uts_sem);
+	error = __put_new_uname(name);
+	up_read(&uts_sem);
+
+	error = error ? -EFAULT : 0;
+	return error;
+}
+
+int __put_long_uname(struct long_utsname __user *name)
+{
+	int error;
+
+	if (!name)
+		return -EFAULT;
+	if (!access_ok(VERIFY_WRITE, name, sizeof(struct new_utsname)))
+		return -EFAULT;
+
+	error = __copy_to_user(&name->sysname, &system_utsname.sysname,
+				__NEW_UTS_LEN);
+	error |= __put_user(0, name->sysname + __NEW_UTS_LEN);
+	error |= __copy_to_user(&name->nodename, &system_utsname.nodename,
+				__POSIX_HOST_NAME_MAX);
+	error |= __put_user(0, name->nodename + __POSIX_HOST_NAME_MAX);
+	error |= __copy_to_user(&name->release, &system_utsname.release,
+				__NEW_UTS_LEN);
+	error |= __put_user(0, name->release + __NEW_UTS_LEN);
+	error |= __copy_to_user(&name->version, &system_utsname.version,
+				__NEW_UTS_LEN);
+	error |= __put_user(0, name->version + __NEW_UTS_LEN);
+	error |= __copy_to_user(&name->machine, &system_utsname.machine,
+				__NEW_UTS_LEN);
+	error |= __put_user(0, name->machine + __NEW_UTS_LEN);
+	error |= __copy_to_user(&name->domainname, &system_utsname.domainname,
+				__NEW_UTS_LEN);
+	error |= __put_user(0, name->domainname + __NEW_UTS_LEN);
+
+	return error;
+}
+
+int put_long_uname(struct long_utsname __user *name)
+{
+	int error;
+
+	down_read(&uts_sem);
+	error = __put_long_uname(name);
+	up_read(&uts_sem);
+
+	error = error ? -EFAULT : 0;
+	return error;
+}
--- linux-2617-rc5-hostname.orig/arch/powerpc/kernel/syscalls.c
+++ linux-2617-rc5-hostname/arch/powerpc/kernel/syscalls.c
@@ -255,14 +255,13 @@ static inline int override_machine(char
 	return 0;
 }

-long ppc_newuname(struct new_utsname __user * name)
+long ppc_newuname(struct new_utsname __user *name)
 {
-	int err = 0;
+	int err;

-	down_read(&uts_sem);
-	if (copy_to_user(name, &system_utsname, sizeof(*name)))
+	err = put_new_uname(name);
+	if (err)
 		err = -EFAULT;
-	up_read(&uts_sem);
 	if (!err)
 		err = override_machine(name->machine);
 	return err;
@@ -270,12 +269,10 @@ long ppc_newuname(struct new_utsname __u

 int sys_uname(struct old_utsname __user *name)
 {
-	int err = 0;
+	int err;

-	down_read(&uts_sem);
-	if (copy_to_user(name, &system_utsname, sizeof(*name)))
+	err = put_old_uname(name);
 		err = -EFAULT;
-	up_read(&uts_sem);
 	if (!err)
 		err = override_machine(name->machine);
 	return err;
@@ -285,28 +282,10 @@ int sys_olduname(struct oldold_utsname _
 {
 	int error;

-	if (!access_ok(VERIFY_WRITE, name, sizeof(struct oldold_utsname)))
-		return -EFAULT;
-
-	down_read(&uts_sem);
-	error = __copy_to_user(&name->sysname, &system_utsname.sysname,
-			       __OLD_UTS_LEN);
-	error |= __put_user(0, name->sysname + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->nodename, &system_utsname.nodename,
-				__OLD_UTS_LEN);
-	error |= __put_user(0, name->nodename + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->release, &system_utsname.release,
-				__OLD_UTS_LEN);
-	error |= __put_user(0, name->release + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->version, &system_utsname.version,
-				__OLD_UTS_LEN);
-	error |= __put_user(0, name->version + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->machine, &system_utsname.machine,
-				__OLD_UTS_LEN);
+	error = put_oldold_uname(name);
 	error |= override_machine(name->machine);
-	up_read(&uts_sem);

-	return error? -EFAULT: 0;
+	return error ? -EFAULT : 0;
 }

 long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
--- linux-2617-rc5-hostname.orig/include/asm-mips/unistd.h
+++ linux-2617-rc5-hostname/include/asm-mips/unistd.h
@@ -1176,6 +1176,9 @@ type name (atype a,btype b,ctype c,dtype
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_OLDOLD_UNAME
+#define __ARCH_WANT_OLD_UNAME
+#define __ARCH_WANT_NEW_UNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_SGETMASK
 #define __ARCH_WANT_SYS_UTIME
--- linux-2617-rc5-hostname.orig/include/asm-powerpc/unistd.h
+++ linux-2617-rc5-hostname/include/asm-powerpc/unistd.h
@@ -454,6 +454,8 @@ type name(type1 arg1, type2 arg2, type3
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_OLDOLD_UNAME
+#define __ARCH_WANT_NEW_UNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_SGETMASK
 #define __ARCH_WANT_SYS_SIGNAL
--- linux-2617-rc5-hostname.orig/arch/mips/kernel/linux32.c
+++ linux-2617-rc5-hostname/arch/mips/kernel/linux32.c
@@ -1039,10 +1039,8 @@ asmlinkage long sys32_newuname(struct ne
 {
 	int ret = 0;

-	down_read(&uts_sem);
-	if (copy_to_user(name,&system_utsname,sizeof *name))
+	if (put_new_uname(name))
 		ret = -EFAULT;
-	up_read(&uts_sem);

 	if (current->personality == PER_LINUX32 && !ret)
 		if (copy_to_user(name->machine, "mips\0\0\0", 8))
--- linux-2617-rc5-hostname.orig/lib/Makefile
+++ linux-2617-rc5-hostname/lib/Makefile
@@ -5,7 +5,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o utsname.o

 lib-$(CONFIG_SMP) += cpumask.o

--- linux-2617-rc5-hostname.orig/include/asm-m32r/unistd.h
+++ linux-2617-rc5-hostname/include/asm-m32r/unistd.h
@@ -410,6 +410,7 @@ __syscall_return(type,__res); \
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
+#define	__ARCH_WANT_OLD_UNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
--- linux-2617-rc5-hostname.orig/arch/m32r/kernel/sys_m32r.c
+++ linux-2617-rc5-hostname/arch/m32r/kernel/sys_m32r.c
@@ -200,15 +200,11 @@ asmlinkage int sys_ipc(uint call, int fi
 	}
 }

-asmlinkage int sys_uname(struct old_utsname * name)
+asmlinkage int sys_uname(struct old_utsname *name)
 {
-	int err;
-	if (!name)
-		return -EFAULT;
-	down_read(&uts_sem);
-	err=copy_to_user(name, &system_utsname, sizeof (*name));
-	up_read(&uts_sem);
-	return err?-EFAULT:0;
+	int err = put_old_uname(name);
+
+	return err ? -EFAULT : 0;
 }

 asmlinkage int sys_cacheflush(void *addr, int bytes, int cache)
--- linux-2617-rc5-hostname.orig/arch/xtensa/kernel/syscalls.c
+++ linux-2617-rc5-hostname/arch/xtensa/kernel/syscalls.c
@@ -127,11 +127,11 @@ out:
 	return error;
 }

-int sys_uname(struct old_utsname * name)
+int sys_uname(struct old_utsname *name)
 {
-	if (name && !copy_to_user(name, &system_utsname, sizeof (*name)))
-		return 0;
-	return -EFAULT;
+	if (put_old_uname(name))
+		return -EFAULT;
+	return 0;
 }

 /*
--- linux-2617-rc5-hostname.orig/include/asm-xtensa/unistd.h
+++ linux-2617-rc5-hostname/include/asm-xtensa/unistd.h
@@ -434,6 +434,7 @@ static __inline__ _syscall3(int,execve,c
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_RT_SIGACTION
+#define __ARCH_WANT_OLD_UNAME
 #endif

 #endif	/* _XTENSA_UNISTD_H */
--- linux-2617-rc5-hostname.orig/arch/um/kernel/syscall_kern.c
+++ linux-2617-rc5-hostname/arch/um/kernel/syscall_kern.c
@@ -107,12 +107,9 @@ long sys_pipe(unsigned long __user * fil
 long sys_uname(struct old_utsname __user * name)
 {
 	long err;
-	if (!name)
-		return -EFAULT;
-	down_read(&uts_sem);
-	err=copy_to_user(name, &system_utsname, sizeof (*name));
-	up_read(&uts_sem);
-	return err?-EFAULT:0;
+
+	err = put_old_uname(name);
+	return err ? -EFAULT : 0;
 }

 long sys_olduname(struct oldold_utsname __user * name)
--- linux-2617-rc5-hostname.orig/include/asm-um/unistd.h
+++ linux-2617-rc5-hostname/include/asm-um/unistd.h
@@ -18,6 +18,8 @@ extern int um_execve(const char *file, c
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_OLD_UNAME
+#define __ARCH_WANT_NEW_UNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_SGETMASK
 #define __ARCH_WANT_SYS_SIGNAL
--- linux-2617-rc5-hostname.orig/include/asm-sh/unistd.h
+++ linux-2617-rc5-hostname/include/asm-sh/unistd.h
@@ -427,6 +427,7 @@ __syscall_return(type,__sc0); \
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_OLD_UNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_SGETMASK
 #define __ARCH_WANT_SYS_SIGNAL
--- linux-2617-rc5-hostname.orig/include/asm-sh64/unistd.h
+++ linux-2617-rc5-hostname/include/asm-sh64/unistd.h
@@ -493,6 +493,7 @@ __syscall_return(type,__sc0);
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_OLD_UNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_SGETMASK
 #define __ARCH_WANT_SYS_SIGNAL
--- linux-2617-rc5-hostname.orig/arch/sh/kernel/sys_sh.c
+++ linux-2617-rc5-hostname/arch/sh/kernel/sys_sh.c
@@ -261,15 +261,12 @@ asmlinkage int sys_ipc(uint call, int fi
 	return -EINVAL;
 }

-asmlinkage int sys_uname(struct old_utsname * name)
+asmlinkage int sys_uname(struct old_utsname *name)
 {
 	int err;
-	if (!name)
-		return -EFAULT;
-	down_read(&uts_sem);
-	err=copy_to_user(name, &system_utsname, sizeof (*name));
-	up_read(&uts_sem);
-	return err?-EFAULT:0;
+
+	err = put_old_uname(name);
+	return err ? -EFAULT : 0;
 }

 asmlinkage ssize_t sys_pread_wrapper(unsigned int fd, char * buf,
--- linux-2617-rc5-hostname.orig/arch/sh64/kernel/sys_sh64.c
+++ linux-2617-rc5-hostname/arch/sh64/kernel/sys_sh64.c
@@ -273,13 +273,10 @@ asmlinkage int sys_ipc(uint call, int fi
 	return -EINVAL;
 }

-asmlinkage int sys_uname(struct old_utsname * name)
+asmlinkage int sys_uname(struct old_utsname *name)
 {
 	int err;
-	if (!name)
-		return -EFAULT;
-	down_read(&uts_sem);
-	err=copy_to_user(name, &system_utsname, sizeof (*name));
-	up_read(&uts_sem);
-	return err?-EFAULT:0;
+
+	err = put_old_uname(name);
+	return err ? -EFAULT : 0;
 }
--- linux-2617-rc5-hostname.orig/arch/x86_64/kernel/sys_x86_64.c
+++ linux-2617-rc5-hostname/arch/x86_64/kernel/sys_x86_64.c
@@ -144,12 +144,10 @@ full_search:
 	}
 }

-asmlinkage long sys_uname(struct new_utsname __user * name)
+asmlinkage long sys_uname(struct new_utsname __user *name)
 {
-	int err;
-	down_read(&uts_sem);
-	err = copy_to_user(name, &system_utsname, sizeof (*name));
-	up_read(&uts_sem);
+	int err = put_new_uname(name);
+
 	if (personality(current->personality) == PER_LINUX32)
 		err |= copy_to_user(&name->machine, "i686", 5);
 	return err ? -EFAULT : 0;
--- linux-2617-rc5-hostname.orig/include/asm-x86_64/unistd.h
+++ linux-2617-rc5-hostname/include/asm-x86_64/unistd.h
@@ -617,8 +617,10 @@ __SYSCALL(__NR_tee, sys_tee)
 __SYSCALL(__NR_sync_file_range, sys_sync_file_range)
 #define __NR_vmsplice		278
 __SYSCALL(__NR_vmsplice, sys_vmsplice)
+#define __NR_uname_long		279
+__SYSCALL(__NR_uname_long, sys_uname_long)

-#define __NR_syscall_max __NR_vmsplice
+#define __NR_syscall_max __NR_uname_long

 #ifndef __NO_STUBS

@@ -640,6 +642,8 @@ do { \
 #define __ARCH_WANT_OLD_STAT
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
+#define __ARCH_WANT_OLDOLD_UNAME
+#define __ARCH_WANT_NEW_UNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_SGETMASK
 #define __ARCH_WANT_SYS_SIGNAL
--- linux-2617-rc5-hostname.orig/arch/x86_64/ia32/sys_ia32.c
+++ linux-2617-rc5-hostname/arch/x86_64/ia32/sys_ia32.c
@@ -790,38 +790,17 @@ asmlinkage long sys32_mmap2(unsigned lon
 	return error;
 }

-asmlinkage long sys32_olduname(struct oldold_utsname __user * name)
+asmlinkage long sys32_olduname(struct oldold_utsname __user *name)
 {
-	int error;
+	int error = put_oldold_uname(name);
+	char *arch = "x86_64";

-	if (!name)
-		return -EFAULT;
-	if (!access_ok(VERIFY_WRITE,name,sizeof(struct oldold_utsname)))
-		return -EFAULT;
-
-  	down_read(&uts_sem);
-
-	error = __copy_to_user(&name->sysname,&system_utsname.sysname,__OLD_UTS_LEN);
-	 __put_user(0,name->sysname+__OLD_UTS_LEN);
-	 __copy_to_user(&name->nodename,&system_utsname.nodename,__OLD_UTS_LEN);
-	 __put_user(0,name->nodename+__OLD_UTS_LEN);
-	 __copy_to_user(&name->release,&system_utsname.release,__OLD_UTS_LEN);
-	 __put_user(0,name->release+__OLD_UTS_LEN);
-	 __copy_to_user(&name->version,&system_utsname.version,__OLD_UTS_LEN);
-	 __put_user(0,name->version+__OLD_UTS_LEN);
-	 {
-		 char *arch = "x86_64";
-		 if (personality(current->personality) == PER_LINUX32)
-			 arch = "i686";
-
-		 __copy_to_user(&name->machine,arch,strlen(arch)+1);
-	 }
-
-	 up_read(&uts_sem);
-
-	 error = error ? -EFAULT : 0;
-
-	 return error;
+	if (personality(current->personality) == PER_LINUX32)
+		arch = "i686";
+	__copy_to_user(&name->machine, arch, strlen(arch)+1);
+
+	error = error ? -EFAULT : 0;
+	return error;
 }

 long sys32_uname(struct old_utsname __user * name)
--- linux-2617-rc5-hostname.orig/arch/i386/kernel/sys_i386.c
+++ linux-2617-rc5-hostname/arch/i386/kernel/sys_i386.c
@@ -204,42 +204,17 @@ asmlinkage int sys_ipc (uint call, int f
 /*
  * Old cruft
  */
-asmlinkage int sys_uname(struct old_utsname __user * name)
+asmlinkage int sys_uname(struct old_utsname __user *name)
 {
-	int err;
-	if (!name)
-		return -EFAULT;
-	down_read(&uts_sem);
-	err=copy_to_user(name, &system_utsname, sizeof (*name));
-	up_read(&uts_sem);
-	return err?-EFAULT:0;
+	int err = put_old_uname(name);
+
+	return err ? -EFAULT : 0;
 }

-asmlinkage int sys_olduname(struct oldold_utsname __user * name)
+asmlinkage int sys_olduname(struct oldold_utsname __user *name)
 {
-	int error;
-
-	if (!name)
-		return -EFAULT;
-	if (!access_ok(VERIFY_WRITE,name,sizeof(struct oldold_utsname)))
-		return -EFAULT;
-
-  	down_read(&uts_sem);
-
-	error = __copy_to_user(&name->sysname,&system_utsname.sysname,__OLD_UTS_LEN);
-	error |= __put_user(0,name->sysname+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->nodename,&system_utsname.nodename,__OLD_UTS_LEN);
-	error |= __put_user(0,name->nodename+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->release,&system_utsname.release,__OLD_UTS_LEN);
-	error |= __put_user(0,name->release+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->version,&system_utsname.version,__OLD_UTS_LEN);
-	error |= __put_user(0,name->version+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->machine,&system_utsname.machine,__OLD_UTS_LEN);
-	error |= __put_user(0,name->machine+__OLD_UTS_LEN);
-
-	up_read(&uts_sem);
+	int error = put_oldold_uname(name);

 	error = error ? -EFAULT : 0;
-
 	return error;
 }
--- linux-2617-rc5-hostname.orig/drivers/char/random.c
+++ linux-2617-rc5-hostname/drivers/char/random.c
@@ -223,7 +223,6 @@
  * Eastlake, Steve Crocker, and Jeff Schiller.
  */

-#include <linux/utsname.h>
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -240,6 +239,7 @@
 #include <linux/spinlock.h>
 #include <linux/percpu.h>
 #include <linux/cryptohash.h>
+#include <linux/utsname.h>

 #include <asm/processor.h>
 #include <asm/uaccess.h>
--- linux-2617-rc5-hostname.orig/arch/i386/kernel/syscall_table.S
+++ linux-2617-rc5-hostname/arch/i386/kernel/syscall_table.S
@@ -315,3 +315,5 @@ ENTRY(sys_call_table)
 	.long sys_splice
 	.long sys_sync_file_range
 	.long sys_tee			/* 315 */
+	.long sys_ni_syscall		/* vmsplice */
+	.long sys_uname_long
--- linux-2617-rc5-hostname.orig/include/linux/syscalls.h
+++ linux-2617-rc5-hostname/include/linux/syscalls.h
@@ -27,6 +27,7 @@ struct msgbuf;
 struct msghdr;
 struct msqid_ds;
 struct new_utsname;
+struct long_utsname;
 struct nfsctl_arg;
 struct __old_kernel_stat;
 struct pollfd;
@@ -435,6 +436,7 @@ asmlinkage long sys_gethostname(char __u
 asmlinkage long sys_sethostname(char __user *name, int len);
 asmlinkage long sys_setdomainname(char __user *name, int len);
 asmlinkage long sys_newuname(struct new_utsname __user *name);
+asmlinkage long sys_uname_long(struct long_utsname __user *name);

 asmlinkage long sys_getrlimit(unsigned int resource,
 				struct rlimit __user *rlim);




