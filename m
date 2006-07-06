Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbWGFDAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbWGFDAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 23:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbWGFDAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 23:00:36 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:42908 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965145AbWGFDAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 23:00:35 -0400
Date: Wed, 5 Jul 2006 20:00:34 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix poll() nfds check.
Message-ID: <Pine.LNX.4.58.0607051949460.6604@shell3.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a trivial patch to fix the nfds check in the poll system call
implementation. Namely, OPEN_MAX no longer does anything important in
the kernel, and checking that nfds is greater than max_fdset AND greater
than OPEN_MAX therefore just seems wrong.

This brings up a slightly-tangential question: Why do the nfds checks
exist in select()/poll()? They're not strictly necessary, since bad
input will be caught later when we validate all the fds, one by one.
Furthermore, these checks optimize the handling of error cases (which
should be uncommon) while pessimizing correct usage of the syscalls
(which should be more common).

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -Npru linux-2.6.17-git25/fs/select.c linux-new/fs/select.c
--- linux-2.6.17-git25/fs/select.c	2006-07-05 19:06:56.000000000 -0700
+++ linux-new/fs/select.c	2006-07-05 19:10:51.000000000 -0700
@@ -671,7 +671,7 @@ int do_sys_poll(struct pollfd __user *uf
 	fdt = files_fdtable(current->files);
 	max_fdset = fdt->max_fdset;
 	rcu_read_unlock();
-	if (nfds > max_fdset && nfds > OPEN_MAX)
+	if (nfds > max_fdset)
 		return -EINVAL;

 	poll_initwait(&table);
