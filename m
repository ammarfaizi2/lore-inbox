Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265830AbTIJWeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265883AbTIJWdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:33:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:62179 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265900AbTIJWbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:31:02 -0400
Date: Wed, 10 Sep 2003 15:12:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: jbarnes@sgi.com (Jesse Barnes)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] you have how many nodes??
Message-Id: <20030910151254.52f53e62.akpm@osdl.org>
In-Reply-To: <20030910213602.GC17266@sgi.com>
References: <20030910213602.GC17266@sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbarnes@sgi.com (Jesse Barnes) wrote:
>
> Needed this for booting on a 128 node system.
>
> -#define ZONE_SHIFT (BITS_PER_LONG - 8)
> +#define ZONE_SHIFT (BITS_PER_LONG - 10)

eeek, ia32 just lost another two page flags.

This stuff needs to be controlled by per-arch and per-subarch header files.

Instead of going backwards like this we'd like to actually free up _more_
bits in page->flags.  The worst (and controlling) case is on 32-bit NUMA:
eight nodes, three zones per node.  That's five bits, leaving us 27 page
flags.

So we'd need

	include/asm-foo/zonestuff.h:
	
	#define ARCH_MAX_NODES_SHIFT	3	/* Up to 8 nodes */
	#define ARCH_MAX_ZONES_SHIFT	2	/* Up to 4 zones per node */


and all the mm.h/mmzone.h constants use those two.


I think.  We could just say "dang numaq needs five bits", so:


	#if BITS_PER_LONG == 32
	#define ZONE_SHIFT 5
	#else
	#define ZONE_SHIFT 10
	#endif


Bit sleazy, but I think that would suffice.
