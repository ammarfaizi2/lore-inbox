Return-Path: <linux-kernel-owner+w=401wt.eu-S1751562AbXALCNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbXALCNe (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 21:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbXALCNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 21:13:34 -0500
Received: from mail.tmr.com ([64.65.253.246]:41818 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbXALCNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 21:13:33 -0500
Message-ID: <45A6EED7.4020707@tmr.com>
Date: Thu, 11 Jan 2007 21:13:43 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org, torvalds@osdl.org,
       mjt@tls.msk.ru
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.61.0701110724040.19233@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0701110724040.19233@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Wed, 10 Jan 2007, Aubrey wrote:
> 
>> Hi all,
>>
>> Opening file with O_DIRECT flag can do the un-buffered read/write access.
>> So if I need un-buffered access, I have to change all of my
>> applications to add this flag. What's more, Some scripts like "cp
>> oldfile newfile" still use pagecache and buffer.
>> Now, my question is, is there a existing way to mount a filesystem
>> with O_DIRECT flag? so that I don't need to change anything in my
>> system. If there is no option so far, What is the right way to achieve
>> my purpose?
>>
>> Thanks a lot.
>> -Aubrey
>> -
> 
> I don't think O_DIRECT ever did what a lot of folks expect, i.e.,
> write this buffer of data to the physical device _now_. All I/O
> ends up being buffered. The `man` page states that the I/O will
> be synchronous, that at the conclusion of the call, data will have
> been transferred. However, the data written probably will not be
> in the physical device, perhaps only in a DMA-able buffer with
> a promise to get it to the SCSI device, soon.
> 

No one (who read the specs) ever though thought the write was "right
now," just that it was direct from user buffers. So it is not buffered,
but it is queued through the elevator.

> Maybe you need to say why you want to use O_DIRECT with its terrible
> performance?

Because it doesn't have terrible performance, because the user knows 
better than the o/s what it "right," etc. I used it to eliminate cache 
impact from large but non-essential operations, others use it on slow 
machines to avoid the CPU impact and bus bandwidth impact of extra copies.

Please don't assume that users are unable to understand how it works 
because you believe some other feature which does something else would 
be just as good. There is no other option which causes the writes to be 
queued right now and not use any cache, and that is sometimes just what 
you want.

I do like the patch to limit per-file and per-system cache, though, in 
some cases I really would like the system to slow gradually rather than 
fill 12GB of RAM with backlogged writes, then queue them and have other 
i/o crawl or stop.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
