Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266954AbUAXPRr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 10:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266955AbUAXPRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 10:17:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10198 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266954AbUAXPRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 10:17:45 -0500
Date: Sat, 24 Jan 2004 10:17:42 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: viro@parcelfarce.linux.theplanet.co.uk
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Zero last byte of mount option page.
Message-ID: <Xine.LNX.4.44.0401241009320.22495-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

Here's a patch which zeroes the last byte of the mount option data copied 
from userspace during mount(2).

For filesystems which parse mount options as strings (the majority), lack 
of a zero terminator could cause the page to be overrun.  The source code 
comments specify that the maximum size of the mount data is PAGE_SIZE-1, 
so this patch will not affect any valid binary-formatted mount data.

Patch is against 2.6.2-rc1-mm2, and also applies to recent 2.4.

- James
-- 
James Morris
<jmorris@redhat.com>

diff -urN -X dontdiff linux-2.6.2-rc1-mm2.o/fs/namespace.c linux-2.6.2-rc1-mm2.w/fs/namespace.c
--- linux-2.6.2-rc1-mm2.o/fs/namespace.c	2004-01-23 14:30:05.000000000 -0500
+++ linux-2.6.2-rc1-mm2.w/fs/namespace.c	2004-01-24 09:46:52.000919520 -0500
@@ -763,6 +763,9 @@
 	if (dev_name && !memchr(dev_name, 0, PAGE_SIZE))
 		return -EINVAL;
 
+	if (data_page)
+		((char *)data_page)[PAGE_SIZE - 1] = 0;
+
 	/* Separate the per-mountpoint flags */
 	if (flags & MS_NOSUID)
 		mnt_flags |= MNT_NOSUID;

