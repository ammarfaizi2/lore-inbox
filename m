Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274969AbTHMNYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274982AbTHMNYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:24:23 -0400
Received: from www.13thfloor.at ([212.16.59.250]:51910 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S274969AbTHMNYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:24:18 -0400
Date: Wed, 13 Aug 2003 15:24:30 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: jeff millar <wa1hco@adelphia.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SOLUTION Re: 2.6.0-test3 cannot mount root fs
Message-ID: <20030813132429.GA7551@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: jeff millar <wa1hco@adelphia.net>,
	linux-kernel@vger.kernel.org
References: <20030809115656.GC27013@www.13thfloor.at> <20030809090718.GA10360@gamma.logic.tuwien.ac.at> <20030809130641.A8174@electric-eye.fr.zoreil.com> <20030809090718.GA10360@gamma.logic.tuwien.ac.at> <01a201c35e65$0536ef60$ee52a450@theoden> <3F34D0EA.8040006@rogers.com> <20030813061546.GB24994@gamma.logic.tuwien.ac.at> <00ac01c36193$72c892a0$6401a8c0@wa1hco> <20030813123010.GA7274@www.13thfloor.at> <00bb01c36198$51cba650$6401a8c0@wa1hco>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <00bb01c36198$51cba650$6401a8c0@wa1hco>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 08:42:12AM -0400, jeff millar wrote:
> I didn't try 16 versions but did try at least
> 
>     /dev/hda3, 0303, 03:03, hda3
> 
> All with grub.conf similar to below
> 
> Please let me know if I need to try something else with grub.. If you have a
> patch, I'll try it tonite and email the results to you and the list.

here is the patch, please try to capture/copy
all lines starting with $$ (and the ones immediately
following) ... 

boot okay ...

$$ name_to_dev_t() >/dev/hda1<
$$ check >hda1<
$$ check >hda1< (<31)
$$ try_name() I
$$ try_name() >hda1<,0
$$ open >/sys/block/hda1/dev< = -1
$$ fail
$$ strtoul >1< -> 1
$$ try_name() II
$$ try_name() >hda<,1
$$ open >/sys/block/hda/dev< = 0
$$ read 0[32] = >3:0
< (4)
$$ buf: >3:0<
$$ mkdev (3,0) -> 768
$$ open2 >/sys/block/hda/range< = 0
$$ read2 0[32] = >64
< (3)
$$ buf: >64<
$$ strtoul >64< -> 64
$$ 1 < 64 ?
$$ name_to_dev_t() done
VFS: Mounted root (ext2 filesystem) readonly.


device not present ...

$$ name_to_dev_t() >/dev/hdc1<
$$ check >hdc1<
$$ check >hdc1< (<31)
$$ try_name() I
$$ try_name() >hdc1<,0
$$ open >/sys/block/hdc1/dev< = -1
$$ fail
$$ strtoul >1< -> 1
$$ try_name() II
$$ try_name() >hdc<,1
$$ open >/sys/block/hdc/dev< = -1
$$ fail
$$ name_to_dev_t() failed
$$ name_to_dev_t() done
VFS: Cannot open root device "hdc1" or unknown-block(0,0)


patch below ...
-----------------

diff -NurP --minimal linux-2.6.0-test3/init/do_mounts.c linux-2.6.0-test3-debug/init/do_mounts.c
--- linux-2.6.0-test3/init/do_mounts.c	2003-08-09 16:31:35.000000000 +0200
+++ linux-2.6.0-test3-debug/init/do_mounts.c	2003-08-13 15:15:23.000000000 +0200
@@ -62,11 +62,14 @@
 
 	/* read device number from .../dev */
 
+	printk("$$ try_name() >%s<,%d\n", name, part);
 	sprintf(path, "/sys/block/%s/dev", name);
 	fd = open(path, 0, 0);
+	printk("$$ open >%s< = %d\n", path, fd);
 	if (fd < 0)
 		goto fail;
 	len = read(fd, buf, 32);
+	printk("$$ read %d[32] = >%*s< (%d)\n", fd, len, buf, len);
 	close(fd);
 	if (len <= 0 || len == 32 || buf[len - 1] != '\n')
 		goto fail;
@@ -74,9 +77,11 @@
 	/*
 	 * The format of dev is now %u:%u -- see print_dev_t()
 	 */
-	if (sscanf(buf, "%u:%u", &maj, &min) == 2)
+	printk("$$ buf: >%s<\n", buf);
+	if (sscanf(buf, "%u:%u", &maj, &min) == 2) {
 		res = MKDEV(maj, min);
-	else
+		printk("$$ mkdev (%d,%d) -> %d\n", maj, min, res);
+	} else
 		goto fail;
 
 	/* if it's there and we are not looking for a partition - that's it */
@@ -86,21 +91,27 @@
 	/* otherwise read range from .../range */
 	sprintf(path, "/sys/block/%s/range", name);
 	fd = open(path, 0, 0);
+	printk("$$ open2 >%s< = %d\n", path, fd);
 	if (fd < 0)
 		goto fail;
 	len = read(fd, buf, 32);
+	printk("$$ read2 %d[32] = >%*s< (%d)\n", fd, len, buf, len);
 	close(fd);
 	if (len <= 0 || len == 32 || buf[len - 1] != '\n')
 		goto fail;
 	buf[len - 1] = '\0';
+	printk("$$ buf: >%s<\n", buf);
 	range = simple_strtoul(buf, &s, 10);
+	printk("$$ strtoul >%s< -> %d\n", buf, range);
 	if (*s)
 		goto fail;
 
 	/* if partition is within range - we got it */
+	printk("$$ %d < %d ?\n", part, range);
 	if (part < range)
 		return res + part;
 fail:
+	printk("$$ fail\n");
 	return (dev_t) 0;
 }
 
@@ -130,27 +141,32 @@
 	dev_t res = 0;
 	int part;
 
+	printk("$$ name_to_dev_t() >%s<\n", name);
 	sys_mkdir("/sys", 0700);
 	if (sys_mount("sysfs", "/sys", "sysfs", 0, NULL) < 0)
 		goto out;
 
 	if (strncmp(name, "/dev/", 5) != 0) {
 		res = (dev_t) simple_strtoul(name, &p, 16);
+		printk("$$ strtoul >%s< -> %d\n", name, res);
 		if (*p)
 			goto fail;
 		goto done;
 	}
 	name += 5;
 	res = Root_NFS;
+	printk("$$ check >%s<\n", name);
 	if (strcmp(name, "nfs") == 0)
 		goto done;
 
+	printk("$$ check >%s< (<31)\n", name);
 	if (strlen(name) > 31)
 		goto fail;
 	strcpy(s, name);
 	for (p = s; *p; p++)
 		if (*p == '/')
 			*p = '.';
+	printk("$$ try_name() I\n");
 	res = try_name(s, 0);
 	if (res)
 		goto done;
@@ -160,7 +176,9 @@
 	if (p == s || !*p || *p == '0')
 		goto fail;
 	part = simple_strtoul(p, NULL, 10);
+	printk("$$ strtoul >%s< -> %d\n", p, part);
 	*p = '\0';
+	printk("$$ try_name() II\n");
 	res = try_name(s, part);
 	if (res)
 		goto done;
@@ -168,19 +186,23 @@
 	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')
 		goto fail;
 	p[-1] = '\0';
+	printk("$$ try_name() III\n");
 	res = try_name(s, part);
 done:
+	printk("$$ name_to_dev_t() done\n");
 	sys_umount("/sys", 0);
 out:
 	sys_rmdir("/sys");
 	return res;
 fail:
+	printk("$$ name_to_dev_t() failed\n");
 	res = (dev_t) 0;
 	goto done;
 }
 
 static int __init root_dev_setup(char *line)
 {
+	printk("$$ root_dev_setup() >%s<\n", line);
 	strlcpy(saved_root_name, line, sizeof(saved_root_name));
 	return 1;
 }

