Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbUENU6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUENU6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 16:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUENU6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 16:58:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:54732 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262794AbUENU6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 16:58:50 -0400
Date: Fri, 14 May 2004 13:58:49 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Message-ID: <20040514135849.Y21045@build.pdx.osdl.net>
References: <20040513032736.40651f8e.akpm@osdl.org> <20040513114520.A8442@infradead.org> <20040513035134.2e9013ea.akpm@osdl.org> <20040513121850.B22989@build.pdx.osdl.net> <20040513123809.01398f93.akpm@osdl.org> <20040513124249.J21045@build.pdx.osdl.net> <20040514191454.GJ3044@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040514191454.GJ3044@dualathlon.random>; from andrea@suse.de on Fri, May 14, 2004 at 09:14:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli (andrea@suse.de) wrote:
> On Thu, May 13, 2004 at 12:42:49PM -0700, Chris Wright wrote:
> > * Andrew Morton (akpm@osdl.org) wrote:
> > > Chris Wright <chrisw@osdl.org> wrote:
> > > >  +static int capability_mask;
> > > >  +module_param_named(mask, capability_mask, int, 0);
> > > >  +MODULE_PARM_DESC(mask, "Mask of capability checks to ignore");
> > > 
> > > Is there a way to make this tunable at runtime, btw?
> > 
> > Yeah, it'd require sysctl or similar, and further reduces the security,
> > unless you only allow bit clearing or something.
> 
> the runtime switch would be more confortable, the config is:
> 
> ONFIG_SECURITY=y
> CONFIG_SECURITY_NETWORK=y
> CONFIG_SECURITY_CAPABILITIES=y
> CONFIG_SECURITY_CAPABILITIES_BOOTPARAM=y

So you already prepare for a capability bootparam.

> CONFIG_SECURITY_ROOTPLUG=m
> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> CONFIG_SECURITY_SELINUX_DEVELOP=y
> # CONFIG_SECURITY_SELINUX_MLS is not set
> 
> if the runtime switch needs sysctl then probably we can stay with
> disable_cap_mlock or mlock_group (I prefer disable_cap_mlock because
> having more sysctl doesn't make it more secure, if you can exploit
> disable_cap_mlock you can exploit hugetlbfs_group and you can exploit
> mlock_group too). It's an hack and the simplest hack is

Well it's just basic security issue.  The disable_cap_mlock has less
runtime risk because it's only exposing a single capability.  The ability
to mask off capability checks as boot/module load time (not compilation
time) is more flexible, and doesn't have to touch any extra code (which
gives the feel of cleaner hack), and is runtime safe (unless you care
a lot about setting up oracle, then re-enabling the CAP_IPC_LOCK checks
to minimized risk exposure).  You could give the module_param some 0644
access, but now uid == 0 or CAP_DAC_OVERRIDE could freely change the
mask during runtime.  So, to my thinking, you'd want to control with
sysctl that only allows bit clearing.

> disable_cap_mlock and it is more "featured" than the group that is only
> available to one group of users at once.

Question of audience...machine running oracle, or machine with users
that want safe gpg.  In fact, they probably aren't same machine, and I
bet in both cases a single group would work.  Well, anyway for gpg we
only want rlimits, and this work is already done...

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
