Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUGFWZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUGFWZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 18:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUGFWZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 18:25:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:8844 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264639AbUGFWZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 18:25:35 -0400
Date: Tue, 6 Jul 2004 15:28:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: jim.houston@comcast.net
Cc: kevcorry@us.ibm.com, linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       torvalds@osdl.org, agk@redhat.com
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
Message-Id: <20040706152817.38ce1151.akpm@osdl.org>
In-Reply-To: <1089151650.985.129.camel@new.localdomain>
References: <200407011035.13283.kevcorry@us.ibm.com>
	<200407021233.09610.kevcorry@us.ibm.com>
	<20040702124218.0ad27a85.akpm@osdl.org>
	<200407061323.27066.kevcorry@us.ibm.com>
	<20040706142335.14efcfa4.akpm@osdl.org>
	<1089151650.985.129.camel@new.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston <jim.houston@comcast.net> wrote:
>
> On Tue, 2004-07-06 at 17:23, Andrew Morton wrote:
> > Kevin Corry <kevcorry@us.ibm.com> wrote:
> > >
> > > After talking with Alasdair a bit, there might be one bug in the "dm-use-idr"
> > > patch I submitted before. It seems (based on some comments in lib/idr.c) that
> > > the idr_find() routine might not return NULL if the desired ID value is not
> > > in the tree.
> > 
> > 
> > Confused.  idr_find() returns the thing it found, or NULL.  To which
> > comments do you refer?
> 
> Hi Andrew, Kevin,
> 
> Kevin is correct.  It's more of the nonsense related to having a counter
> in the upper bits of the id.  If you call idr_find with an id that is
> beyond the currently allocated space it ignores the upper bits and
> returns one of the entries that is in the allocated space.  This
> aliasing is most annoying.

erk, OK, we have vestigial bits still.  Note that MAX_ID_SHIFT is now 31 on
32-bit, so we're still waggling the top bit.

> I'm attaching an untested patch which removes the counter in the upper
> bits of the id and makes idr_find return NULL if the requested id is
> beyond the allocated space.

Would you have time to get it tested please?

>  I suspect that there are problems with
> id values which are less than zero.

Me too.  I'd only be confident in the 0..2G range.


> -#endif
> +	if (id >= (1 << n))
> +		return NULL;
>  	while (n > 0 && p) {
>  		n -= IDR_BITS;
>  		p = p->ary[(id >> n) & IDR_MASK];
> 

I think the above test is unneeded?
