Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbVLNVUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbVLNVUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 16:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbVLNVUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 16:20:05 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:53993 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S964992AbVLNVUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 16:20:03 -0500
Subject: Re: [PATCH/RFC] SPI: add async message handing library to
	David	Brownell's core
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
       dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
In-Reply-To: <43A07577.5080501@ru.mvista.com>
References: <20051212182026.4e393d5a.vwool@ru.mvista.com>
	 <20051213170629.7240d211.vwool@ru.mvista.com>
	 <1134586122.24118.52.camel@localhost.localdomain>
	 <43A07577.5080501@ru.mvista.com>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Wed, 14 Dec 2005 13:19:59 -0800
Message-Id: <1134595199.24118.118.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 22:41 +0300, Vitaly Wool wrote:
> >Is this really true?  Is tasklet scheduling "harder" than kernal thread
> >scheduling?  A close look at my PXA SSP SPI implementation will reveal
> >that my design is nearly lock-less and callable from any execution
> >context (i.e. interrupt context).
> >  
> >
> It's harder in your case because the tasklet is created each time it's 
> scheduled again, as far as I see it in your impleemntation.
> Each SPI controller thread is created only once so it's more lightweight 
> than what you do.
> 
I'm not sure what you mean by "create".  The tasklet structures are
created and initialized once in the driver probe function.  I'm not an
expert but I looked into the implementation (softirq.c) of tasklets and
found the following design:

1) Tasklets are run by a softirq.
2) A softirq is really a kernel thread allocated on a per cpu basis.
3) A "scheduled" tasklet is simply a member of a link list maintained by
the softirq thread.

My driver implementation has the following features:

1) Uses only one kernel thread for all SPI controllers.
2) Reuses existing performance tuned kernel infrastructure (i.e.
tasklets)
3) Implements a low latency locking scheme for dispatching SPI transfers
via tasklet's serial scheduling guarantees.

IMHO, from a system load perspective, my approach is lighter and simpler
than adding a dedicated kernel thread for each SPI controller.

Stephen


