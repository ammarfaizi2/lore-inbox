Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317395AbSFMBmW>; Wed, 12 Jun 2002 21:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317396AbSFMBmV>; Wed, 12 Jun 2002 21:42:21 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:58339 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S317395AbSFMBmT>;
	Wed, 12 Jun 2002 21:42:19 -0400
Date: Thu, 13 Jun 2002 11:41:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: torvalds@transmeta.com
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] remove getname32
Message-Id: <20020613114127.0a137a70.sfr@canb.auug.org.au>
In-Reply-To: <20020612155535.61b20b66.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Take 2 - this time with the whole patch :-)

This patch has been OK'd by one o fthe ppc64 maintainers (Anton Blanchard).

On Wed, 12 Jun 2002 15:55:35 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Linus,
> 
> OK, arch/ppc64/kernel/sys_ppc32.c has a getname32 function. The only
> difference between it and getname() is that it calls do_getname32()
> instead of do_getname() (see fs/namei.c).  The difference between
> do_getname and do_getname32 is that the former checks to make sure that
> the pointer it is passed is less that TASK_SIZE and restricts the length
> copied to the lesser of PATH_MAX and (TASK_SIZE - pointer).  do_getname32
> uses PAGE_SIZE instead of PATH_MAX.
> 
> arch/ia64/ia32/sys_ia32.c defined a getname32(), but nothing used it.
> 
> This patch removes both.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.21/arch/ia64/ia32/sys_ia32.c 2.5.21-sfr.1/arch/ia64/ia32/sys_ia32.c
--- 2.5.21/arch/ia64/ia32/sys_ia32.c	Mon Jun 10 23:13:43 2002
+++ 2.5.21-sfr.1/arch/ia64/ia32/sys_ia32.c	Wed Jun 12 15:52:20 2002
@@ -3629,47 +3629,6 @@
 	return ret;
 }
 
-/* In order to reduce some races, while at the same time doing additional
- * checking and hopefully speeding things up, we copy filenames to the
- * kernel data space before using them..
- *
- * POSIX.1 2.4: an empty pathname is invalid (ENOENT).
- */
-static inline int
-do_getname32 (const char *filename, char *page)
-{
-	int retval;
-
-	/* 32bit pointer will be always far below TASK_SIZE :)) */
-	retval = strncpy_from_user((char *)page, (char *)filename, PAGE_SIZE);
-	if (retval > 0) {
-		if (retval < PAGE_SIZE)
-			return 0;
-		return -ENAMETOOLONG;
-	} else if (!retval)
-		retval = -ENOENT;
-	return retval;
-}
-
-static char *
-getname32 (const char *filename)
-{
-	char *tmp, *result;
-
-	result = ERR_PTR(-ENOMEM);
-	tmp = (char *)__get_free_page(GFP_KERNEL);
-	if (tmp)  {
-		int retval = do_getname32(filename, tmp);
-
-		result = tmp;
-		if (retval < 0) {
-			putname(tmp);
-			result = ERR_PTR(retval);
-		}
-	}
-	return result;
-}
-
 asmlinkage long
 sys32_sched_rr_get_interval (pid_t pid, struct timespec32 *interval)
 {
diff -ruN 2.5.21/arch/ppc64/kernel/sys_ppc32.c 2.5.21-sfr.1/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.21/arch/ppc64/kernel/sys_ppc32.c	Mon Jun  3 12:16:59 2002
+++ 2.5.21-sfr.1/arch/ppc64/kernel/sys_ppc32.c	Wed Jun 12 15:42:25 2002
@@ -82,47 +82,6 @@
  */
 #define MSR_USERCHANGE	(MSR_FE0 | MSR_FE1)
 
-/* In order to reduce some races, while at the same time doing additional
- * checking and hopefully speeding things up, we copy filenames to the
- * kernel data space before using them..
- *
- * POSIX.1 2.4: an empty pathname is invalid (ENOENT).
- */
-static inline int do_getname32(const char *filename, char *page)
-{
-	int retval;
-
-	/* 32bit pointer will be always far below TASK_SIZE :)) */
-	retval = strncpy_from_user((char *)page, (char *)filename, PAGE_SIZE);
-	if (retval > 0) {
-		if (retval < PAGE_SIZE)
-			return 0;
-		return -ENAMETOOLONG;
-	} else if (!retval)
-		retval = -ENOENT;
-	return retval;
-}
-
-char * getname32(const char *filename)
-{
-	char *tmp, *result;
-
-	result = ERR_PTR(-ENOMEM);
-  tmp =  __getname();
-	if (tmp)  {
-		int retval = do_getname32(filename, tmp);
-
-		result = tmp;
-		if (retval < 0) {
-			putname(tmp);
-			result = ERR_PTR(retval);
-		}
-	}
-	return result;
-}
-
-
-
 extern asmlinkage long sys_utime(char * filename, struct utimbuf * times);
 
 struct utimbuf32 {
@@ -142,7 +101,7 @@
 		return sys_utime(filename, NULL);
 	if (get_user(t.actime, &times->actime) || __get_user(t.modtime, &times->modtime))
 		return -EFAULT;
-	filenam = getname32(filename);
+	filenam = getname(filename);
 
 	ret = PTR_ERR(filenam);
 	if (!IS_ERR(filenam)) {
@@ -937,7 +896,7 @@
 	
 	PPCDBG(PPCDBG_SYS32X, "sys32_statfs - entered - pid=%ld current=%lx comm=%s\n", current->pid, current, current->comm);
 	
-	pth = getname32 (path);
+	pth = getname (path);
 	ret = PTR_ERR(pth);
 	if (!IS_ERR(pth)) {
 		set_fs (KERNEL_DS);
