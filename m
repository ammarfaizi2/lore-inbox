Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUA1W01 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 17:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266230AbUA1W01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 17:26:27 -0500
Received: from mra02.ex.eclipse.net.uk ([212.104.129.89]:14013 "EHLO
	mra02.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S266128AbUA1WZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 17:25:27 -0500
Message-ID: <4018369E.6090105@example.com>
Date: Wed, 28 Jan 2004 22:24:30 +0000
From: Example <example@example.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: GOTO Masanori <gotom@debian.or.jp>, linux-kernel@vger.kernel.org
Subject: Re: [uPATCH] refuse plain ufs mount
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There's a semantic change introduced by this patch.
I don't know enough about UFS to call it a bug, but it
certainly looks suspicious.

 >--- fs/ufs/super.c.org	2003-10-20 12:50:24.000000000 +0900
 >+++ fs/ufs/super.c	2004-01-27 13:26:05.000000000 +0900
 >@@ -516,7 +516,7 @@
 > 		printk("wrong mount options\n");
 > 		goto failed;
 > 	}
 >-	if (!(sbi->s_mount_opt & UFS_MOUNT_UFSTYPE)) {
 >+	if (!(sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) && !silent) {
 > 		printk("You didn't specify the type of your ufs filesystem\n\n"
 > 		"mount -t ufs -o ufstype="
 > 		"sun|sunx86|44bsd|old|hp|nextstep|netxstep-cd|openstep ...\n\n"
 >@@ -575,7 +575,7 @@
 > 		uspi->s_sbsize = super_block_size = 2048;
 > 		uspi->s_sbbase = 0;
 > 		flags |= UFS_DE_OLD | UFS_UID_OLD | UFS_ST_OLD | UFS_CG_OLD;
 >-		if (!(sb->s_flags & MS_RDONLY)) {
 >+		if (!(sb->s_flags & MS_RDONLY) && !silent) {
 > 			printk(KERN_INFO "ufstype=old is supported read-only\n");
 > 			sb->s_flags |= MS_RDONLY;

If "silent" is set, this variable assignment is skipped.  I
would have thought that the assignment should happen, and only
the printk() should be skipped.

 > 		}
 >@@ -589,7 +589,7 @@
 > 		uspi->s_sbsize = super_block_size = 2048;
 > 		uspi->s_sbbase = 0;
 > 		flags |= UFS_DE_OLD | UFS_UID_OLD | UFS_ST_OLD | UFS_CG_OLD;
 >-		if (!(sb->s_flags & MS_RDONLY)) {
 >+		if (!(sb->s_flags & MS_RDONLY) && !silent) {
 > 			printk(KERN_INFO "ufstype=nextstep is supported read-only\n");
 > 			sb->s_flags |= MS_RDONLY;

Same here.

 > 		}
 >@@ -603,7 +603,7 @@
 > 		uspi->s_sbsize = super_block_size = 2048;
 > 		uspi->s_sbbase = 0;
 > 		flags |= UFS_DE_OLD | UFS_UID_OLD | UFS_ST_OLD | UFS_CG_OLD;
 >-		if (!(sb->s_flags & MS_RDONLY)) {
 >+		if (!(sb->s_flags & MS_RDONLY) && !silent) {
 > 			printk(KERN_INFO "ufstype=nextstep-cd is supported read-only\n");
 > 			sb->s_flags |= MS_RDONLY;

And again.

 > 		}
 >@@ -617,7 +617,7 @@
 > 		uspi->s_sbsize = super_block_size = 2048;
 > 		uspi->s_sbbase = 0;
 > 		flags |= UFS_DE_44BSD | UFS_UID_44BSD | UFS_ST_44BSD | UFS_CG_44BSD;
 >-		if (!(sb->s_flags & MS_RDONLY)) {
 >+		if (!(sb->s_flags & MS_RDONLY) && !silent) {
 > 			printk(KERN_INFO "ufstype=openstep is supported read-only\n");
 > 			sb->s_flags |= MS_RDONLY;

Another one.

 > 		}
 >@@ -631,13 +631,14 @@
 > 		uspi->s_sbsize = super_block_size = 2048;
 > 		uspi->s_sbbase = 0;
 > 		flags |= UFS_DE_OLD | UFS_UID_OLD | UFS_ST_OLD | UFS_CG_OLD;
 >-		if (!(sb->s_flags & MS_RDONLY)) {
 >+		if (!(sb->s_flags & MS_RDONLY) && !silent) {
 > 			printk(KERN_INFO "ufstype=hp is supported read-only\n");
 > 			sb->s_flags |= MS_RDONLY;

And again.

 >  		}
 >  		break;
 > 	default:
 >-		printk("unknown ufstype\n");
 >+		if (!silent)
 >+			printk("unknown ufstype\n");
 > 		goto failed;
 > 	}
 > 	
 >@@ -687,7 +688,8 @@
 > 		uspi->s_sbbase += 8;
 > 		goto again;
 > 	}
 >-	printk("ufs_read_super: bad magic number\n");
 >+	if (!silent)
 >+		printk("ufs_read_super: bad magic number\n");
 > 	goto failed;
 >
 > magic_found:


Kind regards,

Jon
