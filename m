Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266287AbUFUQAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266287AbUFUQAV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 12:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266288AbUFUQAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 12:00:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47558 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266287AbUFUQAO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 12:00:14 -0400
Date: Mon, 21 Jun 2004 12:53:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Steven Dake <sdake@mvista.com>, Stian Jordet <liste@jordet.nu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sct@redhat.logos.cnet, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.4] page->buffers vanished in journal_try_to_free_buffers()
Message-ID: <20040621155313.GA12559@logos.cnet>
References: <1075832813.5421.53.camel@chevrolet.hybel> <Pine.LNX.4.58L.0402052139420.16422@logos.cnet> <1078225389.931.3.camel@buick.jordet> <1087232825.28043.4.camel@persist.az.mvista.com> <20040615131650.GA13697@logos.cnet> <1087322198.8117.10.camel@persist.az.mvista.com> <20040617131600.GB3029@logos.cnet> <1087830410.2719.53.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087830410.2719.53.camel@sisko.scot.redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Jun 21, 2004 at 04:06:50PM +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Thu, 2004-06-17 at 14:16, Marcelo Tosatti wrote:
> 
> > Stephen, Andrew, do you have any idea how the buffers could have vanished
> > under us with the page locked? That should not be possible. 
> 
> No, especially not on UP as Frank reported.  
> 
> > I dont see how this "page->buffers = NULL" could be caused by hardware problem, 
> > which is usually one or two bit flip.
> 
> We don't know for sure that it's page->buffers.  If we have gone round
> the bh->b_this_page loop already, we could have ended up following the
> pointers either to an invalid bh, or to one that's not on the current
> page.  So it could also be the previous buffer's b_this_page that got
> clobbered, rather than page->buffers.
> 
> That's possible in this case, but it's still a bit surprising that we'd
> *always* get a NULL pointer rather than some other random pointer as a
> result. 

I dont remember seeing any case which was not a NULL pointer dereference.

> The buffer-ring debug patch that you posted looks like the obvious way
> to dig further into this.  If that doesn't get anyway, we can also trap
> the case where following bh->b_this_page gives us a buffer whose b_page
> is on a different page.

Fine.  Just printing out bh->b_page at debug_page() will allow us to verify that, yes?

--- transaction.c.orig  2004-06-21 12:50:01.090082264 -0300
+++ transaction.c       2004-06-21 12:50:45.574319632 -0300
@@ -1704,9 +1704,9 @@ void debug_page(struct page *p)
                 p->index, atomic_read(&p->count), p->flags);
  
        while (bh) {
-               printk(KERN_ERR "%s: bh b_next:%p blocknr:%lu b_list:%u state:%lx\n",
+               printk(KERN_ERR "%s: bh b_next:%p blocknr:%lu b_list:%u state:%lx b_page:%p\n",
                        __FUNCTION__, bh->b_next, bh->b_blocknr, bh->b_list,
-                               bh->b_state);
+                               bh->b_state, bh->b_page);
                bh = bh->b_this_page;
        }
 }



