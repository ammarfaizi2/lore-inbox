Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWJ0US7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWJ0US7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 16:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWJ0US7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 16:18:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16060 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751046AbWJ0US6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 16:18:58 -0400
Date: Fri, 27 Oct 2006 13:15:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch] drivers: wait for threaded probes between initcall
 levels
Message-Id: <20061027131529.980cd53e.akpm@osdl.org>
In-Reply-To: <20061027114729.49185fd2@freekitty>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	<20061026224541.GQ27968@stusta.de>
	<20061027010252.GV27968@stusta.de>
	<20061027012058.GH5591@parisc-linux.org>
	<20061026182838.ac2c7e20.akpm@osdl.org>
	<20061026191131.003f141d@localhost.localdomain>
	<20061027170748.GA9020@kroah.com>
	<20061027172219.GC30416@elf.ucw.cz>
	<20061027113908.4a82c28a.akpm@osdl.org>
	<20061027114144.f8a5addc.akpm@osdl.org>
	<20061027114237.d577c153.akpm@osdl.org>
	<20061027114729.49185fd2@freekitty>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 11:47:29 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> On Fri, 27 Oct 2006 11:42:37 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > From: Andrew Morton <akpm@osdl.org>
> > 
> > The multithreaded-probing code has a problem: after one initcall level (eg,
> > core_initcall) has been processed, we will then start processing the next
> > level (postcore_initcall) while the kernel threads which are handling
> > core_initcall are still executing.  This breaks the guarantees which the
> > layered initcalls previously gave us.
> > 
> > IOW, we want to be multithreaded _within_ an initcall level, but not between
> > different levels.
> > 
> > Fix that up by causing the probing code to wait for all outstanding probes at
> > one level to complete before we start processing the next level.
> > 
> > Cc: Greg KH <greg@kroah.com>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > ---
> > 
> 
> This looks like a good place to use a counting semaphore.
> 

I couldn't work out a way of doing that.  I guess one could a) count the
number of threads which are going to be started, b) start them all, c) do
an up() when each thread ends and d) handle errors somehow.

