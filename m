Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263131AbTCYR3l>; Tue, 25 Mar 2003 12:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263107AbTCYR2h>; Tue, 25 Mar 2003 12:28:37 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:63867 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263111AbTCYR2a>; Tue, 25 Mar 2003 12:28:30 -0500
Date: Tue, 25 Mar 2003 17:39:40 GMT
Message-Id: <200303251739.h2PHdeDa006902@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 4/8] 2.4: Throttle ENOMEM warnings more aggressively.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The VM can fail normal allocations quite often under severe load.  The
VFS just ignores this in getblk, retrying silently, but ext3 emits a
warning; the patch just makes them a bit less frequent.

--- linux-2.4-ext3push/fs/jbd/journal.c.=K0003=.orig	2003-03-25 10:59:15.000000000 +0000
+++ linux-2.4-ext3push/fs/jbd/journal.c	2003-03-25 10:59:15.000000000 +0000
@@ -1660,7 +1660,7 @@ void * __jbd_kmalloc (char *where, size_
 		 * messages. */
 		jbd_debug(1, "ENOMEM in %s, retrying.\n", where);
 
-		if (time_after(jiffies, last_warning + 5*HZ)) {
+		if (time_after(jiffies, last_warning + 120*HZ)) {
 			printk(KERN_NOTICE
 			       "ENOMEM in %s, retrying.\n", where);
 			last_warning = jiffies;
