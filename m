Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272369AbRIPQAA>; Sun, 16 Sep 2001 12:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272362AbRIPP7v>; Sun, 16 Sep 2001 11:59:51 -0400
Received: from gear.torque.net ([204.138.244.1]:11785 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S272345AbRIPP7e>;
	Sun, 16 Sep 2001 11:59:34 -0400
Message-ID: <3BA4CB70.50B4A3AB@torque.net>
Date: Sun, 16 Sep 2001 11:55:28 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml@krimedawg.org
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Jens Axboe <axboe@suse.de>
Subject: Re: OOPS in scsi generic stuff 2.4.10-pre6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkml@krimedawg.org <<nameless>> wrote:
> The ksymoops output.  Let me know if there is anything else I can offer
> to help?  This happened when ripping a cd with cdparanoia on an IDE drive
> with the ide-scsi stuff.

....

> >>EIP; c01b7688 <generic_unplug_device+8/30>   <=====
> Trace; c01f8fe6 <sg_common_write+1d6/1f0>
> Trace; c01f9bc0 <sg_cmd_done_bh+0/280>    #### bizarre
> Trace; c01f8c16 <sg_write+256/280>

generic_unplug_device() was an addition into the sg driver
by Jens Axboe. Under heavy stress testing I have also received
an oops from this function.

It is there because the tentacles of the Linux block subsystem 
have found their way into the the SCSI midlevel. The st and sg 
drivers are proof of why this is bad design as they are char 
devices.

If the generic_unplug_device() call is removed then the
sg driver will periodically have its commands suspended
on the SCSI mid level queue until the block subsystem
decides to send something to the device in question.
This can be seconds (which isn't a pleasant thing to do
to a cdwriter).

Doug Gilbert


Oops output:
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Unable to handle kernel paging request at virtual address 0a080294
c01b7688
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01b7688>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210002
eax: 0a08021c   ebx: 00200202   ecx: 00000010   edx: 0a08021c
esi: e6634064   edi: e6634040   ebp: c1bc8940   esp: d55bfefc
ds: 0018   es: 0018   ss: 0018
Process cdparanoia (pid: 3380, stackpage=d55bf000)
Stack: ea8bfc80 c01f8fe7 0a08021c ea8bfc80 d55bff6c dd2f0000 00007770 c01f9bc0
       00001770 00000001 d55bff6c e6634000 e6634040 08058b64 c01f8c17 e6634000
       e6634040 d55bff6c 00001770 00000001 e3cae540 ffffffea 00000000 000077a0
Call Trace: [<c01f8fe7>] [<c01f9bc0>] [<c01f8c17>] [<c012ebe6>] [<c0106c2b>]
Code: 80 7a 78 00 74 15 c6 42 78 00 8d 42 28 39 42 28 74 09 52 8b

>>EIP; c01b7688 <generic_unplug_device+8/30>   <=====
Trace; c01f8fe6 <sg_common_write+1d6/1f0>
Trace; c01f9bc0 <sg_cmd_done_bh+0/280>
Trace; c01f8c16 <sg_write+256/280>
Trace; c012ebe6 <sys_write+96/d0>
Trace; c0106c2a <system_call+32/38>
Code;  c01b7688 <generic_unplug_device+8/30>
00000000 <_EIP>:
Code;  c01b7688 <generic_unplug_device+8/30>   <=====
   0:   80 7a 78 00               cmpb   $0x0,0x78(%edx)   <=====
Code;  c01b768c <generic_unplug_device+c/30>
   4:   74 15                     je     1b <_EIP+0x1b> c01b76a2
<generic_unplug_device+22/30>
Code;  c01b768e <generic_unplug_device+e/30>
   6:   c6 42 78 00               movb   $0x0,0x78(%edx)
Code;  c01b7692 <generic_unplug_device+12/30>
   a:   8d 42 28                  lea    0x28(%edx),%eax
Code;  c01b7694 <generic_unplug_device+14/30>
   d:   39 42 28                  cmp    %eax,0x28(%edx)
Code;  c01b7698 <generic_unplug_device+18/30>
  10:   74 09                     je     1b <_EIP+0x1b> c01b76a2
<generic_unplug_device+22/30>
Code;  c01b769a <generic_unplug_device+1a/30>
  12:   52                        push   %edx
Code;  c01b769a <generic_unplug_device+1a/30>
  13:   8b 00                     mov    (%eax),%eax
