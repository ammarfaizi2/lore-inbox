Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVLTVHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVLTVHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVLTVHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:07:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932115AbVLTVHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:07:22 -0500
Date: Tue, 20 Dec 2005 13:03:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: James Courtier-Dutton <James@superbug.co.uk>
cc: Adrian Bunk <bunk@stusta.de>, Sergey Vlasov <vsu@altlinux.ru>,
       Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
In-Reply-To: <43A86B20.1090104@superbug.co.uk>
Message-ID: <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
 <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local>
 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de>
 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <43A86B20.1090104@superbug.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Dec 2005, James Courtier-Dutton wrote:
>
> They all load in the correct order if they are modules. The problem comes when
> one compiles them into the kernel. They then load in the wrong order and bad
> things happen, resulting in the recommendation that alsa should always be
> modules.

Which, as a recommendation, is pure and utter crap.

> In this basis, we should not have to change the code in alsa at all, but
> instead change the kernel to understand the load order, even if compiled into
> the kernel and not as modules.

NO.

The kernel does support this (and has supported for a long time).

First off, load order matters, even in the kernel. Within one "class" of 
initializers, you can just specify the right order in the Makefile, and it 
will honor them. Of course, that ends up often being hard to do across 
different directories, which is why there's another facility:

The kernel has several different classes of ordering. Anybody who thinks 
that "module_init()" is it, just hasn't looked at <linux/init.h>. There's 
seven different levels:

	#define core_initcall(fn)               __define_initcall("1",fn)
	#define postcore_initcall(fn)           __define_initcall("2",fn)
	#define arch_initcall(fn)               __define_initcall("3",fn)
	#define subsys_initcall(fn)             __define_initcall("4",fn)
	#define fs_initcall(fn)                 __define_initcall("5",fn)
	#define device_initcall(fn)             __define_initcall("6",fn)
	#define late_initcall(fn)               __define_initcall("7",fn)

where the next-to-last one is the regular "device_initcall()" (and this is 
what a "module_init()" in a compiled-in driver will use).

Now, something like the basic sound subsystem initialization should 
obviously NOT be a "device initcall". It's not a device. It's a subsystem 
that serves devices, and thus the basic sound initialization should 
probably use "subsys_initcall()" instead.

Now, if it's built as a module, that "subsys_initcall()" ends up doing 
exactly the same thing as a plain "module_init()", and you'll never see 
any difference. But when it's built into the kernel, it means that it gets 
initialized with the other subsystems.

Now, one thing to look out for is that if your "core sound initialization" 
depends on PCI probing having completed (ie it's not a pure subsystem with 
no dependencies on anything else), the common hack for that is to just use 
the "fs_initicall()" instead. But a truly independent subsystem (which 
sound hopefully is) should just use subsys_initcall(), and then, if that 
subsystem internally has more complex ordering, just use the link order in 
the Makefiles to indicate that.

> I have no idea how to get the kernel to do this though. Any pointers?

The above should hopefully make the kernel support for this obvious.

I thought more people knew about all this. Forcing (or even just 
encouraging) people to use loadable modules is just horrible. I personally 
run a kernel with no modules at all: it makes for a simpler bootup, and in 
some situations (embedded) it has both security and size advantages.

			Linus
