Return-Path: <linux-kernel-owner+w=401wt.eu-S932579AbWLSBAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWLSBAx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 20:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWLSBAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 20:00:53 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37565 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932582AbWLSBAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 20:00:52 -0500
Date: Mon, 18 Dec 2006 17:00:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-Id: <20061218170028.eaa1faf0.akpm@osdl.org>
In-Reply-To: <20061219004319.GA821@tv-sign.ru>
References: <20061217223416.GA6872@tv-sign.ru>
	<20061218162701.a3b5bfda.akpm@osdl.org>
	<20061219004319.GA821@tv-sign.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 03:43:19 +0300
Oleg Nesterov <oleg@tv-sign.ru> wrote:

> On 12/18, Andrew Morton wrote:
> >
> > On Mon, 18 Dec 2006 01:34:16 +0300
> > Oleg Nesterov <oleg@tv-sign.ru> wrote:
> > 
> > > NOTE: I removed 'int cpu' parameter, flush_workqueue() locks/unlocks
> > > workqueue_mutex unconditionally. It may be restored, but I think it
> > > doesn't make much sense, we take the mutex for the very short time,
> > > and the code becomes simpler.
> > > 
> > 
> > Taking workqueue_mutex() unconditionally in flush_workqueue() means
> > that we'll deadlock if a single-threaded workqueue callback handler calls
> > flush_workqueue().
> 
> Well. But flush_workqueue() drops workqueue_mutex before going to sleep ?
> 
> 	flush_workqueue(single_threaded_wq);
> 		...
> 		mutex_lock(&workqueue_mutex);
> 		...
> 		mutex_unlock(&workqueue_mutex);
> 		wait_for_completition();
> 							handler runs,
> 							calls flush_workqueue(),
> 							workqueue_mutex is free

Oh.  OK.  In that case we can switch to preempt_disable() for the
cpu-hotplug holdoff.  Sometime.

> > It's an idiotic thing to do, but I think I spotted a site last week which
> > does this.  scsi?  Not sure..
> 
> Ok, it is time to sleep. I'll look tomorrov and re-send if flush_cpu_workqueue()
> really needs "bool workqueue_mutex_is_locked" parameter.

Hopefully not.
