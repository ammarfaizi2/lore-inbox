Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbTIXFZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 01:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTIXFZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 01:25:35 -0400
Received: from tomts15-srv.bellnexxia.net ([209.226.175.3]:49578 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261260AbTIXFZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 01:25:33 -0400
Date: Wed, 24 Sep 2003 01:25:30 -0400
From: mh <mh@nadir.org>
To: linux-kernel@vger.kernel.org
Subject: NMI lockup with 2.4.21
Message-ID: <20030924052528.GE2899@nadir.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have already reported lockups with 2.4.21 vanilla SMP but never got
a response. Symptoms are iptables keeps working, box pings but that's
it. only magic sysrq can save the day.

I cannot reproduce this easily. it happens maybe once every 2 months
or so. The system in question is under a constant medium load. mostly
network (http and smtp).

This time I had the NMI watchdog turned on and it caught a lockup.

I've said this before and maybe I'm out to lunch, but a lot of these
SMP lockup reports seem to have iptables in common. I realize that alot
of people use it.. but..

anyway here is the decoded lockup:

ksymoops 2.4.9 on i686 2.4.21.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -m /boot/System.map (specified)

NMI Watchdog detected LOCKUP on CPU1, eip c0107f93, registers:
CPU:    1
EIP:    0010:[<c0107f93>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000087
eax: c02cf9a0   ebx: 00000011   ecx: 00000000   edx: cdb82000
esi: 0000044e   edi: cfc220a8   ebp: cfc22000   esp: cdb83f70
ds: 0018   es: 0018   ss: 0018
Process httpd (pid: 32163, stackpage=cdb83000)
Stack: c011d6f4 00000000 00000011 bfffe660 00000000 cfc22000 cdb83fc4 c1e432e0 
00000004 00000000 00000135 cdb82000 404d7218 404d7218 bfffe678 c01079e7
00000011 bfffe660 cdb83fc4 00000000 c01093ef 402bc378 00000001 00000001
Call Trace:   [<c011d6f4>] [<c01079e7>] [<c01093ef>]
Code: 75 f6 f0 81 28 00 00 00 01 0f 85 e2 ff ff ff c3 90 f0 ff 00 


>>EIP; c0107f93 <__write_lock_failed+f/20>   <=====

>>eax; c02cf9a0 <tasklist_lock+0/20>
>>edx; cdb82000 <_end+d851168/104cf1c8>
>>edi; cfc220a8 <_end+f8f1210/104cf1c8>
>>ebp; cfc22000 <_end+f8f1168/104cf1c8>
>>esp; cdb83f70 <_end+d8530d8/104cf1c8>

Trace; c011d6f4 <.text.lock.fork+a5/121>
Trace; c01079e7 <sys_fork+27/30>
Trace; c01093ef <system_call+33/38>

Code;  c0107f93 <__write_lock_failed+f/20>
00000000 <_EIP>:
Code;  c0107f93 <__write_lock_failed+f/20>   <=====
   0:   75 f6                     jne    fffffff8 <_EIP+0xfffffff8>   <=====
Code;  c0107f95 <__write_lock_failed+11/20>
   2:   f0 81 28 00 00 00 01      lock subl $0x1000000,(%eax)
Code;  c0107f9c <__write_lock_failed+18/20>
   9:   0f 85 e2 ff ff ff         jne    fffffff1 <_EIP+0xfffffff1>
Code;  c0107fa2 <__write_lock_failed+1e/20>
   f:   c3                        ret    
Code;  c0107fa3 <__write_lock_failed+1f/20>
  10:   90                        nop    
Code;  c0107fa4 <__read_lock_failed+0/14>
  11:   f0 ff 00                  lock incl (%eax)


