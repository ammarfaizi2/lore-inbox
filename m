Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbVBQSS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVBQSS4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 13:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVBQSSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 13:18:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:3239 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262324AbVBQSSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 13:18:01 -0500
Date: Thu, 17 Feb 2005 10:18:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
cc: Andrew Morton <akpm@osdl.org>, noel@zhtwn.com, kas@fi.muni.cz,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: -rc3 leaking NOT BIO [Was: Memory leak in 2.6.11-rc1?]
In-Reply-To: <200502170800.28012.kernel-stuff@comcast.net>
Message-ID: <Pine.LNX.4.58.0502171014200.2371@ppc970.osdl.org>
References: <20050121161959.GO3922@fi.muni.cz> <200502160107.08039.kernel-stuff@comcast.net>
 <20050216155255.0ffab555.akpm@osdl.org> <200502170800.28012.kernel-stuff@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 17 Feb 2005, Parag Warudkar wrote:
> 
> A question - is it safe to assume it is  a kmalloc based leak? (I am thinking 
> of tracking it down by using kprobes to insert a probe into __kmalloc and 
> record the stack to see what is causing so many allocations.)

It's definitely kmalloc-based, but you may not catch it in __kmalloc. The 
"kmalloc()" function is actually an inline function which has some magic 
compile-time code that statically determines when the size is constant and 
can be turned into a direct call to "kmem_cache_alloc()" with the proper 
cache descriptor.

So you'd need to either instrument kmem_cache_alloc() (and trigger on the 
proper slab descriptor) or you would need to modify the kmalloc() 
definition in <linux/slab.h> to not do the constant size optimization, at 
which point you can instrument just __kmalloc() and avoid some of the 
overhead.

		Linus
