Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbVKQWUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVKQWUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbVKQWUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:20:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964835AbVKQWUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:20:08 -0500
Date: Thu, 17 Nov 2005 14:20:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org, ak@suse.de,
       ebiederm@xmission.com
Subject: Re: [PATCH 9/10] kdump: read previous kernel's memory
Message-Id: <20051117142023.43764d8b.akpm@osdl.org>
In-Reply-To: <20051117132944.GM3981@in.ibm.com>
References: <20051117131339.GD3981@in.ibm.com>
	<20051117131825.GE3981@in.ibm.com>
	<20051117132004.GF3981@in.ibm.com>
	<20051117132138.GG3981@in.ibm.com>
	<20051117132315.GH3981@in.ibm.com>
	<20051117132437.GI3981@in.ibm.com>
	<20051117132557.GJ3981@in.ibm.com>
	<20051117132659.GK3981@in.ibm.com>
	<20051117132850.GL3981@in.ibm.com>
	<20051117132944.GM3981@in.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> wrote:
>
> +ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> +                               size_t csize, unsigned long offset, int userbuf)
> +{
> +	void  *vaddr;
> +
> +	if (!csize)
> +		return 0;
> +
> +	vaddr = kmap_atomic_pfn(pfn, KM_PTE0);
> +
> +	if (userbuf) {
> +		if (copy_to_user(buf, (vaddr + offset), csize)) {
> +			kunmap_atomic(vaddr, KM_PTE0);
> +			return -EFAULT;

The copy_*_user() inside kmap_atomic() is problematic.

On some configs (eg, x86, highmem) the process is running atomically, hence
the copy_*_user() will *refuse* to fault in the user's page if it's not
present.  Because pagefaulting involves doing things which sleep.

So

a) This code will generate might_sleep() warnings at runtime and

b) It'll return -EFAULT for user pages which haven't been faulted in yet.


We do all sorts of gruesome tricks in mm/filemap.c to get around all this. 
I don't think your code is as performance-sensitive, so a suitable fix
might be to double-copy the data.  Make sure that the same physical page is
used as a bounce page for each copy (ie: get the caller to pass it in) and
that page will be cache-hot and the performance should be acceptable.

If it really is performance-sensitive then you'll need to play filemap.c
games.  It'd be better to use a sleeping kmap instead, if poss.  That's
kmap().

Please send an incremental patch when it's sorted.  
