Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWCOWK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWCOWK5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWCOWK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:10:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65445 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751194AbWCOWK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:10:56 -0500
Date: Wed, 15 Mar 2006 14:13:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: bcrl@kvack.org, galak@kernel.crashing.org, vgoyal@in.ibm.com,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org, gregkh@suse.de
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in
 "struct resource"
Message-Id: <20060315141305.13864705.akpm@osdl.org>
In-Reply-To: <m1fylje5sv.fsf@ebiederm.dsl.xmission.com>
References: <20060315193114.GA7465@in.ibm.com>
	<20060315205306.GC25361@kvack.org>
	<46E23BE4-4353-472B-90E6-C9E7A3CFFC15@kernel.crashing.org>
	<20060315211335.GD25361@kvack.org>
	<m1y7zbe6rn.fsf@ebiederm.dsl.xmission.com>
	<20060315212841.GE25361@kvack.org>
	<m1fylje5sv.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> Benjamin LaHaise <bcrl@kvack.org> writes:
> 
> > On Wed, Mar 15, 2006 at 02:29:32PM -0700, Eric W. Biederman wrote:
> >> If the impact is very slight or unmeasurable this means the option
> >> needs to fall under CONFIG_EMBEDDED, where you can change if
> >> every last bit of RAM counts but otherwise you won't care.
> >
> > But we have a data type that is correct for this usage: dma_addr_t.
> 
> Well the name is wrong.  Because these are in general not DMA addresses,
> but it may have the other desired properties.  So it may be
> useable.

Yes, dma_addr_t does the right thing but has the wrong name.

I guess it should have been called bus_addr_t (?).  If so, I guess a
suitable compromise might be:

#ifndef bus_addr_t
#define bus_addr_t dma_addr_t
#endif

then use bus_addr_t in struct resource.

Yes, we'd like to see the impact on vmlinux size, please.

Many of the problems will be in printks.  Whoever does this work should
capture stderr from before- and after- allmodconfig builds and diff them.

The appropriate way to printk a bus_addr_t will be

	printk("%lld", (unsigned long long)val);

which will increase code size even if bus_addr_t is u32, sadly.


Finally, we shouldn't just slavishly fix up great piles of printks to fix
the warnings (actually they're bugs).  Lots of the printks we have are
fairly useless, and there are other ways of finding out a device's IO and
IOMEM addresses anyway.

So IMO the preferred way of fixing a printk which is generating warnings is
to delete the thing.  Chances are that if the affected code actually has a
maintainer, he won't notice anyway ;)

