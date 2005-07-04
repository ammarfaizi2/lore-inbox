Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVGDTmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVGDTmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 15:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVGDTmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 15:42:22 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:44428 "EHLO
	ermintrude.int.immunix.com") by vger.kernel.org with ESMTP
	id S261588AbVGDTmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 15:42:17 -0400
Date: Mon, 4 Jul 2005 12:37:53 -0700
From: Tony Jones <tonyj@suse.de>
To: serge@hallyn.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
Message-ID: <20050704193753.GA28893@immunix.com>
References: <20050630194458.GA23439@serge.austin.ibm.com> <20050630195043.GE23538@serge.austin.ibm.com> <20050704031820.GA6871@immunix.com> <20050704115135.GA27617@vino.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050704115135.GA27617@vino.hallyn.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 06:51:35AM -0500, serge@hallyn.com wrote:

> > I don't think your symbol_get() is doing what you think it is ;-)

> Hmm, I wonder whether something changed.  It shouldn't be possible to
> rmmod module b if module a has done a symbol_get on it...  

Are you thinking of resolve_symbol rather than get_symbol?

You are calling __symbol_get("ops").

Maybe (/probably :-)) I'm totally misunderstanding what you are doing but:

a) I would have thought you would need to call symbol_get on the name the
   caller was passing, i.e symbol_get(capability_security_ops)
b) The module registering these ops would need to EXPORT_SYMBOL this name.
c) mod->state is MODULE_STATE_COMING right before the call to mod->init
   in sys_init_module which causes any symbol_gets() to return 0 (not that
   you actually care about the return value, only it's side effect)
d) I don't see anything in this code path that would incr a ref on the 
   registering module as a side effect of returning the sym.

> more stringent locking will be required after all to support unloading.
> That, or a rmmod lsm hook.

Yep.  I was able to rmmod subdomain and capability, the former with unpleasant
results.

Tony
