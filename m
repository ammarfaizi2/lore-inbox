Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264243AbTDWUJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTDWUJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:09:09 -0400
Received: from [81.80.245.157] ([81.80.245.157]:30949 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id S264243AbTDWUJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:09:00 -0400
Date: Wed, 23 Apr 2003 22:20:02 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Ben Collins <bcollins@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423202002.GA10567@vitel.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Ben Collins <bcollins@debian.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030423132227.GI820@hottah.alcove-fr> <20030423133256.GG354@phunnypharm.org> <20030423135814.GJ820@hottah.alcove-fr> <20030423135448.GI354@phunnypharm.org> <20030423142131.GK820@hottah.alcove-fr> <20030423142353.GL354@phunnypharm.org> <20030423145122.GL820@hottah.alcove-fr> <20030423144857.GN354@phunnypharm.org> <20030423152914.GM820@hottah.alcove-fr> <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 04:13:42PM -0300, Marcelo Tosatti wrote:

> > I confirm that your patch at least solves the initialisation issues.
> > I'll test later with some ieee devices and I'll report back if I found
> > other issues.
> 
> Any news on that, Stelian ?


Well, mixed success. I've done just some simple tests with an Apple
iPod (seen as a firewire drive). When plugged in, it is automatically
recognized and hotplug loads sbp2, which sees the drive and the two
partitions.

Mounted it, did a dd if=/dev/zero of=/mnt/ipod bs=1M count=1024.

It stalled without transferring anything. Strange.

Interrupted the dd, relaunched, all worked correctly this time. I've
tried several times but unable to reproduce the stall. Copied several
files from/to the iPod without problems.

Umounted, rmmod sbp2, unplugged the iPod. Replugged the ipod, try
to remount.

Three different behaviours follow, all reproductible (!):
* correct behaviour, the mount succeeds
* mount hangs. wchan is 'end' (?)
* mount oopses, see the report below.

Is this better or not than the -pre7 version ? Honestly I don't know,
there were problems with the old one too (however the old version
reacted to plug/unplug mount/umount events by freezing hard the
laptop, while the new one just oopses, so this is an improvement
from some point of view...)

Stelian.

ksymoops 2.4.5 on i686 2.4.21-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-rc1/ (default)
     -m /boot/System.map-2.4.21-rc1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

CPU: 20000805 23:30 official release 4.1.4#2
WARNING: USB Mass Storage data integrity not assured
ds: no socket drivers loaded!
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x377 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
Unable to handle kernel NULL pointer dereference at virtual address 00000004
c78b99f4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c78b99f4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010212
eax: 00000000   ebx: c115ba60   ecx: c78b9940   edx: c6d9dc00
esi: 00000001   edi: c4f7e3c0   ebp: 00000010   esp: c4f0befc
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 931, stackpage=c4f0b000)
Stack: c115ba60 c02f0e50 c014f47f fffffffa c502a2c0 c6f7e2a0 c6f7e2bc 00000812 
       c0140d83 c4f7e3c0 c502a2c0 00000000 c502a2c0 c4f7e3c0 ffffffe9 c113e2e0 
       c0140e78 c6f7e2a0 c4f7e3c0 c502a2c0 c502a2c0 c4f7e3c0 c0139463 c4f7e3c0 
Call Trace:    [<c014f47f>] [<c0140d83>] [<c0140e78>] [<c0139463>] [<c0139388>]
  [<c0139723>] [<c01090ff>]
Code: 8b 40 04 85 c0 74 10 ff 40 10 8b 43 10 8b 40 24 8b 40 04 83 


>>EIP; c78b99f4 <[sd_mod]sd_open+b4/230>   <=====

>>ebx; c115ba60 <_end+e48b88/74f7188>
>>ecx; c78b9940 <[sd_mod]sd_open+0/230>
>>edx; c6d9dc00 <_end+6a8ad28/74f7188>
>>edi; c4f7e3c0 <_end+4c6b4e8/74f7188>
>>esp; c4f0befc <_end+4bf9024/74f7188>

Trace; c014f47f <new_inode+f/50>
Trace; c0140d83 <do_open+123/150>
Trace; c0140e78 <blkdev_open+38/50>
Trace; c0139463 <dentry_open+d3/1d0>
Trace; c0139388 <filp_open+68/70>
Trace; c0139723 <sys_open+53/a0>
Trace; c01090ff <system_call+33/38>

Code;  c78b99f4 <[sd_mod]sd_open+b4/230>
00000000 <_EIP>:
Code;  c78b99f4 <[sd_mod]sd_open+b4/230>   <=====
   0:   8b 40 04                  mov    0x4(%eax),%eax   <=====
Code;  c78b99f7 <[sd_mod]sd_open+b7/230>
   3:   85 c0                     test   %eax,%eax
Code;  c78b99f9 <[sd_mod]sd_open+b9/230>
   5:   74 10                     je     17 <_EIP+0x17>
Code;  c78b99fb <[sd_mod]sd_open+bb/230>
   7:   ff 40 10                  incl   0x10(%eax)
Code;  c78b99fe <[sd_mod]sd_open+be/230>
   a:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  c78b9a01 <[sd_mod]sd_open+c1/230>
   d:   8b 40 24                  mov    0x24(%eax),%eax
Code;  c78b9a04 <[sd_mod]sd_open+c4/230>
  10:   8b 40 04                  mov    0x4(%eax),%eax
Code;  c78b9a07 <[sd_mod]sd_open+c7/230>
  13:   83 00 00                  addl   $0x0,(%eax)


1 warning issued.  Results may not be reliable.

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
