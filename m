Return-Path: <linux-kernel-owner+w=401wt.eu-S1753839AbXACCc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbXACCc1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 21:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753846AbXACCc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 21:32:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:17850 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753839AbXACCc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 21:32:26 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,228,1165219200"; 
   d="scan'208"; a="180849056:sNHT18893252"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Zach Brown'" <zach.brown@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>, "'Benjamin LaHaise'" <bcrl@kvack.org>,
       <suparna@in.ibm.com>
Subject: RE: [patch] aio: add per task aio wait event condition
Date: Tue, 2 Jan 2007 18:32:25 -0800
Message-ID: <001101c72edf$6821f8b0$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Accu28ojKMHj5LKaSaKVV4BZ3u6TNgAAGjTw
In-Reply-To: <96568BA6-9ECD-4E1D-B5B3-3AA41463A8EE@oracle.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote on Tuesday, January 02, 2007 6:06 PM
> On Jan 2, 2007, at 5:50 PM, Chen, Kenneth W wrote:
> > Zach Brown wrote on Tuesday, January 02, 2007 5:24 PM
> >>> That is not possible because when multiple tasks waiting for
> >>> events, they
> >>> enter the wait queue in FIFO order, prepare_to_wait_exclusive() does
> >>> __add_wait_queue_tail().  So first io_getevents() with min_nr of 2
> >>> will be woken up when 2 ops completes.
> >>
> >> So switch the order of the two sleepers in the example?
> >
> > Not sure why that would be a problem though:  whoever sleep first will
> > be woken up first.
> 
> Why would the min_nr = 3 sleeper be woken up in that case?  Only 2  
> ios were issued.
> 
> Maybe the app was relying on the min_nr = 2 completion to issue 3  
> more ios for the min_nr = 3 sleeper, who knows.
> 
> Does that clear up the confusion?


Not really. I don't think I understand your concern. You gave an example:

issue 2 ops
first io_getevents sleeps with a min_nr of 2
second io_getevents sleeps with min_nr of 3
2 ops complete but only test the second sleeper's min_nr of 3
first sleeper twiddles thumbs

Or:

issue 2 ops
first io_getevents sleeps with a min_nr of 3
second io_getevents sleeps with min_nr of 2
2 ops complete but only test the second sleeper's min_nr of 2
first sleeper twiddles thumbs


First scenario doesn't exist because in the new scheme, we test first
sleeper (as in head of the queue) when 2 ops complete. It wakes up first.

2nd scenario is OK to me because first sleeper waiting for 3 events,
and there are only 2 ops completed, so it waits.

The one scenario that I can think of that breaks down is that one task
sleeps with min_nr of 100.  Then 50 ops completed.  Comes along 2nd
thread does a io_getevents and it will take all 50 events in the 2nd
thread.  Is that what you are talking about?  It doesn't involve two
sleepers.  That I can fix by testing whether wait queue is active or
not at the beginning of fast path in read_events().

The bigger question is: what is the semantics on event reap order for
thread? Random, FIFO or round robin?  It is not specified anywhere.
What would be the most optimal policy?

