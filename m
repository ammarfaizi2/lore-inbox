Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWHARS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWHARS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbWHARS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:18:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:62333 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750959AbWHARS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:18:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=QvXEn6vvT1rkCACj1PZ4zC0W6vL3H44mJzBgu+cNrUX3io4dF2vwGSl5JrG3180iwi2M7sUfU95/Tnwhe47Jy5u2wINXa3dKeumJ/0ZWI2Kn3KBUQTduBnqREfHsBKrhjAZcoutEvb95OYxv2+bX51UKU9VaiFy9JWXat2CmaCw=
Date: Wed, 2 Aug 2006 01:20:24 +0800
From: kenny <nek.in.cn@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [Patch] kernel: bug fixing for kernel/kmod.c
Message-ID: <20060801172024.GA24303@kenny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think there is a bug in kmod.c. In __call_usermodehelper(), when 
kernel_thread(wait_for_helper, ...) return success, since
wait_for_helper() might call complete() at any time, the sub_info should
not be used any more.

the following patch is made in 2.6.17.7

--- kmod.c      2006-07-25 11:36:01.000000000 +0800
+++ /tmp/kmod.c 2006-08-02 01:01:42.702054000 +0800
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
