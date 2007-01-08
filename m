Return-Path: <linux-kernel-owner+w=401wt.eu-S1161315AbXAHPhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161315AbXAHPhg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 10:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161317AbXAHPhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 10:37:36 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:47298 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161315AbXAHPhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 10:37:35 -0500
Date: Mon, 8 Jan 2007 21:07:26 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070108153726.GB31263@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106111117.54bb2307.akpm@osdl.org> <20070107110013.GD13579@in.ibm.com> <20070107115957.6080aa08.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107115957.6080aa08.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 11:59:57AM -0800, Andrew Morton wrote:
> > How would this provide a stable access to cpu_online_map in functions
> > that need to block while accessing it (as flush_workqueue requires)?
> 
> If a thread simply blocks, that will not permit a cpu plug/unplug to proceed.
> 
> The thread had to explicitly call try_to_freeze().  CPU plug/unplug will
> not occur (and cpu_online_map will not change) until every process in the
> machine has called try_to_freeze()).

Maybe my misunderstanding of the code, but:

Looking at the code, it seems to me that try_to_freeze() will be called very 
likely from the signal-delivery path (get_signal_to_deliver()). Isnt
that correct? If so, consider a thread as below:


 Thread1 :
	for_each_online_cpu() { online_map = 0x1111 at this point }
		do_some_thing();
			kmalloc(); <- blocks


Can't Thread1 be frozen in the above blocking state w/o it voluntarily 
calling try_to_freeze?  If so, online_map can change when it returns
from kmalloc() ..

> So the problem which you're referring to will only occur if a workqueue
> callback function calls try_to_freeze(), which would be mad.
> 
> 
> Plus flush_workqueue() is on the way out.  We're slowly edging towards a
> working cancel_work() which will only block if the work which you're trying
> to cancel is presently running.  With that, pretty much all the
> flush_workqueue() calls go away, and all these accidental rarely-occurring
> deadlocks go away too.

Fundamentally, I think it is important to give the ability to block
concurrent hotplug operations from happening ..

-- 
Regards,
vatsa
