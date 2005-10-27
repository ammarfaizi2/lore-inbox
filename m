Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVJ0Q4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVJ0Q4T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 12:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVJ0Q4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 12:56:19 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:31184 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751291AbVJ0Q4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 12:56:18 -0400
Date: Thu, 27 Oct 2005 09:54:49 -0700
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, torvalds@osdl.org, arjan@infradead.org, dada1@cosmosbay.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 spinlocks should use the full 32 bits, not only 8
 bits
Message-Id: <20051027095449.028ef1db.pj@sgi.com>
In-Reply-To: <20051020232658.GA29923@elte.hu>
References: <20051017000343.782d46fc.akpm@osdl.org>
	<1129533603.2907.12.camel@laptopd505.fenrus.org>
	<20051020215047.GA24178@elte.hu>
	<Pine.LNX.4.64.0510201455030.10477@g5.osdl.org>
	<20051020220228.GA26247@elte.hu>
	<Pine.LNX.4.64.0510201512480.10477@g5.osdl.org>
	<20051020222703.GA28221@elte.hu>
	<20051020154457.100b5565.akpm@osdl.org>
	<20051020225347.GA29303@elte.hu>
	<20051020160115.2b34cb8e.akpm@osdl.org>
	<20051020232658.GA29923@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Ingo - I think you broke the sparc defconfig build with this.

I am seeing the sparc defconfig (crosstool) build broken with 2.6.14-rc5-mm1.
It built ok with 2.6.14-rc4-mm1.

This build now fails for me, with:

=========================================================
  CC      net/ipv4/route.o
In file included from include/linux/mroute.h:129,
                 from net/ipv4/route.c:89:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function `__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function `__raw_write_unlock'
net/ipv4/route.c: In function `rt_check_expire':
net/ipv4/route.c:663: warning: dereferencing `void *' pointer
net/ipv4/route.c:663: error: request for member `raw_lock' in something not a structure or union
make[2]: *** [net/ipv4/route.o] Error 1
=========================================================

Your patch added:

> +++ linux/include/linux/spinlock.h
> ...
> +# define write_unlock_irq(lock) \
> +    do { __raw_write_unlock(&(lock)->raw_lock); local_irq_enable(); } while (0)

I see __raw_write_unlock defined in include/asm-sparc/spinlock.h, which
is not included in defconfig sparc builds because such builds are non-
debug UP builds.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
