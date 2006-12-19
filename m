Return-Path: <linux-kernel-owner+w=401wt.eu-S932513AbWLSAnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWLSAnc (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWLSAnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:43:32 -0500
Received: from mail.screens.ru ([213.234.233.54]:59341 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932513AbWLSAnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:43:31 -0500
Date: Tue, 19 Dec 2006 03:43:19 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-ID: <20061219004319.GA821@tv-sign.ru>
References: <20061217223416.GA6872@tv-sign.ru> <20061218162701.a3b5bfda.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061218162701.a3b5bfda.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18, Andrew Morton wrote:
>
> On Mon, 18 Dec 2006 01:34:16 +0300
> Oleg Nesterov <oleg@tv-sign.ru> wrote:
> 
> > NOTE: I removed 'int cpu' parameter, flush_workqueue() locks/unlocks
> > workqueue_mutex unconditionally. It may be restored, but I think it
> > doesn't make much sense, we take the mutex for the very short time,
> > and the code becomes simpler.
> > 
> 
> Taking workqueue_mutex() unconditionally in flush_workqueue() means
> that we'll deadlock if a single-threaded workqueue callback handler calls
> flush_workqueue().

Well. But flush_workqueue() drops workqueue_mutex before going to sleep ?

	flush_workqueue(single_threaded_wq);
		...
		mutex_lock(&workqueue_mutex);
		...
		mutex_unlock(&workqueue_mutex);
		wait_for_completition();
							handler runs,
							calls flush_workqueue(),
							workqueue_mutex is free
							
> It's an idiotic thing to do, but I think I spotted a site last week which
> does this.  scsi?  Not sure..

Ok, it is time to sleep. I'll look tomorrov and re-send if flush_cpu_workqueue()
really needs "bool workqueue_mutex_is_locked" parameter.

Oleg.

