Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUHTHWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUHTHWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUHTHWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:22:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:38801 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267602AbUHTHSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:18:22 -0400
Date: Fri, 20 Aug 2004 00:16:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: cherry@osdl.org, linux-kernel@vger.kernel.org, zam@namesys.com,
       demidov@namesys.com
Subject: Re: 2.6.8.1-mm2
Message-Id: <20040820001629.387715be.akpm@osdl.org>
In-Reply-To: <4125A2F6.5050308@namesys.com>
References: <20040819014204.2d412e9b.akpm@osdl.org>
	<1092927166.29916.0.camel@cherrybomb.pdx.osdl.net>
	<4125A2F6.5050308@namesys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> John Cherry wrote:
> 
> >The new "errors" are from reiser4 code and they all appear to be...
> >
> >fs/reiser4/reiser4.h:18:2: #error "Please turn 4k stack off"
> >
> >  
> >
> zam, can you or Mr. Demidov work on using kmalloc to reduce stack usage?
> 
> Andrew suggested that for statically sized objects kmalloc is quite fast 
> (one instruction I think he said), so my objection to kmallocing a lot 
> has faded.

err, not that quick - but it's pretty quick.

With a kmalloc with a constant size and, preferably, a constant gfp mask
we'll jump directly into __cache_alloc() and in the common case we'll pluck
an entry directly out of the cpu-local head array:

So the kmalloc fastpath is, effectively:

	local_irq_save(save_flags);
	ac = ac_data(cachep);
	if (likely(ac->avail)) {
		ac->touched = 1;
		objp = ac_entry(ac)[--ac->avail];
	}
	local_irq_restore(save_flags);
	return objp;


Not bad...
