Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264096AbUESH1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264096AbUESH1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 03:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUESH1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 03:27:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:26860 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264096AbUESH1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 03:27:09 -0400
Date: Wed, 19 May 2004 00:27:04 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       olaf+list.linux-kernel@olafdietsche.de, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] support cap inheritable (Re: [PATCH] scaled-back caps, take 4 (was Re: [PATCH] capabilites, take 2)
Message-ID: <20040519002704.K21045@build.pdx.osdl.net>
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <40A4F163.6090802@stanford.edu> <20040514110752.U21045@build.pdx.osdl.net> <200405141548.05106.luto@myrealbox.com> <20040517231912.H21045@build.pdx.osdl.net> <20040517235844.I21045@build.pdx.osdl.net> <40AAB9AA.8090508@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40AAB9AA.8090508@myrealbox.com>; from luto@myrealbox.com on Tue, May 18, 2004 at 06:34:34PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski (luto@myrealbox.com) wrote:
> Chris Wright wrote:
> 
> > -#define CAP_INIT_INH_SET    to_cap_t(0)
> > +#define CAP_INIT_INH_SET    to_cap_t(~0)
> > +/* ~0 is legacy inheritable mode and can never be capset by user */
> > +#define cap_orig_inh(_cap) (cap_t((_cap)) == ~0)
> 
> So how do you say "inherit all caps"?

Legacy mode requires effectively reserving a bit, which works in this case
since all 32 aren't used.  So inherit all caps is all valid caps (which,
btw,  still exludes CAP_SETPCAP).  Something like "=eip cap_setpcap-eip"
would inherit all valid caps.

> > @@ -56,10 +59,13 @@
> >  int cap_capset_check (struct task_struct *target, kernel_cap_t *effective,
> >  		      kernel_cap_t *inheritable, kernel_cap_t *permitted)
> >  {
> > +	kernel_cap_t target_inheritable = target->cap_inheritable;
> > +	if (cap_orig_inh(target_inheritable))
> > +		target_inheritable = 0;
> >  	/* Derived from kernel/capability.c:sys_capset. */
> >  	/* verify restrictions on target's new Inheritable set */
> >  	if (!cap_issubset (*inheritable,
> > -			   cap_combine (target->cap_inheritable,
> > +			   cap_combine (target_inheritable,
> >  					current->cap_permitted))) {
> >  		return -EPERM;
> >  	}
> 
> What stops legacy mode from being reenabled?

I believe only a kernel thread could do this (and init) since they are the
only ones that could get CAP_SETPCAP.  Same threat as it is currently.

> I think you missed the case when root-but-no-caps execs setuid root -- I 
> don't see anything that would enable secureexec.

Yup you're right.  I liked how you did that in your patch and was just going
to steal that bit ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
