Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261546AbSIZWsF>; Thu, 26 Sep 2002 18:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbSIZWsF>; Thu, 26 Sep 2002 18:48:05 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:40715 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261546AbSIZWsD>;
	Thu, 26 Sep 2002 18:48:03 -0400
Date: Thu, 26 Sep 2002 15:51:48 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20020926225147.GC7304@kroah.com>
References: <20020927003210.A2476@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020927003210.A2476@sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 12:32:10AM -0400, Christoph Hellwig wrote:
> 
> >  /* Set EXTENT bits starting at BASE in BITMAP to value TURN_ON. */
> >  static void set_bitmap(unsigned long *bitmap, short base, short extent, int new_value)
> > @@ -62,7 +63,12 @@
> >  		return -EINVAL;
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
> and remove that one.  Just adding more and more hooks without thinking
> gets us exactly nowhere except to an unmaintainable codebase.

capable is needed to be checked, as we are not modifying the existing
permission logic.

> Also is there a _real_ need to pass in all the arguments?

I'll let Stephen answer that one, as SELinux uses it.

Oops, ok, nevermind, I don't see _any_ security module using this hook.
In fact they are using the capable(CAP_SYS_RAWIO) hook, which is exactly
what you suggest :)

I'll go remove it.

> >  			return -EPERM;
> >  	}
> > +	retval = security_ops->iopl(old, level);
> > +	if (retval) {
> > +		return retval;
> > +	}
> > +
> 
> again (and another few times)

Ok, again, no one is using it.  I'll go remove it (and go audit all of
the other hooks.)

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

Bah, ok, again no one uses these either.

Consider me roasted, I'll go audit this whole thing to try to justify
every one of the hooks we ask for.

Very sorry for bothering people.

thanks,

greg k-h
