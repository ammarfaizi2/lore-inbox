Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWB1Ru7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWB1Ru7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWB1Ru6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:50:58 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:8098 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S932285AbWB1Ru6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:50:58 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Date: Tue, 28 Feb 2006 09:50:53 -0800
User-Agent: KMail/1.9.1
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <1140841250.2587.33.camel@localhost.localdomain> <1140894083.9852.30.camel@localhost.localdomain> <200602280944.32210.jbarnes@virtuousgeek.org>
In-Reply-To: <200602280944.32210.jbarnes@virtuousgeek.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602280950.53412.jbarnes@virtuousgeek.org>
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

On Tuesday, February 28, 2006 9:44 am, Jesse Barnes wrote:
> Something like this would be really handy.  Check out fbmem.c:fb_mmap
> for a bad example of what can happen w/o it.
>
> In fact, I think it might make sense to export WC functionality via an
> mmap flag (on an advisory basis since the platform may not support it
> or there may be aliasing issues that prevent it); having an arch
> independent routine to request it would make that addition easy to do
> in generic code.  (In particular I wanted this for the sysfs PCI
> interface. Userspace apps can map PCI resources there and it would be
> nice if they could map them with WC semantics if requested.)

Oh, forgot to mention fallback semantics.  Instead of almost every driver 
doing:
	if (!(iocookie = ioremap_writecombine(addr, size)))
		iocookie = ioremap(addr, size); /* fallback to uncached */

maybe it would be best to have something like

	iocookie = ioremap_wc_or_uc(addr, size);

that tries write combine first but silently falls back to UC if the 
former is impossible (or a new ioremap with flags or priority args or 
whatever).  OTOH some drivers may want to be notified if the WC mapping 
fails?  Just a thought...

Jesse
