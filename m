Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbVGMTsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVGMTsq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbVGMTng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:43:36 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:22202 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262378AbVGMTmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:42:20 -0400
Date: Wed, 13 Jul 2005 12:42:15 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Miles Lane <miles.lane@gmail.com>
Cc: airlied@gmail.com, linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>
Subject: Re: OOPS in 2.6.13-rc1-mm1 -- EIP is at sysfs_release+0x49/0xb0
Message-Id: <20050713124215.77a6a6a1.rdunlap@xenotime.net>
In-Reply-To: <a44ae5cd05071307546d3f8f9e@mail.gmail.com>
References: <a44ae5cd05070301417531fac2@mail.gmail.com>
	<21d7e9970507070331107831c6@mail.gmail.com>
	<1121055986.10029.9.camel@localhost.localdomain>
	<21d7e99705071300173ae0c39b@mail.gmail.com>
	<a44ae5cd05071307546d3f8f9e@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2005 09:54:10 -0500 Miles Lane wrote:

> On 7/13/05, Dave Airlie <airlied@gmail.com> wrote:
> > > Thanks Dave,
> > >
> > > I switched to the i915 kernel driver and still got the OOPS.
> > > I also continue to get the overlapping mtrr message.  I am currently
> > > testing 2.6.13-rc2-git3.  I have tried to run strace with hald, but
> > > cannot reproduce the problem this way.  I am not sure I am invoking the
> > > command corrently.  I have written to the hal developers, but have not
> > > received a response yet.  Here's the current output:
> > >
> > 
> > Can you try and see if you apply the patch from
> > 
> > http://lkml.org/lkml/2005/7/8/257
> > 
> > It should apply to your kernel.. I cannot get this to happen on my
> > system... the mtrr overlaps are just vesafb setting up the mtrrs, you
> > might try without vesafb...
> 
> I will try booting without vesafb enabled.
> 
> I get an error building with the patch applied to 2.6.13-rc2-git3:
> 
> arch/i386/kernel/built-in.o(.text+0x4010): In function `die':
> arch/i386/kernel/traps.c:343: undefined reference to `last_sysfs_name'
> make: *** [.tmp_vmlinux1] Error 1

Miles,
Here is an updated version of the patch that builds for me.
(uses last_sysfs_file instead of last_sysfs_name)

---
~Randy



Track and print last_sysfs_file on oops.
---

 arch/i386/kernel/traps.c |    6 ++++++
 fs/sysfs/file.c          |    7 +++++++
 2 files changed, 13 insertions(+)

diff -Naurp linux-2613-rc1-mm1/arch/i386/kernel/traps.c~last_sysfs_file linux-2613-rc1-mm1/arch/i386/kernel/traps.c
--- linux-2613-rc1-mm1/arch/i386/kernel/traps.c~last_sysfs_file	2005-07-13 12:28:25.000000000 -0700
+++ linux-2613-rc1-mm1/arch/i386/kernel/traps.c	2005-07-13 12:38:41.000000000 -0700
@@ -370,6 +370,12 @@ void die(const char * str, struct pt_reg
 #endif
 		if (nl)
 			printk("\n");
+		{
+			extern char last_sysfs_file[];
+
+			printk(KERN_ALERT "last sysfs file: %s\n",
+					last_sysfs_file);
+		}
 #ifdef CONFIG_KGDB
 	/* This is about the only place we want to go to kgdb even if in
 	 * user mode.  But we must go in via a trap so within kgdb we will
diff -Naurp linux-2613-rc1-mm1/fs/sysfs/file.c~last_sysfs_file linux-2613-rc1-mm1/fs/sysfs/file.c
--- linux-2613-rc1-mm1/fs/sysfs/file.c~last_sysfs_file	2005-07-13 12:13:35.000000000 -0700
+++ linux-2613-rc1-mm1/fs/sysfs/file.c	2005-07-13 12:26:26.000000000 -0700
@@ -6,6 +6,8 @@
 #include <linux/fsnotify.h>
 #include <linux/kobject.h>
 #include <linux/namei.h>
+#include <linux/limits.h>
+
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 
@@ -324,8 +326,13 @@ static int check_perm(struct inode * ino
 	return error;
 }
 
+char last_sysfs_file[PATH_MAX];
+
 static int sysfs_open_file(struct inode * inode, struct file * filp)
 {
+	d_path(filp->f_dentry, sysfs_mount, last_sysfs_file,
+			sizeof(last_sysfs_file));
+
 	return check_perm(inode,filp);
 }
 
