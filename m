Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315606AbSENKzg>; Tue, 14 May 2002 06:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315608AbSENKzf>; Tue, 14 May 2002 06:55:35 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:53192 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S315606AbSENKze>;
	Tue, 14 May 2002 06:55:34 -0400
Date: Tue, 14 May 2002 11:55:43 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: "Hans K. Rosbach" <hk@circlestorm.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Initrd or Cdrom as root
In-Reply-To: <016f01c1fb33$d97baef0$8f2b76d9@dead2>
Message-ID: <Pine.LNX.4.33.0205141151230.1724-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002, Hans K. Rosbach wrote:

> Is there any way to dynamically load initrd or cdrom permanently as
> the root fs when booting from cdrom?
>
> My problem is that I need a reliable way to ALWAYS find the correct
> device to mount. Is there any way to make the kernel automagically
> mount the cdrom it booted from?

yes, just pass rootcd=1 as a boot command line option with the hack below
applied. Make sure that cdrom support is always compiled statically,
otherwise it will break.

--- 2418-/drivers/cdrom/cdrom.c	Fri Nov 16 18:14:08 2001
+++ 2418-rootparam/drivers/cdrom/cdrom.c	Tue Mar 12 00:29:54 2002
@@ -2480,6 +2480,11 @@
         return proc_dostring(ctl, write, filp, buffer, lenp);
 }

+kdev_t get_cdrom_dev(void)
+{
+	return topCdromPtr ? topCdromPtr->dev : 0;
+}
+
 /* Unfortunately, per device settings are not implemented through
    procfs/sysctl yet. When they are, this will naturally disappear. For now
    just update all drives. Later this will become the template on which
--- 2418-/init/main.c	Mon Feb 25 19:38:13 2002
+++ 2418-rootparam/init/main.c	Tue Mar 12 00:29:54 2002
@@ -311,6 +311,16 @@

 __setup("root=", root_dev_setup);

+static int rootcd_enable __initdata = 0;
+
+static int __init rootcd_setup(char *str)
+{
+	get_option(&str, &rootcd_enable);
+	return 1;
+}
+
+__setup("rootcd=", rootcd_setup);
+
 static int __init checksetup(char *line)
 {
 	struct kernel_param *p;
@@ -772,6 +782,10 @@
 	rd_load();
 #endif

+	if (rootcd_enable) {
+		extern kdev_t get_cdrom_dev(void);
+		ROOT_DEV = get_cdrom_dev();
+	}
 	/* Mount the root filesystem.. */
 	mount_root();


