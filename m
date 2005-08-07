Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752267AbVHGQUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbVHGQUF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 12:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbVHGQUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 12:20:05 -0400
Received: from modeemi.modeemi.cs.tut.fi ([130.230.72.134]:30911 "EHLO
	modeemi.modeemi.cs.tut.fi") by vger.kernel.org with ESMTP
	id S1752265AbVHGQUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 12:20:05 -0400
Date: Sun, 7 Aug 2005 19:20:01 +0300
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: assertion (cnt <= tp->packets_out) failed
Message-ID: <20050807162001.GL27323@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: shd@modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> I suspect this is a side effect of some changes Herbert Xu and 
> myself did to fix some other bugs.

I think I crossed this bug independently today. I did some testing, and 
got kernel panics when uploading files with ftp on a gigabit lan. The 
error happens always at net/ipv4/tcp_output.c:918. Here's a matrix of 
combinations that crashes or doesn't crash:

kernel			what happens
2.6.12			no crash
2.6.13-rc1 & e1000	no crash
2.6.13-rc1 & skge	no crash
2.6.13-rc2 & e1000	crash
2.6.13-rc2 & skge	no crash
2.6.13-rc3 & e1000	crash
2.6.13-rc3 & skge	no crash
2.6.13-rc5 & e1000	crash
2.6.13-rc5 & skge	no crash

There were big changes in tcp_output.c between rc1 and rc2, and the bug 
is triggered when using e1000 with rc2 or later. And because the bug 
does not happen on skge (new sk98 driver) it makes me guess it's a race 
condition of sorts.. I am surprised this bug wasn't noticed with rc2.

The crash happens just in the beginning of a tcp connection. Only some 
packets are sent and then the sends stall by slowing down, and after 5 
secs the kernel crashes. Basically usage pattern is this:

upload file a
upload file b
upload file a (replaces old file)
upload file b (replaces old file)
upload file a (replaces old file) => slowdown and then a crash in 5 secs 


Here's the kernel greeting:

Kernel BUG at "net/ipv4/tcp_output.c":918
Invalid operand: 0000 [1]
CPU 0
Modules linked in:
Pid 0, comm: swapper Not tainted 2.6.13-rc5
RIP: 0010:[<ffffffff804d086d>] <ffffffff804d086d><__tcp_push_pending_frames+429>
...
Process swapper (pid: 0, threadinfo ffffffff807de000, task ffffffff80640ec0)
...
Call Trace: <IRQ> <ffffffff804ce30c><tcp_rcv_established+1964>
		  <...>             <tcp_v4_do_rcv+37> ... <...><ip_local_deliver_finish+0>
		  <...>             <tcp_v4_rcv+1483> ... <...><ip_local_deliver+322>
		  <...>             <ip_rcv+1107> ... <...><netif_receive_skb+426>
		  <...>             <process_backlog+154>
		  <...>             <__do_softirq+83>
		  <...>             <do_softirq+53>
		  <...>             <ret_from_intr+0>
		  <...>             <default_idle+0>
		  <...>             <cpu_idle+49>
		  <...>             <_sinittext+534>
		  <...>             <>
		  <...>             <>
		  <...>             <>
		  <...>             <>
		  <...>             <>
		  <...>             <>
...
RIP <ffffffff804d086d><__tcp_push_pending_frames+429> ...
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!


Here's system info:

Linux e275d 2.6.13-rc2 #1 Sun Aug 7 18:48:05 EEST 2005 x86_64 AMD Athlon(tm) 64 Processor 3000+ AuthenticAMD GNU/Linux
 
Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12i
mount                  2.12i
module-init-tools      3.0
e2fsprogs              1.38
jfsutils               1.1.4
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.6.25
nfs-utils              1.0.6
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   058
Modules Loaded         



-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
