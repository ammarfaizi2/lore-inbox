Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266907AbUFYXQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266907AbUFYXQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 19:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUFYXQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 19:16:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:31168 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266915AbUFYXQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 19:16:08 -0400
Date: Fri, 25 Jun 2004 16:16:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
       George Georgalis <george@galis.org>
Subject: Re: SATA_SIL works with 2.6.7-bk8 seagate drive, but oops
In-Reply-To: <20040625213433.GB6502@trot.local>
Message-ID: <Pine.LNX.4.58.0406251602140.1844@ppc970.osdl.org>
References: <20040624155919.GA16422@trot.local>
 <Pine.GSO.4.33.0406241442430.25702-100000@sweetums.bluetronic.net>
 <20040625213433.GB6502@trot.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Jun 2004, George Georgalis wrote:
> 
> However at about 3Gb (if that is relevant) top segfaulted with a
> non critical oops. top will not restart, but the box is otherwise
> functioning well considering the write load.

Ok, this is unlikely to be SATA-related, unless SATA just happened to 
corrupt something really strange.

> Unable to handle kernel NULL pointer dereference at virtual address 000000b4
>  printing eip:
> c017c78a
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT 
> CPU:    0
> EIP:    0060:[<c017c78a>]    Not tainted
> EFLAGS: 00010286   (2.6.7-sta-bk8) 
> EIP is at pid_alive+0xa/0x30

That's "p->pids[PIDTYPE_PID].pidptr", and it looks like "p" is NULL.

That in turn _shouldn't_ happen, since that comes from 

	struct task_struct *task = proc_task(inode);

and proc_task() should always be non-NULL for any /proc file that has one 
of the pid-based dentry ops. 

> Could this be related to "Unknown HZ value! (91) Assume 100." which
> started showing up with VIA motherboards on 2.5.x (I think) on top or ps
> commands.  When I researched it before, It never caused ill, had been
> identified as a "kernel bug" but benign. I know nothing more.

No, that's just a pstools bug. It shouldn't try to guess HZ at all.

> ATM, ps also seg faults, here is a corresponding oops,

Same problem. One of your existing /proc/<xxx>/ directories has a NULL 
"task" pointer, and that really shouldn't happen.

Hmm. I do worry that maybe it's the SATA thing that has written NULL 
somewhere, since the /proc code never clears that field once it is set 
(and it would always be set by the code that creates the inode in the 
first place). 

		Linus
