Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbSJMUsV>; Sun, 13 Oct 2002 16:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261804AbSJMUsS>; Sun, 13 Oct 2002 16:48:18 -0400
Received: from packet.digeo.com ([12.110.80.53]:22433 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261801AbSJMUrW>;
	Sun, 13 Oct 2002 16:47:22 -0400
Message-ID: <3DA9DD2F.E5A20CD2@digeo.com>
Date: Sun, 13 Oct 2002 13:53:03 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.42-mm2 contest results
References: <200210132128.13752.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Oct 2002 20:53:03.0665 (UTC) FILETIME=[86141A10:01C272FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Here are the surprisingly different results from 2.5.42-mm2 with the contest
> benchmark (http://contest.kolivas.net). This was run with pagetable sharing
> enabled. Older results hidden for clarity.
> 
> noload:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.5.41-mm3 [1]          74.4    93      0       0       1.11
> 2.5.42 [2]              72.5    93      0       0       1.08
> 2.5.42-mm2 [3]          79.0    92      0       0       1.18
> 

Well something is burning CPU there, and I do not know what it is.
Things are normal here:

With 2.5.42-mm2++, shared pagetables enabled:
make -j6 bzImage  416.97s user 33.94s system 374% cpu 2:00.28 total

With 2.5.42+last night's BK:
make -j6 bzImage  416.09s user 33.04s system 370% cpu 2:01.15 total

With 2.5.42:
make -j6 bzImage  416.56s user 32.49s system 375% cpu 1:59.69 total

So.  Could you please profile the `noload' run?  Just enable oprofile
and local IO APIC and do:

- add "idle=poll" to your kernel boot commandline
- sudo rm -rf /var/lib/oprofile
- sudo op_start --vmlinux=/boot/vmlinux --ctr0-event=CPU_CLK_UNHALTED \
  --ctr0-count=600000
- time make -j4 bzImage ; sudo op_stop
- oprofpp -l -i /boot/vmlinux
- sudo killall oprofiled

(Do the `make' quickly after the op_start to avoid bogus idle time).

Thanks.
