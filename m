Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264209AbTH1TSE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 15:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbTH1TSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 15:18:03 -0400
Received: from rainbow.in-berlin.de ([212.42.229.242]:40460 "EHLO
	rainbow.in-berlin.de") by vger.kernel.org with ESMTP
	id S264209AbTH1TRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 15:17:44 -0400
Date: Thu, 28 Aug 2003 21:17:35 +0200
From: Robert Joop <1014856075@rainbow.in-berlin.de>
To: linux-kernel@vger.kernel.org
Subject: lock held by non-existent process
Message-ID: <20030828191735.GO11314@rainbow.timesink.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,

i've got a strange phenomenon and after some discussion on the
#kernelnewbies IRC channel, baldrick (duncan sands) suggested i reported
it here.

i got almost 1000 sendmail processes waiting for a read lock on
/etc/mail/aliases.db, but didn't find any process holding the write
lock. (the processes piled up in some 20 hours.)
the process reported in /proc/locks as holding the write lock doesn't
show up in ps(1) output or in /proc/*.
there was a sendmail process with this PID (normal delivery) an hour
before the pileup started, but at the time when it started the PIDs
hadn't reached the number range again.

i've got no idea what should have written the file (why else a write
lock?), my last change to it was a week ago...

anyway, i `fuser -k`'ed all processes and did a `cat /proc/locks` again.
this time it segfaulted! (it went fine before the `fuser -k`.)

the ksymoops(1) output is attached.

the kernel was built by me 9 days ago from the 2.4.21-4 debian kernel
source package.

it was the first time i experienced such a behaviour.

rj

--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="o3.out"

ksymoops 2.4.8 on i686 2.4.21.  Options used
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

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000008
c014b00a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c014b00a>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: 00000000   ecx: 00000061   edx: 00000c00
esi: cc5761e2   edi: c13bdd54   ebp: 00000006   esp: cadffee8
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 7767, stackpage=cadff000)
Stack: cc5761b5 c021b2a0 c911ec40 c911eb8c c13bdd58 00000000 c911ec40 c13bdd54 
       c13bdd58 cc576000 c014b35e cc5761e2 c13bdd54 00000006 c0211290 00000c00 
       cc5761e2 000001e2 00000c00 00000c00 cc576000 00001000 c015925b cc576000 
Call Trace:    [<c014b35e>] [<c015925b>] [<c0156693>] [<c0138f53>] [<c010730f>]
Code: 8b 58 08 8b 44 24 38 89 34 24 c7 44 24 04 6f 95 21 c0 89 44 


>>EIP; c014b00a <lock_get_status+1a/270>   <=====

>>esi; cc5761e2 <_end+c2b041e/105472bc>
>>edi; c13bdd54 <_end+10f7f90/105472bc>
>>esp; cadffee8 <_end+ab3a124/105472bc>

Trace; c014b35e <get_locks_status+5e/120>
Trace; c015925b <locks_read_proc+2b/50>
Trace; c0156693 <proc_file_read+c3/1c0>
Trace; c0138f53 <sys_read+a3/130>
Trace; c010730f <system_call+33/38>

Code;  c014b00a <lock_get_status+1a/270>
00000000 <_EIP>:
Code;  c014b00a <lock_get_status+1a/270>   <=====
   0:   8b 58 08                  mov    0x8(%eax),%ebx   <=====
Code;  c014b00d <lock_get_status+1d/270>
   3:   8b 44 24 38               mov    0x38(%esp,1),%eax
Code;  c014b011 <lock_get_status+21/270>
   7:   89 34 24                  mov    %esi,(%esp,1)
Code;  c014b014 <lock_get_status+24/270>
   a:   c7 44 24 04 6f 95 21      movl   $0xc021956f,0x4(%esp,1)
Code;  c014b01b <lock_get_status+2b/270>
  11:   c0 
Code;  c014b01c <lock_get_status+2c/270>
  12:   89 44 00 00               mov    %eax,0x0(%eax,%eax,1)


1 warning issued.  Results may not be reliable.

--kA1LkgxZ0NN7Mz3A--
