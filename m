Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUDBWNZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 17:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbUDBWNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 17:13:25 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:59662 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261181AbUDBWNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 17:13:20 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>, linux-kernel@vger.kernel.org
Subject: Re: Exploring sigqueue leak (was: Strange 'zombie' problem both in 2.4 and 2.6)
Date: Sat, 3 Apr 2004 01:13:09 +0300
User-Agent: KMail/1.5.4
References: <200404021605.15909@zigzag.lvk.cs.msu.su>
In-Reply-To: <200404021605.15909@zigzag.lvk.cs.msu.su>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404030113.09958.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 April 2004 15:05, Nikita V. Youshchenko wrote:
> Hello.
>
> Yesterday I posted to linux-kernel describind a problem that caused both
> 2.4 and 2.6 kernels to leave lots of zombies.
> I analysed the problem and found it is caused by overflow of 'sigqueue'
> slab cache (I may be wrong in terminology here). Details are in my
> previous post.
>
> Now I'm looking for advice from somebody who understands how stuff in
> linux/signal.c works.
>
> [the following ins about unpatched 2.6.4 kernel]
>
> Seems that 'sigqueue' objects are allocated exactly in 2 places: in
> __sigqueue_alloc() and in send_signal().
>
> __sigqueue_alloc() seems to be used only by sigqueue_alloc();
> sigqueue_alloc() seems only to be used by alloc_posix_timer() from
> kernel/posix-timers.c;
> alloc_posix_timer() is a static function used only by sys_timer_create()
> syscall handler.
> This syscall is not one widely used; I'm not sure it it is actually used by
> anything running here.
>
> So the leak seems to happen through allocation of 'sigqueue' objects in
> send_signal().
> However, if I understand correctly, object allocated here keeps information
> about signal being transferred, and lives as long as this tranfer is in
> progress.
> Signal transfer is somewhat very fast.
> So, if everything is working ok, usually zero 'sigqueue' objects should be
> allocated.
>
> Seems that it is possible to find out how many 'sigqueue' objects are
> currently allocated by running
>    grep sigqueue /proc/slabinfo
> and looking at the first number of output.
> So seems that almost always the first number in the output of the above
> command should be zero.
> And that's exactly what happens on all hosts here expect the server.

Sorry, still no real help from me but maybe some useful data points:

On my home box:

# grep sigqueue /proc/slabinfo
sigqueue              18     25    156   25    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      32     18     1    0    0    0   57 : cpustat  33581      2  33583      0
Another home box:
# grep sigqueue /proc/slabinfo
sigqueue               9     25    156   25    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      16     16     1    0    0    0   57 : cpustat  71984      1  71985
Third box:
# grep sigqueue /proc/slabinfo
sigqueue              16     25    156   25    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      16     16     1    0    0    0   57 : cpustat 1388121      1 1388122      0

No more 2.6 boxes for you here ;)

So, not exactly zero but small.

Now, 2.4 boxes:

# grep sigqueue /proc/slabinfo
sigqueue               0     29    132    0    1    1
# grep sigqueue /proc/slabinfo
sigqueue               8     29    132    1    1    1
# grep sigqueue /proc/slabinfo
sigqueue               0      0    132    0    0    1 :  252  126

Smaller.
--
vda

