Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932884AbWF0KiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932884AbWF0KiP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 06:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWF0KiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 06:38:14 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:33202 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751270AbWF0KiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 06:38:13 -0400
Date: Tue, 27 Jun 2006 12:33:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Nathan Scott <nathans@sgi.com>, Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060627103317.GA18501@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060623144928.GA32694@infradead.org> <20060626200300.GA15424@elte.hu> <20060627063339.GA27938@elte.hu> <20060627181632.A1297906@wobbly.melbourne.sgi.com> <20060627082240.GA672@elte.hu> <84144f020606270141x5a0afd6anfa6008bfcbba5fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020606270141x5a0afd6anfa6008bfcbba5fb@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5052]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pekka Enberg <penberg@cs.helsinki.fi> wrote:

> On 6/27/06, Ingo Molnar <mingo@elte.hu> wrote:
> >and since XFS makes use of KM_SLEEP in 130+ callsites, that means it is
> >in essence using GFP_NOFAIL massively!
> 
> Yup, it's not just a wrapper, XFS really has its own allocator and the 
> PF_FSTRANS magic makes it hard to convert to slab proper.

AFAICS PF_FSTRANS is mostly just avoidance of having to pass the 
__GFP_FS flag around:

                if ((current->flags & PF_FSTRANS) || (flags & KM_NOFS))
                        lflags &= ~__GFP_FS;

Btw., this XFS way of handling PF_FSTRANS in a nested and letting it 
translate into the clearing of __GFP_FS might just be the proper way of 
doing it in other FS and IO code too?

Conceptually, it is really the property of the general task context that 
it's "inside a filesystem transaction", not a property of the immediate 
allocation callsite. I.e. we should transform all uses of GFP_NOFS into 
PF_FSTRANS save-set/restore calls.

I'd not be surprised if that also fixed a couple of bugs: it's much more 
robust and more maintainable to identify the codepaths that are a 
filesystem operation than to identify all allocations (explicit or 
implicit) in a codepath that is known to be a filesystem operation 
(especially in a constantly evolving kernel).

	Ingo
