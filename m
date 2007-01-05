Return-Path: <linux-kernel-owner+w=401wt.eu-S1422680AbXAETAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422680AbXAETAA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 14:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbXAETAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 14:00:00 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:42654 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422673AbXAES77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 13:59:59 -0500
Subject: RE: [openib-general] [PATCH  v4 01/13] Linux RDMA Core Changes
From: Steve Wise <swise@opengridcomputing.com>
To: Felix Marti <felix@chelsio.com>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, netdev@vger.kernel.org
In-Reply-To: <8A71B368A89016469F72CD08050AD334F3BE50@maui.asicdesigners.com>
References: <8A71B368A89016469F72CD08050AD334F3BE50@maui.asicdesigners.com>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 12:59:59 -0600
Message-Id: <1168023599.14028.38.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-05 at 09:32 -0800, Felix Marti wrote:
> 
> > -----Original Message-----
> > From: openib-general-bounces@openib.org [mailto:openib-general-
> > bounces@openib.org] On Behalf Of Steve Wise
> > Sent: Friday, January 05, 2007 6:22 AM
> > To: Roland Dreier
> > Cc: linux-kernel@vger.kernel.org; openib-general@openib.org;
> > netdev@vger.kernel.org
> > Subject: Re: [openib-general] [PATCH v4 01/13] Linux RDMA Core Changes
> > 
> > On Thu, 2007-01-04 at 13:34 -0800, Roland Dreier wrote:
> > > OK, I'm back from vacation today.
> > >
> > > Anyway I don't have a definitive statement on this right now.  I
> guess
> > > I agree that I don't like having an extra parameter to a function
> that
> > > should be pretty fast (although req notify isn't quite as hot as
> > > something like posting a send request or polling a cq), given that
> it
> > > adds measurable overhead.  (And I am surprised that the overhead is
> > > measurable, since 3 arguments still fit in registers, but OK).
> > >
> > > I also agree that adding an extra entry point just to pass in the
> user
> > > data is ugly, and also racy.
> > >
> > > Giving the kernel driver a pointer it can read seems OK I guess,
> > > although it's a little ugly to have a backdoor channel like that.
> > >
> > 
> > Another alternative is for the cq-index u32 memory to be allocated by
> > the kernel and mapped into the user process.  So the lib can
> read/write
> > it, and the kernel can read it directly.  This is the fastest way
> > perfwise, but I didn't want to do it because of the page granularity
> of
> > mapping.  IE it would require a page of address space (and backing
> > memory I guess) just for 1 u32.  The CQ element array memory is
> already
> > allocated this way (and its DMA coherent too), but I didn't want to
> > overload that memory with this extra variable either.  Mapping just
> > seemed ugly and wasteful to me.
> > 
> > So given 3 approaches:
> > 
> > 1) allow user data to be passed into ib_req_notify_cq() via the
> standard
> > uverbs mechanisms.
> > 
> > 2) hide this in the chelsio driver and have the driver copyin the info
> > directly.
> > 
> > 3) allocate the memory for this in the kernel and map it to the user
> > process.
> > 
> > I chose 1 because it seemed the cleanest from an architecture point of
> > view and I didn't think it would impact performance much.
> 
> [Felix Marti] In addition, is arming the CQ really in the performance
> path? - Don't apps poll the CQ as long as there are pending CQEs and
> only arm the CQ for notification once there is nothing left to do? If
> this is the case, it would mean that we waste a few cycles 'idle'
> cycles. 

I tend to agree.  This shouldn't be the hot perf path like
post_send/recv and poll.

> Steve, next to the micro benchmark that you did, did you run any
> performance benchmark that actually moves traffic? If so, did you see a
> difference in performance?
> 

No.  But I didn't explicitly measure with and without this one single
change.


