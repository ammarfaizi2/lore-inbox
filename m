Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318123AbSGMICV>; Sat, 13 Jul 2002 04:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318122AbSGMICU>; Sat, 13 Jul 2002 04:02:20 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:28912 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318121AbSGMICS>;
	Sat, 13 Jul 2002 04:02:18 -0400
Date: Sat, 13 Jul 2002 04:04:51 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch[ Simple Topology API
In-Reply-To: <3D2F75D7.3060105@us.ibm.com>
Message-ID: <Pine.GSO.4.21.0207130355180.13648-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jul 2002, Matthew Dobson wrote:

> Here is a very rudimentary topology API for NUMA systems.  It uses prctl() for 
> the userland calls, and exposes some useful things to userland.  It would be 
> nice to expose these simple structures to both users and the kernel itself. 
> Any architecture wishing to use this API simply has to write a .h file that 
> defines the 5 calls defined in core_ibmnumaq.h and include it in asm/mmzone.h. 
>   Voila!  Instant inclusion in the topology!
> 
> Enjoy!

It's hard to enjoy the use of prctl().  Especially for things like
"give me the number of the first CPU in node <n>" - it ain't no
process controll, no matter how you stretch it.

<soapbox> That's yet another demonstration of the evil of multiplexing
syscalls.  They hide the broken APIs and make them easy to introduce.
And broken APIs get introduced - through each of these.  prctl(), fcntl(),
ioctl() - you name it.  Please, don't do that. </soapbox>

Please, replace that API with something sane.  "Current processor" and
_maybe_ "current node" are reasonable per-process things (even though
the latter is obviously redundant).  They are inherently racy, however -
if you get scheduled on the return from syscall the value may have
nothing to reality by the time you return to userland.  The rest is
obviously system-wide _and_ not process-related (it's "tell me about
the configuration of machine").  Implementing them as prctls makes
absolutely no sense.  If anything, that's sysctl material.

