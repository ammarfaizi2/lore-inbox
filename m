Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269324AbUHZS3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269324AbUHZS3A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269216AbUHZSYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:24:18 -0400
Received: from peabody.ximian.com ([130.57.169.10]:12958 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269339AbUHZSRj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:17:39 -0400
Subject: Re: POSIX_FADV_NOREUSE and O_STREAMING behavior in 2.6.7
From: Robert Love <rml@ximian.com>
To: drolenc@rtlogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <412E2058.60302@rtlogic.com>
References: <412E2058.60302@rtlogic.com>
Content-Type: text/plain
Date: Thu, 26 Aug 2004 14:17:19 -0400
Message-Id: <1093544239.30480.7.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 11:39 -0600, David Rolenc wrote:
> I am trying to get O_STREAMING (Robert Love patch for 2.4) behavior in 
> 2.6 and just a glance at fadvise.c suggests that POSIX_FADV_NOREUSE is 
> not implemented any differently than POSIX_FADV_WILLNEED. Am I missing 
> something?

Yes, they are currently the same.  Their difference in theory is subtle:
NOREUSE says "I will use this once in the future" and WILLNEED says "I
will use this [some number of times] in the future".

So for both of them, you want to keep the data in the page cache.  But
for NOREUSE you could do drop-behind of the pages.  But Linux does not
currently do drop-behind, so we have them both do the same thing.

>  I want to read data from disk with readahead and drop the 
> data from the page cache as soon as I am done with it. Do I have to call 
> fadvise with POSIX_FADV_DONTNEED after every read?

Yes, you do.  Or every couple of reads.

The sort of applications that need DONTNEED already are setup in a way
to make that easy.  You either have a streaming loop, like:

	do {
		read
		process
	} while (repeat);

Or you are readings lots of files (like updatedb).

In the first case, just stick the fadvise call after the processing.  In
the latter case, call fadvise before closing the file.

You don't _have_ to call fadvise after every reading.  Just whenever you
want to drop the pages.  Whenever it makes sense.

	Robert Love


