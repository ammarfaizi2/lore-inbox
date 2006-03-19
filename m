Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWCSW1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWCSW1m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 17:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWCSW1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 17:27:42 -0500
Received: from fmr19.intel.com ([134.134.136.18]:13198 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751141AbWCSW1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 17:27:41 -0500
Message-Id: <200603192227.k2JMRNg30260@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <suparna@in.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Zach Brown'" <zach.brown@oracle.com>, <pbadari@gmail.com>
Subject: RE: [patch] bug fix in dio handling write error - v2
Date: Sun, 19 Mar 2006 14:27:33 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZLS/A6B1aQlAkmRe2Hra7siMenBwAVewyg
In-Reply-To: <20060319115458.GA29422@in.ibm.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote on Sunday, March 19, 2006 3:55 AM
> On Sun, Mar 19, 2006 at 01:27:33AM -0800, Chen, Kenneth W wrote:
> > Referring to original posting:
> > http://marc.theaimsgroup.com/?t=113752710100001&r=1&w=2
> > 
> > Suparna pointed out that this fix has a potential race window.  I think
> > the race condition also exists on the READ side currently. The fundamental
> > problem is that dio->result is overloaded with dual use: an indicator of
> > fall back path for partial dio write, and an error indicator used in the
> > I/O completion path.  In the event of device error, the setting of -EIO
> > to dio->result clashes with value used to track partial write that activates
> > the fall back path.
> 
> Isn't there a possibility that part of the IO for the overall request
> may already have been submitted at this point ? (i.e. within
> do_direct_IO->submit_page_section ->dio_send_cur_page->dio_bio_submit) 
> This is what I was referring to in my earlier response to Zach's patch.

I suppose it is possible there.  What you are saying here is effectively
that it is impossible to use dio->result to track partial write and at the
same time to track error returned from device driver. Because direct_io_work
can only determines whether it is a partial write at the end of io submission
and in mid stream of those io submission, a return code could be coming back
from the driver.  Thus messing up all the subsequent logic.

Taking one of your earlier idea, how about the following patch: separating
out IO completion code from partial IO tracking?


--- ./fs/direct-io.c.orig	2006-03-19 13:36:52.000000000 -0800
+++ ./fs/direct-io.c	2006-03-19 13:47:42.000000000 -0800
@@ -129,6 +129,7 @@ struct dio {
 	/* AIO related stuff */
 	struct kiocb *iocb;		/* kiocb */
 	int is_async;			/* is IO async ? */
+	int completion_code;		/* IO completion code */
 	ssize_t result;                 /* IO result */
 };
 
@@ -250,6 +251,10 @@ static void finished_one_bio(struct dio 
 			    ((offset + transferred) > dio->i_size))
 				transferred = dio->i_size - offset;
 
+			/* check for error in completion path */
+			if (dio->completion_code)
+				transferred = dio->completion_code;
+
 			dio_complete(dio, offset, transferred);
 
 			/* Complete AIO later if falling back to buffered i/o */
@@ -406,7 +411,7 @@ static int dio_bio_complete(struct dio *
 	int page_no;
 
 	if (!uptodate)
-		dio->result = -EIO;
+		dio->completion_code = -EIO;
 
 	if (dio->is_async && dio->rw == READ) {
 		bio_check_pages_dirty(bio);	/* transfers ownership */
@@ -964,6 +969,7 @@ direct_io_worker(int rw, struct kiocb *i
 	dio->next_block_for_io = -1;
 
 	dio->page_errors = 0;
+	dio->completion_code = 0;
 	dio->result = 0;
 	dio->iocb = iocb;
 	dio->i_size = i_size_read(inode);


