Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261350AbSJCVhm>; Thu, 3 Oct 2002 17:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbSJCVhm>; Thu, 3 Oct 2002 17:37:42 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:18445 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261350AbSJCVhV>;
	Thu, 3 Oct 2002 17:37:21 -0400
Date: Thu, 3 Oct 2002 14:40:04 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [BK PATCH] minor devfs cleanup for 2.5.40
Message-ID: <20021003214003.GC1388@kroah.com>
References: <20021003213908.GB1388@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021003213908.GB1388@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And here's the patch for those who want to see it.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.682   -> 1.683  
#	    init/do_mounts.c	1.23    -> 1.24   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/03	hch@sgi.com	1.683
# [PATCH] Remove some more devfs crap
# 
# Translation code for old devfs names that _never_ were in mainline
# for root=.
# --------------------------------------------
#
diff -Nru a/init/do_mounts.c b/init/do_mounts.c
--- a/init/do_mounts.c	Thu Oct  3 14:31:22 2002
+++ b/init/do_mounts.c	Thu Oct  3 14:31:22 2002
@@ -642,63 +642,6 @@
 	return rd_load_image("/dev/root");
 }
 
-#ifdef CONFIG_DEVFS_FS
-
-static void __init convert_name(char *prefix, char *name, char *p, int part)
-{
-	int host, bus, target, lun;
-	char dest[64];
-	char src[64];
-	char *base = p - 1;
-
-	/*  Decode "c#b#t#u#"  */
-	if (*p++ != 'c')
-		return;
-	host = simple_strtol(p, &p, 10);
-	if (*p++ != 'b')
-		return;
-	bus = simple_strtol(p, &p, 10);
-	if (*p++ != 't')
-		return;
-	target = simple_strtol(p, &p, 10);
-	if (*p++ != 'u')
-		return;
-	lun = simple_strtol(p, &p, 10);
-	if (!part)
-		sprintf(dest, "%s/host%d/bus%d/target%d/lun%d",
-				prefix, host, bus, target, lun);
-	else if (*p++ == 'p')
-		sprintf(dest, "%s/host%d/bus%d/target%d/lun%d/part%s",
-				prefix, host, bus, target, lun, p);
-	else
-		sprintf(dest, "%s/host%d/bus%d/target%d/lun%d/disc",
-				prefix, host, bus, target, lun);
-	*base = '\0';
-	sprintf(src, "/dev/%s", name);
-	sys_mkdir(src, 0755);
-	*base = '/';
-	sprintf(src, "/dev/%s", name);
-	sys_symlink(dest, src);
-}
-
-static void __init devfs_make_root(char *name)
-{
-
-	if (!strncmp(name, "sd/", 3))
-		convert_name("../scsi", name, name+3, 1);
-	else if (!strncmp(name, "sr/", 3))
-		convert_name("../scsi", name, name+3, 0);
-	else if (!strncmp(name, "ide/hd/", 7))
-		convert_name("..", name, name + 7, 1);
-	else if (!strncmp(name, "ide/cd/", 7))
-		convert_name("..", name, name + 7, 0);
-}
-#else
-static void __init devfs_make_root(char *name)
-{
-}
-#endif
-
 static void __init mount_root(void)
 {
 #ifdef CONFIG_ROOT_NFS
@@ -713,7 +656,6 @@
 		ROOT_DEV = Root_FD0;
 	}
 #endif
-	devfs_make_root(root_device_name);
 	create_dev("/dev/root", ROOT_DEV, root_device_name);
 #ifdef CONFIG_BLK_DEV_FD
 	if (MAJOR(ROOT_DEV) == FLOPPY_MAJOR) {
