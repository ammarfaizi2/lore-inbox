Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWDDWXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWDDWXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 18:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWDDWXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 18:23:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15237 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750800AbWDDWXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 18:23:12 -0400
Date: Tue, 4 Apr 2006 15:19:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: ebiederm@xmission.com, bunk@stusta.de, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net, fastboot@osdl.org
Subject: Re: 2.6.17-rc1-mm1: KEXEC became SMP-only
Message-Id: <20060404151904.764ad9f4.akpm@osdl.org>
In-Reply-To: <4432ECF1.8040606@vmware.com>
References: <20060404014504.564bf45a.akpm@osdl.org>
	<20060404162921.GK6529@stusta.de>
	<m1acb15ja2.fsf@ebiederm.dsl.xmission.com>
	<4432B22F.6090803@vmware.com>
	<m1irpp41wx.fsf@ebiederm.dsl.xmission.com>
	<4432C7AC.9020106@vmware.com>
	<20060404132546.565b3dae.akpm@osdl.org>
	<4432ECF1.8040606@vmware.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden <zach@vmware.com> wrote:
>
> Andrew Morton wrote:
> >
> >>  struct subarch_hooks subarch_hook_vector = {
> >>       .machine_power_off = machine_power_off,
> >>       .machine_halt = machine_halt,
> >>       .machine_irq_setup = machine_irq_setup,
> >>       .machine_subarch_setup = machine_subarch_probe
> >>       ...
> >>  };
> >>
> >>  And machine_subarch_probe can dynamically change this vector if it 
> >>  confirms that the platform is appropriate?
> >>     
> >
> > I don't recall anyone expressing any desire for the ability to set these
> > things at runtime.  Unless there is such a requirement I'd suggest that the
> > best way to address Eric's point is to simply rename the relevant functions
> > from foo() to subarch_foo().
> >   
> 
> Avoiding the runtime assignment isn't possible if you want a generic 
> subarch that truly can run on multiple different platforms.

Well as I said - I haven't seen any requirement for this expressed.  That
doesn't mean that such a requirements doesn't exist, of course.

> I prefer runtime assignment not for this reason, but simply because it 
> also eliminates two artifacts:
> 
> 1) You can add new subarch hooks without breaking every other 
> sub-architecture

Is that useful?   If you need a new subarch_bar() then

a) Implement it in the subarch which needs it
b) Implement an attribute(weak) stub in a new subarch-stubs.c
c) call it.

That's a little more costly than a static inline stub, but not much.  Are
there likely to be any subarch calls which are a) called frequently and b)
not required on some subarchs?

> 2) You don't need #ifdef SUBARCH_FUNC_FOO goo to do this (renaming 
> voyager_halt -> default)

Why would one need that?  Isn't it simply a matter of renaming
machine_halt() to subarch_machine_halt() everywhere?

I'm just looking for the simplest option here.  Eric has identified a code
maintainability problem - it'd be good to fix that, but we shouldn't add
runtime cost/complexity unless we actually gain something from it.
