Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWHBHUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWHBHUN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWHBHUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:20:13 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:45533 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751313AbWHBHUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:20:12 -0400
Subject: Re: [PATCH 7 of 13] Make __FIXADDR_TOP variable to allow it to
	make space for a hypervisor
From: Rusty Russell <rusty@rustcorp.com.au>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andrew Morton <akpm@osdl.org>, jeremy@xensource.com,
       linux-kernel@vger.kernel.org, Christian.Limpach@cl.cam.ac.uk,
       clameter@sgi.com, ebiederm@xmission.com, kraxel@suse.de,
       hollisb@us.ibm.com, ian.pratt@xensource.com, zach@vmware.com
In-Reply-To: <20060802070147.GM2654@sequoia.sous-sol.org>
References: <patchbomb.1154421371@ezr.goop.org>
	 <b6c100bb5ca5e2839ac8.1154421378@ezr.goop.org>
	 <20060801090330.GC2654@sequoia.sous-sol.org>
	 <20060801073428.f543ba9f.akpm@osdl.org>
	 <20060801213751.GA11244@sequoia.sous-sol.org>
	 <1154483250.2570.17.camel@localhost.localdomain>
	 <20060802070147.GM2654@sequoia.sous-sol.org>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 17:20:05 +1000
Message-Id: <1154503206.2570.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-02 at 00:01 -0700, Chris Wright wrote:
> Here's an updated patch.  Rather than use __FIXADDR_TOP to adjust for
> MAXMEM, directly update __VMALLOC_RESERVE which is used to reserve the
> space for vmalloc, iomap, and fixmap (as comments aptly point out).  I
> tested this with a bunch of configurations, and booted a XenoLinux
> kernel with this patch as well.

Just one minor point:

> +void set_fixaddr_top(unsigned long top)
> +{
> +	BUG_ON(fixmaps > 0);
> +#ifdef CONFIG_COMPAT_VDSO
> +	BUG_ON(top - PAGE_SIZE != __FIXADDR_TOP);
> +#else
> +	__FIXADDR_TOP = top - PAGE_SIZE;
> +	__VMALLOC_RESERVE -= top;
> +#endif
>  }

This no longer seems to be an appropriate name.  How about
set_address_top_reserve or something?

void set_address_top_reserve(unsigned long reserve)
{
	BUG_ON(fixmaps > 0);
#ifdef CONFIG_COMPAT_VDSO
	BUG_ON(reserve != 0);
#else
	__FIXADDR_TOP = -reserve - PAGE_SIZE;
	__VMALLOC_RESERVE += reserve;
#endif
}

(I *think* I got the logic here correct).

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

