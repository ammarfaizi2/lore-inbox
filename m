Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbTJCWBJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 18:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbTJCWBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 18:01:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:38885 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261267AbTJCWBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 18:01:06 -0400
Subject: Re: PATCH 2.6.0-test6-mm2] aio ref count during retry
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031003144010.3445ec1f.akpm@osdl.org>
References: <1064596018.1950.10.camel@ibm-c.pdx.osdl.net>
	 <1064620762.2115.29.camel@ibm-c.pdx.osdl.net>
	 <20030929040935.GA3637@in.ibm.com> <20030929131057.GA4630@in.ibm.com>
	 <1064876358.23108.41.camel@ibm-c.pdx.osdl.net>
	 <20030930040020.GA3435@in.ibm.com>
	 <1064964169.1922.16.camel@ibm-c.pdx.osdl.net>
	 <20031001084639.GA4188@in.ibm.com>
	 <1065215946.1862.164.camel@ibm-c.pdx.osdl.net>
	 <20031003144010.3445ec1f.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1065218455.1862.198.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Oct 2003 15:00:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-03 at 14:40, Andrew Morton wrote:
> Daniel McNeil <daniel@osdl.org> wrote:
> >
> > Here is the patch for AIO retry to hold an extra ref count.
> > The patch is small, but I wanted to make sure it was safe.
> > I spent time looking over the retry code and this patch looks
> > ok to me.  It is potentially calling put_ioctx() while holding
> > ctx->ctx_lock, I do not think that will cause any problems.
> > This should never be the last reference on the ioctx anyway,
> > since the loop is checking list_empty(&ctx->run_list).
> 
> So...  if the refcount is never zero in there, why are you changing it to
> take an additional reference?

The extra reference is on the iocb itself.  Each iocb has a reference
on the ioctx.  When dropping the extra reference using __aio_put_req(),
you have to check if it was the last reference and then drop that iocb's
reference on the ioctx by calling put_ioctx().  It is the ioctx's ref
count that is never zero here.

Having the extra ref on the iocb, guarantees that the iocb won't be
freed until the extra reference is dropped. In the initial submit
case, the lower level code has looking at the iocb after submitting
it (which was racy without the extra reference).  This patch just
added the extra reference for iocb during retries.

Daniel

