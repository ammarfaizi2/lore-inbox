Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTHVEqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 00:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbTHVEqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 00:46:45 -0400
Received: from postoffice02.Princeton.EDU ([128.112.130.38]:466 "EHLO
	Princeton.EDU") by vger.kernel.org with ESMTP id S263015AbTHVEqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 00:46:42 -0400
Message-ID: <3F459F02.B11234CF@cs.princeton.edu>
Date: Fri, 22 Aug 2003 00:41:39 -0400
From: Yaoping Ruan <yruan@cs.princeton.edu>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel hangs up running web server
References: <3F3D672D.1AF660B6@cs.princeton.edu> <20030815164334.1e37b5b8.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I posted this kernel lock problem sometime last week. Though there're helpful
suggestion, I haven't found any useful information from the kernel. I've tried
2.6.0-test3 and the same thing happened. The machine couldn't be reached by "ping"
after hanging up. But the bug may not be in sendfile() or epoll() since a version
without these two system call also causes kernel lock.

Thus I've made both the server (Flash) and the workload generator (Flexiclient)
available at:
www.cs.princeton.edu/~yruan/flash
 and would appreciate if any of the developers could try them out. To run the test

1. generate fileset at server side by copying over fileset and
   ./fileset -s zipfset -n #DIRS
2. compile Flash (may change options in config.h) and run
   ./flash -user YOUR_ACCOUNT
3. run client as:
   ./zipfgen -s spec -n #DIRS | ./batcher 5 | ./flexiclient -host HOST -time
SECONDS -active 1000
(it's a rarely happened bug, better to run more than 1800 seconds, with 1000
connections)

Thanks a lot


- Yaoping


Andrew Morton wrote:

> Yaoping Ruan <yruan@cs.princeton.edu> wrote:
> >
> > Hi,
> >
> > Recently we updated a user space web server to use the sendfile() and
> > epoll() interface, and tried to measure the performance with SpecWeb99
> > benchmark. As the load increases, e.g a SpecWeb99's target score of 600
> > connection, the kernel sometimes hangs up without any logging
> > information, and the only way left is to push the reset button to
> > reboot.
> >
> > We also made similar updates to use sendfile() and kevent() on FreeBSD
> > and achieved a score of 1000 connections. Thus the possibility of
> > application bug is low (also it is a user space server). Before the
> > sendfile() and epoll() change, it was also fine but only could get a
> > SpecWeb99 score of 500.
> >
> > The kernel we were using was 2.4.21 with the epoll patch applied. Since
> > the epoll man pages mention the interface is stabilized in 2.5.66, we
> > also tried 2.5.66 but didn't see anything better. The machine is a PIII
> > Xeon processor-based Intel server motherboard, with 2 CPU support but
> > only 1 is used, Maxtor Diamond IDE disk, Promise Ultra DMA 66
> > controller, and a single Netgear GA621 gigabit ethernet network adapter.
> >
>
> Definitely a kernel bug.
>
> Could you please test 2.6.0-test3?  If that has the same problem then
> some initial steps would be:
>
> - Boot the kernel with the "nmi_watchdog=1" option on the kernel boot
>   command line.  (It needs to be an SMP-compiled kernel for this to work.
>   Or one which has the local APIC enabled in config)
>
> - Make sure that /proc/sys/kernel/sysrq was set to `1' after booting.
>
> - Can you still ping the machine after it hangs up?
>
> - Type ALT-SYSRQ-T and/pr ALT-SYSRQ-P on the keyboard, see if you get a trace.
>
> - ALT-SYSRQ-M may be interesting too (memory stats)
>
> If the nmi watchdog doesn't generate a trace then the sysrq keys should do
> so.
>
> If the above does not provide us with enough information to solve the bug
> then the next step would be for you to provide sufficient material for a
> kernel developer to reproduce the problem.
>
> Thanks.

