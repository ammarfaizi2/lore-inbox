Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281005AbRKOTXt>; Thu, 15 Nov 2001 14:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281006AbRKOTXc>; Thu, 15 Nov 2001 14:23:32 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:1548 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281005AbRKOTXY>; Thu, 15 Nov 2001 14:23:24 -0500
Message-ID: <3BF41608.DF8C7068@zip.com.au>
Date: Thu, 15 Nov 2001 11:22:48 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>, lkml <linux-kernel@vger.kernel.org>
Subject: death by ATA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andre.

A shared mapping stress test tool was developed for ext3 testing.
It's called `bash-shared-mapping', and you run it with a script
called `run-bash-shared-mapping.sh'.  These tools are in

	http://www.zip.com.au/~akpm/ext3-tools.tar.gz

This program is the meanest stress tester I have ever seen.  It
has the scalps of three or four core kernel bugs on its belt and
several ext3 ones too.

Its IPI rate kills my otherwise-fine-runs-cerberus-overnight BP6
in thirty seconds.

Its IDE load kills my otherwise-fine-runs-cerberus-overnight
P6DBE in a few hours.

We have another failure here on a uniprocessor VIA C3, running
2.4.15-pre4. The controller is a VT8231.  Running at UDMA100.

The oops indicates a bug in the IDE driver's error recovery. Note
the "ide0: reset: success" followed by a null pointer deref in the
IDE interrupt handler.  You'll see that local variable `rq' has
value zero.

What does "end-request: buffer-list destroyed" mean?

What does "ide_dmaproc: chipset supported ide_dma_timeout func only: 14"
mean?

Do you think this is caused by a hardware failure?  If so, do you
expect that the reset recovery (once the oops is fixed) will bring
the disk back online?

Thanks.


end_request: buffer-list destroyed
hda8: bad access: block=5296, count=-2                            
end_request: I/O error, dev 03:08 (hda), sector 5296
hda8: bad access: block=5298, count=-4
end_request: I/O error, dev 03:08 (hda), sector 5298
hda8: bad access: block=5300, count=-6              
end_request: I/O error, dev 03:08 (hda), sector 5300
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command                                      
hda: status timeout: status=0xd0 { Busy }
hda: no DRQ after issuing WRITE          
ide0: reset: success           
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:                                                              
c01dee53      
*pde = 00000000
Oops: 0000     
CPU:    0 
EIP:    0010:[<c01dee53>]    Not tainted
EFLAGS: 00010002                        
eax: c039a350   ebx: 00000000   ecx: c11e5160   edx: c03701f7
esi: 00000008   edi: c039a380   ebp: c039a340   esp: c02f7f30
ds: 0018   es: 0018   ss: 0018                               
Process swapper (pid: 0, stackpage=c02f7000)
Stack: c01d5df0 c039a380 c039a380 c11e5160 c039a380 c11e5160 00000202 c01d62b0 
       c039a380 c01dedf0 c118f640 04000001 0000000e c02f7fac c010833a 0000000e 
       c11e5160 c02f7fac c02f7fac 0000000e c036dac0 c118f640 c01084c8 0000000e 
Call Trace: [<c01d5df0>] [<c01d62b0>] [<c01dedf0>] [<c010833a>] [<c01084c8>]   
   [<c01051a0>] [<c010a738>] [<c01051a0>] [<c01051c4>] [<c0105242>] [<c0105000>] 
                                                                                 
Code: 8b 43 20 74 08 48 75 0c e9 b0 00 00 00 48 0f 85 a9 00 00 00 
Kernel panic: Aiee, killing interrupt handler!                
In interrupt handler - not syncing         

c01dee53      
*pde = 00000000
Oops: 0000     
CPU:    0 
EIP:    0010:[<c01dee53>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002                        
eax: c039a350   ebx: 00000000   ecx: c11e5160   edx: c03701f7
esi: 00000008   edi: c039a380   ebp: c039a340   esp: c02f7f30
ds: 0018   es: 0018   ss: 0018                               
Process swapper (pid: 0, stackpage=c02f7000)
Stack: c01d5df0 c039a380 c039a380 c11e5160 c039a380 c11e5160 00000202 c01d62b0 
       c039a380 c01dedf0 c118f640 04000001 0000000e c02f7fac c010833a 0000000e 
       c11e5160 c02f7fac c02f7fac 0000000e c036dac0 c118f640 c01084c8 0000000e 
Call Trace: [<c01d5df0>] [<c01d62b0>] [<c01dedf0>] [<c010833a>] [<c01084c8>]   
   [<c01051a0>] [<c010a738>] [<c01051a0>] [<c01051c4>] [<c0105242>] [<c0105000>] 
Code: 8b 43 20 74 08 48 75 0c e9 b0 00 00 00 48 0f 85 a9 00 00 00 

>>EIP; c01dee53 <write_intr+63/150>   <=====
Trace; c01d5df0 <ide_do_request+2b0/300>
Trace; c01d62b0 <ide_intr+100/160>
Trace; c01dedf0 <write_intr+0/150>
Trace; c010833a <handle_IRQ_event+3a/70>
Trace; c01084c8 <do_IRQ+78/c0>
Trace; c01051a0 <default_idle+0/40>
Trace; c010a738 <call_do_IRQ+5/d>
Trace; c01051a0 <default_idle+0/40>
Trace; c01051c4 <default_idle+24/40>
Trace; c0105242 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>
Code;  c01dee53 <write_intr+63/150>
0000000000000000 <_EIP>:
Code;  c01dee53 <write_intr+63/150>   <=====
   0:   8b 43 20                  mov    0x20(%ebx),%eax   <=====
Code;  c01dee56 <write_intr+66/150>
   3:   74 08                     je     d <_EIP+0xd> c01dee60 <write_intr+70/150>
Code;  c01dee58 <write_intr+68/150>
   5:   48                        dec    %eax
Code;  c01dee59 <write_intr+69/150>
   6:   75 0c                     jne    14 <_EIP+0x14> c01dee67 <write_intr+77/150>
Code;  c01dee5b <write_intr+6b/150>
   8:   e9 b0 00 00 00            jmp    bd <_EIP+0xbd> c01def10 <write_intr+120/150>
Code;  c01dee60 <write_intr+70/150>
   d:   48                        dec    %eax
Code;  c01dee61 <write_intr+71/150>
   e:   0f 85 a9 00 00 00         jne    bd <_EIP+0xbd> c01def10 <write_intr+120/150>

 <0>Kernel panic: Aiee, killing interrupt handler!
