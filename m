Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318114AbSFTELJ>; Thu, 20 Jun 2002 00:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318115AbSFTELI>; Thu, 20 Jun 2002 00:11:08 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:62130 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318114AbSFTELH>;
	Thu, 20 Jun 2002 00:11:07 -0400
Message-ID: <3D115563.4020402@us.ibm.com>
Date: Wed, 19 Jun 2002 21:09:07 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: mgross@unix-os.sc.intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net, richard.a.griffiths@intel.com
Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as the number of spindles
 gets large
References: <200206200022.g5K0MKP27994@unix-os.sc.intel.com> <3D1127D6.F6988C4B@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> mgross wrote:
>>Has anyone done any work looking into the I/O scaling of Linux / ext3 per
>>spindle or per adapter?  We would like to compare notes.
> 
> No.  ext3 scalability is very poor, I'm afraid.  The fs really wasn't
> up and running until kernel 2.4.5 and we just didn't have time to
> address that issue.

Ick.  That takes the prize for the highest BKL contention I've ever 
seen, except for some horribly contrived torture tests of mine.  I've 
had data like this sent to me a few times to analyze and the only 
thing I've been able to suggest up to this point is not to use ext3.

>>I've only just started to look at the ext3 code but it seems to me that replacing the
>>BKL with a per - ext3 file system lock could remove some of the contention thats
>>getting measured.  What data are the BKL protecting in these ext3 functions?  Could a
>>lock per FS approach work?
> 
> The vague plan there is to replace lock_kernel with lock_journal
> where appropriate.  But ext3 scalability work of this nature
> will be targetted at the 2.5 kernel, most probably.

I really doubt that dropping in lock_journal will help this case very 
much.  Every single kernel_flag entry in the lockmeter output where 
Util > 0.00% is caused by ext3.  The schedule entry is probably caused 
by something in ext3 grabbing BKL, getting scheduled out for some 
reason, then having it implicitly released in schedule().  The 
schedule() contention comes from the reacquire_kernel_lock().

We used to see plenty of ext2 BKL contention, but Al Viro did a good 
job fixing that early in 2.5 using a per-inode rwlock.  I think that 
this is the required level of lock granularity, another global lock 
just won't cut it.
http://lse.sourceforge.net/lockhier/bkl_rollup.html#getblock

-- 
Dave Hansen
haveblue@us.ibm.com

