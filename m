Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266863AbUHCVXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266863AbUHCVXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266858AbUHCVXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:23:06 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:46816 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S266863AbUHCVXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:23:01 -0400
Date: Tue, 3 Aug 2004 23:22:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803212231.GJ2241@dualathlon.random>
References: <20040803210737.GI2241@dualathlon.random> <Pine.LNX.4.44.0408031712371.5948-100000@dhcp83-102.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408031712371.5948-100000@dhcp83-102.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 05:13:56PM -0400, Rik van Riel wrote:
> On Tue, 3 Aug 2004, Andrea Arcangeli wrote:
> 
> > > -	if (shmflg & SHM_HUGETLB)
> > > +	if (shmflg & SHM_HUGETLB) {
> > > +		/* hugetlb_zero_setup takes care of mlock user accounting */
> > >  		file = hugetlb_zero_setup(size);
> > > +		shp->mlock_user = current->user;
> > > +	} else {
> 
> > where do you change mlock_user in chown?
> 
> You don't.  Normal users aren't allowed to chown each
> other's files, nor are they allowed to "give away" one
> of their files to somebody else.
> 
> On unlock the quota gets deducted from the user who
> created the hugetlbfs file.
> 
> This means there shouldn't be security issues with this
> approach.  Let me know if I've overlooked one.

I agree there aren't security issues, but it's still very wrong to
charge the old user if the admin gives the locked ram to a new user.
This erratic behaviour shows how much the rlimit approch is flawed for
named fs objects that have nothing to do with the transient task that
created them.
