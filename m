Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267357AbTBPTze>; Sun, 16 Feb 2003 14:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267362AbTBPTzd>; Sun, 16 Feb 2003 14:55:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21765 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267357AbTBPTzd>; Sun, 16 Feb 2003 14:55:33 -0500
Date: Sun, 16 Feb 2003 12:01:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: more signal locking bugs?
In-Reply-To: <Pine.LNX.4.44.0302161139530.2952-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302161151160.2952-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Feb 2003, Linus Torvalds wrote:
> 
> See? ABBA _does_ happen with the task lock, it's just that the magic 
> required to do so is fairly unlikely thanks to the added requirement for 
> the irq to happen at just the right moment (ie there are no static 
> code-paths that can cause it).

Note: to clarify, this isn't in any way a new situation. As far as I can 
tell, this deadlock exists in 2.4.x too. And it's almost certainly pretty 
much impossible to trigger in practice, and as such we shouldn't need to 
be deeply worried about it. 

But it should make us think about the _design_ of locking in this region. 
Clearly we got it wrong, and clearly we never noticed for several years.

The simple fix is to make the task-lock be IRQ-safe. That fixes it, and
that's probably the right minimal solution for for 2.4.x (unless the "fix"  
for 2.4.x is to just ignore it since it's possible to trigger mostly in a
theoretical sense).

But assuming you accept that making the task-lock be irq-safe is the right
solution, then making it solve the signal handling and /proc scalability
issues is likely to be the right solution: since it's irq-safe, there's no 
real reason not to use it to protect task->{sighand | signal | parent} 
too.

			Linus

