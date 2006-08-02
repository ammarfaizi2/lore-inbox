Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWHBO32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWHBO32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 10:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWHBO32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 10:29:28 -0400
Received: from mx1.dg.gov.cn ([61.145.199.108]:18693 "HELO dg.gov.cn")
	by vger.kernel.org with SMTP id S1750886AbWHBO31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 10:29:27 -0400
Date: Wed, 2 Aug 2006 22:30:46 +0800
From: Kenneth Lee <kenlee@dg.gov.cn>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] kernel: bug fixing for kernel/kmod.c
Message-ID: <20060802143046.GA5645@kenny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Signed-off-by: Kenneth Lee <kenlee@dg.gov.cn>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think there is a bug in kmod.c: In __call_usermodehelper(), when 
kernel_thread(wait_for_helper, ...) return success, since
wait_for_helper() might call complete() at any time, the sub_info should
not be used any more.

Normally wait_for_helper() take a long time to finish, you may not get 
problem for most of the case. But if you remove /sbin/modprobe, it may
become easier for you to get a oop in khelper.

the following patch is made in 2.6.17.7

--- linux-2.6.17.7/kernel/kmod.c.orig   2006-08-02 22:13:21.805902750
+0800
+++ linux-2.6.17.7/kernel/kmod.c        2006-08-02 22:15:36.946348500
+0800
@@ -198,6 +198,7 @@ static void __call_usermodehelper(void *
 {
        struct subprocess_info *sub_info = data;
        pid_t pid;
+       int wait = sub_info->wait;

        /* CLONE_VFORK: wait until the usermode helper has execve'd
         * successfully We need the data structures to stay around
@@ -212,7 +213,7 @@ static void __call_usermodehelper(void *
        if (pid < 0) {
                sub_info->retval = pid;
                complete(sub_info->complete);
-       } else if (!sub_info->wait)
+       } else if (!wait)
                complete(sub_info->complete);
 }

-- 
