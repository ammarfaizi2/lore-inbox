Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261994AbSIWOdq>; Mon, 23 Sep 2002 10:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262014AbSIWOdq>; Mon, 23 Sep 2002 10:33:46 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:21673 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261994AbSIWOdn>;
	Mon, 23 Sep 2002 10:33:43 -0400
Message-ID: <3D8F256D.1070107@watson.ibm.com>
Date: Mon, 23 Sep 2002 10:30:05 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@digeo.com>,
       Alexander Viro <viro@math.psu.edu>, linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] adding aio_readv/writev
References: <3D8B878C.8070503@watson.ibm.com> <1032555981.2082.10.camel@dell_ss3.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:

>Why not batch up multiple requests with one io_submit? It has the same
>effect, except there would be multiple responses.
>
Even though the multiple iocb's enter the kernel together, they still 
get processed individually so a fair amount of unnecessary data 
transmission and function invocation are still occurring in the submit 
code path.
Depending on how long it takes for io_submit_one to return, there might 
be a reduced probability for merging of io requests at the i/o scheduler.
Finally, the multiple responses need to be handled as you mentioned. I 
suppose the application could wait for the last request (in the 
io_submit list) and that would most probably ensure that the preceding 
ones were complete as well but its not a guarantee offered by the aio 
API, right ?
Besides, the application needs the data (represented by multiple 
requests) at one go so partial completion isn't likely to be  useful and 
will only be an overhead.

While a quantitative assessment of the above tradeoffs is possible, it 
will be difficult to make a good comparison before "true" aio 
functionality is in place for 2.5. Such an assessment is unlikely to 
happen before the feature freeze takes effect. So I'm making a case for 
putting in async vector I/O interfaces in for the following three reasons:
- the synchronous API does provide separate entry points for vector I/O. 
Extending the same to the async interfaces, especially when it doesn't 
even involve creating new syscalls, seems natural for completeness.
- underlying in-kernel infrastructure already supports it, so no major 
changes are needed.
- there exists atleast one major application class (databases) that uses 
vectored I/O heavily and benefits from async I/O. Hence async vectored 
I/O is also likely to be useful. Can anyone else with experience on 
other OS's comment on this ?

Comments, reasons for not doing async readv/writev directly welcome.

- Shailabh

>
>
>On Fri, 2002-09-20 at 13:39, Shailabh Nagar wrote:
>
>>Ben,
>>
>>Currently there is no way to initiate an aio readv/writev in 2.5. There 
>>were no aio_readv/writev calls in 2.4 either - I'm wondering if there 
>>was any particular reason for excluding readv/writev operations from aio ?
>>
>>The read/readv paths have anyway been merged for raw/O_DIRECT and 
>>regular file read/writes. So why not expose the vector read/write to the 
>>user by adding the IOCB_CMD_PREADV/IOCB_CMD_READV and 
>>IOCB_CMD_PWRITEV/IOCB_CMD_WRITEV commands to the aio set. Without that, 
>>raw/O_DIRECT readv users would need to unnecessarily cycle through their 
>>iovecs at a library level submitting them individually.
>>For larger iovecs, user/library code would needlessly deal with multiple 
>>completions. While I'm not sure of the performance impact of the absence 
>>of aio_readv/writev, it seems easy enough to provide.
>>Most of the functions are already in place. We would only
>>need a way to pass the iovec through the iocb.
>>
>>I was thinking of something like this:
>>
>>struct iocb {
>>
>>+union {
>>        __u64	aio_buf
>>+      __u64	aio_iovp
>>+}
>>+union {
>>        __u64	aio_nbytes
>>+      __u64	aio_nsegs
>>+}
>>
>>allowing the iovec * & nsegs to be passed into sys_io_submit. Some code 
>>would be added (within case handling of IOCB_CMD_READV within 
>>io_submit_one) to copy & verify the iovec pointers and then call 
>>aio_readv/aio_writev (if its defined for the fs).
>>
>>What do you think ? I wanted to get some feedback before trying to code 
>>this up.
>>
>>While we are on the topic of expanding aio operations, what about 
>>providing IOCB_CMD_READ/WRITE, distinct from their pread/pwrite 
>>counterparts ? Do you think thats needed ?
>>
>>- Shailabh
>>

