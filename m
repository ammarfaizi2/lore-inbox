Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWGEJbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWGEJbm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 05:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWGEJbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 05:31:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51098 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932412AbWGEJbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 05:31:41 -0400
Date: Wed, 5 Jul 2006 02:31:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-Id: <20060705023120.2b70add6.akpm@osdl.org>
In-Reply-To: <20060705084914.GA8798@elte.hu>
References: <20060705084914.GA8798@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 10:49:14 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> Subject: uninline init_waitqueue_*() functions
> From: Ingo Molnar <mingo@elte.hu>
> 
> some wait.h inlines are way too large: init_waitqueue_entry() and
> init_waitqueue_func_entry() generate 20-30 bytes of inlined code
> per call site, and init_waitqueue_head() is 30-40 bytes (on x86).

20-30 bytes for

> -static inline void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p)
> -{
> -	q->flags = 0;
> -	q->private = p;
> -	q->func = default_wake_function;
> -}

seem too much.

This:

--- a/fs/select.c~a
+++ a/fs/select.c
@@ -129,6 +129,7 @@ static void __pollwait(struct file *filp
 	entry->filp = filp;
 	entry->wait_address = wait_address;
 	init_waitqueue_entry(&entry->wait, current);
+	init_waitqueue_entry(&entry->wait, current);
 	add_wait_queue(wait_address,&entry->wait);
 }
 

Increases fs/select.o by only seven bytes.


And this:

diff -puN fs/select.c~a fs/select.c
--- a/fs/select.c~a
+++ a/fs/select.c
@@ -128,7 +128,7 @@ static void __pollwait(struct file *filp
 	get_file(filp);
 	entry->filp = filp;
 	entry->wait_address = wait_address;
-	init_waitqueue_entry(&entry->wait, current);
+	xxinit_waitqueue_entry(&entry->wait, current);
 	add_wait_queue(wait_address,&entry->wait);
 }
 
_

shrinks fs/select.o by eight bytes.  (More than I expected).  So it does
appear to be a space win, but a pretty slim one.

