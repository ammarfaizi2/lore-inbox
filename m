Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317378AbSHQQzv>; Sat, 17 Aug 2002 12:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317380AbSHQQzv>; Sat, 17 Aug 2002 12:55:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35856 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317378AbSHQQzu>; Sat, 17 Aug 2002 12:55:50 -0400
Date: Sat, 17 Aug 2002 10:02:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re:
 async-io API registration for 2.5.29)]
In-Reply-To: <2159880183.1029535922@[10.10.2.3]>
Message-ID: <Pine.LNX.4.44.0208170953190.3062-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Martin J. Bligh wrote:
> 
> I don't see why the area above PAGE_OFFSET has to be global, or per
> VM (by which I'm assuming you're meaning the set of pagetables per
> process, aka group of tasks sharing an mm). 

Basic issue: if the VM's aren't _identical_ (in every way, including the 
kernel one), they cannot share the page tables in an SMP environment with 
two threads running on two CPU's at the same time.

And once you cannot share the page tables, you're screwed. 

> Assume 3 level page tables and a 3/1 user/kernel split for the sake 
> of argument.

No, no, that's the wrong way to go about it. You have to show a _portable_ 
way to do it, not a "if I assume this, I can do it".

For example, on x86 with the regular 2-level page tables, if you want to 
have different kernel mappings, you have to copy the page directory 
per-CPU, and then on task switch you have to change the PGD appropriately.

Which, btw, means that you have to invalidate the TLB for that CPU, even
if you would otherwise not have needed to. Look at how the lazy TLB
switching works, and realize that two threads can _switch_ CPU's as things
stand now, without ever a single TLB invalidate happening. They can take 
over the TLB of the other thread when they move to another CPU. You'd 
break that, horribly and fundamentally.

So to make this work, you'd have to have:
 - architecture-specific hacks
 - realize that not all architectures can do it at all, so the places that 
   depend on this would have to have some abstraction that makes it go 
   away when not needed.
 - fix up lazy TLB switching (conditionally on the hack).

It just sounds really messy to me.

		Linus

