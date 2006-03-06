Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWCFTge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWCFTge (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbWCFTge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:36:34 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:63550 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750926AbWCFTgd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:36:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tiXqF8m8AcCvELi7Rq269bGZzwWi0vvO9W7gb3CqmpO4/8+WSR6wPt2u8Bw97qVvQgLD6CmVTESCT4Fu5i6qHqwKFirZW+d4II2h9yM4IGpiU1c9WIUKpEaq2YkzZhlfHmoWg4r2Px8EB2W3PB3hdTmBZ+Ud8r/q1R7for/+HiM=
Message-ID: <41b516cb0603061136r4569d393i4e7ec5b7f66da669@mail.gmail.com>
Date: Mon, 6 Mar 2006 11:36:32 -0800
From: "Chris Leech" <chris.leech@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 8/8] [I/OAT] TCP recv offload to I/OAT
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060305004534.1d94b3cf.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060303214036.11908.10499.stgit@gitlost.site>
	 <20060303214236.11908.98881.stgit@gitlost.site>
	 <20060305004534.1d94b3cf.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/06, Andrew Morton <akpm@osdl.org> wrote:
> Chris Leech <christopher.leech@intel.com> wrote:
> >
> > +#ifdef CONFIG_NET_DMA
> >  +    tp->ucopy.dma_chan = NULL;
> >  +    if ((len > sysctl_tcp_dma_copybreak) && !(flags & MSG_PEEK) && !sysctl_tcp_low_latency && __get_cpu_var(softnet_data.net_dma))
> >  +            dma_lock_iovec_pages(msg->msg_iov, len, &tp->ucopy.locked_list);
> >  +#endif
>
> The __get_cpu_var() here will run smp_processor_id() from preemptible
> context.  You'll get a big warning if the correct debug options are set.
>
> The reason for this is that preemption could cause this code to hop between
> CPUs.

I've been playing with different models of where to select which DMA
channel to use in order to reduce cache thrash and lock contention in
the driver.  It's not a clean per-cpu issue because per I/O there are
potentially operations happening in both the process syscall and the
netrx softirq context.

Right now the code delays selection of a DMA channel until the first
offload copy is ready to go, so the __get_cpu_var() you point out is
just checking to see if any hardware exists for I/OAT at this point
before doing the page pinning.  Before anything is done with the
channel the per-cpu pointer is re-read safely with preemption disabled
and a reference count is incremented.

 - Chris
