Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTFYMFB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 08:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTFYMFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 08:05:01 -0400
Received: from arbi.Informatik.uni-oldenburg.de ([134.106.1.7]:5128 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE") by vger.kernel.org with ESMTP
	id S263398AbTFYME7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 08:04:59 -0400
Subject: patch 2.4.21 better static buffer check
To: linux-kernel@vger.kernel.org
Date: Wed, 25 Jun 2003 13:56:54 +0200 (MEST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E19V8tS-0009zc-00@grossglockner.Informatik.Uni-Oldenburg.DE>
From: "Walter Harms" <Walter.Harms@Informatik.Uni-Oldenburg.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi list,
writing via sprintf() into static buffers is only asking
for trouble, IMHO. Therefor I changed do_mount.c to use
snprintf() instead of sprintf(). 

regards,
walter

--- init/do_mounts.c.org        2003-06-24 22:05:02.000000000 +0200
+++ init/do_mounts.c    2003-06-24 22:25:03.000000000 +0200
@@ -421,7 +421,7 @@
        int fd;
        va_list args;
        va_start(args, fmt);
-       vsprintf(buf, fmt, args);
+       vsnprintf(buf,sizeof(buf),fmt, args);
        va_end(args);
        fd = open("/dev/root", O_RDWR | O_NDELAY, 0);
        if (fd >= 0) {
@@ -710,16 +710,16 @@
             return;
        lun = simple_strtol(p, &p, 10);
        if (!part)
-            sprintf(dest, "%s/host%d/bus%d/target%d/lun%d",
+            snprintf(dest,sizeof(dest), "%s/host%d/bus%d/target%d/lun%d",
                        prefix, host, bus, target, lun);
        else if (*p++ == 'p')
-            sprintf(dest, "%s/host%d/bus%d/target%d/lun%d/part%s",
+            snprintf(dest,sizeof(dest), "%s/host%d/bus%d/target%d/lun%d/part%s",
                        prefix, host, bus, target, lun, p);
        else
-            sprintf(dest, "%s/host%d/bus%d/target%d/lun%d/disc",
+            snprintf(dest,sizeof(dest), "%s/host%d/bus%d/target%d/lun%d/disc",
                        prefix, host, bus, target, lun);
        *base = '\0';
-       sprintf(src, "/dev/%s", name);
+       snprintf(src,sizeof(src), "/dev/%s", name);
        sys_mkdir(src, 0755);
        *base = '/';
        sprintf(src, "/dev/%s", name);
@@ -801,7 +801,8 @@
 #ifdef CONFIG_BLK_DEV_INITRD
        int ram0 = kdev_t_to_nr(MKDEV(RAMDISK_MAJOR,0));
        int error;
-       int i, pid;
+       int i;
+       pid_t pid;
 
        create_dev("/dev/root.old", ram0, NULL);
        /* mount initrd on rootfs' /root */

-- 
