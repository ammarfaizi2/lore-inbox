Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUGFXCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUGFXCo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 19:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUGFXCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 19:02:44 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:43475 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264677AbUGFXCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 19:02:08 -0400
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: Andrew Morton <akpm@osdl.org>
Cc: kevcorry@us.ibm.com, linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       torvalds@osdl.org, agk@redhat.com
In-Reply-To: <20040706152817.38ce1151.akpm@osdl.org>
References: <200407011035.13283.kevcorry@us.ibm.com>
	 <200407021233.09610.kevcorry@us.ibm.com>
	 <20040702124218.0ad27a85.akpm@osdl.org>
	 <200407061323.27066.kevcorry@us.ibm.com>
	 <20040706142335.14efcfa4.akpm@osdl.org>
	 <1089151650.985.129.camel@new.localdomain>
	 <20040706152817.38ce1151.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1089154845.985.164.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 06 Jul 2004 19:00:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-06 at 18:28, Andrew Morton wrote:
> Jim Houston <jim.houston@comcast.net> wrote:
> >
> > On Tue, 2004-07-06 at 17:23, Andrew Morton wrote:
> > > Kevin Corry <kevcorry@us.ibm.com> wrote:
> > > >
> > > > After talking with Alasdair a bit, there might be one bug in the "dm-use-idr"
> > > > patch I submitted before. It seems (based on some comments in lib/idr.c) that
> > > > the idr_find() routine might not return NULL if the desired ID value is not
> > > > in the tree.
> > > 
> > > 
> > > Confused.  idr_find() returns the thing it found, or NULL.  To which
> > > comments do you refer?
> > 
> > Hi Andrew, Kevin,
> > 
> > Kevin is correct.  It's more of the nonsense related to having a counter
> > in the upper bits of the id.  If you call idr_find with an id that is
> > beyond the currently allocated space it ignores the upper bits and
> > returns one of the entries that is in the allocated space.  This
> > aliasing is most annoying.
> 
> erk, OK, we have vestigial bits still.  Note that MAX_ID_SHIFT is now 31 on
> 32-bit, so we're still waggling the top bit.
> 
> > I'm attaching an untested patch which removes the counter in the upper
> > bits of the id and makes idr_find return NULL if the requested id is
> > beyond the allocated space.
> 
> Would you have time to get it tested please?
> 
> >  I suspect that there are problems with
> > id values which are less than zero.
> 
> Me too.  I'd only be confident in the 0..2G range.
> 
> 
> > -#endif
> > +	if (id >= (1 << n))
> > +		return NULL;
> >  	while (n > 0 && p) {
> >  		n -= IDR_BITS;
> >  		p = p->ary[(id >> n) & IDR_MASK];
> > 
> 
> I think the above test is unneeded?

Hi Everyone,

With out the test above an id beyond the allocated space will alias
to one that exists.  Perhaps the highest id currently allocated is 
100, there will be two layers in the radix tree and the while loop
above will only look at the 10 least significant bits.  If you call
idr_find with 1025 it will return the pointer associated with id 1.

The patch I sent was against linux-2.6.7, so I missed the change to
MAX_ID_SHIFT.

Jim Houston - Concurrent Computer Corp.

