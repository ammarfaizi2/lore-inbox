Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283771AbRLWWzP>; Sun, 23 Dec 2001 17:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283724AbRLWWy4>; Sun, 23 Dec 2001 17:54:56 -0500
Received: from grootstal.nijmegen.internl.net ([217.149.192.7]:63120 "EHLO
	grootstal.nijmegen.internl.net") by vger.kernel.org with ESMTP
	id <S284147AbRLWWyp>; Sun, 23 Dec 2001 17:54:45 -0500
Date: Sun, 23 Dec 2001 23:53:15 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: linux-kernel@vger.kernel.org
Subject: <=2.4.17 deadlock (RedHat 7.2, SMP)
Message-ID: <20011223235315.A9071@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem occurs only when I disconnect a PPP dialup to an ISP. It
results in a box which only listens to alt-sysrq or a power cycle. The
userland setup is a bit complicated (two pppd instances, a zebra routing
daemon) but below there should be a clue about the cause.  This is all
on a RedHat 7.2 distro running on a dual PIII box. My brain decoded the
following JPEG picture I took from the screen after typing alt-sysrq-p
3 times:

Pid: 5613, comm                 pppd
EIP: 0010: [<c0403068>] CPU: 1 EFLAGS 00000286  not tainted
Call Trace: c0273cae c028ee04 c0293ac8 c0155879 c013f063
   c0150bc6 c028eac8 c01076cb

Pid: 5613, comm                 pppd
EIP: 0010: [<c040306f>] CPU: 1 EFLAGS 00000286  not tainted 
Call Trace: c0273cae c028ee04 c0293ac8 c0155879 c013f063
   c0150bc6 c028eac8 c01076cb

Pid: 18, comm                   kjournald
EIP: 0010: [<c03fca5b>] CPU: 0 EFLAGS 00000286  not tainted
Call Trace: c02ad897 c011f1ea c0140af5 c0179dde c011560c
   c017ca4d c017c7e0 c010590f

cat /proc/version says:
Linux version 2.4.17-b65 (fvm@iapetus.localdomain) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 SMP Sun Dec 23 22:16:27 CET 2001

ksymoops says:
ksymoops 2.4.1 on i686 2.4.17-b65.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-b65/ (default)
     -m /boot/System.map-2.4.17-b65 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
EIP: 0010: [<c0403068>] CPU: 1 EFLAGS 00000286  not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace: c0273cae c028ee04 c0293ac8 c0155879 c013f063
   c0150bc6 c028eac8 c01076cb
EIP: 0010: [<c040306f>] CPU: 1 EFLAGS 00000286  not tainted
Call Trace: c0273cae c028ee04 c0293ac8 c0155879 c013f063
   c0150bc6 c028eac8 c01076cb
EIP: 0010: [<c03fca5b>] CPU: 0 EFLAGS 00000286  not tainted
Call Trace: c02ad897 c011f1ea c0140af5 c0179dde c011560c
   c017ca4d c017c7e0 c010590f
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c0403068 <stext_lock+6c30/e9ac>   <=====
Trace; c0273cae <rs_wait_until_sent+b6/c4>
Trace; c028ee04 <ppp_ioctl+33c/d84>
Trace; c0293ac8 <ppp_destroy_channel+1bc/1c4>
Trace; c0155879 <dput+19/214>
Trace; c013f063 <filp_close+133/140>
>>EIP; c040306f <stext_lock+6c37/e9ac>   <=====
Trace; c0273cae <rs_wait_until_sent+b6/c4>
Trace; c028ee04 <ppp_ioctl+33c/d84>
Trace; c0293ac8 <ppp_destroy_channel+1bc/1c4>
Trace; c0155879 <dput+19/214>
Trace; c013f063 <filp_close+133/140>
>>EIP; c03fca5b <stext_lock+623/e9ac>   <=====
Trace; c02ad897 <do_ide_request+f/14>
Trace; c011f1ea <__run_task_queue+d2/e0>
Trace; c0140af5 <__wait_on_buffer+55/9c>
Trace; c0179dde <journal_commit_transaction+114a/181c>
Trace; c011560c <schedule+640/818>


3 warnings issued.  Results may not be reliable.

-- 
Frank
