Return-Path: <linux-kernel-owner+w=401wt.eu-S1752749AbXACBQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbXACBQ5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 20:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbXACBQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 20:16:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:17316 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752749AbXACBQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 20:16:56 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,228,1165219200"; 
   d="scan'208"; a="180830255:sNHT20014869"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Zach Brown'" <zach.brown@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>, "'Benjamin LaHaise'" <bcrl@kvack.org>,
       <suparna@in.ibm.com>
Subject: RE: [patch] aio: add per task aio wait event condition
Date: Tue, 2 Jan 2007 17:16:55 -0800
Message-ID: <000d01c72ed4$dbc78920$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Accu0QSbqSB3jbH+QduypfJ99uEZIQAAv7+g
In-Reply-To: <0DF58573-AC11-4732-B48C-76401C1A222D@oracle.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote on Tuesday, January 02, 2007 4:49 PM
> On Dec 29, 2006, at 6:31 PM, Chen, Kenneth W wrote:
> > This patch adds a wait condition to the wait queue and only wake-up
> > process when that condition meets.  And this condition is added on a
> > per task base for handling multi-threaded app that shares single  
> > ioctx.
> 
> But only one of the waiting tasks is tested, the one at the head of  
> the list.  It looks like this change could starve a io_getevents()  
> with a low min_nr in the presence of another io_getevents() with a  
> larger min_nr.
> 
> > +	if (waitqueue_active(&ctx->wait)) {
> > +		struct aio_wait_queue *wait;
> > +		wait = container_of(ctx->wait.task_list.next,
> > +				    struct aio_wait_queue, wait.task_list);
> > +		if (nr_evt >= wait->nr_wait)
> > +			wake_up(&ctx->wait);
> > +	}
> 
> First is the fear of starvation as mentioned previously.
> 
> issue 2 ops
> first io_getevents sleeps with a min_nr of 2
> second io_getevents sleeps with min_nr of 3
> 2 ops complete but only test the second sleeper's min_nr of 3
> first sleeper twiddles thumbs

That is not possible because when multiple tasks waiting for events, they
enter the wait queue in FIFO order, prepare_to_wait_exclusive() does
__add_wait_queue_tail().  So first io_getevents() with min_nr of 2 will
be woken up when 2 ops completes.

