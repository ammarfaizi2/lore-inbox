Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVCSDl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVCSDl6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 22:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVCSDl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 22:41:58 -0500
Received: from fire.osdl.org ([65.172.181.4]:48070 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262015AbVCSDlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 22:41:51 -0500
Date: Fri, 18 Mar 2005 19:41:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: Kmap_atomic vs Kmap
Message-Id: <20050318194134.5b710075.akpm@osdl.org>
In-Reply-To: <423B86C6.7030107@lougher.demon.co.uk>
References: <4235BAC0.6020001@lougher.demon.co.uk>
	<20050314165117.1c5068b7.akpm@osdl.org>
	<423B86C6.7030107@lougher.demon.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Lougher <phillip@lougher.demon.co.uk> wrote:
>
> Andrew Morton wrote in relation to my initial SquashFS patch:
> > Phillip Lougher <phillip@lougher.demon.co.uk> wrote:
> > 
> >>+skip_read:
> >>+	memset(pageaddr + bytes, 0, PAGE_CACHE_SIZE - bytes);
> >>+	kunmap(page);
> >>+	flush_dcache_page(page);
> >>+	SetPageUptodate(page);
> >>+	unlock_page(page);
> >>+
> >>+	return 0;
> >>+}
> 
> > See if you can use kmap_atomic() here - kmap() is slow, theoretically
> > deadlocky and is deprecated.
> > 
> 
>  From some browsing of the kernel source and a useful article on lwn.net 
> I think I can replace all the readpage_xxx (symlink, readpage & 
> readpage4k) kmap/kunmaps with kmap_atomic(page, KM_USER0)/kunmap(kaddr, 
> KM_USER0)...

Yes.

Generally the only reason the kernel needs to modify pagecache pages is to
do a quick memset or to copy a string in there or something like that.  So
a quick kmap_atomic/memory copy/kunmap_atomic() cycle is a fairly common
pattern.

The one exception is the directory-in-pagecache code where we tend to do a
lot of stuff while holding the kmap.  Not that there's any particular
reason why we needed to do it that way.

> The lwn.net article mentions that k[un]map_atomic is the new alternative 
> to kmap (as Andrew Morton mentioned).
> 
> I've noticed in asm-ppc/highmem.h the following comment
> 
> /*
>   * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
>   * gives a more generic (and caching) interface. But kmap_atomic can
>   * be used in IRQ contexts, so in some (very limited) cases we need
>   * it.
>   */
> 
> Given what Andrew and the lwn.net article says, this comment is rather 
> confusing.  Is it wrong?

I'd say so, yes.  For a start, kmap_high() takes a global lock.
