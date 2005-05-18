Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVERGsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVERGsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 02:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVERGsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 02:48:38 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:52386 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262104AbVERGs0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 02:48:26 -0400
Message-ID: <428AE65E.8010508@in.ibm.com>
Date: Wed, 18 May 2005 12:23:18 +0530
From: suzuki <suzuki@in.ibm.com>
Organization: IBM Global Services India
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-aio kvack.org" <linux-aio@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix for  __generic_file_aio_read() to return 0 on EOF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I came across the following problem while running ltp-aiodio testcases
from ltp-full-20050405 on linux-2.6.12-rc3-mm3. I tried running the
tests with EXT3 as well as JFS filesystems.

One or two fsx-linux testcases were hung after some time. These
testcases were hanging at wait_for_all_aios().

 From initial debugging I found that there were some iocbs which were
not getting completed eventhough the last retry for those returned
-EIOCBQUEUED. Also all such pending iocbs represented READ operation.

Further debugging revealed that all such iocbs hit EOF in the DIO layer.
To be more precise, the "pos" from which they were trying to read was
greater than the "size" of the file. So the generic_file_direct_IO
returned 0.

This happens rarely as there is already a check in
__generic_file_aio_read(), for whether "pos" < "size" before calling
direct IO routine.

> size = i_size_read(inode);
> if (pos < size) {
> 	  retval = generic_file_direct_IO(READ, iocb,
>                                iov, pos, nr_segs);


But for READ, we are taking the inode->i_sem only in the DIO layer. So
it is possible that some other process can change the size of the file
before we take the i_sem. In such a case ( when "pos" > "size"), the
__generic_file_aio_read() would return -EIOCBQUEUED even though there
were no I/O requests submitted by the DIO layer. This would cause the
AIO layer to expect aio_complete() for THE iocb, which doesnot happen.
And thus the test hangs forever, waiting for an I/O completion, where
there are no requests submitted at all.

The following patch makes __generic_file_aio_read() return 0 ( instead
of returning -EIOCBQUEUED ), on getting 0 from generic_file_direct_IO(),
so that the AIO layer does the aio_complete().

Testing:

I have tested the patch on a SMP machine(with 2 Pentium 4 (HT)) running
linux-2.6.12-rc3-mm3. I ran the ltp-aiodio testcases and none of the
fsx-linux tests hung. Also the aio-stress tests ran without any problem.

-- 
thanks,

Suzuki K P
Linux Technology Centre
IBM Software Labs

"Sorrow keeps u Human ,Failure Keeps u Humble,Success keeps u Glowing.
  But only God Keeps u Going..... "




Signed-off-by : Suzuki K P <suzuki@in.ibm.com>

-----------------------------------------------------------------------

diff -Naurp linux-2.6.12-rc4.org/mm/filemap.c linux-2.6.12-rc4/mm/filemap.c
--- linux-2.6.12-rc4.org/mm/filemap.c   2005-05-07 10:50:31.000000000 +0530
+++ linux-2.6.12-rc4/mm/filemap.c       2005-05-18 17:53:14.000000000 +0530
@@ -1004,7 +1004,7 @@ __generic_file_aio_read(struct kiocb *io
                 if (pos < size) {
                         retval = generic_file_direct_IO(READ, iocb,
                                                 iov, pos, nr_segs);
-                       if (retval >= 0 && !is_sync_kiocb(iocb))
+                       if (retval > 0 && !is_sync_kiocb(iocb))
                                 retval = -EIOCBQUEUED;
                         if (retval > 0)
                                 *ppos = pos + retval;







