Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264194AbUDBVhR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 16:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbUDBVeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 16:34:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:30849 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264187AbUDBVda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 16:33:30 -0500
Date: Fri, 2 Apr 2004 13:35:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: chrisw@osdl.org, andrea@suse.de, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-Id: <20040402133540.1dfa0256.akpm@osdl.org>
In-Reply-To: <20040401173034.16e79fee.akpm@osdl.org>
References: <20040401135920.GF18585@dualathlon.random>
	<20040401170705.Y22989@build.pdx.osdl.net>
	<20040401173034.16e79fee.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Rumour has it that the more exhasperated among us are brewing up a patch to
> login.c which will allow capabilities to be retained after the setuid.

So I spent a few hours getting pam_cap to work, and indeed it is now doing the
right thing.  But the kernel is not.

It turns out that the whole "drop capabilities and then run something"
thing does not work in either 2.4 or 2.6.  And hasn't done since forever. 
What we have in there is no more useful than suser().

You can do prctl(PR_SET_KEEPCAPS, 1) so that permitted caps are retained
across setuid().  And after the setuid() you can raise effective caps
again.  So that's workable, although pretty sad - it requires that su and
login be patched to run the prctl and to re-raise effective caps.

But the two showstoppers are:

1) capabilities are unconditionally nuked across execve() unless you're
   root (cap_bprm_set_security())

2) the kernel unconditionally removes CAP_SETPCAP in dummy_capget() so
   it is not possible for even a root-owned, otherwise-fully-capable task
   to raise capabilities on another task.  Period.

I must say that I'm fairly disappointed that we developed and merged all
that fancy security stuff but nobody ever bothered to fix up the existing
simple capability code.

Particularly as, apparently, the new security stuff STILL cannot solve the
extremely simple Oracle-wants-CAP_IPC_LOCK requirement.

Chris has proposed a little patch which will enable the retention of caps
across execve.  I'd be interested in knowing why we _ever_ dropped caps
across execve?  I thing we should run with Chris's patch - but the new
functionality should of course only be enabled by some admin-settable knob.

I'm looking at securebits.h and wondering why that exists - there's no code
in-kernel to set the thing, although it is exported to modules.  Perhaps
securebits should be exposed in /proc and used to enable
retain-caps-across-execve.
