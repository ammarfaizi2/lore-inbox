Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267674AbTAaCQN>; Thu, 30 Jan 2003 21:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267682AbTAaCQN>; Thu, 30 Jan 2003 21:16:13 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:42759 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S267674AbTAaCQM>;
	Thu, 30 Jan 2003 21:16:12 -0500
Date: Fri, 31 Jan 2003 03:21:51 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Samuel Flory <sflory@rackable.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Wesley Wright <wewright@verizonmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB HardDisk Booting 2.4.20
Message-ID: <20030131022151.GA25068@alpha.home.local>
References: <1043947657.7725.32.camel@steven> <1043952432.31674.22.camel@irongate.swansea.linux.org.uk> <3E39A895.9000602@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E39A895.9000602@rackable.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 02:35:01PM -0800, Samuel Flory wrote:
>  The problem I've seen is there is a several second delay before the 
> usb device is availble.  My solution was to stick a sleep in my initrd 
> before attempting to mount /.  A more rational patch might be to retry 
> mounting / after a few seconds delay before giving up.  I think I saw 
> patch doing this on the usb list.

Hello !

I'm personnaly using this simple patch with success with an usb disk on
key. It adds an option "setuptime" which waits the requested amount of ms
before booting. I use it with "setuptime=2500" and my USB works fine.

I think it could be of a more general use, and perhaps it could be
accepted into mainstream if it doesn't break anything ?

Cheers,
Willy


--- linux-21pre/init/main.c	Sat Dec 21 16:53:09 2002
+++ linux-21pre-usb/init/main.c	Sat Dec 21 17:35:50 2002
@@ -126,6 +126,7 @@
 
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
+static int setuptime;	/* time(ms) to let devices set up before root mount */
 
 static int __init profile_setup(char *str)
 {
@@ -136,6 +137,15 @@
 
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
@@ -546,11 +556,25 @@
 
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
 	lock_kernel();
 	do_basic_setup();
 
+	finish_setup();
 	prepare_namespace();
 
 	/*

