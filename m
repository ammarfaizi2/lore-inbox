Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264969AbUFRDKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264969AbUFRDKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 23:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264977AbUFRDKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 23:10:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:64462 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264969AbUFRDKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 23:10:14 -0400
Date: Thu, 17 Jun 2004 20:08:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: sdake@mvista.com, liste@jordet.nu, linux-kernel@vger.kernel.org,
       sct@redhat.logos.cnet
Subject: Re: [2.4] page->buffers vanished in journal_try_to_free_buffers()
Message-Id: <20040617200859.7fada9fe.akpm@osdl.org>
In-Reply-To: <20040617131600.GB3029@logos.cnet>
References: <1075832813.5421.53.camel@chevrolet.hybel>
	<Pine.LNX.4.58L.0402052139420.16422@logos.cnet>
	<1078225389.931.3.camel@buick.jordet>
	<1087232825.28043.4.camel@persist.az.mvista.com>
	<20040615131650.GA13697@logos.cnet>
	<1087322198.8117.10.camel@persist.az.mvista.com>
	<20040617131600.GB3029@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
>  > tmp (page->buffers) above is null.  b_this_page is at offset 0x28 (the accessed address in the oops).  This means that
>  > page->buffers is set to null by some other routine which results in the oops.
>  > 
>  > I read the page allocate code
>  > (ext3_read_page->block_read_full_page->create_emty_buffers->create_buffers), and it appears that it is not possible to allocate a page->buffers value of zero in the allocate function.  I am having difficulty reproducing and cannot debug further, however.  Can page->buffers be set to zero somewhere else?  
>  >Perhaps kswapd and some other thread are racing on the free?
> 
>  Steve, 
> 
>  Hum, I'm starting to believe we might have an issue here.
> 
>  Searching lkml archives I find other similar oopses at the same place 
>  (trying to access 00000028, tmp->b_this_page), as you said.
> 
>  However I wonder what other kernel codepath could remove the page buffers
>  under us, the page MUST be locked here. In the backtrace above the page 
>  is locked by shrink_cache(). And with the page locked, we guarantee the VM
>  freeing routines (shrink_cache) wont try to mess with the page.
> 
>  Can you reproduce the oopsen?
> 
>  Stephen, Andrew, do you have any idea how the buffers could have vanished
>  under us with the page locked? That should not be possible. 
> 
>  I dont see how this "page->buffers = NULL" could be caused by hardware problem, 
>  which is usually one or two bit flip.

It's a bit odd.  The page is definitely locked, and definitely had non-null
->buffers a few tens of instructions beforehand.

Is this an SMP machine?

One possibility is that we died on the second pass around the loop:
page->buffers points at a buffer_head which has a NULL ->b_this_page.  But
I cannot suggest how ->b_this_page could have been zapped.

