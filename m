Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422748AbWJaEyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422748AbWJaEyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 23:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422674AbWJaEyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 23:54:12 -0500
Received: from mail-gw3.adaptec.com ([216.52.22.36]:64168 "EHLO
	mail-gw3.adaptec.com") by vger.kernel.org with ESMTP
	id S1422748AbWJaEyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 23:54:11 -0500
Message-ID: <4546D79E.40507@adaptec.com>
Date: Tue, 31 Oct 2006 10:27:02 +0530
From: Ravi Krishnamurthy <Ravi_Krishnamurthy@adaptec.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: linux-kernel@vger.kernel.org
Subject: Re:  Block driver freezes when using CFQ
References: <454313C9.4010602@adaptec.com> <20061030082233.GL4563@kernel.dk>
In-Reply-To: <20061030082233.GL4563@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2006 04:54:08.0980 (UTC) FILETIME=[99B02140:01C6FCA8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sat, Oct 28 2006, Ravi Krishnamurthy wrote:
>> Hi all,
>>
>>    I have written a block driver that registers a virtual device and
>> routes requests to appropriate real devices after some re-mapping of
>> the requests. I am testing the driver by creating a filesystem on the
>> virtual device and copying a large number of files on to it. The test
>> causes the device to become unresponsive after some time. After some
>> debugging, I noticed that this happens only if the I/O scheduler being
>> used is CFQ. I have not had any trouble if the scheduler is noop,
>> anticipatory or deadline. The problem occurs on all the kernels I have
>> tested - 2.6.18-rc2, 2.6.18-rc4, 2.6.19-rc3.
>>


> 
> The io scheduler is not obligated to recall your request handling
> function, _unless_ you have no pending io at the point where
> elv_next_request() returns NULL but there are things pending. 
> IOW, when you complete your requests you want to just recall your request handling
> function. Just insert something ala:
> 
>         if (elv_next_request(q))
>                 q->request_fn(q);
> 
> when you are done completing requests.
> 
> Does that fix it?

I haven't had a chance to test this fix. A workaround I had tried was to
insert these lines at the end of the request function:
        if (! elv_queue_empty(q))
             blk_plug_device(q);

This worked for me. So I assume the fix you have suggested will surely
work.

I am curious to know why the problem does not occur when I am using the
anticipatory scheduler. Also, in the suggested fix, is it guaranteed that
elv_next_request() will not return NULL as long as the elevator queue is
not empty?

Thanks,
Ravi.
