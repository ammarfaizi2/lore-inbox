Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266845AbUIJH54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266845AbUIJH54 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 03:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUIJH5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 03:57:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:23181 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266845AbUIJH4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 03:56:52 -0400
Date: Fri, 10 Sep 2004 00:54:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc1-bk14 Oops] In groups_search()
Message-Id: <20040910005454.23bbf9fb.akpm@osdl.org>
In-Reply-To: <41415B15.1050402@bigpond.net.au>
References: <413FA9AE.90304@bigpond.net.au>
	<20040909010610.28ca50e1.akpm@osdl.org>
	<4140EE3E.5040602@bigpond.net.au>
	<20040909171450.6546ee7a.akpm@osdl.org>
	<4141092B.2090608@bigpond.net.au>
	<20040909200650.787001fc.akpm@osdl.org>
	<41413F64.40504@bigpond.net.au>
	<20040909231858.770ab381.akpm@osdl.org>
	<414149A0.1050006@bigpond.net.au>
	<20040909235217.5a170840.akpm@osdl.org>
	<41415B15.1050402@bigpond.net.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
>  Sep 10 17:22:29 mudlark kernel: Unable to handle kernel paging request at virtual address f2d8bef4
>  Sep 10 17:22:29 mudlark kernel:  printing eip:
>  Sep 10 17:22:29 mudlark kernel: c013957f
>  Sep 10 17:22:29 mudlark kernel: *pde = 00507067
>  Sep 10 17:22:29 mudlark kernel: *pte = 32d8b000
>  Sep 10 17:22:29 mudlark kernel: Oops: 0000 [#1]
>  Sep 10 17:22:29 mudlark kernel: PREEMPT DEBUG_PAGEALLOC
>  Sep 10 17:22:29 mudlark kernel: Modules linked in: tulip ohci_hcd
>  Sep 10 17:22:29 mudlark kernel: CPU:    0
>  Sep 10 17:22:29 mudlark kernel: EIP:    0060:[<c013957f>]    Not tainted VLI
>  Sep 10 17:22:30 mudlark kernel: EFLAGS: 00010082   (2.6.9-rc1-bk16) 
>  Sep 10 17:22:30 mudlark kernel: EIP is at cache_free_debugcheck+0x207/0x2a3
>  Sep 10 17:22:30 mudlark kernel: eax: f2d8bef4   ebx: 80052c00   ecx: f2d8bef8   edx: 00000ef8
>  Sep 10 17:22:32 mudlark kernel: esi: f2d3164c   edi: f2d8b000   ebp: c18ff680   esp: f2e95cfc
>  Sep 10 17:22:33 mudlark kernel: ds: 007b   es: 007b   ss: 0068
>  Sep 10 17:22:34 mudlark rc: Starting webmin:  succeeded
>  Sep 10 17:22:34 mudlark kernel: Process mount (pid: 2671, threadinfo=f2e94000 task=f2da1a60)
>  Sep 10 17:22:34 mudlark kernel: Stack: c18ff680 f2d8b000 00000000 00000246 32d8b000 c18ff680 c1903054 f2d8bef8 
>  Sep 10 17:22:34 mudlark kernel:        00000282 c013a185 c18ff680 f2d8bef8 c01b2a6d 00000000 f2d8bef8 f2d8bfe5 
>  Sep 10 17:22:34 mudlark kernel:        f2d8bef8 c01b2a6d f2d8bef8 00000041 00000800 f2fafec0 00000005 0000001f 
>  Sep 10 17:22:34 mudlark kernel: Call Trace:
>  Sep 10 17:22:34 mudlark kernel:  [<c013a185>] kfree+0x59/0x9b
>  Sep 10 17:22:34 mudlark kernel:  [<c01b2a6d>] parse_rock_ridge_inode_internal+0x1c9/0x654
>  Sep 10 17:22:34 mudlark kernel:  [<c01b2a6d>] parse_rock_ridge_inode_internal+0x1c9/0x654
>  Sep 10 17:22:34 mudlark kernel:  [<c01b3090>] parse_rock_ridge_inode+0x27/0x67

Could you see if this patch fixes the above crash?

--- 25/fs/isofs/rock.c~rock-kludge	2004-09-10 00:52:30.394468656 -0700
+++ 25-akpm/fs/isofs/rock.c	2004-09-10 00:53:14.544756792 -0700
@@ -62,7 +62,7 @@
 }                                     
 
 #define MAYBE_CONTINUE(LABEL,DEV) \
-  {if (buffer) kfree(buffer); \
+  {if (buffer) { kfree(buffer); buffer = NULL; } \
   if (cont_extent){ \
     int block, offset, offset1; \
     struct buffer_head * pbh; \
_


I sure hope it does, so I don't have to look at rock.c again.
