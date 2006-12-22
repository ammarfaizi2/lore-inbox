Return-Path: <linux-kernel-owner+w=401wt.eu-S1752423AbWLVTrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbWLVTrA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbWLVTrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:47:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38882 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752423AbWLVTq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:46:59 -0500
Date: Fri, 22 Dec 2006 14:55:32 -0500 (EST)
Message-Id: <20061222.145532.104028283.k-ueda@ct.jp.nec.com>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: mchristi@redhat.com, linux-kernel@vger.kernel.org, agk@redhat.com,
       jens.axboe@oracle.com, dm-devel@redhat.com, j-nomura@ce.jp.nec.com,
       k-ueda@ct.jp.nec.com
Subject: Re: [dm-devel] Re: [RFC PATCH 2/8] rqbased-dm: add block layer hook
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
In-Reply-To: <458B86D4.3000107@cs.wisc.edu>
References: <20061221074947.GC17199@kernel.dk>
	<20061221.172246.21934588.k-ueda@ct.jp.nec.com>
	<458B86D4.3000107@cs.wisc.edu>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Fri, 22 Dec 2006 01:18:44 -0600, Mike Christie <michaelc@cs.wisc.edu> wrote:
> > In addition to the suggested approach, what do you think about
> > adding a new flag to req->cmd_flags which lets the end_io() handler
> > not to return bio to upper layer?
> > It will be useful for multipathing and can be done even within
> > the current __end_that_request_first().
> > For example,
> > 
> > static int __end_that_request_first()
> > {
> > 	.....
> > 	error = 0;
> > 	if (end_io_error(uptodate))
> > 		error = !uptodate ? -EIO : uptodate;
> > 	.....
> > 	if (error && (req->cmd_flags & "NEW_FLAG"))
> > 		return 0; /* Tell the driver to call end_that_request_last() */
> > 
> > 	total_types = bio_nbytes = 0;
> > 	while ((bio = req->bio) != NULL) {
> > 		..... /* process of finishing bios */
> > 	}
> > 	.....
> > }
> > 
> 
> Who would call end_that_request_first with the new flag set? The scsi
> layer or multipath layer?

Multipath layer sets the new flag.
SCSI layer of an underlying device calls __end_that_request_first()
for a cloned request.  And original bios which were issued to a dm
device will be completed through the cloned request when no error
occurs on the clone.  When an error occurs, the completion process of
the bios are skipped.

Thanks,
Kiyoshi Ueda

