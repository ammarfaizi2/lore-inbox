Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWETJ1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWETJ1V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 05:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWETJ1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 05:27:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53715 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932262AbWETJ1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 05:27:20 -0400
Date: Sat, 20 May 2006 02:26:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, kraxel@suse.de, zach@vmware.com
Subject: Re: [patch] i386, vdso=[0|1] boot option and
 /proc/sys/vm/vdso_enabled
Message-Id: <20060520022650.46b048f8.akpm@osdl.org>
In-Reply-To: <20060520085351.GA28716@elte.hu>
References: <1147759423.5492.102.camel@localhost.localdomain>
	<20060516064723.GA14121@elte.hu>
	<1147852189.1749.28.camel@localhost.localdomain>
	<20060519174303.5fd17d12.akpm@osdl.org>
	<20060520010303.GA17858@elte.hu>
	<20060519181125.5c8e109e.akpm@osdl.org>
	<Pine.LNX.4.64.0605191813050.10823@g5.osdl.org>
	<20060520085351.GA28716@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > > Well that patch took a machine from working to non-working.  Pretty serious
> > > stuff.  We should get to the bottom of the problem so we can assess the
> > > risk and impact, no?
> > 
> > Yes. And it would be good to have a way to turn it off - either 
> > globally of by some per-process setup (eg off by default, but turn on 
> > when doing some magic).
> > 
> > The per-process one would be the harder one, because it would require 
> > the fixmap entry, but not globally. So I suspect the only practical 
> > thing would be to have it be a kernel boot-time option.
> 
> below is a patch that adds the vdso=0 boot option from exec-shield and 
> the /proc/sys/vm/vdso_enabled per-system sysctl.
> 
> Andrew, could you try this - do newly started processes work fine if you 
> re-enable the vdso after booting with vdso=0?

vmm:/home/akpm# echo 1 > /proc/sys/vm/vdso_enabled 
vmm:/home/akpm# 
vmm:/home/akpm> ls -l
zsh: segmentation fault  ls -l

> That could tell us whether 
> it's an init bug or a glibc bug.

It tells us neither.  This could be a new kernel bug which only certain old
userspace setups are known to trigger.  Until we know exactly why this is
occurring, we don't know where the bug is.

And once we've worked that thing out, and if we determine that the bug is
in userspace then we might be able to craft the patch in such a fashion
that the old userspace continues to work, which would be a win.

>  arch/i386/kernel/sysenter.c |   21 +++++++++++++++++++++
>  include/linux/sysctl.h      |    1 +
>  kernel/sysctl.c             |   16 ++++++++++++++++
>  3 files changed, 38 insertions(+)

Documentation/kernel-parameters.txt, please.

> +unsigned int vdso_enabled = 1;

__read_mostly.


