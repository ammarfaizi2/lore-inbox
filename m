Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWCWJgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWCWJgZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWCWJgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:36:25 -0500
Received: from [194.90.237.34] ([194.90.237.34]:40846 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S932425AbWCWJgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:36:24 -0500
Date: Thu, 23 Mar 2006 11:37:13 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, rdreier@cisco.com, greg@kroah.com,
       openib-general@openib.org
Subject: Re: [PATCH 9 of 18] ipath - char devices for diagnostics and lightweight subnet management
Message-ID: <20060323093713.GB1802@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <patchbomb.1143072293@eng-12.pathscale.com> <dffa0687112e4fdcf7d0.1143072302@eng-12.pathscale.com> <20060323064113.GC9841@mellanox.co.il> <1143103701.6411.21.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143103701.6411.21.camel@camp4.serpentine.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 23 Mar 2006 09:39:05.0625 (UTC) FILETIME=[A060A090:01C64E5D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Bryan O'Sullivan <bos@pathscale.com>:
> > Could you please explain why is this useful? Users could not care less -
> > they never have to touch an SMA.
> 
> We have customers who use our driver who do not want a full IB stack
> present, for example in embedded environments.

I understand they do, but they could just use the parts of IB stack and never
notice.  In my experience, embedded systems are typically diskless - why is a
userspace SMA better than kernel-level one for them? The advantage would be
everyone using a single kernel/user interface, common utilities for
management, diagnostics ... I could go on.

So what's your point? Memory usage? Let's take a look:

ib_mad is the IB stack module that includes between other things the
kernel-level SMA (BTW, if necessary, you should be able to split it out so that
it is only loaded on demand):

I think IB stack is modest, as core modules go.
Here's how a loaded IB stack looks like on my system:

Module                  Size  Used by
ib_mad                 36260  2 ib_ipath,ib_mthca
ib_core                46080  3 ib_ipath,ib_mthca,ib_mad

So there are *maximum* 82K code to save.  This is a 64-bit system, I think
embedded systems are usually 32 bit so there'll be just 41K.

And I don't believe you can save much since as a solution you seem to have
re-implemented the full IB stack in your low level driver:

Module                  Size  Used by
ib_ipath               79256  0
ipath_core            159764  1 ib_ipath

By contrast, a low-level which doesn't reimplement IB core is just a bit
above 100K.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
