Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVHCTpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVHCTpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 15:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVHCTpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 15:45:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38068 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262431AbVHCTpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 15:45:32 -0400
Date: Wed, 3 Aug 2005 12:45:14 -0700
From: Chris Wright <chrisw@osdl.org>
To: serue@us.ibm.com
Cc: Chris Wright <chrisw@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Stacker - single-use static slots
Message-ID: <20050803194514.GK7762@shell0.pdx.osdl.net>
References: <20050727181732.GA22483@serge.austin.ibm.com> <Lynx.SEL.4.62.0507271527390.1844@thoron.boston.redhat.com> <Lynx.SEL.4.62.0507271535150.1844@thoron.boston.redhat.com> <20050803164516.GB13691@serge.austin.ibm.com> <20050803175742.GI7762@shell0.pdx.osdl.net> <20050803192751.GA18837@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803192751.GA18837@serge.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* serue@us.ibm.com (serue@us.ibm.com) wrote:
> > James had suggested to effectively stash the list in the last slot, so
> > there's only the array with one reserved slot.
> 
> Oh, I didn't catch that.  I like it.  Will do.
> 
> So you mean 3 slots total including the shared one?

Yeah, i.e. common case is $LSM and capabilities.  Stack slot is last
one, and gets put to use only if needed.

> Any comments on the added argument to register_security and
> mod_reg_security to request a static slot?

Why would you not request a static slot?

> +	spin_lock(&security_field_spinlock);
> +	if (idx && *idx) {
> +		int i;
> +
> +		*idx = -1;

So, I guess this means you request one, but who knows which one you'll
get?

> +		for (i=0; i<CONFIG_SECURITY_STACKER_NUMFIELDS; i++) {
> +			if (security_field_owners[i] == NULL) {
> +				security_field_owners[i] = ops;
> +				*idx = i;
> +				break;
> +			}
> +		}
> +	}
> +	spin_unlock(&security_field_spinlock);

> Given the likelyhood of
> capability/cap_stack being registered, it seemed worthwhile not to have
> it waste a spot, but it is an API change...

API change is no big deal.  Seems useful to get index value so you can
do optimized retrieve later.  But, I don't see it useful to request that
way.  Just register, get index, if index == last slot, lookup hits list.

thanks,
-chris
