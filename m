Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVGDUqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVGDUqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 16:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVGDUqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 16:46:20 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:7361 "EHLO
	ermintrude.int.immunix.com") by vger.kernel.org with ESMTP
	id S261660AbVGDUqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 16:46:15 -0400
Date: Mon, 4 Jul 2005 13:41:55 -0700
From: Tony Jones <tonyj@immunix.com>
To: serge@hallyn.com
Cc: Tony Jones <tonyj@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
Message-ID: <20050704204155.GA30210@immunix.com>
References: <20050630194458.GA23439@serge.austin.ibm.com> <20050630195043.GE23538@serge.austin.ibm.com> <20050704031820.GA6871@immunix.com> <20050704115135.GA27617@vino.hallyn.com> <20050704193753.GA28893@immunix.com> <20050704200646.GA4211@vino.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050704200646.GA4211@vino.hallyn.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 03:06:46PM -0500, serge@hallyn.com wrote:

> > You are calling __symbol_get("ops").
> > 
> > Maybe (/probably :-)) I'm totally misunderstanding what you are doing but:
> > a) I would have thought you would need to call symbol_get on the name the
> >    caller was passing, i.e symbol_get(capability_security_ops)
> > b) The module registering these ops would need to EXPORT_SYMBOL this name.
> > c) mod->state is MODULE_STATE_COMING right before the call to mod->init
> >    in sys_init_module which causes any symbol_gets() to return 0 (not that
> >    you actually care about the return value, only it's side effect)
> > d) I don't see anything in this code path that would incr a ref on the 
> >    registering module as a side effect of returning the sym.
> 
> __symbol_get should eventually call try_module_get, which increments the
> use count, right?

Duh, I missed the call to try_module_get,  probably because it's right
below the 'if (mod && mod->state == MODULE_STATE_COMING) return 0;' :-)
in strong_try_module_get (2.6.13-rc1)

mod->state is MODULE_STATE_COMING until after mod->init returns and since
you are calling __symbol_get indirectly from the modules init routine,
bammo.

> Any suggestions on a good way to do what I wanted to do?  Frankly a
> new LSM hook seems the cleanest solution.  Or, I could ramp up the
> locking and permit module deletion, probably at a bit of performance
> cost.  Or I could just count on modules doing a symbol_get on
> themselves?

I think any symbol_get is problematic given the above. I was thinking
you could wrap mod_reg_security but it would still need to be called from
within the modules init fn.

I'm going to have to give it some thought, but a new rmmod hook does seem
a good solution off the top of my head.

Tony
