Return-Path: <linux-kernel-owner+w=401wt.eu-S932566AbWLSAvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWLSAvu (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWLSAvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:51:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36841 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932566AbWLSAvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:51:48 -0500
Date: Mon, 18 Dec 2006 16:51:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC rc1-mm1] implement flush_work()
Message-Id: <20061218165119.8cd8e7e4.akpm@osdl.org>
In-Reply-To: <20061218201714.GA501@tv-sign.ru>
References: <20061218201714.GA501@tv-sign.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 23:17:14 +0300
Oleg Nesterov <oleg@tv-sign.ru> wrote:

> Add ->current_work to the "struct cpu_workqueue_struct", it points to
> currently running "struct queue_work". When flush_work(work) detects
> ->current_work == work, it inserts a barrier at the _head_ of ->worklist
> (and thus right _after_ that work) and waits for completition. This means
> that the next work fired on that CPU will be this barrier, or another
> barrier queued by concurrent flush_work(), so the caller of flush_work()
> will be woken before any "regular" work has a chance to run.
> 
> Since __queue_work() does both set_wq_data() and list_add_tail() atomically
> under cwq->lock, flush_work() can remove the pending work from queue when
> it sees "get_wq_data(work) == cwq".

Seems sane.

> NOTE: flush_work() doesn't like no-auto-release works. Unless they go away
> we can fix this later or add the "don't do this" comment.

Yes, let's make the _NAR stuff go away pleeeeze.  It's fairly
straightforward, and is on my todo list somewhere.
