Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWEaIjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWEaIjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 04:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWEaIjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 04:39:15 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:32035 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S964869AbWEaIjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 04:39:14 -0400
Subject: Re: linux-2.6 x86_64 kgdb issue
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: Andi Kleen <ak@suse.de>
Cc: Piet Delaney <piet@bluelane.com>, "Amit S. Kale" <amitkale@linsyssoft.com>,
       "Vladimir A. Barinov" <vbarinov@ru.mvista.com>,
       Andrew Morton <akpm@osdl.org>, kgdb-bugreport@lists.sourceforge.net,
       trini@kernel.crashing.org, linux-kernel@vger.kernel.org
In-Reply-To: <200605310913.54758.ak@suse.de>
References: <446E0B4B.9070003@ru.mvista.com> <200605310750.34047.ak@suse.de>
	 <1149057987.26542.116.camel@piet2.bluelane.com>
	 <200605310913.54758.ak@suse.de>
Content-Type: text/plain
Organization: BlueLane Tech,
Date: Wed, 31 May 2006 01:39:09 -0700
Message-Id: <1149064749.26542.191.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 May 2006 08:39:13.0354 (UTC) FILETIME=[B1B852A0:01C6848D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 09:13 +0200, Andi Kleen wrote:
> On Wednesday 31 May 2006 08:46, Piet Delaney wrote:
> > On Wed, 2006-05-31 at 07:50 +0200, Andi Kleen wrote:
> > > > Perhaps we should add a kgdb config menu option and #define
> > > > CONFIG_16KSTACKS to double the stack size so the kernel can be 
> > > > debugged with more context available. I'm currently using -O0 for 
> > > > the networking stack and -O1 for the rest of the kernel. Sounds like 
> > > > it would be helpful now for AMD64 targets.
> > > 
> > > You only got stack overflows when working with kgdb right?
> > 
> > Yes, I was using kgdb to look at the stack audits I stored in
> > the thread structure.
> 
> Again this likely points to kgdb using too much stack.

My bet is that in this case I was storing a LOT of 
data in the thread structure, so the space left for 
the stack was massively reduced. 

I was using a debugging tool for taking snapshots of the
top 16 PC's on the stack when you take a spinlock; for 
each premption level. It's thread specific data, so the 
thread structure seemed like a reasonable place to store it.

> 
>   
> > > Sounds like a kgdb problem to me then that can and should be probably fixed. e.g. 
> > > afaik kgdb isn't reentrant anyways so it could just use static buffers.
> > 
> > On Solaris the problem was that the kernel stack was larger because tail
> > optimization was disabled with optimization disabled. I'm not having
> > a kgdb problem with i386, it seems that Vladimir is/was and Amit
> > suspected it being due to the AMD64 requiring largers stacks. Seems
> > plausible to me. I thought you might have thoughts on that.
> 
> Stack usage in Linux isn't that tight that it should make a difference.
> If something needs too much stack we just fix it.
>  
> > > 
> > > I would suggest against adding any new config options for this - it would
> > > conflict with the great goal of having loadable debuggers that work
> > > on any kernels.
> > 
> > What's the conflict with larger kernel stacks and a loadable (kgdb)
> > module? 
> 
> We'll not increase the stacks by default but the debugger should
> work anyways.

Sure but the debugger environment must tolerate larger stacks.
A developer may prefer to use a larger stack, like in my case
of storing debug info in the thread structure. The interrupt 
stack checks can easily miss nicking the thread structure, so
increasing the stack size for experimentation SHOULD always work.


> 
> > I was suggesting larger stack space for the kernel, not kgdb. I agree
> > this case might be one where kgdb has caused the kernel to trip over 
> > the edge. I don't feel comfortable running on a kernel that running
> > that close to running out of stack space. Maybe that's just a personal
> > preference; I'm paranoid I guess. I like having rock solid systems and
> > wacking the stack isn't always detected. On SunOS we had a REDZONE but
> > last I check Linux didn't; has one been added? 
> 
> Interrupts can check for too much stack space used.

But this can miss a minor abuse. The interrupt check
is a quick and simple hack but I wonder if it's really
optimal for commercial implementations.

> 
> > If it hasn't it might 
> > be good to keep in mind having a CPU specific physical page available
> > when we grow into the REDZONE. Looked to me like the stack grows right
> > into the thread structure; might make a nice exploit for a linux root
> > kit.
> 
> If you have a stack overflow you usually have other problems than that.

Yep, like viewing the stack with kgdb. With Solaris all of the task use
the same virtual address space for the stack, so mapping in a physical
page was easy. Linux stacks are mapped linear 1:1 to physical pages, 
so it's not easy.
 

> 
> > Having loadable debuggers seems a bit high hopes, as 'we' haven't even
> > release linux with kgdb built into the Linux src yet. 
> 
> Yes because you if modular works you don't need to build it in.

I think all modules should be ABLE to be built in. 2.6 has made good
progress in that regard. I'd prefer to see kgdb also ABLE to be linked
in or a module; just like most modules are doing now. I don't see an
advantage to the Linux community to REQUIRING the kgdb module to 
NOT being ABLE to be linked in. Using modules often requires more
work to set up and get working right. It has it's advantages, I'd
prefer to leave it up to the developer to choose. Sometimes you
unload a module and pre-existing callbacks can mess up things in
unexpected way when the size of data structures change. I've used
kgdb on modules but for stuff like the TCP stack I really don't
want to mess with that. I'd prefer we make it easier for users
to get set up for kernel debugging. Just config kgdb, avoid using
kernel modules, install and run. Having kgdb in the kernel source
tree doesn't preclude it's use as a module. It does require it to
be under the GNU license. Unfortunately the HPUX kgdb patch wasn't
under the GNU license; it had some nice features, like kgdb over
TCP with ssh encryption. An that was 10 years ago! 

> 
> Modular was working at some point on x86-64 for kdb and the original 2.6 version
> of kgdb was nearly there too.

Yea, I saw that, too bad we can't seem to get a version of kgdb into
the kernel that can be update with the rest of the kernel. As I recall
NetBSD, FreeBSD, and OpenBSD have always done it that way. 'We' almost
got George Anzinger's kgdb patch into Linux; it was working great in the
mm series. Seems it should all be configurable with #ifdef CONFIG_KGDB
just like other kernel features. If you want to support other debuggers
than gdb I suppose common trap code could use a common CONFIG_* token.

-piet

>  
> -Andi
> 
-- 
---
piet@bluelane.com

