Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267630AbSLFWv0>; Fri, 6 Dec 2002 17:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbSLFWv0>; Fri, 6 Dec 2002 17:51:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6672 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267630AbSLFWvY>; Fri, 6 Dec 2002 17:51:24 -0500
Date: Fri, 6 Dec 2002 14:58:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jim Houston <jim.houston@ccur.com>
cc: george anzinger <george@mvista.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <3DF11D16.289456B2@ccur.com>
Message-ID: <Pine.LNX.4.44.0212061450330.1101-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Dec 2002, Jim Houston wrote:
> 
> I know it would be a few extra lines of assembly code but it would be
> nice if the restart routine had the original arguments.

It's not even extra code on x86, since we don't stomp on any of the
arguments, and they will all have the same values when returning. So on
x86, we could see the arguments by just adding parameters to the
sys_restart_syscall() function.

However, the same is not necessarily true on other architectures, where
there can be overlap between clobbers and arguments (so that the first
invocation of the system call may have trashed the arguments unless it
explicitly saves it), and that's the reason I don't want to expose the
original ones.

Also, I actually much prefer the arguments to be saved away in the restart 
block for another reason too - because that way you can _trust_ them. The 
restart function basically knows that the arguments are truly the same 
that were saved away - if you allow the register contents from user space 
to be re-used, clever 'ptrace()' usage will be able to change the 
registers.

In other words, with the current setup, we can actually have hidden kernel 
state inside the restart block, and it never gets leaked to/from user 
space. That's potentially quite useful in itself (you can cache argument 
values).

		Linus

