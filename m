Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbVKWVgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVKWVgx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbVKWVgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:36:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28052 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932540AbVKWVgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:36:52 -0500
Date: Wed, 23 Nov 2005 13:36:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
In-Reply-To: <1132782245.13095.4.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> 
 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> 
 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> 
 <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de>  <438359D7.7090308@suse.de>
 <p7364qjjhqx.fsf@verdi.suse.de>  <1132764133.7268.51.camel@localhost.localdomain>
  <20051123163906.GF20775@brahms.suse.de>  <1132766489.7268.71.camel@localhost.localdomain>
  <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org>  <4384AECC.1030403@zytor.com>
  <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Nov 2005, Alan Cox wrote:
> 
> There is a much much better way to do it than just user space and
> without hitting cr3/cr4 - put "lock works" in the PAT and while we'll
> have to add PAT support which we need to do anyway we would get a world
> where on uniprocessor lock prefix only works on addresse targets we want
> it to - ie pci_alloc_consistent() pages.

No. That would be wrong.

The thing is, "lock" is useless EVEN ON SMP in user space 99% of the time.

Think of all the thread locking in libc - where 99% of all processes are 
single-threaded, and it does nothing but slow things down.

Actual UP machines are going to go away - even ARM is going SMP, and in 
the PC space, we'll have multi-core laptops probably being the rule rather 
than the exception in a couple of years. So the kernel will need "lock" in 
the forseeable future, and optimizing for UP is a lost game.

But optimizing for a single _thread_ is not a lost game. I don't believe 
that threaded applications are necessarily going to take over all that 
much in a lot of areas. Sure, we'll have more threaded apps too, but we'll 
continue to have tons more of performance-critical non-threaded things 
like compilers etc.

And _that_ is worth optimizing for. General libraries that have to be able 
to handle the threaded case dynamically, but that are often run with no 
shared memory anywhere.

THAT is what I'd like to have CPU support for. Not for UP (it's going 
away), and not for the kernel (it's never single-threaded).

			Linus
