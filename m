Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318049AbSG2WPS>; Mon, 29 Jul 2002 18:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318069AbSG2WPR>; Mon, 29 Jul 2002 18:15:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35599 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318049AbSG2WOd>; Mon, 29 Jul 2002 18:14:33 -0400
Date: Mon, 29 Jul 2002 15:17:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Larson <plars@austin.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfs_read/vfs_write small bug fix (2.5.29)
In-Reply-To: <1027980379.11135.223.camel@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.33.0207291510340.1492-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29 Jul 2002, Paul Larson wrote:
> > 
> > (Or maybe glibc doesn't know that the kernel pread/pwrite system calls 
> > were always 64-bit clean, and it just happened to work).
?
> No, with just this patch it still fails on pread02 and pwrite02.

Ok, that just means that it's a library issue now - having looked at
historical kernel behaviour (and a lot of 64/bit architectures emulating
their old 32/bit system calls), the kernel system call interface is
clearly a 64-bit value, ie the kernel only export pread64/pwrite64, not a
"traditional" pread/pwrite at all.

So the question is what the library should do with a 32-bit negative 
"offset_t" passed in to the user-level "pread()" implementation. 

Looking at the disassembly of glibc pread, the implementation seems to be 
to just clear %edx on x86 (which are the high bits of the 64-bit offset 
value passed into sys_pread64()). 

And equally clearly your test wants to get EINVAL.

Your test would pass if glibc just sign-extended the 32-bit value to 64 
bits, instead of zero-extending it.

Alternativealy, your test would pass if glibc just internally checked for 
a negative offset.

I think the sign-extending sounds like the right idea, but that will
obviously break applications that _want_ to pread() in the 2GB-4GB address
without using pread64(). Something that sounds unlikely to be an issue, of
course (and which should have failed with -EBIG at open time anyway)

		Linus

