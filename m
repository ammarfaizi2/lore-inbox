Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264943AbUEKW1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbUEKW1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 18:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265015AbUEKW1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 18:27:10 -0400
Received: from mail.tmr.com ([216.238.38.203]:31238 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S264943AbUEKWYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 18:24:40 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Random file I/O regressions in 2.6
Date: Tue, 11 May 2004 18:26:37 -0400
Organization: TMR Associates, Inc
Message-ID: <c7rjla$i7b$1@gatekeeper.tmr.com>
References: <1084228767.6140.832.camel@localhost.localdomain> <20040510160740.5db8c62c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1084314090 18667 192.168.12.100 (11 May 2004 22:21:30 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20040510160740.5db8c62c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
>>I am nervous about this change. You are totally getting rid of
>>lazy-readahead and that was the optimization which gave the best
>>possible boost in performance. 
> 
> 
> Because it disabled the large readahead outside the area which the app is
> reading.  But it's still reading too much.
> 
> 
>>Let me see how this patch does with a DSS benchmark.
> 
> 
> That was not a real patch.  More work is surely needed to get that right.
> 
> 
>>In the normal large random workload this extra page would have
>>compesated for all the wasted readaheads.
> 
> 
> I disagree that 64k is "normal"!
> 
> 
>> However in the case of
>>sysbench with Andrew's ra-copy patch the readahead calculation is not
>>happening quiet right. Is it worth trying to get a marginal gain 
>>with sysbench at the cost of getting a big hit on DSS benchmarks,
>>aio-tests,iozone and probably others. Or am I making an unsubstantiated
>>claim? I will get back with results.
> 
> 
> It shouldn't hurt at all - the app does a seek, we perform the
> correctly-sized read.
> 
> As I say, my main concern is that we correctly transition from seeky access
> to linear access and resume readahead.

One real problem is that you are trying to do in the kernel what would 
be best done in the application and better done in glibc... Because the 
benefit of readahead varies based on fd rather than device. Consider a 
program reading data from a file and putting it in a database. The 
benefit of readahead for the sequential access data file is higher than 
seek-read combinations. The library could do readahead based on the 
bytes read since the last seek on a by-file basis, something the kernel 
can't.

This is not to say the kernel work hasn't been a benefit, but note that 
with all the patches 2.4 still seems to outperform 2.6. And that's a 
problem since other parts of 2.6 scale so well. I do see that 2.4 seems 
to outperform 2.6 for usenet news, where you have small reads against a 
modest database, a few TB or so, and 400-2000 processes doing random 
reads against the data. Settings and schedulers seem to have only modest 
effect there.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
