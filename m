Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbTKNQj5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 11:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTKNQj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 11:39:57 -0500
Received: from ns.suse.de ([195.135.220.2]:60599 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262789AbTKNQjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 11:39:53 -0500
Date: Fri, 14 Nov 2003 17:39:52 +0100
From: Michael Schroeder <mls@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 early userspace init
Message-ID: <20031114163952.GA17972@suse.de>
References: <20031112115021.GA24875@suse.de> <1068655518.14435.37.camel@camp4.serpentine.com> <bp0t9i$ta3$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bp0t9i$ta3$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 2048G/BBC5057B
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 01:32:34PM -0800, H. Peter Anvin wrote:
> I think it's useful to maintain bass-ackwards compatibility with
> root=, especially since if any hack is put it now, it creates new
> legacy.
> 
> Looking for init, or linuxrc, inside the initramfs makes sense.  It
> should *NOT* be tied to the init= option, though... consider when all
> of this is pulled out of kernel space; you don't want "init=" to break
> finding your RAID volumes when you're trying to find a different
> "real" init binary.

Exactly. People may want to change the root partition with a
root= option, so reserving root=0:0 to flag kinit booting is
IMHO a bad idea. And init=/bin/bash should provide the user
with a mounted root.

So, how's the following patch:

--- init/do_mounts.c.orig	2003-11-12 12:49:12.000000000 +0100
+++ init/do_mounts.c	2003-11-14 17:33:49.000000000 +0100
@@ -14,6 +14,7 @@
 #include "do_mounts.h"
 
 extern int get_filesystem_list(char * buf);
+extern asmlinkage long sys_access(const char * filename, int mode);
 
 int __initdata rd_doload;	/* 1 = load RAM disk, 0 = don't load */
 
@@ -370,6 +371,17 @@
 	mount_block_root("/dev/root", root_mountflags);
 }
 
+static char *kinit_command;
+
+static int __init kinit_setup(char *str)
+{
+	kinit_command = str;
+	return 1;
+}
+
+__setup("kinit=", kinit_setup);
+
+
 /*
  * Prepare the namespace - decide what/where to mount, load ramdisks, etc.
  */
@@ -393,6 +405,16 @@
 	if (initrd_load())
 		goto out;
 
+	/*
+	 * check if there is an early userspace init, if yes
+	 * let it do all the work
+	 */
+	if (kinit_command || sys_access("/sbin/init", 0) == 0) {
+		extern char *execute_command;
+		execute_command = kinit_command ? kinit_command : 0;
+		goto out;
+	}
+
 	if (is_floppy && rd_doload && rd_load_disk(0))
 		ROOT_DEV = Root_RAM0;
 

It also adds a 'kinit' option for the brave users who really
want to specify a diffenent kinit, e.g. 'ash'.

Of course, the kinit program should also be changed to check
for a init=xxx parameter instead of kinit=xxx.

Cheers,
  Michael.

-- 
Michael Schroeder                                   mls@suse.de
main(_){while(_=~getchar())putchar(~_-1/(~(_|32)/13*2-11)*13);}
