Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269468AbUHZTeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269468AbUHZTeB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269232AbUHZT3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:29:33 -0400
Received: from eagle.rtlogic.com ([216.87.68.236]:59055 "EHLO
	eagle.rtlogic.com") by vger.kernel.org with ESMTP id S269496AbUHZTYP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:24:15 -0400
Message-ID: <412E38CD.1050408@rtlogic.com>
Date: Thu, 26 Aug 2004 13:23:57 -0600
From: David Rolenc <drolenc@rtlogic.com>
Reply-To: drolenc@rtlogic.com
Organization: RT Logic!
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: POSIX_FADV_NOREUSE and O_STREAMING behavior in 2.6.7
References: <412E2058.60302@rtlogic.com> <1093544239.30480.7.camel@betsy.boston.ximian.com>
In-Reply-To: <1093544239.30480.7.camel@betsy.boston.ximian.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any technical reason that we couldn't set a flag in the struct 
file* and put code in the read/write calls to handle shrinking the page 
cache? This is similar to what was done with O_STREAMING in 2.4. It 
seems like it would conform more to the behavior expected from 
POSIX_FADV_NOREUSE, and I wouldn't have to make a bunch of system calls :-)

-Dave


Robert Love wrote:

>On Thu, 2004-08-26 at 11:39 -0600, David Rolenc wrote:
>  
>
>>I am trying to get O_STREAMING (Robert Love patch for 2.4) behavior in 
>>2.6 and just a glance at fadvise.c suggests that POSIX_FADV_NOREUSE is 
>>not implemented any differently than POSIX_FADV_WILLNEED. Am I missing 
>>something?
>>    
>>
>
>Yes, they are currently the same.  Their difference in theory is subtle:
>NOREUSE says "I will use this once in the future" and WILLNEED says "I
>will use this [some number of times] in the future".
>
>So for both of them, you want to keep the data in the page cache.  But
>for NOREUSE you could do drop-behind of the pages.  But Linux does not
>currently do drop-behind, so we have them both do the same thing.
>
>  
>
>> I want to read data from disk with readahead and drop the 
>>data from the page cache as soon as I am done with it. Do I have to call 
>>fadvise with POSIX_FADV_DONTNEED after every read?
>>    
>>
>
>Yes, you do.  Or every couple of reads.
>
>The sort of applications that need DONTNEED already are setup in a way
>to make that easy.  You either have a streaming loop, like:
>
>	do {
>		read
>		process
>	} while (repeat);
>
>Or you are readings lots of files (like updatedb).
>
>In the first case, just stick the fadvise call after the processing.  In
>the latter case, call fadvise before closing the file.
>
>You don't _have_ to call fadvise after every reading.  Just whenever you
>want to drop the pages.  Whenever it makes sense.
>
>	Robert Love
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


