Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261968AbSI3JKm>; Mon, 30 Sep 2002 05:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261971AbSI3JKl>; Mon, 30 Sep 2002 05:10:41 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:27380 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S261968AbSI3JKk>; Mon, 30 Sep 2002 05:10:40 -0400
Date: Mon, 30 Sep 2002 02:08:44 -0700
From: Chris Wright <chris@wirex.com>
To: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20020930020844.H12641@figure1.int.wirex.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20020927003210.A2476@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020927003210.A2476@sgi.com>; from hch@infradead.org on Fri, Sep 27, 2002 at 12:32:10AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig (hch@infradead.org) wrote:
> 
> >  	if (turn_on && !capable(CAP_SYS_RAWIO))
> >  		return -EPERM;
> > -
> > + 
> > + 	ret = security_ops->ioperm(from, num, turn_on);
> > + 	if (ret) {
> > + 		return ret;
> > + 	}
> > + 
> 
> Sorry, but this is bullshit (like most of the lsm changes).  Either you
> leave the capable in and say it's enough or you add your random hook
> and remove that one.

I agree, this is the way started, however it touches so much driver code
(not to mention core code) that it seemed likely to be rejected.  I'm
all for replacing capable() calls, but it's not a consistent interface
and can't always be simply exchanged.  I see no reason not to remove the
obvious ones right away.

> Just adding more and more hooks without thinking
> gets us exactly nowhere except to an unmaintainable codebase.

Your point is well-taken.  Of course, we do not want to produce
unmaintainable code.  The hook creation/placement has been thought about
and discussed quite a bit.  

> Also is there a _real_ need to pass in all the arguments?

It was placed there as an obvious contol point over which ioports
could be accessed.  We will definitely revisit this since it's not being
used.

> > + * @module_create:
> > + *	Check the permission before allocating space for a module.
> > + *	@name contains the module name.
> > + *	@size contains the module size.
> > + *	Return 0 if permission is granted.
> > + * @module_initialize:
> > + * 	Check permission before initializing a module.
> > + * 	@mod contains a pointer to the module being initialized.
> > + *	Return 0 if permission is granted.
> 
> Umm, you can't tell me you deny someone to initialize a module he has
> just created?

Coming from two separate system calls there is no guarantee the
callers will be in the same execution domain.

> > + * @sethostname:
> > + *	Check permission before the hostname is set to @hostname.
> > + *	@hostname contains the new hostname
> > + *	Return 0 if permission is granted.
> > + * @setdomainname:
> > + *	Check permission before the domainname is set to @domainname.
> > + *	@domainname contains the new domainname
> > + *	Return 0 if permission is granted.
> 
> You don't think this should maybe be just one hook?

sure, uts releated hooks could be collapsed.

> You might be allowed to swapon but not swapoff?

yes, again there is no assumption the execution domains would be the
same.

> > +static int cap_swapoff (struct swap_info_struct *swap)
> > +{
> > +	return 0;
> > +}
> 
> Live would be a lot simple if an unimplemented op would behave
> as returning zero..

Yes, I agree.  We've had a few patches that did this, nothing
committed to the LSM tree currently.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
