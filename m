Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUFJNPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUFJNPT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 09:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUFJNPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 09:15:19 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:62666 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261234AbUFJNPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 09:15:13 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/5: Device-mapper: kcopyd
Date: Thu, 10 Jun 2004 08:16:18 +0000
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Alasdair G Kergon <agk@redhat.com>
References: <20040602154129.GO6302@agk.surrey.redhat.com> <20040609231805.029672aa.akpm@osdl.org>
In-Reply-To: <20040609231805.029672aa.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406100816.18263.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 June 2004 6:18 am, Andrew Morton wrote:
> Alasdair G Kergon <agk@redhat.com> wrote:
> > kcopyd
> >
> > ...
> > +/* FIXME: this should scale with the number of pages */
> > +#define MIN_JOBS 512
>
> This pins at least 2MB of RAM up-front, even if devicemapper is not in use.

Is that really the case? The MIN_JOBS value is used to initialize the mempool 
of kcopyd_job structures (see kcopyd.c::jobs_init()). A kcopyd_job is 
(according to my calculations on i386) 272 bytes. If you assume they are 
nicely aligned, then we'll round that up to 512 bytes. This means you should 
be able to fit 8 of those structures in a page, and initializing to MIN_JOBS 
should only use 256kB of RAM. Granted, 256kB of RAM isn't all the great 
either, but it's about an order of magnitude less than 2MB.

Or am I not understanding how kmem_caches and mempools work?

The jobs_init() routine is run (and hence the kmem_cache and mempool are 
created) when kcopyd() is loaded, so the min-value has to be set to some 
static number. One possibility to cut down on the up-front memory usage would 
be to reduce the static MIN_JOBS value, and then use mempool_resize() when 
the kcopyd users call kcopyd_client_[create|destroy].

Another thing we could do would be to build kcopyd as its own kernel module. 
Right now it's built in the same module with the core DM driver, so it's 
loaded any time DM is loaded, regardless of whether any DM module is using 
it. It should be fairly easy to split it out in its own module, which means 
that mempool won't be created until some other module is loaded that depends 
on kcopyd.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
