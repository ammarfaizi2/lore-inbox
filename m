Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131489AbRC0TBt>; Tue, 27 Mar 2001 14:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131488AbRC0TBk>; Tue, 27 Mar 2001 14:01:40 -0500
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:9607 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S131486AbRC0TB0>; Tue, 27 Mar 2001 14:01:26 -0500
Date: Tue, 27 Mar 2001 14:00:37 -0500
To: LA Walsh <law@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
Message-ID: <20010327140036.A21171@cs.cmu.edu>
Mail-Followup-To: LA Walsh <law@sgi.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0103270022500.21075-100000@age.cs.columbia.edu> <3AC0CA9C.3D804361@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3AC0CA9C.3D804361@sgi.com>; from law@sgi.com on Tue, Mar 27, 2001 at 09:15:08AM -0800
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2001 at 09:15:08AM -0800, LA Walsh wrote:
> 	Now lets look at the sites want to process terabytes of
> data -- perhaps files systems up into the Pentabyte range.  Often I
> can see these being large multi-node (think 16-1024 clusters as 
> are in use today for large super-clusters).  If I was to characterize
> the performance of them, I'd likely see the CPU pegged at 100% 
> with 99% usage in user space.  Let's assume that increasing the
> block size decreases disk accesses by as much as 10% (you'll have
> to admit -- using a 64bit quantity vs. 32bit quantity isn't going
> to even come close to increasing disk access times by 1 millisecond,
> really, so it really is going to be a much smaller fraction when
> compared to the actual disk latency).  
[snip]
> 	Is there some logical flaw in the above reasoning?

But those changes will affect even the fastpath, i.e. data that is
already in the page/buffer caches. In which case we don't have to wait
for disk access latency. Why would anyone who is working with a
pentabyte of data even consider not relying on essentially always
hitting data that is available the read-ahead cache.

Using similar numbers as presented. If we are working our way through
every single block in a Pentabyte filesystem, and the blocksize is 512
bytes. Then the 1us in extra CPU cycles because of 64-bit operations
would add, according to by back of the envelope calculation, 2199023
seconds of CPU time a bit more than 25 days.

Seriously, there is a lot more that needs to be done than introducing a
64-bit blocknumber. Effectively 512 byte blocks are far too small for
that kind of data, and going to pagesize blocks (and increasing pagesize
to 64KB or 2MB at the same time) is a solution that is far more likely
to give good results since it reduces both the total the number of
'blocks' on the device as well as reducing the total amount of calls
throughout kernel space instead of increasing the cost per call.

Jan

