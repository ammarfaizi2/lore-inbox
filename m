Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTE2Rhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 13:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbTE2Rhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 13:37:39 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:48132 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S262439AbTE2Rhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 13:37:38 -0400
Date: Thu, 29 May 2003 19:49:15 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "David S. Miller" <davem@redhat.com>
cc: mika.penttila@kolumbus.fi, <rmk@arm.linux.org.uk>,
       Andrew Morton <akpm@digeo.com>, <hugh@veritas.com>,
       <LW@karo-electronics.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at
 least))
In-Reply-To: <20030528.183700.104033543.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0305291738000.5042-100000@serv>
References: <Pine.LNX.4.44.0305281827290.5042-100000@serv>
 <20030528.154720.74745668.davem@redhat.com> <Pine.LNX.4.44.0305290151470.5042-100000@serv>
 <20030528.183700.104033543.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 28 May 2003, David S. Miller wrote:

> DMA-mapping.txt defines very precisely when flush_dcache_page() is
> invoked, and that is it's only definition.  I purposely DO NOT say
> that "this is for reads" or "this is for handling virtual aliasing
> in L1 caches", I simply define where this macro is invoked and
> that is it.
> 
> Specifically, flush_dcache_page() is called any time the kernel makes
> cpu stores into a page cache page that might be mapped into a user's
> address space.

cachetlb.txt also says "_OR_ the kernel is about to read from a page cache 
page..." and it's used like this in mm/filemap.c. I think it would be 
better to move this into a separate function, e.g. like this:

flush_user_dcache_page(): If the page is mapped writable into user space, 
flush the dirty data from the user D-cache, so it becomes visible from the 
kernel.
flush_kernel_dcache_page(): The page was written from kernel space and the 
data has to become visible in user space, so flush the data into memory 
and possibly invalidate data in the user D/I-cache. The flush can be 
delayed if this page is currently not mapped.

bye, Roman

