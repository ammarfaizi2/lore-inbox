Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265701AbUHSMlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUHSMlm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 08:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUHSMlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 08:41:42 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:25466 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265701AbUHSMlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 08:41:39 -0400
Date: Thu, 19 Aug 2004 13:41:28 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Pete Zaitcev <zaitcev@redhat.com>
cc: arjanv@redhat.com, <alan@redhat.com>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>, <riel@redhat.com>, <sct@redhat.com>
Subject: Re: PF_MEMALLOC in 2.6
In-Reply-To: <20040818235523.383737cd@lembas.zaitcev.lan>
Message-ID: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004, Pete Zaitcev wrote:

> The PF_MEMALLOC is required on usb-storage threads in 2.4, because ext3
> will deadlock and otherwise misbehave when it's trying to write out
> dirty pages under memory pressure.
> 
> I received a bug report today from an FC3T1 user with same symptoms
> as 2.4. But I'm entirely clueless in the way VM operates. Comments?
> 
> --- linux-2.6.8-rc4-mm1/drivers/usb/storage/usb.c	2004-08-16 12:13:06.000000000 -0700
> +++ linux-2.6.8-rc4-mm1-ub/drivers/usb/storage/usb.c	2004-08-18 23:48:09.335107648 -0700
> @@ -285,7 +285,7 @@ static int usb_stor_control_thread(void 
>  	 */
>  	daemonize("usb-storage");
>  
> -	current->flags |= PF_NOFREEZE;
> +	current->flags |= PF_NOFREEZE|PF_MEMALLOC;
>  
>  	unlock_kernel();

Seems I'm in a minority, and certainly beyond my expertise,
but I'm very suspicious of this.  Though I see mtd_blktrans_thread
already does the same.  I bet it'll fix problems in some workloads,
and it's a very easy change to make, but I doubt it's right.

PF_MEMALLOC entitles the thread to dip into emergency memory reserves
(and stops it from descending into try_to_free_pages: that may be okay,
though Oliver notes that allocations from here ought to be GFP_NOIO,
that's more appropriate).

Fine for it to dip into those reserves when acting on behalf of something
already PF_MEMALLOC (i.e. try_to_free_pages itself), but not fine for it
to do so as a matter of course e.g. worst case, doing readahead could
easily exhaust reserves.  Or, is this thread only used for writing?
that wouldn't be so bad if so.

I'd have thought the right 2.6 answer would be for it to have mempools
for whatever it might need to get the I/O done; but I haven't a clue
in this area, can easily believe that would difficult to implement.

Or would it solve the problem at hand, if it made itself PF_MEMALLOC
just while servicing a request from a PF_MEMALLOC?

Hugh

