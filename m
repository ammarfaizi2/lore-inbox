Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266270AbUAGQdJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 11:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUAGQdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 11:33:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:26498 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266270AbUAGQdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 11:33:05 -0500
Date: Wed, 7 Jan 2004 08:32:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andi Kleen <ak@colin2.muc.de>, Mika Penttil? <mika.penttila@kolumbus.fi>,
       Andi Kleen <ak@muc.de>, David Hinds <dhinds@sonic.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
In-Reply-To: <m1smirlppt.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.58.0401070803320.12602@home.osdl.org>
References: <1aJdi-7TH-25@gated-at.bofh.it> <m37k054uqu.fsf@averell.firstfloor.org>
 <Pine.LNX.4.58.0401051937510.2653@home.osdl.org> <20040106040546.GA77287@colin2.muc.de>
 <Pine.LNX.4.58.0401052100380.2653@home.osdl.org> <20040106081203.GA44540@colin2.muc.de>
 <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de>
 <Pine.LNX.4.58.0401060726450.2653@home.osdl.org> <20040106153706.GA63471@colin2.muc.de>
 <m1brpgn1c3.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0401061554010.9166@home.osdl.org>
 <m13casmk28.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0401062116230.12602@home.osdl.org>
 <m1smirlppt.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Jan 2004, Eric W. Biederman wrote:
> 
> However insert_resource does not quite match what I think needs to
> happen.  After a pci quirk applies insert_resource I will get
> something like:
> 
> fff0000-ffffffff : BIOS ROM Window
>   ffff0000-ffffffff : reserved
> 
> With the reserved region still present and marked as BUSY.

I would suggest ignoring it. Not only because being overly complicated is 
bad, but simply because nobody should care. 

At some point adding extra regions is _purely_ for "documentation" 
reasons, and while that may be nice, it's not worth worrying about. The 
only thing you really want from a _correctness_ standpoint is to make sure 
that nobody else will try to allocate their stuff in that area, and your 
"BIOS ROM Window" resource should do that already. 

> Would it be reasonable to write a variant of request_resource that just
> drops BIOS resources.

It would not be impossible to just have a "force_resource()" that would
simply override _any_ existing resource, but quite frankly, I'd be more
nervous about that.

We could also mark the e820 non-RAM resources with some special
IORESOURCE_TENTATIVE flag, and allow just overriding those. 

But even the simple "insert_resource()" has some potential problems: if 
the BIOS has allocated the minimal window for itself (64kB at 0xffff0000), 
and has allocated some _other_ chip at 0xfffe0000 that the kernel doesn't 
know about yet, your insert_resource() would do the wrong thing and claim 
the whole area for the BIOS writing. 

Maybe that doesn't happen, but it's something to think about.

At some point, the _correct_ answer may be: don't do complex things, and
write a bootable floppy (without any OS at all, or a really minimal one)  
to do BIOS rom updates.

		Linus
