Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWAJHIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWAJHIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 02:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWAJHIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 02:08:15 -0500
Received: from mail.gmx.net ([213.165.64.21]:48267 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750939AbWAJHIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 02:08:14 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20060110062457.00c38d18@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 10 Jan 2006 08:08:09 +0100
To: Paolo Ornati <ornati@fastwebnet.it>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <20060109210035.3f6adafc@localhost>
References: <5.2.1.1.2.20060109162113.00ba9fd0@pop.gmx.net>
 <5.2.1.1.2.20060102092903.00bde090@pop.gmx.net>
 <20060101123902.27a10798@localhost>
 <5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
 <5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
 <200512281027.00252.kernel@kolivas.org>
 <20051227190918.65c2abac@localhost>
 <20051227224846.6edcff88@localhost>
 <200512281027.00252.kernel@kolivas.org>
 <5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
 <5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
 <5.2.1.1.2.20060109162113.00ba9fd0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0601-0, 01/02/2006), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:00 PM 1/9/2006 +0100, Paolo Ornati wrote:
>On Mon, 09 Jan 2006 16:52:17 +0100
>Mike Galbraith <efault@gmx.de> wrote:
>
> > >Care to try an experiment?...
>
>Yes.

Thanks.

>With my simple proggy things improve a bit:

<snip rest of good news>

>BUT if I start more of them (3/4) I'm able to fool it.
>
>"./a.out 7000 & ./a.out 6537 & ./a.out 6347 & ./a.out 5873"
>
>2 TOP's snapshots:
>
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5625 paolo     17   0  2392  288  228 R 31.6  0.1   0:10.74 a.out
>  5626 paolo     17   0  2392  288  228 R 28.8  0.1   0:09.16 a.out
>  5627 paolo     17   0  2392  288  228 R 22.2  0.1   0:07.59 a.out
>  5624 paolo     17   0  2392  288  228 R 17.4  0.1   0:08.67 a.out
>
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5626 paolo     16   0  2392  288  228 R 30.1  0.1   0:39.95 a.out
>  5627 paolo     16   0  2392  288  228 R 24.1  0.1   0:34.93 a.out
>  5625 paolo     18   0  2392  288  228 R 23.5  0.1   0:37.53 a.out
>  5624 paolo     18   0  2392  288  228 R 21.9  0.1   0:37.60 a.out
>  5193 root      15   0  167m  17m 2916 S  0.2  3.5   0:09.67 X
>  5638 paolo     18   0  4952 1468  372 R  0.2  0.3   0:00.15 dd
>
>DD test (256MB): real    3m37.122s  (instead of 8s)

Ok, I'll  take another look.  Those should be being throttled.

>REAL LIFE TEST (transcode)
>
>While running only transcode it gets priority 25:
>
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5857 paolo     25   0  114m  18m 2424 R 90.9  3.7   0:14.28 transcode
>  5873 paolo     19   0 49860 4452 1860 S  8.6  0.9   0:01.40 tcdecode
>  5308 paolo     16   0 86796  22m  15m R  0.2  4.4   0:06.26 konsole
>  5687 paolo     16   0 98648  37m 9348 S  0.2  7.5   0:02.11 perl
>  5872 paolo     24   0 21864 1064  600 S  0.2  0.2   0:00.01 tcextract
>
>
>But if I run also the DD test, "transcode" priority start fluctuating
>and can go down to 18/19 (from time to time) interfering with DD:

19 shouldn't interfere from the cpu side, but 18 will.

>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5694 paolo     19   0  114m  18m 2424 R 75.1  3.7   0:42.29 transcode
>  5710 paolo     25   0 49856 4452 1860 R  8.0  0.9   0:04.36 tcdecode
>  5726 paolo     18   0  4952 1468  372 R  4.0  0.3   0:00.77 dd
>
>
>This seems to happen because also transcode is reading (not directly but
>through pipes) from disk so the massive disk usage of DD interferes
>with it, this leads to transcode using less CPU and getting better
>priority.

It can't be pipe waits, they're disabled in the kernel.  Most likely the 
credit we get for being activated without having yet been selected.

>The exact behaviour changes time to time... but seems to confirm my
>teory.
>
>I don't know how can "nicksched" keep transcode priority always to 40
>even when I'm running the DD test... I should retry and see.
>
>
>PS: yes, transcode is reading from disk, but SLOWLY... i think that a
>good read-ahead should fullfill his needs even when doing the HD
>stressing DD test, no?

Dunno.

         -Mike 

