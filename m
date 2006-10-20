Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWJTIsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWJTIsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 04:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWJTIsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 04:48:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24964 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932195AbWJTIsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 04:48:00 -0400
Date: Fri, 20 Oct 2006 01:47:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Lorenz <martin@lorenz.eu.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: un/shared IRQ problem (was: Re: 2.6.18 - another DWARF2)
Message-Id: <20061020014753.4d568ddc.akpm@osdl.org>
In-Reply-To: <20061020083741.GA5709@gimli>
References: <20061017063710.GA27139@gimli>
	<4807377b0610171152tfea31c1v3f907dcaf0a58509@mail.gmail.com>
	<20061018063431.GE20238@gimli>
	<20061018232603.585d14c3.akpm@osdl.org>
	<20061019063921.GJ6189@gimli>
	<20061019000109.626170f7.akpm@osdl.org>
	<m1mz7s5plh.fsf@ebiederm.dsl.xmission.com>
	<20061019101411.f2466b2e.akpm@osdl.org>
	<20061020083741.GA5709@gimli>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 10:37:41 +0200
Martin Lorenz <martin@lorenz.eu.org> wrote:

> On Thu, Oct 19, 2006 at 10:14:11AM -0700, Andrew Morton wrote:
> > On Thu, 19 Oct 2006 08:48:10 -0600
> > ebiederm@xmission.com (Eric W. Biederman) wrote:
> > 
> > > >
> > > > There are already three interrupt sources on 201, so they are all happy to
> > > > share.
> > > >
> > > > It's e1000.  Jesse, you fibbed ;)
> > > >
> > > > static int e1000_request_irq(struct e1000_adapter *adapter)
> > > > {
> > > > 	...
> > > > 	if (adapter->have_msi)
> > > > 		flags &= ~IRQF_SHARED;
> > > 
> > > Well MSI irqs can't be shared, as they are edged triggered.
> > > Is the e1000 really trying to use irq 201?   That would indicate
> > > a logic failure in the msi irq allocator.  It should never allocate
> > > an inuse irq.
> > 
> > It's gone very bad.  See 
> > http://www.lorenz.eu.org/~mlo/kernel/dmesg_2.6.18-ie-la-tp-41.5+0813.boot
> > http://www.lorenz.eu.org/~mlo/kernel/dmesg_2.6.18-ie-la-tp-41.5+0813.out
> > 
> > > I have to ask what is the state in 2.6.19-rc2? I'm wondering if
> > > my turning of the msi irq allocator inside out has fixed this problem.
> > 
> > Martin, please try  CONFIG_PCI_MSI=n.  I'd expect that to fix it (it always does)
> > 
> > > Does this situation work if MSI is disabled, in 2.6.18?
> > > 
> > > The backwards msi irq allocator in 2.6.18 is so convoluted it may have
> > > a corner case where it fails, and that is triggering this mess.
> > > 
> > > If 2.6.19 works with MSI's enabled and 2.6.18 works with MSI disabled
> > > I'm inclined to say I have done all that is reasonable.
> > 
> > oh, we haven't tried 2.6.19-rc2 yet?   Please do that, with CONFIG_PCI_MSI=y.
> 
> ok...
> I compliled and installed the latest git yesterday evening and another one
> this morning because of a configuration mistake I made

OK, sounds like Eric's MSI changes have helped.

> there are new DWARFs but the one I reported for 2.6.18 seem to be fixed
> at least I diden't succeed in triggering it
> 
> the new ones are in 
> http://www.lorenz.eu.org/~mlo/kernel/dmesg_2.6.19-rc2-tp-ie-e1-42.5+0737-gce9e3d99-dirty.run
> http://www.lorenz.eu.org/~mlo/kernel/dmesg_2.6.19-rc2-tp-ie-e1-42.5+0737-gce9e3d99-dirty.boot

Confused.  I see no backtraces in the above.

> http://www.lorenz.eu.org/~mlo/kernel/interrupts_2.6.19-rc2-tp-ie-e1-42.5+0737-gce9e3d99-dirty
> is there too
> 
> http://www.lorenz.eu.org/~mlo/kernel/?C=M;O=D
> for a list of files I uploaded
> 
> [   64.655000] kobject_add failed for vcs6 with -EEXIST, don't try to register things with the same name in the same directory.
> [   64.655000]  [<c0103bfd>] dump_trace+0x69/0x1af
> [   64.655000]  [<c0103d5b>] show_trace_log_lvl+0x18/0x2c
> [   64.656000]  [<c01043fa>] show_trace+0xf/0x11
> [   64.656000]  [<c01044fd>] dump_stack+0x15/0x17
> [   64.656000]  [<c01fbf3d>] kobject_add+0x160/0x189
> [   64.657000]  [<c0250fec>] class_device_add+0xa2/0x3d8
> [   64.658000]  [<c02513ae>] class_device_create+0x7c/0x9c
> [   64.659000]  [<c0237858>] vcs_make_sysfs+0x3c/0x7e
> [   64.659000]  [<c023c641>] con_open+0x6f/0x7c
> [   64.660000]  [<c023259b>] tty_open+0x179/0x2f0
> [   64.661000]  [<c016226e>] chrdev_open+0x124/0x13f
> [   64.662000]  [<c015e665>] __dentry_open+0xc7/0x1ab
> [   64.662000]  [<c015e7c3>] nameidata_to_filp+0x24/0x33
> [   64.662000]  [<c015e804>] do_filp_open+0x32/0x39
> [   64.663000]  [<c015e84d>] do_sys_open+0x42/0xc3
> [   64.663000]  [<c015e907>] sys_open+0x1c/0x1e
> [   64.664000]  [<c0102de7>] syscall_call+0x7/0xb
> [   64.664000] DWARF2 unwinder stuck at syscall_call+0x7/0xb

hm, people report that occasionally - I don't think anyone knows what's
causing it.

