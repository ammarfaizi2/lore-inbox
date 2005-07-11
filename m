Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVGKR4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVGKR4L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 13:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVGKRyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 13:54:24 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:60294 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261941AbVGKRwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 13:52:20 -0400
Date: Mon, 11 Jul 2005 12:51:35 -0500
From: serue@us.ibm.com
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, James Morris <jmorris@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gerrit@us.ibm.com>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
Message-ID: <20050711175135.GD15292@serge.austin.ibm.com>
References: <20050630194458.GA23439@serge.austin.ibm.com> <20050630195043.GE23538@serge.austin.ibm.com> <1121092828.12334.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121092828.12334.94.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen.

More comments below.  This finally proves that I need to provide some
documentation for each hook under stacker showing how modules are
expected to interact.  This hopefully will help me catch things like
this.  Hopefully it would also be useful to module writers in general.

Quoting Stephen Smalley (sds@epoch.ncsc.mil):
> On Thu, 2005-06-30 at 14:50 -0500, serue@us.ibm.com wrote:
> > Adds the actual stacker LSM.
> <snip>
> > +static int stacker_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
> > +{
> > +	RETURN_ERROR_IF_ANY_ERROR(inode_getsecurity,inode_getsecurity(inode,name,buffer,size));
> > +}
> > +
> > +static int stacker_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
> > +{
> > +	RETURN_ERROR_IF_ANY_ERROR(inode_setsecurity,inode_setsecurity(inode,name,value,size,flags));
> > +}
> > +
> > +static int stacker_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
> > +{
> > +	RETURN_ERROR_IF_ANY_ERROR(inode_listsecurity,inode_listsecurity(inode,buffer, buffer_size));
> > +}
> 
> These hooks pose a similar problem for stacking as with the
> [gs]etprocattr hooks, although [gs]etsecurity have the benefit of
> already taking a distinguishing name suffix (the part after the
> security. prefix).  Note also that inode_getsecurity returns the number
> of bytes used/required on success.
> 
> The proposed inode_init_security hook will likewise have an issue for
> stacking.

I can imagine a few ways of fixing this:

	1.	We simply expect that only one module use xattrs.  This
	is probably unacceptable, as we will want both EVM and selinux
	to store xattrs.

	2.	A module registers an xattr name when it registers
	itself.  Then only the registered module is consulted on one of
	these calls.  If no module is registered, all are consulted as
	they are now.

		This prevents a module like capability from deciding
	based on its own credentials whether another module's hook
	should be called.  Is that a good or bad thing?

		This might have the added bonus of obviating the need
	for a separate cap_stack module.
	
	3.	We return an error <0 only if all modules return <0.
	Otherwise we do the obvious thing:  setxattr, return 0.
	getxattr: do we return the first nonzero and stop there, or
	do we return a concatenation of the results?  I assume the
	former...

thanks,
-serge
