Return-Path: <SRS0=kmhh=EI=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C46C2D0A3
	for <io-uring@archiver.kernel.org>; Mon,  2 Nov 2020 21:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E9F206E5
	for <io-uring@archiver.kernel.org>; Mon,  2 Nov 2020 21:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgKBVAr (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 2 Nov 2020 16:00:47 -0500
Received: from shells.gnugeneration.com ([66.240.222.126]:51274 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKBVAq (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 2 Nov 2020 16:00:46 -0500
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2020 16:00:46 EST
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 90DB21A4035B; Mon,  2 Nov 2020 12:52:59 -0800 (PST)
Date:   Mon, 2 Nov 2020 12:52:59 -0800
From:   Vito Caputo <vcaputo@pengaru.com>
To:     io-uring@vger.kernel.org
Subject: relative openat dirfd reference on submit
Message-ID: <20201102205259.qsbp6yea3zfrqwuk@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hello list,

I've been tinkering a bit with some async continuation passing style
IO-oriented code employing liburing.  This exposed a kind of awkward
behavior I suspect could be better from an ergonomics perspective.

Imagine a bunch of OPENAT SQEs have been prepared, and they're all
relative to a common dirfd.  Once io_uring_submit() has consumed all
these SQEs across the syscall boundary, logically it seems the dirfd
should be safe to close, since these dirfd-dependent operations have
all been submitted to the kernel.

But when I attempted this, the subsequent OPENAT CQE results were all
-EBADFD errors.  It appeared the submit didn't add any references to
the dependent dirfd.

To work around this, I resorted to stowing the dirfd and maintaining a
shared refcount in the closures associated with these SQEs and
executed on their CQEs.  This effectively forced replicating the
batched relationship implicit in the shared parent dirfd, where I
otherwise had zero need to.  Just so I could defer closing the dirfd
until once all these closures had run on their respective CQE arrivals
and the refcount for the batch had reached zero.

It doesn't seem right.  If I ensure sufficient queue depth and
explicitly flush all the dependent SQEs beforehand
w/io_uring_submit(), it seems like I should be able to immediately
close(dirfd) and have the close be automagically deferred until the
last dependent CQE removes its reference from the kernel side.

Regards,
Vito Caputo
