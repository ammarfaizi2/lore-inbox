Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751866AbWB1Roj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbWB1Roj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWB1Roi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:44:38 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:30624 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S1751866AbWB1Roi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:44:38 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Date: Tue, 28 Feb 2006 09:44:31 -0800
User-Agent: KMail/1.9.1
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <1140841250.2587.33.camel@localhost.localdomain> <200602251428.01767.ak@suse.de> <1140894083.9852.30.camel@localhost.localdomain>
In-Reply-To: <1140894083.9852.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602280944.32210.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, February 25, 2006 11:01 am, Bryan O'Sullivan wrote:
> On Sat, 2006-02-25 at 14:28 +0100, Andi Kleen wrote:
> > Before we can add such a macro I suspect you would first
> > need to provide some spec how that "portable write combining"
> > is supposed to work and get feedback from the other architectures.
>
> It seems like we'd need a function that tries to enable or disable
> write combining on an MMIO memory range.  This would be implemented by
> arches that support it, and would fail on others.  Drivers could then
> try to enable write combining, and if it failed, either bail, print a
> warning message, or do something else appropriate.
>
> So on i386 and x86_64, this function would fiddle with the MTRRs.  On
> powerpc, it would either configure the northbridge appropriately or
> fail.  On other arches, I don't know enough to say, so the default
> would be to fail.
>
> Is this reasonable?  I can code a strawman implementation up, if the
> basic idea looks sane.

Something like this would be really handy.  Check out fbmem.c:fb_mmap for 
a bad example of what can happen w/o it.

In fact, I think it might make sense to export WC functionality via an 
mmap flag (on an advisory basis since the platform may not support it or 
there may be aliasing issues that prevent it); having an arch 
independent routine to request it would make that addition easy to do in 
generic code.  (In particular I wanted this for the sysfs PCI interface.  
Userspace apps can map PCI resources there and it would be nice if they 
could map them with WC semantics if requested.)

I don't think it addresses the flushing issue you seem to be concerned 
about though.  I don't know the exact semantics of sfence, but I think 
bcrl is likely right that it won't absolutely guarantee that your writes 
have hit the device before proceeding (though it may do that on some CPU 
implementations).

Thanks,
Jesse
