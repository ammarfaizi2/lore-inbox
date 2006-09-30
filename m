Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWI3Izf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWI3Izf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWI3Izf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:55:35 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:35797 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751174AbWI3Izd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:55:33 -0400
Date: Sat, 30 Sep 2006 10:55:32 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: x z <dealup@yahoo.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Makefile for linux modules
Message-ID: <20060930085532.GA13745@uranus.ravnborg.org>
References: <20060929182008.fee2a229.akpm@osdl.org> <20060930015700.26045.qmail@web52812.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060930015700.26045.qmail@web52812.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert.

>    I have a makefielt to make several driver modules:
> obj-$(CONFIG_FUSION_SPI)	+= mptbase.o mptscsih.o
> mptspi.o
> obj-$(CONFIG_FUSION_FC)		+= mptbase.o mptscsih.o
> mptfc.o
> obj-m				+= mptbase.o mptscsih.o mptsas.o
> obj-$(CONFIG_FUSION_LAN)	+= mptlan.o
> obj-m				+= mptctl.o
> obj-m                           += mptcfg.o
> obj-m                       +=mptstm.o

The above kbuild file snippet tells us that you are creating
a number of modules:
mptbase.ko mptscsih.ko mptsas.ko mptlan.ko mptctl.ko mtpcfg.ko and mptstm.ko
They are each build from a single .c file.

> mptbase-objs             := comfunc.o

Now you try to include confunc.o in every module.
To do so you need to tell kbuild that you are dealing with a module
based on composite .o files.
That would look like:
obj-$(CONFIG_FUSION_PCI) += mptbase-foo.o
mtpbase-foo-y := comfunc.o mptbase.o

This will result in a module named mtpbase-foo.ko which is hardly what
you try to achive. Likewise you will have duplicate symbols in the
modules due to comfunc.o being included more than once.

The only sane approce here is to compile comfunc.o as an independent
module and let the modutils pull in the comfunc (deservers a more
specific name) module as needed.

So what you need to do is simply:
obj-m += comfunc.o

And accept this is a module so all symbols that you needs must be properly
exported using EXPORT_SYMBOL*

	Sam
