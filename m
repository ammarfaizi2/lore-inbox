Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbTKLLuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 06:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbTKLLuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 06:50:23 -0500
Received: from ns.suse.de ([195.135.220.2]:226 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262034AbTKLLuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 06:50:22 -0500
Date: Wed, 12 Nov 2003 12:50:21 +0100
From: Michael Schroeder <mls@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6 early userspace init
Message-ID: <20031112115021.GA24875@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 2048G/BBC5057B
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,

how about adding something like this to init/do_mounts.c?

--- do_mounts.c.orig	2003-11-12 12:49:12.000000000 +0100
+++ do_mounts.c	2003-11-12 12:02:05.000000000 +0100
@@ -14,6 +14,7 @@
 #include "do_mounts.h"
 
 extern int get_filesystem_list(char * buf);
+extern asmlinkage long sys_access(const char * filename, int mode);
 
 int __initdata rd_doload;	/* 1 = load RAM disk, 0 = don't load */
 
@@ -393,6 +394,13 @@
 	if (initrd_load())
 		goto out;
 
+	/*
+	 * check if there is an early userspace init, if yes
+	 * let it do all the work
+	 */
+	if (sys_access("/sbin/init", 0) == 0)
+		goto out;
+
 	if (is_floppy && rd_doload && rd_load_disk(0))
 		ROOT_DEV = Root_RAM0;
 
I wont to be able to fetch the boot= parameter via /proc/cmdline
in kinit and choose the boot devices, so I dislike the boot=0:0
suggestion.

Also, should the above code clear the init= parameter, i.e.
main.c:execute_command?

Cheers,
  Michael.

-- 
Michael Schroeder                                   mls@suse.de
main(_){while(_=~getchar())putchar(~_-1/(~(_|32)/13*2-11)*13);}
