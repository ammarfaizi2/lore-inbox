Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbUKKQ0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbUKKQ0G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 11:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbUKKQ0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 11:26:06 -0500
Received: from asplinux.ru ([195.133.213.194]:28172 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S262270AbUKKQY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 11:24:56 -0500
Message-ID: <419392D0.3050102@sw.ru>
Date: Thu, 11 Nov 2004 19:26:56 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH]: 4/4GB: Incorrect bound check in do_getname()
Content-Type: multipart/mixed;
 boundary="------------040801000603030500010508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040801000603030500010508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes incorrect address range check in do_getname().
Theoretically this can lead to do_getname() failure on kernel
address space string on the TASK_SIZE boundary addresses when
4GB split is ON.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Kirill

P.S. These 4GB split patches are against modified 2.6.8.1 kernel, but 
should be appliable to last Fedora kernels

--------------040801000603030500010508
Content-Type: text/plain;
 name="diff-arch-4gb-getname"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-arch-4gb-getname"

--- linux-2.6.8.1.test/fs/namei.c.tasksize	2003-08-28 21:38:41.000000000 +0400
+++ linux-2.6.8.1.test/fs/namei.c	2003-09-11 16:02:04.000000000 +0400
@@ -106,11 +106,12 @@
 	int retval;
 	unsigned long len = PATH_MAX;
 
-	if ((unsigned long) filename >= TASK_SIZE) {
-		if (!segment_eq(get_fs(), KERNEL_DS))
+	if (!segment_eq(get_fs(), KERNEL_DS)) {
+		if ((unsigned long) filename >= TASK_SIZE)
 			return -EFAULT;
-	} else if (TASK_SIZE - (unsigned long) filename < PATH_MAX)
-		len = TASK_SIZE - (unsigned long) filename;
+		if (TASK_SIZE - (unsigned long) filename < PATH_MAX)
+			len = TASK_SIZE - (unsigned long) filename;
+	}
 
 	retval = strncpy_from_user((char *)page, filename, len);
 	if (retval > 0) {

--------------040801000603030500010508--

