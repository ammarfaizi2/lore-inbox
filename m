Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbTEKS1E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 14:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTEKS1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 14:27:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42765 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261843AbTEKS1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 14:27:02 -0400
Date: Sun, 11 May 2003 11:38:34 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Davide Libenzi <davidel@xmailserver.org>,
       Jamie Lokier <jamie@shareable.org>, Jos Hulzink <josh@stack.nl>,
       Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
In-Reply-To: <m1fznl74f9.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44.0305111124240.12955-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 May 2003, Eric W. Biederman wrote:
> 
> Now if someone could tell me how to do a jump to 0xffff0000:0xfff0 in real
> mode I would find that very interesting.

You should be able to do it the same way as you enter unreal mode, ie:

 - in protected mode cpl0, crate a segment that has index 0xf000 (ie you 
   need a large GDT for this to work), and has the right attributes (ie 
   base 0xffff0000, 16-bit, etc).

   Make sure you reload the other segments with something sanish and be 
   16-bit clean.

 - clear the PE bit, but do _not_ do the long jump to reload the segment 
   that intel says you should do - just do a short jump to 0xfff0.

One problem is that the code segment you create this way will have the 
right base and size, but it will be non-writeable (no way to create a 
writable code segment in protected mode), so it will be different in other 
ways.

And because you'll have to do some of the the setup with that new and
inconvenient CS, you'll either have to make the limit be big (and wrap 
around EIP in order to first execute code that is in low memory), or 
you'll have to play even more tricks and clear both PE and PG at the same 
time and just "fall through" to the code at 0xfffffff0. 

Sounds like it might work, at least on a few CPU's. 

		Linus

