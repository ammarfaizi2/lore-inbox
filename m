Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUDBWgs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 17:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbUDBWgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 17:36:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:33706 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261244AbUDBWgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 17:36:42 -0500
Date: Fri, 2 Apr 2004 14:36:39 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: chrisw@osdl.org, andrea@suse.de, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040402143639.G21045@build.pdx.osdl.net>
References: <20040401135920.GF18585@dualathlon.random> <20040401170705.Y22989@build.pdx.osdl.net> <20040401173034.16e79fee.akpm@osdl.org> <20040402133540.1dfa0256.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040402133540.1dfa0256.akpm@osdl.org>; from akpm@osdl.org on Fri, Apr 02, 2004 at 01:35:40PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> So I spent a few hours getting pam_cap to work, and indeed it is now doing the
> right thing.  But the kernel is not.

Do you have a patch?  Seems it could be useful to get this and libcap back
up-to-date .

> It turns out that the whole "drop capabilities and then run something"
> thing does not work in either 2.4 or 2.6.  And hasn't done since forever. 
> What we have in there is no more useful than suser().

Indeed.  This is often how I refer to it.  There's one exception.
Without the use of execve(), a resident daemon can drop it's privs as
needed.

> You can do prctl(PR_SET_KEEPCAPS, 1) so that permitted caps are retained
> across setuid().  And after the setuid() you can raise effective caps
> again.  So that's workable, although pretty sad - it requires that su and
> login be patched to run the prctl and to re-raise effective caps.
> 
> But the two showstoppers are:
> 
> 1) capabilities are unconditionally nuked across execve() unless you're
>    root (cap_bprm_set_security())

Or exec'ing a setuid root program.  And in either of those cases they
get raised to full sets, which may not be nice.

> 2) the kernel unconditionally removes CAP_SETPCAP in dummy_capget() so
>    it is not possible for even a root-owned, otherwise-fully-capable task
>    to raise capabilities on another task.  Period.

This is how the kernel was before the security stuff went in.  

> I must say that I'm fairly disappointed that we developed and merged all
> that fancy security stuff but nobody ever bothered to fix up the existing
> simple capability code.

Our goal was actually to keep is compatible.  All of it's limitations
predate the security stuff.

> Particularly as, apparently, the new security stuff STILL cannot solve the
> extremely simple Oracle-wants-CAP_IPC_LOCK requirement.
> 
> Chris has proposed a little patch which will enable the retention of caps
> across execve.  I'd be interested in knowing why we _ever_ dropped caps
> across execve?  I thing we should run with Chris's patch - but the new
> functionality should of course only be enabled by some admin-settable knob.

I'm not sure, but it likely has to do with anticipating having the fs
bits of capabilities to do proper setting at execve().  I think basically
nobody really uses capabilites except in either simple root drops a
few privs ways (no exec), or within larger security models running as
kernel modules.

> I'm looking at securebits.h and wondering why that exists - there's no code
> in-kernel to set the thing, although it is exported to modules.  Perhaps
> securebits should be exposed in /proc and used to enable
> retain-caps-across-execve.

IIRC, changing those (existing) securebits settings creates an unusable
machine.  Again, I think there was some anticipation of the fs bits
going in later.  Perhaps those securebits pieces could just be removed?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
