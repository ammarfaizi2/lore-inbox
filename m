Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263503AbSITUmK>; Fri, 20 Sep 2002 16:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263511AbSITUmJ>; Fri, 20 Sep 2002 16:42:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:49566 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263503AbSITUmI>; Fri, 20 Sep 2002 16:42:08 -0400
Message-ID: <3D8B878C.8070503@watson.ibm.com>
Date: Fri, 20 Sep 2002 16:39:40 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben LaHaise <bcrl@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>,
       linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: [RFC] adding aio_readv/writev
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,

Currently there is no way to initiate an aio readv/writev in 2.5. There 
were no aio_readv/writev calls in 2.4 either - I'm wondering if there 
was any particular reason for excluding readv/writev operations from aio ?

The read/readv paths have anyway been merged for raw/O_DIRECT and 
regular file read/writes. So why not expose the vector read/write to the 
user by adding the IOCB_CMD_PREADV/IOCB_CMD_READV and 
IOCB_CMD_PWRITEV/IOCB_CMD_WRITEV commands to the aio set. Without that, 
raw/O_DIRECT readv users would need to unnecessarily cycle through their 
iovecs at a library level submitting them individually.
For larger iovecs, user/library code would needlessly deal with multiple 
completions. While I'm not sure of the performance impact of the absence 
of aio_readv/writev, it seems easy enough to provide.
Most of the functions are already in place. We would only
need a way to pass the iovec through the iocb.

I was thinking of something like this:

struct iocb {

+union {
        __u64	aio_buf
+      __u64	aio_iovp
+}
+union {
        __u64	aio_nbytes
+      __u64	aio_nsegs
+}

allowing the iovec * & nsegs to be passed into sys_io_submit. Some code 
would be added (within case handling of IOCB_CMD_READV within 
io_submit_one) to copy & verify the iovec pointers and then call 
aio_readv/aio_writev (if its defined for the fs).

What do you think ? I wanted to get some feedback before trying to code 
this up.

While we are on the topic of expanding aio operations, what about 
providing IOCB_CMD_READ/WRITE, distinct from their pread/pwrite 
counterparts ? Do you think thats needed ?

- Shailabh
	

