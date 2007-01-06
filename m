Return-Path: <linux-kernel-owner+w=401wt.eu-S1751351AbXAFPMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbXAFPMF (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 10:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbXAFPMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 10:12:05 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:45047 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351AbXAFPMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 10:12:02 -0500
Date: Sat, 6 Jan 2007 20:41:53 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-ID: <20070106151153.GA24274@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061217223416.GA6872@tv-sign.ru> <20061218162701.a3b5bfda.akpm@osdl.org> <20061219004319.GA821@tv-sign.ru> <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070105085634.GB18088@in.ibm.com> <20070105124246.GA83@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070105124246.GA83@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 03:42:46PM +0300, Oleg Nesterov wrote:
> preempt_disable() can't prevent cpu_up, but flush_workqueue() doesn't care
> _unless_ cpu_down also happened meantime (and hence a fresh CPU may have
> pending work_structs which were moved from a dead CPU).

Yes, that was what I had in mind.

> So you are right, we still need the patch above, but I think we don't have
> new problems with preempt_disable().

Right, preempt_disable() hasn't added any new problem. Its just
revealing the same problem as earlier, by opening up window for cpu
hotplug events to happen in the middle of flush_workqueue().

Ideally I would have liked a lock_cpu_hotplug() equivalent which blocks
all cpu hotplug events during the entire flush_workqueue(). In its
absence, I guess we just need to deal with all these ugly races ..

In summary, I think we need to go ahead with the preemp_disable() patch
in flush_workqueue() from Andrew and the race fix you posted here:

	http://lkml.org/lkml/2006/12/30/37

-- 
Regards,
vatsa
