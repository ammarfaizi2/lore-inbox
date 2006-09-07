Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751842AbWIGTRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWIGTRG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 15:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWIGTRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 15:17:05 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:40832 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751842AbWIGTRB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 15:17:01 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Pavel Emelianov <xemul@openvz.org>
Cc: Kirill Korotaev <dev@sw.ru>, Dave Hansen <haveblue@us.ibm.com>,
       Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Hugh Dickins <hugh@veritas.com>, Matt Helsley <matthltc@us.ibm.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <44FFCA4D.9090202@openvz.org>
References: <44FD918A.7050501@sw.ru>
	 <1157478392.3186.26.camel@localhost.localdomain>  <44FED3CA.7000005@sw.ru>
	 <1157579641.31893.26.camel@linuxchandra>  <44FFCA4D.9090202@openvz.org>
Content-Type: text/plain
Organization: IBM
Date: Thu, 07 Sep 2006 12:16:56 -0700
Message-Id: <1157656616.19884.34.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-07 at 11:29 +0400, Pavel Emelianov wrote:
> Chandra Seetharaman wrote:
> 
> [snip]
> >>> Will we need new user/kernel interfaces for cpu, i/o bandwidth, etc...?
> >>>       
> >> no. no new interfaces are required.
> >>     
> >
> > Good to know that. 
> >
> > Your CPU controller supports guarantee ?
> >   
> It does, but CPU controller is not so simple as memory one.

Hmm... the reason I asked is that the UBC infrastructure doesn't provide
guarantee support and Kirill mentioned there is no changes required to
UBC if you have to move your CPU controller to be under UBC.

>From your reply it does look like you need to make some changes (add
guarantee support) to UBC, if you want to move the CPU controller to be
under UBC.

> > Do you have a i/o controller ?
> >
> >   
> >> BUT: I remind you the talks at OKS/OLS and in previous UBC discussions.
> >> It was noted that having a separate interfaces for CPU, I/O bandwidth
> >>     
> >
> > But, it will be lot simpler for the user to configure/use if they are
> > together. We should discuss this also.
> >   
> IMHO such unification may only imply that one syscall is used to pass
> configuration info into kernel.
> Each controller has specific configurating parameters different from the
> other ones. E.g. CPU controller must assign a "weight" to each group to
> share CPU time accordingly, but what is a "weight" for memory controller?
> IO may operate on "bandwidth" and it's not clear what is a "bandwidth" in
> Kb/sec for CPU controller and so on.
> 
> [snip]
> >> The question is - whether web server is multithreaded or not...
> >> If it is not - then no problem here, you can change current
> >> context and new resources will be charged accordingly.
> >>
> >> And current BC code is _able_ to handle it with _minor_ changes.
> >> (One just need to save bc not on mm struct, but rather on vma struct
> >> and change mm->bc on set_bc_id()).
> >>
> >> However, no one (can some one from CKRM team please?) explained so far
> >> what to do with threads. Consider the following example.
> >>
> >> 1. Threaded web server spawns a child to serve a client.
> >> 2. child thread touches some pages and they are charged to child BC
> >>    (which differs from parent's one)
> >> 3. child exits, but since its mm is shared with parent, these pages
> >>    stay mapped and charged to child BC.
> >>
> >> So the question is:  what to do with these pages?
> >> - should we recharge them to another BC?
> >> - leave them charged?
> >>     
> >
> > Leave them charged. It will be charged to the appropriate UBC when they
> > touch it again.
> >   
> Do you mean that page must be re-charged each time someone touches it?

What I meant is that to leave them charged, and if when they are
ummapped and mapped later, charge it to the appropriate BC.

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


