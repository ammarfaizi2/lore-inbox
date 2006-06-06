Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWFFWk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWFFWk6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 18:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWFFWk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 18:40:58 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:24967 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751096AbWFFWk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 18:40:57 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: hpa@zytor.com
Subject: kinit problem with cciss root device
Date: Tue, 6 Jun 2006 16:40:48 -0600
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, iss_storagedev@hp.com,
       Mike Miller <mike.miller@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606061640.48644.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kinit converts "root=/dev/cciss/c0d0p1" to "cciss.c0d0", which
doesn't exist under /sys/block because register_disk() converts
"cciss/c0d0" to "cciss!c0d0" (note "!", not ".").

I don't know whether it's the *right* fix, but the patch below
makes things work.  It still doesn't make kinit exactly match
the register_disk() behavior because register_disk() only changes
the first "/" in the string.

This was a nuisance to debug because when it failed, the only
output I got was this:

  ...
  Adding console on ttyS0 at I/O port 0x3f8 (options '115200')
  Time: tsc clocksource has been installed.
  Freeing unused kernel memory: 260k freed
    argc == 4
  Kernel panic - not syncing: Attempted to kill init!
    argv[0]: "/ini 

So you might consider something like the "drain output" hunk below,
which allowed all the useful messages to get out.


Index: work-mm8/usr/kinit/kinit.c
===================================================================
--- work-mm8.orig/usr/kinit/kinit.c	2006-06-05 19:04:46.000000000 -0600
+++ work-mm8/usr/kinit/kinit.c	2006-06-06 14:19:59.000000000 -0600
@@ -317,5 +317,10 @@
 	if (mnt_sysfs)
 		umount2("/sys", 0);
 
+	/*
+	 * Allow time for messages to drain before kernel panics
+	 * because init is exiting.
+	 * */
+	sleep(10);
 	exit(ret);
 }
Index: work-mm8/usr/kinit/name_to_dev.c
===================================================================
--- work-mm8.orig/usr/kinit/name_to_dev.c	2006-06-05 19:04:46.000000000 -0600
+++ work-mm8/usr/kinit/name_to_dev.c	2006-06-06 14:19:02.000000000 -0600
@@ -151,7 +151,7 @@
 
 	for (p = s; *p; p++)
 		if (*p == '/')
-			*p = '.';
+			*p = '!';
 	res = try_name(s, 0);
 	if (res)
 		return res;
