Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262887AbUKRS5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbUKRS5D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbUKRS45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:56:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:37323 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262887AbUKRSzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:55:15 -0500
Date: Thu, 18 Nov 2004 10:55:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Miklos Szeredi <miklos@szeredi.hu>, hbryan@us.ibm.com, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <1100798975.6018.26.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0411181047590.2222@ppc970.osdl.org>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
  <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>  <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
 <1100798975.6018.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Nov 2004, Alan Cox wrote:
> 
> > I really do believe that user-space filesystems have problems. There's a 
> > reason we tend to do them in kernel space. 
> > 
> > But limiting the outstanding writes some way may at least hide the thing.
> 
> Possibly dumb question. Is there a reason we can't have a prctl() that
> flips the PF_* flags for a user space daemon in the same way as we do
> for kernel threads that do I/O processing ?

It's more than just PF_MEMALLOC.

And PF_MEMALLOC really is to avoid _recursion_, which is the smallest
problem. It does so by allowing the process to dip into the critical
resources, but that only works if you know that the process is actually
freeing pages right then and there. If you set it willy-nilly, you'll just
run out of pages soon, and you'll be dead.

The GFP_IO and GFP_FS pages are the _real_ protectors. They don't dip into
the (very limited) set of pages, they say "we can still free 90% of
memory, we just have to ignore that dangerous 10%".

And yes, you could somehow expose those as process flags too, and make
people who do GFP_USER or GFP_KERNEL actually look at some process flag
and do the proper masking. 

So clearly you _can_ do it. But it requires very intimate knowledge of VM 
behaviour or the VM knowing about you. 

		Linus
