Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263589AbUECFfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbUECFfa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 01:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbUECFfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 01:35:30 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:33035 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263589AbUECFfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 01:35:18 -0400
Date: Mon, 3 May 2004 07:34:18 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Bill Catlan <wcatlan@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible to delay boot process to boot from USB subsystem?
Message-ID: <20040503053418.GB10228@alpha.home.local>
References: <003201c4309c$fd93cd90$0202a8c0@boxa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003201c4309c$fd93cd90$0202a8c0@boxa>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I include the following patch in all my kernels. It adds a "setuptime" boot
option which allows one to specify how many milliseconds to wait before
mounting the root FS. I usually wait 2500 ms to boot on USB flash, but I
once saw a machine which required a bit more (4 sec). The advantage is that
if it isn't enough, just reboot and change the paramter.

Regards,
Willy


diff -urN linux-2.4.23-rc3/init/main.c linux-2.4.23-rc3-setuptime/init/main.c
--- linux-2.4.23-rc3/init/main.c	Fri Oct 10 08:47:16 2003
+++ linux-2.4.23-rc3-setuptime/init/main.c	Sun Nov 23 18:12:19 2003
@@ -127,6 +127,7 @@
 
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
+static int setuptime;	/* time(ms) to let devices set up before root mount */
 
 static int __init profile_setup(char *str)
 {
@@ -137,6 +138,15 @@
 
 __setup("profile=", profile_setup);
 
+static int __init setuptime_setup(char *str)
+{
+    int par;
+    if (get_option(&str,&par)) setuptime = par;
+	return 1;
+}
+
+__setup("setuptime=", setuptime_setup);
+
 static int __init checksetup(char *line)
 {
 	struct kernel_param *p;
@@ -553,12 +563,26 @@
 
 extern void prepare_namespace(void);
 
+static int finish_setup()
+{
+	int tleft;
+	if (setuptime) {
+		printk("Waiting %d ms for devices to set up.\n", setuptime);
+		tleft = setuptime * HZ / 1000;
+		while (tleft) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			tleft = schedule_timeout(tleft);
+		}
+	}
+}
+
 static int init(void * unused)
 {
 	struct files_struct *files;
 	lock_kernel();
 	do_basic_setup();
 
+	finish_setup();
 	prepare_namespace();
 
 	/*


