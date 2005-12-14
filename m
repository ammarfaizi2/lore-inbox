Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVLNLDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVLNLDU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVLNLDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:03:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54220 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932093AbVLNLDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:03:18 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>,
       Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org,
       akpm@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <1134556187.2894.7.camel@laptopd505.fenrus.org>
References: <439EDC3D.5040808@nortel.com>
	 <1134479118.11732.14.camel@localhost.localdomain>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <3874.1134480759@warthog.cambridge.redhat.com>
	 <15167.1134488373@warthog.cambridge.redhat.com>
	 <1134490205.11732.97.camel@localhost.localdomain>
	 <1134556187.2894.7.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 12:03:06 +0100
Message-Id: <1134558186.2894.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 11:29 +0100, Arjan van de Ven wrote:
> On Tue, 2005-12-13 at 16:10 +0000, Alan Cox wrote:
> > On Maw, 2005-12-13 at 15:39 +0000, David Howells wrote:
> > >  (3) Some people want mutexes to be:
> > > 
> > >      (a) only releasable in the same context as they were taken
> > > 
> > >      (b) not accessible in interrupt context, or that (a) applies here also
> > > 
> > >      (c) not initialisable to the locked state
> > > 
> > >      But this means that the current usages all have to be carefully audited,
> > >      and sometimes that unobvious.
> > 
> > Only if you insist on replacing them immediately. If you submit a
> > *small* patch which just adds the new mutexes then a series of small
> > patches can gradually convert code where mutexes are better. 
> 
> this unfortunately is not very realistic in practice... 

to expand on this; this kind of change no matter what needs a mass
change inside the kernel, or the point of it all is sort of moot. The
idea is to make the mutex type the most common one, since most users ARE
mutexes. To make that happen a one time "rather big" change is needed
and planned afaics.

What's remaining is
1) transition period for in kernel stuff
2) out of the kernel code compatibility
3) should a forgotten item be a compile time failure or be allowed to
work still 

1) is a matter of "do we do it all now" or in phases. I don't see a
reason to not do it all now, otherwise a 2 year process will happen

2) that is a semi moot issue; sure a big bang change will break this
compatibility, but so will a gradual switchover. A gradual switchover of
converting core semaphores into mutexes will need changes in external
modules regardless (think vfs but there's many more). The question is
doing it once or doing it multiple times over a period of 2 years.

3) history has shown that non-compiletime items keep lingering on
forever, since there is no incentive or even detection of "old" use. At
minimum a compiler warning is needed. Just look at the sleep_on_*() api;
more than half the users in 2.6 are *new code* in 2.6, even though it's
a deprecated api for ... how long? 

