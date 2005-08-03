Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVHCUcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVHCUcD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 16:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbVHCUcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 16:32:03 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:31702 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262442AbVHCUcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 16:32:01 -0400
Date: Wed, 3 Aug 2005 15:31:21 -0500
From: serge@hallyn.com
To: Chris Wright <chrisw@osdl.org>
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Stacker - single-use static slots
Message-ID: <20050803203121.GA5221@vino.hallyn.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <Lynx.SEL.4.62.0507271527390.1844@thoron.boston.redhat.com> <Lynx.SEL.4.62.0507271535150.1844@thoron.boston.redhat.com> <20050803164516.GB13691@serge.austin.ibm.com> <20050803175742.GI7762@shell0.pdx.osdl.net> <20050803192751.GA18837@serge.austin.ibm.com> <20050803194514.GK7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803194514.GK7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wright (chrisw@osdl.org):
> * serue@us.ibm.com (serue@us.ibm.com) wrote:
> > > James had suggested to effectively stash the list in the last slot, so
> > > there's only the array with one reserved slot.
> > 
> > Oh, I didn't catch that.  I like it.  Will do.
> > 
> > So you mean 3 slots total including the shared one?
> 
> Yeah, i.e. common case is $LSM and capabilities.  Stack slot is last
> one, and gets put to use only if needed.
> 
> > Any comments on the added argument to register_security and
> > mod_reg_security to request a static slot?
> 
> Why would you not request a static slot?

Capability wouldn't use it, though, so that slot would be wasted.  In my
patch, capability, cap_stack, and root_plug don't ask for a slot.

> > +	spin_lock(&security_field_spinlock);
> > +	if (idx && *idx) {
> > +		int i;
> > +
> > +		*idx = -1;
> 
> So, I guess this means you request one, but who knows which one you'll
> get?

If you get -1 back, you didn't get a static slot.  But you don't have to
care as a module writer, the security_*_value functions will default to
using the shared slot if idx==-1.

> > +		for (i=0; i<CONFIG_SECURITY_STACKER_NUMFIELDS; i++) {
> > +			if (security_field_owners[i] == NULL) {
> > +				security_field_owners[i] = ops;
> > +				*idx = i;

This (idx != -1) means you got a static slot.

Of course this can now switch to idx==num_slots meaning you use the
shared slot.

> > Given the likelyhood of
> > capability/cap_stack being registered, it seemed worthwhile not to have
> > it waste a spot, but it is an API change...
> 
> API change is no big deal.  Seems useful to get index value so you can
> do optimized retrieve later.  But, I don't see it useful to request that
> way.  Just register, get index, if index == last slot, lookup hits list.

If we do switch to all LSMs getting a slot, should we just have the
return value for register_security and mod_reg_security be the slot#, or
-error?

thanks,
-serge
