Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVHCTak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVHCTak (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 15:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbVHCTak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 15:30:40 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:28866 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262426AbVHCTai
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 15:30:38 -0400
Date: Wed, 3 Aug 2005 14:27:51 -0500
From: serue@us.ibm.com
To: Chris Wright <chrisw@osdl.org>
Cc: serue@us.ibm.com, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Stacker - single-use static slots
Message-ID: <20050803192751.GA18837@serge.austin.ibm.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <Lynx.SEL.4.62.0507271527390.1844@thoron.boston.redhat.com> <Lynx.SEL.4.62.0507271535150.1844@thoron.boston.redhat.com> <20050803164516.GB13691@serge.austin.ibm.com> <20050803175742.GI7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803175742.GI7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wright (chrisw@osdl.org):
> * serue@us.ibm.com (serue@us.ibm.com) wrote:
> > +#if 0
> > +	printk(KERN_NOTICE "__get_value: %s (%d): head %lx p %lx idx %d returning %lx at %lx\n",
> > +		__FUNCTION__, __LINE__, (long)head, (long)p, idx, (long)p[idx], (long)&p[idx]);
> > +#endif
> > +	return p[idx];
> 
> pr_debug

Thanks.

> > +config SECURITY_STACKER_NUMFIELDS
> > +	int "Number of security fields to reserve"
> > +	depends on SECURITY_STACKER
> > +	default 1
> 
> Not sure config is worth it, also, James had suggested smth like 3
> slots.

I misread that.  I'd latched onto the "selinux+capability" (again),
which combined would need only one spot.

> >  		INIT_HLIST_HEAD(&inode->i_security);
> > +		memset(&inode->i_security_p, 0,
> > +			CONFIG_SECURITY_STACKER_NUMFIELDS*sizeof(void *));
> 
> This CONFIG... is a bit rough.  Can we use a simple name, and if config
> is necessary, assign config to simple name?

Will do.

> > Index: linux-2.6.12/include/linux/fs.h
> > ===================================================================
> > --- linux-2.6.12.orig/include/linux/fs.h	2005-08-01 20:00:50.000000000 -0500
> > +++ linux-2.6.12/include/linux/fs.h	2005-08-01 20:24:55.000000000 -0500
> > @@ -486,6 +486,7 @@ struct inode {
> >  
> >  	atomic_t		i_writecount;
> >  	struct hlist_head	i_security;
> > +	void			*i_security_p[CONFIG_SECURITY_STACKER_NUMFIELDS];
> 
> James had suggested to effectively stash the list in the last slot, so
> there's only the array with one reserved slot.

Oh, I didn't catch that.  I like it.  Will do.

So you mean 3 slots total including the shared one?

Any comments on the added argument to register_security and
mod_reg_security to request a static slot?  Given the likelyhood of
capability/cap_stack being registered, it seemed worthwhile not to have
it waste a spot, but it is an API change...

thanks,
-serge
