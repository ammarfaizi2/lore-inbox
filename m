Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWDUEoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWDUEoD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWDUEoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:40065 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932226AbWDUEoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:00 -0400
Date: Thu, 20 Apr 2006 21:39:51 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 22/22] Add more prevent_tail_call()
Message-ID: <20060421043951.GT12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="add-more-prevent_tail_call.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

[PATCH] Add more prevent_tail_call()

Those also break userland regs like following.

   00000000 <sys_chown16>:
      0:	0f b7 44 24 0c       	movzwl 0xc(%esp),%eax
      5:	83 ca ff             	or     $0xffffffff,%edx
      8:	0f b7 4c 24 08       	movzwl 0x8(%esp),%ecx
      d:	66 83 f8 ff          	cmp    $0xffffffff,%ax
     11:	0f 44 c2             	cmove  %edx,%eax
     14:	66 83 f9 ff          	cmp    $0xffffffff,%cx
     18:	0f 45 d1             	cmovne %ecx,%edx
     1b:	89 44 24 0c          	mov    %eax,0xc(%esp)
     1f:	89 54 24 08          	mov    %edx,0x8(%esp)
     23:	e9 fc ff ff ff       	jmp    24 <sys_chown16+0x24>

where the tailcall at the end overwrites the incoming stack-frame.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 kernel/uid16.c |   59 ++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 13 deletions(-)

--- linux-2.6.16.9.orig/kernel/uid16.c
+++ linux-2.6.16.9/kernel/uid16.c
@@ -20,43 +20,67 @@
 
 asmlinkage long sys_chown16(const char __user * filename, old_uid_t user, old_gid_t group)
 {
-	return sys_chown(filename, low2highuid(user), low2highgid(group));
+	long ret = sys_chown(filename, low2highuid(user), low2highgid(group));
+	/* avoid REGPARM breakage on x86: */
+	prevent_tail_call(ret);
+	return ret;
 }
 
 asmlinkage long sys_lchown16(const char __user * filename, old_uid_t user, old_gid_t group)
 {
-	return sys_lchown(filename, low2highuid(user), low2highgid(group));
+	long ret = sys_lchown(filename, low2highuid(user), low2highgid(group));
+	/* avoid REGPARM breakage on x86: */
+	prevent_tail_call(ret);
+	return ret;
 }
 
 asmlinkage long sys_fchown16(unsigned int fd, old_uid_t user, old_gid_t group)
 {
-	return sys_fchown(fd, low2highuid(user), low2highgid(group));
+	long ret = sys_fchown(fd, low2highuid(user), low2highgid(group));
+	/* avoid REGPARM breakage on x86: */
+	prevent_tail_call(ret);
+	return ret;
 }
 
 asmlinkage long sys_setregid16(old_gid_t rgid, old_gid_t egid)
 {
-	return sys_setregid(low2highgid(rgid), low2highgid(egid));
+	long ret = sys_setregid(low2highgid(rgid), low2highgid(egid));
+	/* avoid REGPARM breakage on x86: */
+	prevent_tail_call(ret);
+	return ret;
 }
 
 asmlinkage long sys_setgid16(old_gid_t gid)
 {
-	return sys_setgid(low2highgid(gid));
+	long ret = sys_setgid(low2highgid(gid));
+	/* avoid REGPARM breakage on x86: */
+	prevent_tail_call(ret);
+	return ret;
 }
 
 asmlinkage long sys_setreuid16(old_uid_t ruid, old_uid_t euid)
 {
-	return sys_setreuid(low2highuid(ruid), low2highuid(euid));
+	long ret = sys_setreuid(low2highuid(ruid), low2highuid(euid));
+	/* avoid REGPARM breakage on x86: */
+	prevent_tail_call(ret);
+	return ret;
 }
 
 asmlinkage long sys_setuid16(old_uid_t uid)
 {
-	return sys_setuid(low2highuid(uid));
+	long ret = sys_setuid(low2highuid(uid));
+	/* avoid REGPARM breakage on x86: */
+	prevent_tail_call(ret);
+	return ret;
 }
 
 asmlinkage long sys_setresuid16(old_uid_t ruid, old_uid_t euid, old_uid_t suid)
 {
-	return sys_setresuid(low2highuid(ruid), low2highuid(euid),
-		low2highuid(suid));
+	long ret = sys_setresuid(low2highuid(ruid), low2highuid(euid),
+				 low2highuid(suid));
+	/* avoid REGPARM breakage on x86: */
+	prevent_tail_call(ret);
+	return ret;
 }
 
 asmlinkage long sys_getresuid16(old_uid_t __user *ruid, old_uid_t __user *euid, old_uid_t __user *suid)
@@ -72,8 +96,11 @@ asmlinkage long sys_getresuid16(old_uid_
 
 asmlinkage long sys_setresgid16(old_gid_t rgid, old_gid_t egid, old_gid_t sgid)
 {
-	return sys_setresgid(low2highgid(rgid), low2highgid(egid),
-		low2highgid(sgid));
+	long ret = sys_setresgid(low2highgid(rgid), low2highgid(egid),
+				 low2highgid(sgid));
+	/* avoid REGPARM breakage on x86: */
+	prevent_tail_call(ret);
+	return ret;
 }
 
 asmlinkage long sys_getresgid16(old_gid_t __user *rgid, old_gid_t __user *egid, old_gid_t __user *sgid)
@@ -89,12 +116,18 @@ asmlinkage long sys_getresgid16(old_gid_
 
 asmlinkage long sys_setfsuid16(old_uid_t uid)
 {
-	return sys_setfsuid(low2highuid(uid));
+	long ret = sys_setfsuid(low2highuid(uid));
+	/* avoid REGPARM breakage on x86: */
+	prevent_tail_call(ret);
+	return ret;
 }
 
 asmlinkage long sys_setfsgid16(old_gid_t gid)
 {
-	return sys_setfsgid(low2highgid(gid));
+	long ret = sys_setfsgid(low2highgid(gid));
+	/* avoid REGPARM breakage on x86: */
+	prevent_tail_call(ret);
+	return ret;
 }
 
 static int groups16_to_user(old_gid_t __user *grouplist,

--
