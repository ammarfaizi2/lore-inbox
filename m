Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWCUTDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWCUTDO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWCUTDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:03:13 -0500
Received: from fmr19.intel.com ([134.134.136.18]:16522 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S964831AbWCUTDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:03:13 -0500
Message-Id: <200603211903.k2LJ30g29071@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Badari Pulavarty'" <pbadari@us.ibm.com>
Cc: <akpm@osdl.org>, <suparna@in.ibm.com>,
       "Zach Brown" <zach.brown@oracle.com>,
       "lkml" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] direct-io: bug fix in dio handling write error
Date: Tue, 21 Mar 2006 11:03:10 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZNCvywebhVponyRZ+MW0KQdLfUEgACRTzA
In-Reply-To: <1142960203.6086.4.camel@dyn9047017100.beaverton.ibm.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote on Tuesday, March 21, 2006 8:57 AM
> I hate to do this you - but your patch breaks error handling on
> synchronous DIO requests.
> 
> Since you are using "dio->io_error" instead of "dio->result" to
> represent an error - you need to make sure to check that (also ?)
> instead of dio->result in direct_io_worker() before calling 
> dio_complete().
> 
> Isn't it ? Am I missing something ?


That's the other part of the maze.  AFAICS, in the synchronous path,
dio_bio_complete already implicitly checks -EIO error:

static int dio_bio_complete(struct dio *dio, struct bio *bio)
{ ...
    return uptodate ? 0 : -EIO;
}

And such error code bubbles up to direct_io_worker's sync path:

direct_io_worker {
    ...
    if (dio->is_async) {
    ...
    } else {
        ret2 = dio_await_completion(dio);
        if (ret == 0)
            ret = ret2;

I've also explicitly ran test case for synchronous write and found no
regression there.  I admit my test coverage may not be very comprehensive.
But I've done the best I can.

It's entirely possible there are more corner cases.  But let's get some
coverage here with -mm and then add fixes as we go.

- Ken

