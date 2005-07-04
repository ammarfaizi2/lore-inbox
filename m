Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVGDUK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVGDUK1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 16:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVGDUKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 16:10:17 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:21665 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S261628AbVGDUHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 16:07:13 -0400
Date: Mon, 4 Jul 2005 15:06:46 -0500
From: serge@hallyn.com
To: Tony Jones <tonyj@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
Message-ID: <20050704200646.GA4211@vino.hallyn.com>
References: <20050630194458.GA23439@serge.austin.ibm.com> <20050630195043.GE23538@serge.austin.ibm.com> <20050704031820.GA6871@immunix.com> <20050704115135.GA27617@vino.hallyn.com> <20050704193753.GA28893@immunix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050704193753.GA28893@immunix.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tony Jones (tonyj@suse.de):
> On Mon, Jul 04, 2005 at 06:51:35AM -0500, serge@hallyn.com wrote:
> 
> > > I don't think your symbol_get() is doing what you think it is ;-)
> 
> > Hmm, I wonder whether something changed.  It shouldn't be possible to
> > rmmod module b if module a has done a symbol_get on it...  
> 
> Are you thinking of resolve_symbol rather than get_symbol?
> 
> You are calling __symbol_get("ops").
> 
> Maybe (/probably :-)) I'm totally misunderstanding what you are doing but:
> a) I would have thought you would need to call symbol_get on the name the
>    caller was passing, i.e symbol_get(capability_security_ops)
> b) The module registering these ops would need to EXPORT_SYMBOL this name.
> c) mod->state is MODULE_STATE_COMING right before the call to mod->init
>    in sys_init_module which causes any symbol_gets() to return 0 (not that
>    you actually care about the return value, only it's side effect)
> d) I don't see anything in this code path that would incr a ref on the 
>    registering module as a side effect of returning the sym.

__symbol_get should eventually call try_module_get, which increments the
use count, right?

But I'm completely misusing symbol_get - as you say, that is supposed
to be "symbol_name", not a pointer to the symbol.

Any suggestions on a good way to do what I wanted to do?  Frankly a
new LSM hook seems the cleanest solution.  Or, I could ramp up the
locking and permit module deletion, probably at a bit of performance
cost.  Or I could just count on modules doing a symbol_get on
themselves?

thanks,
-serge
