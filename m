Return-Path: <linux-kernel-owner+w=401wt.eu-S1753103AbXACBuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbXACBuz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 20:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbXACBuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 20:50:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:3864 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103AbXACBuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 20:50:54 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,228,1165219200"; 
   d="scan'208"; a="180840217:sNHT19477283"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Zach Brown'" <zach.brown@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>, "'Benjamin LaHaise'" <bcrl@kvack.org>,
       <suparna@in.ibm.com>
Subject: RE: [patch] aio: add per task aio wait event condition
Date: Tue, 2 Jan 2007 17:50:53 -0800
Message-ID: <000f01c72ed9$9a73cdd0$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Accu1c2wD/HpfitXRyiPvGTPl1ULfAAADhIg
In-Reply-To: <122AE2A2-3807-42F0-AADF-7305D66CBCE5@oracle.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote on Tuesday, January 02, 2007 5:24 PM
> > That is not possible because when multiple tasks waiting for  
> > events, they
> > enter the wait queue in FIFO order, prepare_to_wait_exclusive() does
> > __add_wait_queue_tail().  So first io_getevents() with min_nr of 2  
> > will be woken up when 2 ops completes.
> 
> So switch the order of the two sleepers in the example?

Not sure why that would be a problem though:  whoever sleep first will
be woken up first.


> The point is that there's no way to guarantee that the head of the  
> wait queue will be the lowest min_nr.

Before I challenge that semantics, I want to mention that in current
implementation, dribbling AIO events will be distributed in round robin
fashion to all pending tasks waiting in io_getevents.  In the example you
gave earlier, task with min_nr of 2 will be woken up after 4 completed
events.  I consider that as an undesirable behavior as well.

Going back to your counter argument, why do we need the lowest min_nr in
the head of the queue?  These are tasks that shares one aio ctx and ioctx
is shareable only among threads.  Any reason why round robin policy is
superior than FIFO?  Also presumably, threads that shares ioctx should be
capable of handling events for the same ioctx.

>From wakeup order point of view, yes, tasks with lowest min_nr wakes up
first, but looking from io completion order, they are not. And these are
the source of excessive ctx switch.

