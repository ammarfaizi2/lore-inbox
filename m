Return-Path: <linux-kernel-owner+w=401wt.eu-S932546AbXAGOVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbXAGOVu (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 09:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbXAGOVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 09:21:50 -0500
Received: from mail.screens.ru ([213.234.233.54]:52069 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932546AbXAGOVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 09:21:49 -0500
Date: Sun, 7 Jan 2007 17:22:46 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070107142246.GA149@tv-sign.ru>
References: <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106173416.GA3771@tv-sign.ru> <20070107104328.GC13579@in.ibm.com> <20070107125603.GA74@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107125603.GA74@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07, Oleg Nesterov wrote:
>
> Thoughts?

How about:

	CPU_DEAD does nothing. After __cpu_disable() cwq->thread runs on
	all CPUs and becomes idle when it flushes cwq->worklist: nobody
	will add work_struct on that list.

	CPU_UP:
		if (!cwq->thread)
			create_workqueue_thread();
		else
			set_cpus_allowed(newcpu);

	flush_workqueue:
		for_each_possible_cpu()		// NOT online!
			if (cwq->thread)
				flush_cpu_workqueue()

Oleg.

