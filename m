Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUBLRU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 12:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266530AbUBLRSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 12:18:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:35821 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266540AbUBLRRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 12:17:48 -0500
Date: Thu, 12 Feb 2004 09:17:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave McCracken <dmccr@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
In-Reply-To: <339500000.1076605352@[10.1.1.5]>
Message-ID: <Pine.LNX.4.58.0402120912430.5816@home.osdl.org>
References: <1076384799.893.5.camel@gaston> <Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
 <20040210173738.GA9894@mail.shareable.org> <20040213002358.1dd5c93a.ak@suse.de>
 <20040212100446.GA2862@elte.hu> <Pine.LNX.4.58.0402120833000.5816@home.osdl.org>
 <339500000.1076605352@[10.1.1.5]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Feb 2004, Dave McCracken wrote:
> 
> So what's a reasonable value for 'not just above' and 'not just below'?  We
> could skip the entire hole, which would give us reasonable behavior for the
> brk area, but it wouldn't work so well for the area below the stack.  I'm
> sure if we define a 'reasonable' value to skip someone somewhere will
> collide with it.

Well, we have had _exactly_ this issue before, which is why I mentioned 
it.

See the HP-PA support code (for "CONFIG_STACK_GROWSUP") for setting up the 
stack in such a way that it leaves some empty space above it in fs/exec.c, 
for example. There it does

	...
        /* Limit stack size to 1GB */
        stack_base = current->rlim[RLIMIT_STACK].rlim_max;
        if (stack_base > (1 << 30))
                stack_base = 1 << 30;
        stack_base = PAGE_ALIGN(STACK_TOP - stack_base);
	...

it it uses RLIMIT_STACK plus a maximum limit (although it's a _big_
maximum limit, much bigger than we'd use for BSS). So we could do
something similar for the BSS, with obviously a smaller hard limit (on a 
64-bit architecture a gigabyte is fine, but ..)

			Linus
