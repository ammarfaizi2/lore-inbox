Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbTCEJCt>; Wed, 5 Mar 2003 04:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbTCEJCt>; Wed, 5 Mar 2003 04:02:49 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:60556 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264844AbTCEJCo>; Wed, 5 Mar 2003 04:02:44 -0500
Date: Wed, 5 Mar 2003 14:47:54 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC][Patch] Retry based aio read for filesystems
Message-ID: <20030305144754.A1600@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the last few days I've been playing with prototyping 
a particular flavour of a retry based implementation for 
filesystem aio read.

It is rather experimental at this point, with only 
limited bits of testing so far. [There are some potential 
races which seem to show up in the case of large reads 
requiring faulting in of the user space buffer. I've 
chosen to leave some printks on now ] 

Am posting these initial patches as responses to this
mail for early comments/feedback on the approach and 
to improve chances of unearthing any potential 
gotchas sooner rather than later :)

A few alternative variations are possible around the  
basic retry-driven theme that Ben LaHaise has designed - 
each with their pros and cons, so I am hoping that sharing 
experiences on what we're trying out may be a step 
towards some insights in determining what works best. 

Its in two parts:
aioretry.patch : Core aio infrastructure modifications
aioread.patch  : Modifications for aio read in 
particular (generic_file_aio_read)

I was working with 2.5.62, and haven't yet tried 
upgrading to 2.5.64.

The idea was to :
- Keep things as simple as possible with minimal changes 
  to the current filesystem read/write paths (which I 
  guess we don't want to disturb too much at this stage). 
  The way to do this is to make the base aio infrastructure 
  handle most of the async (retry) complexities.
- Take incremental steps towards making an operation async 
  - start with blocking->async conversions for the major
  blocking points.
- Keep in mind Dave Miller's concern about effect of aio
  additions (extra parameters) on sync i/o behaviour. So
  retaining sync i/o performance as far as possible gets 
  precedence over aio performance and latency right now.
- Take incremental steps towards tuning aio performance, 
  and optimizing specific paths for aio.

A retry-based model implies that each time we make as 
much progress as is possible in a non-blocking manner,
and then defer a restart of the operation from where we 
left off, at the next opportunity ... and so on, until
we finish. To make sure that a next opportunity does
indeed arise, each time we do _more_ than what we'd do 
for simple non-blocking i/o -- we initiate some steps
towards progress without actually waiting for it. Then
we try to mark ourselves to be notified when enough is
ready to try the next restart-from-where-we-left-off 
attempt.

3 decisions characterise this particular variation:

1. At what level to retry ? 

   This patch does it at the highest level (fops level),
   i.e. high level aio code retries the generic read 
   operation passing in the remaining parts of the buffer 
   to be read.

   No retries happen in the sync case at the moment,
   though the option exists.

2. What kind of state needs to be saved across retries
   and who maintains that ?

   The high level aio code keeps adjusting the parameters 
   to the read as retries progress (this is done by the
   routine calling the fops)

   There is, however, room for optimizations when 
   low-level paths can be modified to reuse state 
   across aio-retries.

3. When to trigger a retry ?
   
   This is the tricky part. This variation uses async 
   wait queue functions instead of the blocking wait, to
   trigger a retry (kick_iocb) when data becomes available. 
   So the synchronous lock_page, wait_on_page_bit have
   their async variations which do an async wait and
   return -EIOCBQUEUED (which is propogated up).

   (BTW, the races that I'm running into are mostly 
   related to this area - avoiding simoultaneous retries,
   dealing with completion while retry is going on
   etc. We need to audit the code and think about this 
   more closely. I wanted to keep the async wakeup  
   as simple as possible ... and deal with the races
   in some other way)

Ben, 

Is this anywhere close to what you had in mind, or
have played with, or were you aiming for retries
at a different (lower) level ?  How's your experience 
been with other variations that you've tried ? 

Would be interesting to take a look and compare notes,
if possible. 
Any chance you'll be putting something out ? 

I guess the retry state you maintain may be a little more 
specific to the target/type of aio, or is implemented in
a way lets state already updated by lower level functions 
to be reused/carried over directly, rather than recomputed 
by the aio code ... - does that work out to be more 
optimal ? Or were you working on a different technique 
altogether ?

There are a couple of fixes that I made in the aio code
as part of the patch. 
- The kiocbClearXXX were doing a set_bit instead of 
  clear_bit
- Sync iocbs were not woken up when iocb->ki_users = 1
  (dio takes a different path for sync and async iocbs,
  so maybe that's why we weren't seeing the problem yet)

Hope that's okay.

Regards
Suparna
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

