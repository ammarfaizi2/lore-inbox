Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUIDRcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUIDRcj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUIDRci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:32:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:30625 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264919AbUIDRcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:32:13 -0400
Message-ID: <4139FAF3.50307@us.ibm.com>
Date: Sat, 04 Sep 2004 10:27:15 -0700
From: badari <pbadari@us.ibm.com>
Organization: IBM
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel McNeil <daniel@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Suparna Bhattacharya <suparna@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: [Bug 3317] New: Kernel oops in aio_complete while running AIO
 application
References: <20040831081835.08942f70.akpm@osdl.org>	 <1094226765.3628.112.camel@dyn318077bld.beaverton.ibm.com> <1094252275.2299.11.camel@ibm-c.pdx.osdl.net>
In-Reply-To: <1094252275.2299.11.camel@ibm-c.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

aio_complete() gets called only when we are done with this dio.
Other calls to finished_one_bio() should be fine. dio->result
should have the return value we want to send back. The fix
I made is to call aio_complete() only if we have something to
report back.

One problem is, dio->result gets updated for IO errors bur
doesn't get updated for errors from get_user_pages().  Things
should be fine, but I am not really comfortable retruning half
errors thro aio_complete() and other half thro return value
of do_direct_IO(). I guess its okay, since some of the IO errors
can happen only after we submit the bio.

Thanks,
Badari

Daniel McNeil wrote:

>On Fri, 2004-09-03 at 08:52, Badari Pulavarty wrote:
>  
>
>>On Tue, 2004-08-31 at 08:18, Andrew Morton wrote:
>>    
>>
>>>Begin forwarded message:
>>>
>>>Date: Tue, 31 Aug 2004 06:15:18 -0700
>>>From: bugme-daemon@osdl.org
>>>To: bugme-new@lists.osdl.org
>>>Subject: [Bugme-new] [Bug 3317] New: Kernel oops in aio_complete while running AIO application
>>>
>>>
>>>http://bugme.osdl.org/show_bug.cgi?id=3317
>>>
>>>      
>>>
>>Hi Andrew,
>>
>>I debugged this some more. Here is whats happening:
>>
>>The test program used program text address as buffer to do the READ to.
>>DIO get_user_pages() returned EFAULT. We called finished_one_bio()
>>as part of dropping the ref. to dio. It called aio_complete().
>>do_direct_IO() returned EFAULT to the caller. aio_run_iocb() expects
>>to see EIOCBQUEUED/RETRY, otherwise it calls aio_complete() with the
>>"ret" value. This is where the second aio_complete() is coming from.
>>So we cleanup "req" and on the next de-ref we get OOPS.
>>
>>The problem here is, finished_one_bio() shouldn't call aio_complete()
>>since no work has been done. I have a fix for this - can you verify this
>>? I am not really comfortable with this "tweaking". (I am not really
>>sure about IO errors like EIO etc. - if they can lead to calling
>>aio_complete() twice)
>>
>>
>>Fix is to call aio_complete() ONLY if there is something to report.
>>Note the we don't update dio->result with any error codes from
>>get_user_pages(), they just passed as "ret" value from do_direct_IO().
>>
>>Thanks,
>>Badari
>>    
>>
>
>Badari,
>
>This does fix the problem when running on my system (ext3).
>
>One question, finished_one_bio() is called in 3 places,
>are you sure the other places won't be harmed by this
>change?
>
>I'm also looking over the code and will let you know if
>I see any problems.
>
>Daniel
>
>--
>To unsubscribe, send a message with 'unsubscribe linux-aio' in
>the body to majordomo@kvack.org.  For more info on Linux AIO,
>see: http://www.kvack.org/aio/
>Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
>
>  
>

