Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVKRVUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVKRVUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbVKRVUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:20:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54188 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750957AbVKRVUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:20:19 -0500
Date: Fri, 18 Nov 2005 13:19:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm1
Message-Id: <20051118131957.3ea831c9.akpm@osdl.org>
In-Reply-To: <437E408A.8010808@reub.net>
References: <20051117111807.6d4b0535.akpm@osdl.org>
	<437D80BD.7030609@reub.net>
	<20051117234252.087fa813.akpm@osdl.org>
	<437E408A.8010808@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> I don't think I should be able to make this happen so easily though:
> 
> 
>  [root@tornado ~]# rmmod e100
>  [root@tornado ~]# rmmod sky2
>  [root@tornado ~]# strace modprobe e100
>  Unable to handle kernel NULL pointer dereference at virtual address 00000010
>    printing eip:
>  c0124fc7
>  *pde = 00000000
>  Oops: 0000 [#1]
>  PREEMPT SMP
>  last sysfs file: /class/net/eth0/flags
>  Modules linked in: nfsd exportfs lockd sunrpc autofs4 lm85 hwmon_vid eeprom ipv6 
>  binfmt_misc hw_random crc32 piix i2c_i801
>  CPU:    0
>  EIP:    0060:[<c0124fc7>]    Not tainted VLI
>  EFLAGS: 00010202   (2.6.15-rc1-mm2-preempt)
>  EIP is at ptrace_check_attach+0x14/0xaf


This might help..


Begin forwarded message:

Date: Fri, 18 Nov 2005 18:07:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc1-mm1 panic in ptrace_check_attach()


On Fri, Nov 18, 2005 at 09:56:40AM -0800, Badari Pulavarty wrote:
> Hi Andrew,
> 
> I am not sure if its already reported. I get panic in
> ptrace_check_attach() while trying to run UML on 2.6.15-rc1-mm1.
> 
> Going to try 2.6.15-rc1-mm2 now. 

Looks like 2.6.15-rc1-mm1 has total crap in ptrace_get_task_struct
(and it looks like my fault because I sent out a wrong patch).

The patch below should fix it:

Index: linux-2.6/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/kernel/ptrace.c	2005-11-18 10:25:35.000000000 +0100
+++ linux-2.6/kernel/ptrace.c	2005-11-18 10:25:54.000000000 +0100
@@ -459,7 +459,7 @@
 	read_unlock(&tasklist_lock);
 	if (!child)
 		return ERR_PTR(-ESRCH);
-	return 0;
+	return child;
 }
 
 #ifndef __ARCH_SYS_PTRACE
