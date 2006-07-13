Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWGMBQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWGMBQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 21:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWGMBQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 21:16:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48312 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932482AbWGMBQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 21:16:40 -0400
Date: Wed, 12 Jul 2006 18:16:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-git4 and 2.6.18-rc1-mm1 OOM's on boot
Message-Id: <20060712181636.d7cbbb99.akpm@osdl.org>
In-Reply-To: <44B528F4.6080409@google.com>
References: <44B528F4.6080409@google.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 09:53:08 -0700
Martin Bligh <mbligh@google.com> wrote:

> -git3 was fine
> (bootlog for git3: http://test.kernel.org/abat/40748/debug/console.log)
> 
> -mm1 has the same issue
> 
> Slightly different manifestations across 2 boots
> 
> http://test.kernel.org/abat/40760/debug/console.log
> http://test.kernel.org/abat/40837/debug/console.log

 [<c0136fcf>] out_of_memory+0x29/0xf6
 [<c0137f48>] __alloc_pages+0x1ed/0x276
 [<c014db73>] kmem_getpages+0x63/0xc1
 [<c014e960>] cache_grow+0xaa/0x139
 [<c014eb6a>] cache_alloc_refill+0x17b/0x1c0
 [<c014f1ef>] __kmalloc+0x83/0x93
 [<c0168cf5>] alloc_fd_array+0x19/0x24
 [<c0169122>] alloc_fdtable+0xb2/0xef
 [<c016917f>] expand_fdtable+0x20/0x7d
 [<c0169221>] expand_files+0x45/0x50
 [<c0161263>] locate_fd+0x70/0x8e
 [<c01612aa>] dupfd+0x29/0x61
 [<c01613dc>] sys_dup+0x1b/0x23
 [<c01027d3>] syscall_call+0x7/0xb

I suspect that's because I had me a little mistake.

--- a/fs/file.c~alloc_fdtable-expansion-fix
+++ a/fs/file.c
@@ -240,7 +240,7 @@ static struct fdtable *alloc_fdtable(int
 	if (!fdt)
   		goto out;
 
-	nfds = max_t(int, 8 * L1_CACHE_BYTES, roundup_pow_of_two(nfds));
+	nfds = max_t(int, 8 * L1_CACHE_BYTES, roundup_pow_of_two(nr + 1));
 	if (nfds > NR_OPEN)
 		nfds = NR_OPEN;
 
_

