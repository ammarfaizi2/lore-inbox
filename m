Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUIFVMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUIFVMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 17:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUIFVMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 17:12:09 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:41963 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266263AbUIFVMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 17:12:02 -0400
Date: Mon, 6 Sep 2004 14:11:42 -0700
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ak@muc.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-Id: <20040906141142.663941fb.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org>
References: <20040831183655.58d784a3.pj@sgi.com>
	<20040904133701.GE33964@muc.de>
	<20040904171417.67649169.pj@sgi.com>
	<Pine.LNX.4.58.0409041717230.4735@ppc970.osdl.org>
	<20040904180548.2dcdd488.pj@sgi.com>
	<Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org>
	<20040904204850.48b7cfbd.pj@sgi.com>
	<Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org>
	<20040904211749.3f713a8a.pj@sgi.com>
	<20040904215205.0a067ab8.pj@sgi.com>
	<20040906182330.GA79122@muc.de>
	<Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> I hate the "byte at a time" interface.
> 
> That said, I think the "long at a time" interface we have now for bitmaps 
> ends up being a compatibility problem, where the compat layer has to worry 
> about big-endian 32-bit "long" lookign different from big-endian 64-bit 
> "long".

My first preference would be to get all the binary bitmap interfaces
(affinity, mbind and mempolicy) "right":

    I think that means an array of 'u32'.  This parallels what I did for
    the ascii format, where there was less need to remain compatible
    (except that ascii is naturally big-endian, while the u32 array has
    the low order word first):

      $ cat /sys/devices/system/node/node0/cpumap
      00000000,00000000,00000000,000000ff

    No doubt Andi will veto this for mbind/mempolicy, because it breaks
    libnuma's he has in the field - a reasonable concern.  We'd probably
    have to burn another couple of system calls, introducing the new API
    while keeping the old one around, as is, for a year or three.

    And this (array of u32) is different from the kernel bitmap, due to
    the reversed u32 halves of each u64 on big endian 64 arches.  If I
    were God, the kernel bitmap would also be an array of u32's, not ulongs.
    Still ... might as well start somewhere, and get the kernel/user API
    "right", even if the kernel internals have an irreparable twist.

    I agree with Andi that there should be an explicit way to get the
    correct size - the loops cause too many user level code bugs, and
    trying to accomodate user code that doesn't know the exact size is
    causing our kernel code too much grief.

    Possible ways to publish cpumask/nodemask sizes include:

     1) # an ascii field in some proc file:

	    $ grep sizeof /proc/sys/kernel

     2) sysctl

     3) overload sched_getaffinity (for sizeof cpumask) and get_mempolicy
	(for sizeof nodemask) to return the sizes if passed zero lengths
	or NULL mask pointers or some other currently useless input.

My second preference would be what we had a week ago.  Minor tweaks
(especially ones that relax the preconditions) to busted API's do more
harm than good.  Leave 'em be, or get 'em "right".  Quit putting
lipstick on a pig.

I was surprised that Andi came up with yet another tweak to this API
(his suggested patch to allow either 0x00 or 0xff fill).  Surely Andi
doesn't need this for _his_ code, since he's competent to code to the
current API.  So I guess he's trying to make life easier for others.
Eh ... doesn't seem worth it.

Leave it be, I say.  Leave it be.  Or get it right.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
