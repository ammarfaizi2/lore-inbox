Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266246AbUARH2b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 02:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUARH2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 02:28:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:43414 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266246AbUARH23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 02:28:29 -0500
Date: Sat, 17 Jan 2004 23:28:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: serge <33554432@mtu-net.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1] oops in load_elf_binary()
Message-Id: <20040117232854.2b1a65f1.akpm@osdl.org>
In-Reply-To: <87brp23zvm.fsf@mtu-net.ru>
References: <87brp23zvm.fsf@mtu-net.ru>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

serge <33554432@mtu-net.ru> wrote:
>
>  The output is:
> 
>  ------------------------------------------------------------------------------
>  Unable to handle kernel paging request at virtual address ffffffe4

We're doing fput(NULL) on a error path, after set_brk() failed.

--- 25/fs/binfmt_elf.c~elf-oops-fix	2004-01-17 23:07:21.000000000 -0800
+++ 25-akpm/fs/binfmt_elf.c	2004-01-17 23:07:29.000000000 -0800
@@ -863,7 +863,8 @@ out:
 	/* error cleanup */
 out_free_dentry:
 	allow_write_access(interpreter);
-	fput(interpreter);
+	if (interpreter)
+		fput(interpreter);
 out_free_interp:
 	if (elf_interpreter)
 		kfree(elf_interpreter);

_

