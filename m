Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTJOVom (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 17:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTJOVom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 17:44:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:13282 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262055AbTJOVok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 17:44:40 -0400
Date: Wed, 15 Oct 2003 14:44:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: kakadu_croc@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7-mm1
Message-Id: <20031015144435.5a0bacf9.akpm@osdl.org>
In-Reply-To: <87smluw6e6.fsf@lapper.ihatent.com>
References: <20031015101151.11153.qmail@web40901.mail.yahoo.com>
	<20031015032215.58d832c1.akpm@osdl.org>
	<87smluw6e6.fsf@lapper.ihatent.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis <alexh@ihatent.com> wrote:
>
> Memory: 774008k/786240k available (2352k kernel code, 11468k reserved, 848k data, 180k init, 0k highmem)
> zapping low mappings.
> Debug: sleeping function called from invalid context at mm/slab.c:1869
> in_atomic():1, irqs_disabled():0
> Call Trace:
>  [<c0107000>] rest_init+0x0/0xf4
>  [<c012a40f>] __might_sleep+0xa0/0xbd
>  [<c015f39b>] kmem_cache_alloc+0x1c3/0x1c8
>  [<c0107000>] rest_init+0x0/0xf4
>  [<c015d2ec>] kmem_cache_create+0x16b/0x6a5
>  [<c04331c3>] mem_init+0x1e4/0x30d
>  [<c0107000>] rest_init+0x0/0xf4
>  [<c0435bcb>] kmem_cache_init+0x182/0x32b
>  [<c04246d2>] start_kernel+0x15d/0x280
>  [<c042444a>] unknown_bootoption+0x0/0xf8

I was thinking of simply suppressing all these early warnings:

--- 25/kernel/sched.c~might_sleep-early-bogons	Wed Oct 15 14:29:21 2003
+++ 25-akpm/kernel/sched.c	Wed Oct 15 14:31:21 2003
@@ -2855,7 +2855,7 @@ void __might_sleep(char *file, int line)
 #if defined(in_atomic)
 	static unsigned long prev_jiffy;	/* ratelimiting */
 
-	if (in_atomic() || irqs_disabled()) {
+	if (system_running && in_atomic() || irqs_disabled()) {
 		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 			return;
 		prev_jiffy = jiffies;


But really we shouldn't do that because it is possible that an early
accidental enabling of interrupts can lock the box.  That happens on ppc64
for example.

We should fix them up.


