Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbUL3HZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbUL3HZO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 02:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUL3HZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 02:25:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:430 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261558AbUL3HZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 02:25:07 -0500
Date: Wed, 29 Dec 2004 23:25:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andres Salomon <dilinger@voxel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel_read result fixes
Message-Id: <20041229232502.0549b408.akpm@osdl.org>
In-Reply-To: <1103873064.5994.6.camel@localhost>
References: <1103873064.5994.6.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andres Salomon <dilinger@voxel.net> wrote:
>
> A few potential vulnerabilities were pointed out by Katrina Tsipenyuk in
>  <http://seclists.org/lists/linux-kernel/2004/Dec/1878.html>.  I haven't
>  seen any discussion or fixes of the issue yet, so here's a patch
>  (against 2.6.9).  The fixes are along the same lines as the previous
>  binfmt_elf fixes.  There's one additional place (inside fs/binfmt_som.c)
>  that a fix could be applied, but since that doesn't compile anyways, I
>  didn't see a point in patching it.

This patch is very wrong.

--- 25/fs/exec.c~kernel_read-result-fixes	2004-12-27 00:39:57.999820768 -0800
+++ 25-akpm/fs/exec.c	2004-12-27 00:39:58.007819552 -0800
@@ -1028,8 +1028,11 @@ int search_binary_handler(struct linux_b
 		bprm->file = file;
 		bprm->loader = loader;
 		retval = prepare_binprm(bprm);
-		if (retval<0)
+		if (retval != BINPRM_BUF_SIZE) {
+			if (retval >= 0)
+				retval = -EIO;
 			return retval;
+		}

prepare_binprm() can and will return values less than 128 if the
executable's file is less than 128 bytes in size.

	linux:/home/akpm> egrep
	zsh: Input/output error: egrep
	linux:/home/akpm> cat /bin/egrep
	#!/bin/sh
	exec /bin/grep -E ${1+"$@"}
	linux:/home/akpm> 
