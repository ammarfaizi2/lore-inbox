Return-Path: <linux-kernel-owner+w=401wt.eu-S1760318AbWLJHHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760318AbWLJHHu (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 02:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760320AbWLJHHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 02:07:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57215 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760319AbWLJHHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 02:07:49 -0500
Date: Sat, 9 Dec 2006 23:07:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: seven <horia.muntean@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Temporary random kernel hang
Message-Id: <20061209230746.7e33b40f.akpm@osdl.org>
In-Reply-To: <7755634.post@talk.nabble.com>
References: <7755634.post@talk.nabble.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 8 Dec 2006 02:38:45 -0800 (PST) seven <horia.muntean@gmail.com> wrote:
> 
> Hello,
> 
> I have some trouble with a multithreaded java network server running on
> SLES10. At random times I see the kernel take 80% of the CPU leaving iddle
> to 0% for 30 seconds. After this period the system returns to normal
> operation state.
> 
> Below is a vmstat -a 3 recording that shows the problem:
> 
>  1  0      0 773068 529184 693048    0    0     0     0  272  201  0  0 100 
> 0  0
>  0  0      0 773068 529184 693064    0    0     0    25  317  334  1  0 99 
> 1  0
>  0  0      0 772944 529216 693248    0    0     0    24  477 1017  3  0 96 
> 0  0
>  0  0      0 772820 529256 693316    0    0     0     0  525 1376  4  1 95 
> 0  0
>  0  0      0 772448 529344 693636    0    0     0   107 1098 3306 11  2 86 
> 0  0
>  0  0      0 772324 529404 693456    0    0     0     0  723 2247  7  2 91 
> 0  0
>  0  0      0 772076 529496 693656    0    0     0   132  770 2488  7  2 91 
> 1  0
>  0  0      0 772200 529528 693608    0    0     0    91  528 1168  4  1 94 
> 1  0
>  0  0      0 772200 529532 693728    0    0     0     0  334  387  1  0 99 
> 0  0
>  0  0      0 772076 529568 693680    0    0     0    24  564 1250  4  1 95 
> 0  0
>  0  0      0 771828 529636 693784    0    0     0     0  787 2144  7  2 91 
> 0  0
>  0  0      0 771580 529744 694232    0    0     0   111  995 3081 11  2 86 
> 1  0
> 107  0      0 771316 529792 694904    0    0     0   153  829 1650 12 37 51 
> 0  0
> 113  0      0 771316 529792 694912    0    0     0     0  323  169 15 85  0 
> 0  0
> 116  0      0 771216 529792 694728    0    0     0    25  292  190 14 86  0 
> 0  0
> 122  0      0 771340 529792 694728    0    0     0    21  311  191 15 85  0 
> 0  0
> 138  0      0 771464 529792 694728    0    0     0     0  365  196 14 86  0 
> 0  0
> 146  0      0 771464 529792 694728    0    0     0     0  331  189 16 84  0 
> 0  0
> 150  0      0 771472 529792 694728    0    0     0     0  336  183 15 85  0 
> 0  0
> 146  0      0 771472 529792 694728    0    0     0     4  310  201 14 86  0 
> 0  0
> 145  0      0 771472 529792 694728    0    0     0     0  285  163 15 85  0 
> 0  0
> procs -----------memory---------- ---swap-- -----io---- -system--
> -----cpu------
>  r  b   swpd   free  inact active   si   so    bi    bo   in   cs us sy id
> wa st
> 146  0      0 771472 529792 694728    0    0     0     0  277  159 14 86  0 
> 0  0
> 145  0      0 771472 529792 694728    0    0     0    32  275  133 15 85  0 
> 0  0
>  0  0      0 771208 529892 694176    0    0     0     0 1012 3408 12  4 84 
> 0  0
>  0  0      0 770712 529972 694488    0    0     0   149  774 2869  8  2 90 
> 0  0
>  0  0      0 770712 529972 694488    0    0     0     0  271  195  0  0 100 
> 0  0
>  0  0      0 770728 529972 694488    0    0     0    35  269  167  0  0 100 
> 1  0
>  0  0      0 770728 529972 694488    0    0     0     7  269  189  0  0 100 
> 0  0
> 
> The application is memory stable ( no leaks ) and a deadlock is out of the
> question since in a deadlock case the system would freeze forever and not
> temporarily. There are around 200 - 250 tcp/ip clients connected to the
> application and 550 threads ( streaming blocking sockets are used so every
> client is managed by one reading thread and one writing thread)
> 
> The same application works fine on SLES9.3
> 
> Hanging Evironment:
> -----------------------------------------------------------------------------
> mustang:~ # uname -a
> Linux mustang 2.6.16.21-0.25-smp #1 SMP Tue Sep 19 07:26:15 UTC 2006 x86_64
> x86_64 x86_64 GNU/Linux
> mustang:~ # java -version
> java version "1.6.0-rc"
> Java(TM) SE Runtime Environment (build 1.6.0-rc-b104)
> Java HotSpot(TM) Server VM (build 1.6.0-rc-b104, mixed mode)
> mustang:~ # cat /etc/SuSE-release
> SUSE Linux Enterprise Server 10 (x86_64)
> VERSION = 10
> -----------------------------------------------------------------------------
> 
> Working environment:
> -----------------------------------------------------------------------------
> apollo:~ # uname -a
> Linux apollo 2.6.5-7.252-smp #1 SMP Tue Feb 14 11:11:04 UTC 2006 x86_64
> x86_64 x86_64 GNU/Linux
> apollo:~ # java -version
> java version "1.6.0-rc"
> Java(TM) SE Runtime Environment (build 1.6.0-rc-b95)
> Java HotSpot(TM) 64-Bit Server VM (build 1.6.0-rc-b95, mixed mode)
> apollo:~ # cat /etc/SuSE-release
> SUSE LINUX Enterprise Server 9 (x86_64)
> VERSION = 9
> PATCHLEVEL = 3
> -----------------------------------------------------------------------------
> 
> Can you give me some pointers about where to start debugging this issue?
> 

A kernel profile will tell us were the kernel is burning CPU.  Something
like this (run as root):

#!/bin/sh
while true
do
	opcontrol --stop
	opcontrol --shutdown
	rm -rf /var/lib/oprofile
	opcontrol --vmlinux=/boot/vmlinux-$(uname -r)
	opcontrol --start-daemon
	opcontrol --start
	date
	sleep 5
	opcontrol --stop
	opcontrol --shutdown
	opreport -l /boot/vmlinux-$(uname -r) | head -50
done | tee /tmp/oprofile-output

Then locate the output record which correlates with one of these episodes.
