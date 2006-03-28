Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWC1BVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWC1BVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 20:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWC1BVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 20:21:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63433 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751158AbWC1BVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 20:21:37 -0500
Date: Mon, 27 Mar 2006 17:23:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: adrian@smop.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1 leaks in dvb playback
Message-Id: <20060327172356.7d4923d2.akpm@osdl.org>
In-Reply-To: <20060326211514.GA19287@wyvern.smop.co.uk>
References: <20060326211514.GA19287@wyvern.smop.co.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bridgett <adrian@smop.co.uk> wrote:
>
> I've had this problem for a little while (probably since 2.6.14/15
> era) but I've only recently spent some time to figure out what's been
> going wrong.
> 
> There is a patch in the -mm series which causes leaks in both
> sock_inode_cache and dentry_cache for me during DVB playback (thanks
> to slabtop). 
> 
> 2.6.16 is fine (no leakage), 2.6.16-mm1 has this problem (~ 2MB/s in
> each cache).

Do you mean that the problem has been present in -mm kernels since the
2.6.14/15 timeframe, and not in mainline?

> I'm using dvbstream and sending the output to /dev/null,  dvb modules
> loaded are dvb_usb_vp7045, dvb_usb, dvb_core, dvb_pll.  It's an EHCI USB
> device running on a Dell D600 latitude.
> 
> turning on some debugging and looking at /proc/slab_allocators and
> /proc/page_owners shows that the most prevalent page owners are:
> 
> (5363 out of 5631)
> Page allocated via order 0, mask 0xd0
> [0xc0161079] poison_obj+41
> [0xc0162355] cache_alloc_refill+981
> [0xc0161889] cache_alloc_debugcheck_after+169
> [0xc01d5169] vsnprintf+857
> [0xc0247eec] lock_sock+204
> [0xc0244999] sock_alloc_inode+25
> [0xc0161f73] kmem_cache_alloc+131
> [0xc027a4b4] inet_csk_accept+436
> 
> (1989 out of 2734)
> Page allocated via order 0, mask 0xd0
> [0xc0162355] cache_alloc_refill+981
> [0xc0161079] poison_obj+41
> [0xc0161079] poison_obj+41
> [0xc01d5169] vsnprintf+857
> [0xc0182341] d_alloc+33
> [0xc0161f73] kmem_cache_alloc+131
> [0xc0182341] d_alloc+33
> [0xc02461e0] sock_attach_fd+96
> 

Strange.  Are you sure that they really leak?  Doing

	echo 3 > /proc/sys/vm/drop_caches

doesn't make them go away?
