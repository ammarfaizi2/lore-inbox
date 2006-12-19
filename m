Return-Path: <linux-kernel-owner+w=401wt.eu-S1754780AbWLSA1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbWLSA1g (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754770AbWLSA1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:27:36 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35078 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780AbWLSA1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:27:35 -0500
Date: Mon, 18 Dec 2006 16:27:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-Id: <20061218162701.a3b5bfda.akpm@osdl.org>
In-Reply-To: <20061217223416.GA6872@tv-sign.ru>
References: <20061217223416.GA6872@tv-sign.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 01:34:16 +0300
Oleg Nesterov <oleg@tv-sign.ru> wrote:

> Remove ->remove_sequence, ->insert_sequence, and ->work_done from
> struct cpu_workqueue_struct. To implement flush_workqueue() we can
> queue a barrier work on each CPU and wait for its completition.

Seems sensible.  I seem to recall considering doing it that way when I
initially implemeted flush_workqueue(), but I don't recall why I didn't do
this.  hmm.

> We don't need to worry about CPU going down while we are are sleeping
> on the completition. take_over_work() will move this work on another
> CPU, and the handler will wake up us eventually.
> 
> NOTE: I removed 'int cpu' parameter, flush_workqueue() locks/unlocks
> workqueue_mutex unconditionally. It may be restored, but I think it
> doesn't make much sense, we take the mutex for the very short time,
> and the code becomes simpler.
> 

Taking workqueue_mutex() unconditionally in flush_workqueue() means
that we'll deadlock if a single-threaded workqueue callback handler calls
flush_workqueue().

It's an idiotic thing to do, but I think I spotted a site last week which
does this.  scsi?  Not sure..
