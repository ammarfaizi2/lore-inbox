Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUG2NTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUG2NTM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 09:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbUG2NTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 09:19:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53386 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264609AbUG2NTF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 09:19:05 -0400
Date: Thu, 29 Jul 2004 09:19:28 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Avi Kivity <avi@exanet.com>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS server on local NFS mount
Message-ID: <20040729121928.GB8629@logos.cnet>
References: <4107357C.9080108@exanet.com> <410739BD.2040203@yahoo.com.au> <41075034.7080701@exanet.com> <410752BE.80808@yahoo.com.au> <41075986.8020401@exanet.com> <41076C6C.2010401@yahoo.com.au> <41077BB5.7050007@exanet.com> <4107805A.3090609@yahoo.com.au> <4107927E.9070406@exanet.com> <4108B558.2050905@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4108B558.2050905@yahoo.com.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 06:29:12PM +1000, Nick Piggin wrote:
> Avi Kivity wrote:
> >Nick Piggin wrote:
> >
> >>Avi Kivity wrote:
> >>
> >>>Nick Piggin wrote:
> >>
> >>
> >>
> >>>>>What's stopping the NFS server from ooming the machine then? Every 
> >>>>>time some bit of memory becomes free, the server will consume it 
> >>>>>instantly. Eventually ext3 will not be able to write anything out 
> >>>>>because it is out of memory.
> >>>>>
> >>>>The NFS server should do the writeout a page at a time.
> >>>
> >>>
> >>>
> >>>
> >>>The NFS server writes not only in response to page reclaim (as a 
> >>>local NFS client), but also in response to pressure from non-local 
> >>>clients. If both ext3 and NFS have the same allocation limits, NFS 
> >>>may starve out ext3.
> >>>
> >>
> >>What do you mean starve out ext3? ext3 gets written to *by the NFS 
> >>server*
> >>which is PF_MEMALLOC. 
> >
> >
> >When the NFS server writes, it allocates pagecache and temporary 
> >objects. When ext3 writes, it allocates temporary objects. If the NFS 
> >server writes too much, ext3 can't allocate memory, and will never be 
> >able to allocate memory.
> >
> 
> That is because your NFS server shouldn't hog as much memory as
> it likes when it is PF_MEMALLOC. The entire writeout path should
> do a page at a time if it is PF_MEMALLOC. Ie, the server should
> be doing write, fsync.
> 
> But now that I think about it, I guess you may not be able to
> distinguish that from regular writeout, so doing a page at a time
> would hurt performance too much.
> 
> Hmm so I guess the idea of a per task reserve limit may be the way
> to do it, yes. Thanks for bearing with me!

Hi, 

By reading the discussion I also agree that we need levels of "allowed deepness"
into the reservations.

We could have a global limit for normal allocators, and per-task 
limit for special "kswapd helpers" (which run with PF_MEMALLOC). 
And with kswapd being the most "deep" eater, as you guys said.

The thing is, those deadlocks are quite uncommon special cases and 
we will need to change core VM logic to handle them. Well...

We need to come up with a generic way of doing it, as Avi says, 
otherwise people will have to keep doing "hacks" to make it work.

Someone needs to sit down and come up with a design. It shouldnt 
be that hard.

Just my two pennies...
