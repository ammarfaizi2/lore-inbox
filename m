Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317696AbSGOXvH>; Mon, 15 Jul 2002 19:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317699AbSGOXvG>; Mon, 15 Jul 2002 19:51:06 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:33421 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317696AbSGOXvF>; Mon, 15 Jul 2002 19:51:05 -0400
Message-ID: <3D336046.5000407@us.ibm.com>
Date: Mon, 15 Jul 2002 16:52:38 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch[ Simple Topology API
References: <Pine.GSO.4.21.0207130355180.13648-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al,

If I can get 1-2 syscalls for the Topo API, and 1-2 for the Membind API, I'll 
gladly make the changes.  For now, though, prctl() works fine.  If it needs to 
be changed at some point, it can be done in about 5 minutes...

As far as the raciness of the get_curr_cpu & get_curr_node calls, that is noted 
in the comments.  Until we get a better way of exposing the current working 
processor to userspace, they'll have to do.  I believe that having *some* idea 
of where you're running is better than having *no* idea of where you're running.

-Matt

Alexander Viro wrote:
> 
> On Fri, 12 Jul 2002, Matthew Dobson wrote:
> 
> 
>>Here is a very rudimentary topology API for NUMA systems.  It uses prctl() for 
>>the userland calls, and exposes some useful things to userland.  It would be 
>>nice to expose these simple structures to both users and the kernel itself. 
>>Any architecture wishing to use this API simply has to write a .h file that 
>>defines the 5 calls defined in core_ibmnumaq.h and include it in asm/mmzone.h. 
>>  Voila!  Instant inclusion in the topology!
>>
>>Enjoy!
> 
> 
> It's hard to enjoy the use of prctl().  Especially for things like
> "give me the number of the first CPU in node <n>" - it ain't no
> process controll, no matter how you stretch it.
> 
> <soapbox> That's yet another demonstration of the evil of multiplexing
> syscalls.  They hide the broken APIs and make them easy to introduce.
> And broken APIs get introduced - through each of these.  prctl(), fcntl(),
> ioctl() - you name it.  Please, don't do that. </soapbox>
> 
> Please, replace that API with something sane.  "Current processor" and
> _maybe_ "current node" are reasonable per-process things (even though
> the latter is obviously redundant).  They are inherently racy, however -
> if you get scheduled on the return from syscall the value may have
> nothing to reality by the time you return to userland.  The rest is
> obviously system-wide _and_ not process-related (it's "tell me about
> the configuration of machine").  Implementing them as prctls makes
> absolutely no sense.  If anything, that's sysctl material.
> 
> 


