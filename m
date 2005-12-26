Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbVLZHnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbVLZHnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 02:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbVLZHnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 02:43:11 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:8881 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751038AbVLZHnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 02:43:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=IPVAbh34Mzk/onXNAHo4102Q2IFxa/Z2vhTTuNrAo0TazsFApKuvQCEVjkQb46uQk+ML69/BOYeQqG6MDtOcYXkbtKqkC0OKzLXmx1BpQCmOXsyJ9sw1QuOuOT1QHYb+expWQ6Ex8zz053YukJ3+cQLSf1uAR9q67PJCJWW2ZKI=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: 4k stacks
Date: Mon, 26 Dec 2005 02:42:51 -0500
User-Agent: KMail/1.8.3
Cc: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com> <200512241403.38482.vda@ilport.com.ua> <200512242143.10291.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
In-Reply-To: <200512242143.10291.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512260242.52379.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I've come up with a patch to "poison"/mark the kernel stacks with Qs
when they're allocated. (I don't think it'll mark the IRQ stacks though).
I clear the marking before the stacks are freed. The patch should work
with any-sized stacks.

There is one wrinkle though: linux has struct thread_info at the bottom of
the kernel stacks, overwriting some of the Qs. stack.c needs to be modified
to skip the first sizeof(struct thread_info) bytes of a page.

DISCLAIMER: I am a novice kernel hacker: this patch may not perform as 
advertised.

signed-off-by: <andrew.j.wade@gmail.com>

diff -uprN 2.6.15-rc5-mm3/kernel/fork.c ajw/kernel/fork.c
--- 2.6.15-rc5-mm3/kernel/fork.c	2005-12-26 01:07:57.087518486 -0500
+++ ajw/kernel/fork.c	2005-12-26 01:12:24.281198483 -0500
@@ -43,6 +43,7 @@
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/string.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -102,6 +103,7 @@ static kmem_cache_t *mm_cachep;
 
 void free_task(struct task_struct *tsk)
 {
+	memset(tsk->thread_info, 0, THREAD_SIZE);
 	free_thread_info(tsk->thread_info);
 	free_task_struct(tsk);
 }
@@ -171,6 +173,8 @@ static struct task_struct *dup_task_stru
 		return NULL;
 	}
 
+	memset(ti, 'Q', THREAD_SIZE);
+
 	*tsk = *orig;
 	tsk->thread_info = ti;
 	setup_thread_stack(tsk, orig);
