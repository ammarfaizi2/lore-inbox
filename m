Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbTEKSsl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 14:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbTEKSsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 14:48:41 -0400
Received: from waste.org ([209.173.204.2]:48514 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261855AbTEKSsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 14:48:40 -0400
Date: Sun, 11 May 2003 14:00:23 -0500
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Jamie Lokier <jamie@shareable.org>, Jos Hulzink <josh@stack.nl>,
       Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
Message-ID: <20030511190023.GC9173@waste.org>
References: <m1fznl74f9.fsf@frodo.biederman.org> <Pine.LNX.4.44.0305111124240.12955-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305111124240.12955-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 11:38:34AM -0700, Linus Torvalds wrote:
> 
> On 11 May 2003, Eric W. Biederman wrote:
> > 
> > Now if someone could tell me how to do a jump to 0xffff0000:0xfff0 in real
> > mode I would find that very interesting.
> 
> You should be able to do it the same way as you enter unreal mode, ie:
> 
>  - in protected mode cpl0, crate a segment that has index 0xf000 (ie you 
>    need a large GDT for this to work), and has the right attributes (ie 
>    base 0xffff0000, 16-bit, etc).
> 
>    Make sure you reload the other segments with something sanish and be 
>    16-bit clean.
> 
>  - clear the PE bit, but do _not_ do the long jump to reload the segment 
>    that intel says you should do - just do a short jump to 0xfff0.
> 
> One problem is that the code segment you create this way will have the 
> right base and size, but it will be non-writeable (no way to create a 
> writable code segment in protected mode), so it will be different in other 
> ways.
> 
> And because you'll have to do some of the the setup with that new and
> inconvenient CS, you'll either have to make the limit be big (and wrap 
> around EIP in order to first execute code that is in low memory), or 
> you'll have to play even more tricks and clear both PE and PG at the same 
> time and just "fall through" to the code at 0xfffffff0. 
> 
> Sounds like it might work, at least on a few CPU's. 

There's a missing piece of behavior here that's probably fatal.
Namely, the next time the CS descriptor is loaded, even with the same
value, the high bits are lost. So, for example, if you're running BIOS
out of ROM, decompressing it into the top of 20-bit address space,
then long jumping to your uncompressed code, you don't want to find
yourself back in ROM.

Perhaps there's a trick that can be played with loading the descriptor
into CS and then clearing the descriptor table without flushing, but it
sounds rather dubious..

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
