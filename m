Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265864AbTIJWFZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265866AbTIJWFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:05:25 -0400
Received: from lidskialf.net ([62.3.233.115]:15580 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S265864AbTIJWFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:05:10 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: linux-kernel@vger.kernel.org, linux-dvb@linuxtv.org
Subject: Possible kernel thread related crashes on 2.4.x
Date: Wed, 10 Sep 2003 23:03:34 +0100
User-Agent: KMail/1.5.3
Cc: franck@nenie.org, eric@lammerts.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200309102303.34095.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I've been having fatal oopses with some of my DVB receiver systems 
when restarting streaming recently (i.e. opening/closing DVB devices). 
I've only just got into the office with a debug cable to find out what has happening.

Anyway, here are the important parts of the oops (full oops at end of mail):
Unable to handle kernel paging request at virtual address d905a984
...
Trace; c011c79c <free_uid+2c/34>
Trace; c011767b <release_task+2b/16c>
Trace; c0118337 <sys_wait4+307/390>
Trace; c0106c03 <system_call+33/38>

Does this look familiar to anyone? I mean specifically this thread on linux-dvb (among others):
http://www.linuxtv.org/mailinglists/linux-dvb/2003/04-2003/msg00291.html

Searching about found me this patch on LKML:
http://hypermail.idiosynkrasia.net/linux-kernel/archived/2003/week04/0468.html

Which I applied to 2.4.21, and which appears to fix the problem. At least,
I was able to continually restart streaming for 4 hours this afternoon without a problem. 
Previously, I could crash it within 15 minutes.

It seems to be a bug related to kernel threads when starting/stopping them. The DVB drivers 
now do this when a DVB device is opened/closed, although I'm sure they previously left 
them running which would explain why I never saw this behaviour before.

My question is: is there a reason the patch has not yet made it into 2.4.x? It is not in 
2.4.22-pre3.

Ta



ksymoops 2.4.5 on i686 2.4.21.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -m /boot/System.map-2.4.21 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address d905a984
c01295b8
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01295b8>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: 06014dab   ecx: c10072c0   edx: 00000010
esi: c12c74b0   edi: 00000246   ebp: c12dff80   esp: c12dff58
ds: 0018   es: 0018   ss: 0018
Process init (pid: 1, stackpage=c12df000)
Stack: c867c000 0000048b c12de000 c12dff80 c011c79c c12c74b0 c029b570 c011767b
       c029b570 c867c000 bffff730 c0118337 c867c000 c12de000 00000000 bffff730
       bffff6f4 c12dffb0 00000000 c12de000 00000000 00000000 00000000 c12de000
Call Trace:    [<c011c79c>] [<c011767b>] [<c0118337>] [<c0106c03>]
Code: 89 44 99 18 89 59 14 8b 41 10 8d 50 ff 89 51 10 83 f8 01 75


>>EIP; c01295b8 <kmem_cache_free+34/a8>   <=====

>>ebx; 06014dab Before first symbol
>>ecx; c10072c0 <_end+ceb68c/105f93cc>
>>esi; c12c74b0 <_end+fab87c/105f93cc>
>>ebp; c12dff80 <_end+fc434c/105f93cc>
>>esp; c12dff58 <_end+fc4324/105f93cc>

Trace; c011c79c <free_uid+2c/34>
Trace; c011767b <release_task+2b/16c>
Trace; c0118337 <sys_wait4+307/390>
Trace; c0106c03 <system_call+33/38>

Code;  c01295b8 <kmem_cache_free+34/a8>
00000000 <_EIP>:
Code;  c01295b8 <kmem_cache_free+34/a8>   <=====
   0:   89 44 99 18               mov    %eax,0x18(%ecx,%ebx,4)   <=====
Code;  c01295bc <kmem_cache_free+38/a8>
   4:   89 59 14                  mov    %ebx,0x14(%ecx)
Code;  c01295bf <kmem_cache_free+3b/a8>
   7:   8b 41 10                  mov    0x10(%ecx),%eax
Code;  c01295c2 <kmem_cache_free+3e/a8>
   a:   8d 50 ff                  lea    0xffffffff(%eax),%edx
Code;  c01295c5 <kmem_cache_free+41/a8>
   d:   89 51 10                  mov    %edx,0x10(%ecx)
Code;  c01295c8 <kmem_cache_free+44/a8>
  10:   83 f8 01                  cmp    $0x1,%eax
Code;  c01295cb <kmem_cache_free+47/a8>
  13:   75 00                     jne    15 <_EIP+0x15> c01295cd <kmem_cache_free+49/a8>

 <0>Kernel panic: Attempted to kill init!

1 warning issued.  Results may not be reliable.

