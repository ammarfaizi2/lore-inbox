Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314128AbSDVLuB>; Mon, 22 Apr 2002 07:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314129AbSDVLuB>; Mon, 22 Apr 2002 07:50:01 -0400
Received: from swan.nt.tuwien.ac.at ([128.131.67.158]:14231 "EHLO
	swan.nt.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S314128AbSDVLuA>; Mon, 22 Apr 2002 07:50:00 -0400
To: linux-kernel@vger.kernel.org
Subject: nbd + raid1 + 2.4.19-pre7
From: Thomas Zeitlhofer <tzeitlho+lkml@nt.tuwien.ac.at>
Date: 22 Apr 2002 13:49:56 +0200
Message-ID: <yzuwuv0j6l7.fsf@swan.nt.tuwien.ac.at>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The setup here:

   /dev/md106: raid1 over /dev/md6 (raid1 over two ide disks) and
                          /dev/nd6 
   using nbd-server and nbd-client from nbd-2.0 (sf.net/projects/nbd/)

When disconnecting the network link between nbd-server and nbd-client
all processes attempting IO to /dev/nd6 are hanging in D state for
exactly 15 minutes. During this time the load of the machine increases
by about 2 for each IO attempt. Using the raid1 setup from above, all
IO attempts to _other_ raid1 devices (e.g. /dev/md0 which is raid1 over
two ide disks) are hanging in D state, too. After the 15 minutes 
period the load drops down and everything is working fine again -
also /dev/nd6 has been marked faulty as expected.
(same behavior in 2.4.18-ac3)

Any suggestions how to avoid this long time period before the machine
becomes usable again?

Additionally, detaching the nbd-client (nbd-client -d) during a
raid1-resync from  nd6 -> md6 resulted in the following oops:
-------------------------------------------------
ksymoops 2.4.5 on i686 2.4.19-pre7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre7/ (default)
     -m /boot/System.map-2.4.19-pre7 (specified)

Apr 20 19:58:37 test1 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000018
Apr 20 19:58:37 test1 kernel: f8970164
Apr 20 19:58:37 test1 kernel: *pde = 00000000
Apr 20 19:58:37 test1 kernel: Oops: 0000
Apr 20 19:58:37 test1 kernel: CPU:    0
Apr 20 19:58:37 test1 kernel: EIP:    0010:[<f8970164>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 20 19:58:37 test1 kernel: EFLAGS: 00010206
Apr 20 19:58:37 test1 kernel: eax: 00004100   ebx: f74cdeb4   ecx: ffffffff   edx: 00000000
Apr 20 19:58:37 test1 kernel: esi: f74cdeac   edi: 00001000   ebp: f770d000   esp: f74cde84
Apr 20 19:58:37 test1 kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 19:58:37 test1 kernel: Process nbd-client (pid: 5695, stackpage=f74cd000)
Apr 20 19:58:37 test1 kernel: Stack: f74173d8 00000a18 f74e8ac0 f8971f90 00000286 00004100 f74cdeac 00000000 
Apr 20 19:58:37 test1 kernel:        00000000 c0000000 f652c000 00000000 00000000 00000000 f74cdeac 00000001 
Apr 20 19:58:37 test1 kernel:        00000000 00000000 00004100 f89704a9 00000000 00000000 f770d000 00001000 
Apr 20 19:58:37 test1 kernel: Call Trace: [<f8971f90>] [<f89704a9>] [<f8971f90>] [<f89704fb>] [<f8971f90>] 
Apr 20 19:58:37 test1 kernel:    [<f89709ef>] [<f8971f90>] [<f8971f90>] [blkdev_ioctl+40/64] [sys_ioctl+359/384] [system_call+51/56]
Apr 20 19:58:37 test1 kernel: Code: 8b 42 18 c7 80 88 00 00 00 30 00 00 00 8b 4c 24 18 89 6c 24 


>>EIP; f8970164 <[nbd]nbd_xmit+74/190>   <=====

>>eax; 00004100 Before first symbol
>>ebx; f74cdeb4 <_end+3720a2f8/3853c444>
>>ecx; ffffffff <END_OF_CODE+7688ed8/????>
>>esi; f74cdeac <_end+3720a2f0/3853c444>
>>edi; 00001000 Before first symbol
>>ebp; f770d000 <_end+37449444/3853c444>
>>esp; f74cde84 <_end+3720a2c8/3853c444>


Trace; f8971f90 <[nbd]nbd_dev+150/1c00>
Trace; f89704a9 <[nbd]nbd_read_stat+b9/100>
Trace; f8971f90 <[nbd]nbd_dev+150/1c00>
Trace; f89704fb <[nbd]nbd_do_it+b/80>
Trace; f8971f90 <[nbd]nbd_dev+150/1c00>
Trace; f89709ef <[nbd]nbd_ioctl+31f/3f0>
Trace; f8971f90 <[nbd]nbd_dev+150/1c00>
Trace; f8971f90 <[nbd]nbd_dev+150/1c00>

Code;  f8970164 <[nbd]nbd_xmit+74/190>
00000000 <_EIP>:
Code;  f8970164 <[nbd]nbd_xmit+74/190>   <=====
   0:   8b 42 18                  mov    0x18(%edx),%eax   <=====
Code;  f8970167 <[nbd]nbd_xmit+77/190>
   3:   c7 80 88 00 00 00 30      movl   $0x30,0x88(%eax)
Code;  f897016e <[nbd]nbd_xmit+7e/190>
   a:   00 00 00 
Code;  f8970171 <[nbd]nbd_xmit+81/190>
   d:   8b 4c 24 18               mov    0x18(%esp,1),%ecx
Code;  f8970175 <[nbd]nbd_xmit+85/190>
  11:   89 6c 24 00               mov    %ebp,0x0(%esp,1)
-------------------------------------------------


        Thomas
