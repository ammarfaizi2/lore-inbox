Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWD2Xmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWD2Xmh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 19:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWD2Xmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 19:42:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750827AbWD2Xmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 19:42:36 -0400
Date: Sat, 29 Apr 2006 16:40:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: greg@kroah.com, kamezawa.hiroyu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH] catch valid mem range at onlining memory
Message-Id: <20060429164043.4cf4a861.akpm@osdl.org>
In-Reply-To: <20060429232615.GA18723@in.ibm.com>
References: <20060428114732.e889ad2d.kamezawa.hiroyu@jp.fujitsu.com>
	<20060428163409.389e895e.akpm@osdl.org>
	<20060428234410.GA7598@kroah.com>
	<20060428170519.1194b077.akpm@osdl.org>
	<20060429071818.GA939@kroah.com>
	<20060429232615.GA18723@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> wrote:
>
> > > All the code bloat's a bit sad though.  It would have been nice to have
> > > made the type of resource.start and .end Kconfigurable.  What happened
> > > to that?
> > 
> > Hm, I didn't remember anything about that.  Vivek, any thoughts?
> >
> 
> Having resource size configurable is nice but it brings added complexity
> with it. The question would be if code bloat is significant enough to 
> go for other option. Last time I had posted few compilation results on
> i386. I am summarizing these again.
> 
> allmodconfig (CONFIG_DEBUG_INFO=n)
> -----------
> 
> vmlinux bloat:4096 bytes
> 
> allyesconfig  (CONFIG_DEBUG_INFO=n)
> -----------
>                                                                                 
> vmlinux size bloat: 52K
> 
> So even with allyesconfig total bloat is 52K and I am assuming the
> systems where memory is at premium are going to use a very limited set
> of modules and effectively will see much lesser code bloat than 52K.
> 
> For Kconfigurable resource size, probably dma_addr_t is not the very 
> appropriate as at lots of places size also needs to be 64 bit and 
> using dma_addr_t is not good. This will then boil down to introducing
> a new type like dma_addr_t whose size is Kconfigurable.

Yes, it would need to to be a new type - resource_addr_t, perhaps.

> Even if it is done, it will not get rid of code bloat completely as lots
> of code bloat comes from printk() statemets where we explicitly typecast
> the resource to (unsigned long long) to avoid compilation warnings across
> the platforms. This typecasting will continue to be there even with
> Kconfigurable resources.

True.

But you know, just because a printk is present doesn't actually mean that
it's useful.

IOW, the default should be to just delete the printks (or the
resource.start/end parts of them), and to grudgingly put them back if
someone screams loudly enough.  We have other ways of viewing the
iomem_resource and ioport_resource trees.

> Personally I would tend to think that we can live with this code bloat.

Every little bit counts ;) We tend to be a bit obsessive about this, but I
think it's good, although perhaps wasteful of developer time..

I wouldn't view any of this as blocking the present patches.  It's
a separable project.
