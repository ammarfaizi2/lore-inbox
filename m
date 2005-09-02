Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030522AbVIBOcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030522AbVIBOcd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 10:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbVIBOcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 10:32:32 -0400
Received: from [212.76.87.54] ([212.76.87.54]:1544 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1030446AbVIBOcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 10:32:31 -0400
From: Al Boldi <a1426z@gawab.com>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Subject: Re: Where is the performance bottleneck?
Date: Fri, 2 Sep 2005 17:28:16 +0300
User-Agent: KMail/1.5
Cc: Jens Axboe <axboe@suse.de>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de> <Pine.LNX.4.61.0508312148040.1081@diagnostix.dwd.de> <Pine.LNX.4.61.0509010852040.17882@diagnostix.dwd.de>
In-Reply-To: <Pine.LNX.4.61.0509010852040.17882@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509020936.14054.a1426z@gawab.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Kiehl wrote:
> top - 08:39:11 up  2:03,  2 users,  load average: 23.01, 21.48, 15.64
> Tasks: 102 total,   2 running, 100 sleeping,   0 stopped,   0 zombie
> Cpu(s):  0.0% us, 17.7% sy,  0.0% ni,  0.0% id, 78.9% wa,  0.2% hi,  3.1%
> si Mem:   8124184k total,  8093068k used,    31116k free,  7831348k
> buffers Swap: 15631160k total,    13352k used, 15617808k free,     5524k
> cached
>
>    PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>   3423 root      18   0 55204  460  392 R 12.0  0.0   1:15.55 dd
>   3421 root      18   0 55204  464  392 D 11.3  0.0   1:17.36 dd
>   3418 root      18   0 55204  464  392 D 10.3  0.0   1:10.92 dd
>   3416 root      18   0 55200  464  392 D 10.0  0.0   1:09.20 dd
>   3420 root      18   0 55204  464  392 D 10.0  0.0   1:10.49 dd
>   3422 root      18   0 55200  460  392 D  9.3  0.0   1:13.58 dd
>   3417 root      18   0 55204  460  392 D  7.6  0.0   1:13.11 dd
>    158 root      15   0     0    0    0 D  1.3  0.0   1:12.61 kswapd3
>    159 root      15   0     0    0    0 D  1.3  0.0   1:08.75 kswapd2
>    160 root      15   0     0    0    0 D  1.0  0.0   1:07.11 kswapd1
>   3419 root      18   0 51096  552  476 D  1.0  0.0   1:17.15 dd
>    161 root      15   0     0    0    0 D  0.7  0.0   0:54.46 kswapd0
>
> A loadaverage of 23 for 8 dd's seems a bit high. Also why is kswapd
> working so hard? Is that correct.

Actually, kswapd is another problem. (see "Kswapd Flaw"  thread)
Which has little impact on your problem but basically kswapd tries very hard 
maybe even to hard to fullfil a request for memory, so when the buffer/cache 
pages are full kswapd tries to find some more unused memory. When it finds 
none it starts recycling the buffer/cache pages.  Which is OK, but it only 
does this after searching for swappable memory which wastes CPU cycles.

This can be tuned a little but not much by adjusting /sys(proc)/.../vm/...
Or renicing kswapd to the lowest priority, which may cause other problems.

Things get really bad when procs start asking for more memory than is 
available, causing kswapd to take the liberty of paging out running procs in 
the hope that these procs won't come back later.  So when they do come back 
something like a wild goose chase begins.  This is also known as OverCommit. 

This is closely related to the dreaded OOM-killer, which occurs when the 
system cannot satisfy a memory request for a returning proc, causing the VM 
to start killing in an unpredictable manner.

Turning OverCommit off should solve this problem but it doesn't.

This is why it is recommended to run the system always with swap enabled even 
if you have tons of memory, which really only pushes the problem out of the 
way until you hit the dead end and the wild goose chase begins again.

Sadly 2.6.13 did not fix this either.

Although this description only vaguely defines the problem from an end-user 
pov, the actual semantics may be quite different.

--
Al

