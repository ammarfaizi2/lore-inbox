Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbVDLUbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbVDLUbt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbVDLUbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:31:09 -0400
Received: from fmr23.intel.com ([143.183.121.15]:29403 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262512AbVDLSdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:33:38 -0400
Message-Id: <200504121833.j3CIXLg12005@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "'Jens Axboe'" <axboe@suse.de>, "Claudio Martins" <ctpm@rnl.ist.utl.pt>,
       "Andrew Morton" <akpm@osdl.org>, "lkml" <linux-kernel@vger.kernel.org>,
       "Neil Brown" <neilb@cse.unsw.edu.au>
Subject: RE: Processes stuck on D state on Dual Opteron
Date: Tue, 12 Apr 2005 11:33:21 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU/UBLGkuUUUSfrRFeB2cKPlQlF0QANTJtQ
In-Reply-To: <425BAC55.7020506@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Tuesday, April 12, 2005 4:09 AM
> Chen, Kenneth W wrote:
> > I like the patch a lot and already did bench it on our db setup.  However,
> > I'm seeing a negative regression compare to a very very crappy patch (see
> > attached, you can laugh at me for doing things like that :-).
>
> OK - if we go that way, perhaps the following patch may be the
> way to do it.

OK, if you are going to do it that way, then the ioc_batching code in get_request
has to be reworked.  We never push the queue so hard that it kicks itself into the
batching mode.  However, calls to get_io_context and put_io_context are unconditional
in that function.  Execution profile shows that these two little functions actually
consumed lots of cpu cycles.

AFAICS, ioc_*batching() is trying to push more requests onto the queue that is full
(or near full) and give high priority to the process that hits the last req slot.
Why do we need to go all the way to tsk->io_context to keep track of that state?
For a clean up bonus, I think the tracking can be moved into the queue structure.


> > My first reaction is that the overhead is in wait queue setup and tear down
> > in get_request_wait function. Throwing the following patch on top does improve
> > things a bit, but we are still in the negative territory.  I can't explain why.
> > Everything suppose to be faster.  So I'm staring at the execution profile at
> > the moment.
> >
>
> Hmm, that's a bit disappointing. Like you said though, I'm sure we
> should be able to get better performance out of this.

Absolutely. I'm disappointed too and this is totally out of expectation.  There
must be some other factors.


