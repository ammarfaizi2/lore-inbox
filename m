Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbVK2HRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbVK2HRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 02:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVK2HRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 02:17:24 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:11463 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751339AbVK2HRY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 02:17:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Pc/I3KIiLe2CoLQZbTU06aJxx6OhjH4BkVBtJrlne87trs8UgHU1z3CE9mGdH/2BzVSGiUHPjifrf8a3UR1dN4FXETthKMmLv2559MlKQBaPJTdy3RP7l6W2TVVc8Qs9h+ZHfTvNJDswuVw3UxPuFU2//ih1rK8d6fNh7XXlp9k=
Message-ID: <121a28810511282317j47a90f6t@mail.gmail.com>
Date: Tue, 29 Nov 2005 08:17:22 +0100
From: Grzegorz Nosek <grzegorz.nosek@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] race condition in procfs
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found a race condition in procfs on SMP systems. The result is an
oops in processes like pidof. Apparently ->proc_read() gets passed a
potentially NULL pointer. The following micro-patch seems to fix it.

Best regards,
 Grzegorz Nosek

--- linux-2.6/fs/proc/base.c.orig 2005-11-25 00:07:43.000000000 +0100
+++ linux-2.6/fs/proc/base.c      2005-11-28 11:44:11.000000000 +0100
@@ -718,6 +718,9 @@
       ssize_t length;
       struct task_struct *task = proc_task(inode);

+       if (!task)
+               return -ENOENT;
+
       if (count > PROC_BLOCK_SIZE)
               count = PROC_BLOCK_SIZE;
       if (!(page = __get_free_page(GFP_KERNEL)))
