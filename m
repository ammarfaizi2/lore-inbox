Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTKYW7r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 17:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTKYW7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 17:59:47 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:53759 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263645AbTKYW7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 17:59:45 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 2.6.0-test10 O_DIRECT memory leak fix
Date: Tue, 25 Nov 2003 14:49:50 -0800
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_2FJXPTP7CPDOM9S4U30O"
Message-Id: <200311251449.50397.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_2FJXPTP7CPDOM9S4U30O
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

I found the problem with O_DIRECT memory leak.

The problem is, when we are doing DIO read and crossed the end of file -
we don't release referencess on all the pages we got from get_user_pages(=
).
(since it is a sucess case).

The fix is to call dio_cleanup() even for sucess cases. Can you please
review this ? I tested the patch with fsstress and there are no memory le=
ak=20
problems now.

Thanks,
Badari

--------------Boundary-00=_2FJXPTP7CPDOM9S4U30O
Content-Type: text/x-diff;
  charset="us-ascii";
  name="dioleak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dioleak.patch"

--- linux-2.6.0-test10/fs/direct-io.c	2003-11-25 12:45:14.000000000 -0800
+++ linux-2.6.0-test10.new/fs/direct-io.c	2003-11-25 15:20:26.554239616 -0800
@@ -946,6 +946,12 @@ direct_io_worker(int rw, struct kiocb *i
 	if (dio->bio)
 		dio_bio_submit(dio);
 
+	/* 
+	 * It is possible that, we return short IO due to end of file.
+	 * In that case, we need to release all the pages we got hold on.
+	 */ 
+	dio_cleanup(dio);
+
 	/*
 	 * OK, all BIOs are submitted, so we can decrement bio_count to truly
 	 * reflect the number of to-be-processed BIOs.

--------------Boundary-00=_2FJXPTP7CPDOM9S4U30O--

