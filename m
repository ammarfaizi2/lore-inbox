Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315625AbSENLx4>; Tue, 14 May 2002 07:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315626AbSENLxz>; Tue, 14 May 2002 07:53:55 -0400
Received: from imladris.infradead.org ([194.205.184.45]:63759 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315625AbSENLxr>; Tue, 14 May 2002 07:53:47 -0400
Date: Tue, 14 May 2002 12:53:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove compat code for old devfs naming scheme
Message-ID: <20020514125339.A23979@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

current init/do_mounts.c contains the devfs_make_root/convert_name
functions which provide compatiblility for the old, pre kernel-merge
devfs naming scheme in the root= kernel command line.

As this was never present in official kernels there is really no need
in keeping it - it just bloats the kernel.

Could you please forward this patch to Linus and maybe Marcelo with
your next devfs update?

	Christoph

--
--- 1.14/init/do_mounts.c	Sun May  5 18:35:44 2002
+++ edited/init/do_mounts.c	Sat May 11 18:32:17 2002
@@ -636,63 +636,6 @@
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
@@ -707,7 +650,6 @@
 		ROOT_DEV = mk_kdev(FLOPPY_MAJOR, 0);
 	}
 #endif
-	devfs_make_root(root_device_name);
 	create_dev("/dev/root", ROOT_DEV, root_device_name);
 #ifdef CONFIG_BLK_DEV_FD
 	if (major(ROOT_DEV) == FLOPPY_MAJOR) {
