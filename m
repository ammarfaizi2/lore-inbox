Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbWCUU4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbWCUU4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbWCUU4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:56:08 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:49554 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965107AbWCUU4G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:56:06 -0500
Subject: RE: [patch] direct-io: bug fix in dio handling write error
From: Badari Pulavarty <pbadari@us.ibm.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: akpm@osdl.org, suparna@in.ibm.com, Zach Brown <zach.brown@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200603211903.k2LJ30g29071@unix-os.sc.intel.com>
References: <200603211903.k2LJ30g29071@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 12:57:52 -0800
Message-Id: <1142974672.6086.15.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 11:03 -0800, Chen, Kenneth W wrote:
> Badari Pulavarty wrote on Tuesday, March 21, 2006 8:57 AM
> > I hate to do this you - but your patch breaks error handling on
> > synchronous DIO requests.
> > 
> > Since you are using "dio->io_error" instead of "dio->result" to
> > represent an error - you need to make sure to check that (also ?)
> > instead of dio->result in direct_io_worker() before calling 
> > dio_complete().
> > 
> > Isn't it ? Am I missing something ?
> 
> 
> That's the other part of the maze.  AFAICS, in the synchronous path,
> dio_bio_complete already implicitly checks -EIO error:
> 
> static int dio_bio_complete(struct dio *dio, struct bio *bio)
> { ...
>     return uptodate ? 0 : -EIO;
> }
> 
> And such error code bubbles up to direct_io_worker's sync path:
> 
> direct_io_worker {
>     ...
>     if (dio->is_async) {
>     ...
>     } else {
>         ret2 = dio_await_completion(dio);
>         if (ret == 0)
>             ret = ret2;
> 
> I've also explicitly ran test case for synchronous write and found no
> regression there.  I admit my test coverage may not be very comprehensive.
> But I've done the best I can.
> 
> It's entirely possible there are more corner cases.  But let's get some
> coverage here with -mm and then add fixes as we go.

I know that is not your fault - but does this mean that we can't
return success for partial IO ? 

If some one asks to do IO for 128K and if we get -EIO after say, 64K 
- we fail the whole IO  with -EIO ?

Thanks,
Badari

