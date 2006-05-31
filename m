Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWEaHON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWEaHON (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 03:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWEaHON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 03:14:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:38533 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964833AbWEaHON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 03:14:13 -0400
From: Andi Kleen <ak@suse.de>
To: piet@bluelane.com
Subject: Re: linux-2.6 x86_64 kgdb issue
Date: Wed, 31 May 2006 09:13:53 +0200
User-Agent: KMail/1.9.1
Cc: "Amit S. Kale" <amitkale@linsyssoft.com>,
       "Vladimir A. Barinov" <vbarinov@ru.mvista.com>,
       Andrew Morton <akpm@osdl.org>, kgdb-bugreport@lists.sourceforge.net,
       trini@kernel.crashing.org, linux-kernel@vger.kernel.org
References: <446E0B4B.9070003@ru.mvista.com> <200605310750.34047.ak@suse.de> <1149057987.26542.116.camel@piet2.bluelane.com>
In-Reply-To: <1149057987.26542.116.camel@piet2.bluelane.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605310913.54758.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 May 2006 08:46, Piet Delaney wrote:
> On Wed, 2006-05-31 at 07:50 +0200, Andi Kleen wrote:
> > > Perhaps we should add a kgdb config menu option and #define
> > > CONFIG_16KSTACKS to double the stack size so the kernel can be 
> > > debugged with more context available. I'm currently using -O0 for 
> > > the networking stack and -O1 for the rest of the kernel. Sounds like 
> > > it would be helpful now for AMD64 targets.
> > 
> > You only got stack overflows when working with kgdb right?
> 
> Yes, I was using kgdb to look at the stack audits I stored in
> the thread structure.

Again this likely points to kgdb using too much stack.

  
> > Sounds like a kgdb problem to me then that can and should be probably fixed. e.g. 
> > afaik kgdb isn't reentrant anyways so it could just use static buffers.
> 
> On Solaris the problem was that the kernel stack was larger because tail
> optimization was disabled with optimization disabled. I'm not having
> a kgdb problem with i386, it seems that Vladimir is/was and Amit
> suspected it being due to the AMD64 requiring largers stacks. Seems
> plausible to me. I thought you might have thoughts on that.

Stack usage in Linux isn't that tight that it should make a difference.
If something needs too much stack we just fix it.
 
> > 
> > I would suggest against adding any new config options for this - it would
> > conflict with the great goal of having loadable debuggers that work
> > on any kernels.
> 
> What's the conflict with larger kernel stacks and a loadable (kgdb)
> module? 

We'll not increase the stacks by default but the debugger should
work anyways.

> I was suggesting larger stack space for the kernel, not kgdb. I agree
> this case might be one where kgdb has caused the kernel to trip over 
> the edge. I don't feel comfortable running on a kernel that running
> that close to running out of stack space. Maybe that's just a personal
> preference; I'm paranoid I guess. I like having rock solid systems and
> wacking the stack isn't always detected. On SunOS we had a REDZONE but
> last I check Linux didn't; has one been added? 

Interrupts can check for too much stack space used.

> If it hasn't it might 
> be good to keep in mind having a CPU specific physical page available
> when we grow into the REDZONE. Looked to me like the stack grows right
> into the thread structure; might make a nice exploit for a linux root
> kit.

If you have a stack overflow you usually have other problems than that.

> Having loadable debuggers seems a bit high hopes, as 'we' haven't even
> release linux with kgdb built into the Linux src yet. 

Yes because you if modular works you don't need to build it in.

Modular was working at some point on x86-64 for kdb and the original 2.6 version
of kgdb was nearly there too.
 
-Andi

