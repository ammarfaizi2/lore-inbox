Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVFWQkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVFWQkA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 12:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVFWQkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 12:40:00 -0400
Received: from kanga.kvack.org ([66.96.29.28]:61338 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262612AbVFWQj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 12:39:58 -0400
Date: Thu, 23 Jun 2005 12:41:37 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: aio_down() patch series -- cancellation support added
Message-ID: <20050623164137.GA5279@kvack.org>
References: <20050620213835.GA6628@kvack.org> <20050620214614.GC6628@kvack.org> <20050623132926.GA6669@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623132926.GA6669@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 06:59:26PM +0530, Suparna Bhattacharya wrote:
> One quick question.
> Since lock_kiocb() may block, does that mean that the aio worker thread
> could be put to sleep while an iocb cancellation is in progress, even though
> there may be other iocbs/ioctx's to process ?

It's mostly to deal with the case in the other direction: an iocb that is 
in the process of being cancelled somehow needs to block any retries from 
occurring.  Likewise, if a retry was in progress, the cancellation needs 
to be blocked until that retry is complete.  It should be sufficiently 
rare that it's not a problem, but we may have to revisit the issue as more 
cancel methods get written.

> Looking at the rest a little more closely in terms of how everything
> will fit together, a few questions come to mind - need to think
> about it a little more. I guess the main reason you need the aio_down_wait
> callback is to make sure the semaphore is grabbed right in the context
> of the wakeup rather than at retry time, is that correct ?

Yes, that way the retry method is only called if it will make progress, 
and we will not have a thundering herd problem.  I'm debugging the changes 
needed to implement async pipes using aio_down(), and the patch so far 
looks pretty straightforward.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
