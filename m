Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266105AbUAGAG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 19:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266106AbUAGAG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 19:06:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:35772 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266105AbUAGAG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 19:06:57 -0500
Date: Tue, 6 Jan 2004 16:06:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andi Kleen <ak@colin2.muc.de>, Mika Penttil? <mika.penttila@kolumbus.fi>,
       Andi Kleen <ak@muc.de>, David Hinds <dhinds@sonic.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
In-Reply-To: <m1brpgn1c3.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.58.0401061554010.9166@home.osdl.org>
References: <1aJdi-7TH-25@gated-at.bofh.it> <m37k054uqu.fsf@averell.firstfloor.org>
 <Pine.LNX.4.58.0401051937510.2653@home.osdl.org> <20040106040546.GA77287@colin2.muc.de>
 <Pine.LNX.4.58.0401052100380.2653@home.osdl.org> <20040106081203.GA44540@colin2.muc.de>
 <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de>
 <Pine.LNX.4.58.0401060726450.2653@home.osdl.org> <20040106153706.GA63471@colin2.muc.de>
 <m1brpgn1c3.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Jan 2004, Eric W. Biederman wrote:
> 
> And mtd map drivers for rom chips run into the same problem except in
> that case regions is almost always reserved by the BIOS.
> 
> Which means it's just silly for the drivers to fail when request_mem_region
> fails.

Note: you're not supposed to need to do "request_mem_region()" for modern 
drivers. You should only need to claim ownership of the resources, and the 
PCI driver interfaces should do that automatically.

What you should do for resources you know about is to just _create_ them. 
Not necessarily request them (although that is one way of creating them), 
but you can literally just tell the kernel that they are there. That will 
already mean that anybody else that tries to allocate a resource will 
avoid that area.

So if you know the hardware is there, and it _tells_ you it's there
(unlike, say, an ISA device), you can just call "request_mem_region()"  
without ever even checking the error return (although you had better make
sure that the name allocation is stable if you are a module - don't want
to start oopsin in /proc if the module gets unloaded).

The PCI layer already does all of that for the "standard" resources. It's 
just that the generic code can't do it for nonstandard regions, so drivers 
for chips that don't have just the regular BAR things should create their 
own resource entries..

		Linus
