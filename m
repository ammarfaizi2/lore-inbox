Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269084AbUIBVSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269084AbUIBVSD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbUIBVRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:17:50 -0400
Received: from cantor.suse.de ([195.135.220.2]:19108 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269084AbUIBVOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:14:50 -0400
Date: Thu, 2 Sep 2004 23:14:48 +0200
From: Andi Kleen <ak@suse.de>
To: Roland Dreier <roland@topspin.com>
Cc: jakub@redhat.com, ak@suse.de, ecd@skynet.be, pavel@suse.cz,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/compat.c: rwsem instead of BKL around ioctl32_hash_table
Message-ID: <20040902211448.GE16175@wotan.suse.de>
References: <20040901072245.GF13749@mellanox.co.il> <524qmi2e1s.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524qmi2e1s.fsf@topspin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 08:40:15AM -0700, Roland Dreier wrote:
> Currently the BKL is used to synchronize access to ioctl32_hash_table
> in fs/compat.c.  It seems that an rwsem would be more appropriate,
> since this would allow multiple lookups to occur in parallel (and also
> serve the general good of minimizing use of the BKL).
> 
> I added lock_kernel()/unlock_kernel() around the call to t->handler
> when a compatibility handler is found in compat_sys_ioctl() to
> preserve the expectation that the BKL will be held during driver ioctl
> operations.  It should be safe to do lock_kernel() while holding
> ioctl32_sem because of the magic BKL sleep semantics.
> 
> I have booted this and run some basic 32-bit userspace on ppc64, and
> also compile tested this for x86_64 and sparc64.

It does not make much sense because the ioctl will take the BKL 
anyways.

If you wanted to fix it properly better make it use RCU - 
but it cannot work for the case of calling a compat handler.

-Andi
