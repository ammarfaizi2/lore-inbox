Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbTL3Dal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 22:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbTL3Dal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 22:30:41 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:64711 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id S264337AbTL3Daj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 22:30:39 -0500
Date: Mon, 29 Dec 2003 22:30:36 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 kernel panic
Message-ID: <20031230033036.GA2158@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031228020759.GA2158@Master.Wizards>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228020759.GA2158@Master.Wizards>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 27, 2003 at 09:07:59PM -0500, Murray J. Root wrote:
> P4 2GHz
> ASUS P4S533 mainboard
> 1G PC2700 RAM
> GF2 GTS video using nv driver
> 2.6.0 compiled with gcc 3.3.2
> 
> At boot kernel gets:
>    INIT: cannot execute "/etc/rc.d/rc.sysinit"
> then panic.
> 
> Same configuration for 2.6.0-test11 and earlier works fine.
> 

To answer myself, I did a diff between 2.6.0-test11 and 2.6.0. Found this:

diff -ru RAW260T11/mm/mmap.c RAW260/mm/mmap.c
--- RAW260T11/mm/mmap.c	2003-11-26 15:44:31.000000000 -0500
+++ RAW260/mm/mmap.c	2003-12-17 21:58:58.000000000 -0500
@@ -19,6 +19,7 @@
 #include <linux/hugetlb.h>
 #include <linux/profile.h>
 #include <linux/module.h>
+#include <linux/mount.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -474,8 +475,13 @@
 	struct rb_node ** rb_link, * rb_parent;
 	unsigned long charged = 0;
 
-	if (file && (!file->f_op || !file->f_op->mmap))
-		return -ENODEV;
+	if (file) {
+		if (!file->f_op || !file->f_op->mmap)
+			return -ENODEV;
+
+		if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
+			return -EPERM;
+	}
 
 	if (!len)
 		return addr;

I undid the changes and it boots fine.
Don't know if it makes a difference but I don't use an initrd.

-- 
Murray J. Root
