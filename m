Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269077AbUICPyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269077AbUICPyu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269066AbUICPyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:54:50 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:16889 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269280AbUICPyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:54:17 -0400
Subject: Re:  [Bug 3317] New: Kernel oops in aio_complete while running AIO
	application
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, daniel@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040831081835.08942f70.akpm@osdl.org>
References: <20040831081835.08942f70.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-aJcC1GVk7rWmY9btnQIQ"
Organization: 
Message-Id: <1094226765.3628.112.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Sep 2004 08:52:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aJcC1GVk7rWmY9btnQIQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-08-31 at 08:18, Andrew Morton wrote:
> Begin forwarded message:
> 
> Date: Tue, 31 Aug 2004 06:15:18 -0700
> From: bugme-daemon@osdl.org
> To: bugme-new@lists.osdl.org
> Subject: [Bugme-new] [Bug 3317] New: Kernel oops in aio_complete while running AIO application
> 
> 
> http://bugme.osdl.org/show_bug.cgi?id=3317
> 

Hi Andrew,

I debugged this some more. Here is whats happening:

The test program used program text address as buffer to do the READ to.
DIO get_user_pages() returned EFAULT. We called finished_one_bio()
as part of dropping the ref. to dio. It called aio_complete().
do_direct_IO() returned EFAULT to the caller. aio_run_iocb() expects
to see EIOCBQUEUED/RETRY, otherwise it calls aio_complete() with the
"ret" value. This is where the second aio_complete() is coming from.
So we cleanup "req" and on the next de-ref we get OOPS.

The problem here is, finished_one_bio() shouldn't call aio_complete()
since no work has been done. I have a fix for this - can you verify this
? I am not really comfortable with this "tweaking". (I am not really
sure about IO errors like EIO etc. - if they can lead to calling
aio_complete() twice)


Fix is to call aio_complete() ONLY if there is something to report.
Note the we don't update dio->result with any error codes from
get_user_pages(), they just passed as "ret" value from do_direct_IO().

Thanks,
Badari








--=-aJcC1GVk7rWmY9btnQIQ
Content-Disposition: attachment; filename=aio-dio.patch
Content-Type: text/plain; name=aio-dio.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.9-rc1.org/fs/direct-io.c	2004-09-03 08:44:22.186328240 -0700
+++ linux-2.6.9-rc1/fs/direct-io.c	2004-09-03 08:45:48.382224472 -0700
@@ -235,7 +235,8 @@ static void finished_one_bio(struct dio 
 			dio_complete(dio, dio->block_in_file << dio->blkbits,
 					dio->result);
 			/* Complete AIO later if falling back to buffered i/o */
-			if (dio->result == dio->size || dio->rw == READ) {
+			if (dio->result == dio->size || 
+				((dio->rw == READ) && dio->result)) {
 				aio_complete(dio->iocb, dio->result, 0);
 				kfree(dio);
 				return;

--=-aJcC1GVk7rWmY9btnQIQ--

