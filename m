Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbTEKTAu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 15:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbTEKTAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 15:00:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31823 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S261212AbTEKTAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 15:00:45 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Jamie Lokier <jamie@shareable.org>, Jos Hulzink <josh@stack.nl>,
       Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
References: <Pine.LNX.4.44.0305111124240.12955-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 May 2003 13:10:11 -0600
In-Reply-To: <Pine.LNX.4.44.0305111124240.12955-100000@home.transmeta.com>
Message-ID: <m1wugx5mgc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

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

I suspect the fact it is unwritable won't be a real problem.  ROM chips
are essentially unwritable.  But there will be the behavioral difference 
between discarding writes and causing an exception.
 
> And because you'll have to do some of the the setup with that new and
> inconvenient CS, you'll either have to make the limit be big (and wrap 
> around EIP in order to first execute code that is in low memory), or 
> you'll have to play even more tricks and clear both PE and PG at the same 
> time and just "fall through" to the code at 0xfffffff0. 
> 
> Sounds like it might work, at least on a few CPU's. 

I will have to try it one of these times.  I keep wondering if I can call
a BIOS without trigger a reset line.

At the same time I think this is very much not what we want in the reboot
path.  As I suspect the existing BIOS if it does anything different will
freak out on us.  Jumping to a known location where there is ram sounds much
safer.

Eric
