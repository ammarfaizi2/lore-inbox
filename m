Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261313AbTC3Xei>; Sun, 30 Mar 2003 18:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261316AbTC3Xei>; Sun, 30 Mar 2003 18:34:38 -0500
Received: from slarti.muc.de ([193.149.48.10]:50698 "HELO slarti.muc.de")
	by vger.kernel.org with SMTP id <S261313AbTC3Xee>;
	Sun, 30 Mar 2003 18:34:34 -0500
From: Stephan Maciej <stephanm@muc.de>
Date: Sun, 30 Mar 2003 22:05:06 +0200
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.66 & 2.4.20] Fix sys_sethostname() and sys_setdomainname()
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_y30h+0J/yb/aXru"
Message-Id: <200303302205.06770.stephanm@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_y30h+0J/yb/aXru
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

a long time ago someone mentioned that sethostname() and setdomainname() 
properly return -EFAULT when passing an invalid pointer to the new name, but 
instead of leaving the fields in system_utsname unchanged the nodename and 
domainname are set to an empty string.

The behaviour of sys_sethostname() can be verified using the attached program 
(sethostname.c); sys_setdomainname() is almost the same so I guess that it 
has the same defect :-)

The attached patches fix this. 

Stephan

--Boundary-00=_y30h+0J/yb/aXru
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sethostanddomainname-2.5.66.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sethostanddomainname-2.5.66.diff"

--- kernel/sys.c~unmodified	2003-03-30 21:33:17.000000000 +0200
+++ kernel/sys.c	2003-03-30 21:43:20.000000000 +0200
@@ -1154,14 +1154,18 @@
 asmlinkage long sys_sethostname(char *name, int len)
 {
 	int errno;
+	char tmp[__NEW_UTS_LEN];
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	if (len < 0 || len > __NEW_UTS_LEN)
 		return -EINVAL;
+	
 	down_write(&uts_sem);
 	errno = -EFAULT;
-	if (!copy_from_user(system_utsname.nodename, name, len)) {
+
+	if (!copy_from_user(tmp, name, len)) {
+		memcpy(system_utsname.nodename, tmp, len);
 		system_utsname.nodename[len] = 0;
 		errno = 0;
 	}
@@ -1193,6 +1197,7 @@
 asmlinkage long sys_setdomainname(char *name, int len)
 {
 	int errno;
+	char tmp[__NEW_UTS_LEN];
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1201,10 +1206,13 @@
 
 	down_write(&uts_sem);
 	errno = -EFAULT;
-	if (!copy_from_user(system_utsname.domainname, name, len)) {
-		errno = 0;
+
+	if (!copy_from_user(tmp, name, len)) {
+		memcpy(system_utsname.domainname, tmp, len);
 		system_utsname.domainname[len] = 0;
+		errno = 0;
 	}
+
 	up_write(&uts_sem);
 	return errno;
 }

--Boundary-00=_y30h+0J/yb/aXru
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="sethostname.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sethostname.c"


#include <linux/utsname.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int main()
{
  int retval;
  char hostname[__NEW_UTS_LEN];

  // Print out current hostname
  if ((retval = gethostname(hostname, __NEW_UTS_LEN)) == -1) {
    printf("call to gethostname() failed, retval=%d: %s\n", retval, strerror(errno));
    return 1;
  };
  
  printf("gethostname()=\"%s\"\n", hostname);

  // Set "new" hostname
  if ((retval = sethostname((char *)-1, 10)) != -1) {
    // We really EXPECT this to fail!
    printf("The Penguin is in trouble!\n");
    return 2;
  } else
    printf("sethostname(INVALID, 10)=%d (error \"%s\")\n", retval, strerror(errno));

  // And now once again:
  if ((retval = gethostname(hostname, __NEW_UTS_LEN)) == -1) {
    printf("call to gethostname() failed, retval=%d: %s\n", retval, strerror(errno));
    return 1;
  };
  
  printf("gethostname()=\"%s\"\n", hostname);

  return 0;
};

--Boundary-00=_y30h+0J/yb/aXru
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sethostanddomainname-2.4.20.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sethostanddomainname-2.4.20.diff"

--- kernel/sys.c~unmodified	2003-03-30 21:51:07.000000000 +0200
+++ kernel/sys.c	2003-03-30 21:53:01.000000000 +0200
@@ -1026,6 +1026,7 @@
 asmlinkage long sys_sethostname(char *name, int len)
 {
 	int errno;
+	char tmp[__NEW_UTS_LEN];
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1033,7 +1034,8 @@
 		return -EINVAL;
 	down_write(&uts_sem);
 	errno = -EFAULT;
-	if (!copy_from_user(system_utsname.nodename, name, len)) {
+	if (!copy_from_user(tmp, name, len)) {
+		memcpy(system_utsname.nodename, tmp, len);
 		system_utsname.nodename[len] = 0;
 		errno = 0;
 	}
@@ -1065,6 +1067,7 @@
 asmlinkage long sys_setdomainname(char *name, int len)
 {
 	int errno;
+	char tmp[__NEW_UTS_LEN];
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1073,9 +1076,10 @@
 
 	down_write(&uts_sem);
 	errno = -EFAULT;
-	if (!copy_from_user(system_utsname.domainname, name, len)) {
-		errno = 0;
+	if (!copy_from_user(tmp, name, len)) {
+		memcpy(system_utsname.domainname, tmp, len);
 		system_utsname.domainname[len] = 0;
+		errno = 0;
 	}
 	up_write(&uts_sem);
 	return errno;

--Boundary-00=_y30h+0J/yb/aXru--

