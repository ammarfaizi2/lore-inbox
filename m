Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWGHCLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWGHCLi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 22:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWGHCLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 22:11:37 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:47013 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932481AbWGHCLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 22:11:37 -0400
Date: Fri, 7 Jul 2006 19:11:36 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: akpm@osdl.org
cc: drepper@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove OPEN_MAX check from poll() syscall.
Message-ID: <Pine.LNX.4.58.0607071904400.4243@shell2.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch removes the OPEN_MAX component of the 'nfds' validity check
within the poll() system call implementation. Although this change will
be visible to userspace, I'll quote Ulrich Drepper for the rationale
behind its validity:

<quote>
[The requirement that EINVAL must be returned if nfds is greater than
OPEN_MAX] must be treated the same way as the EMFILE error in open():
ignore the OPEN_MAX limit if ulimit says so. The question is what to do
if the ulimit < OPEN_MAX. POSIX does not require OPEN_MAX to be the
exact limit.

So, I think removing the OPEN_MAX comparison is the correct way to do
this here. If somebody wants strict POSIX compliance they have to set
ulimit -n to 256.
</quote>

Please apply.

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -Npru linux-2.6.18-rc1/fs/select.c linux-new/fs/select.c
--- linux-2.6.18-rc1/fs/select.c	2006-07-06 20:21:05.000000000 -0700
+++ linux-new/fs/select.c	2006-07-06 20:22:58.000000000 -0700
@@ -671,7 +671,7 @@ int do_sys_poll(struct pollfd __user *uf
 	fdt = files_fdtable(current->files);
 	max_fdset = fdt->max_fdset;
 	rcu_read_unlock();
-	if (nfds > max_fdset && nfds > OPEN_MAX)
+	if (nfds > max_fdset)
 		return -EINVAL;

 	poll_initwait(&table);
