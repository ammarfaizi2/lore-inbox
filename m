Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUHHRpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUHHRpn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 13:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUHHRpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 13:45:43 -0400
Received: from smtp.rol.ru ([194.67.21.9]:28856 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S266034AbUHHRpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 13:45:38 -0400
From: Ilyak Kasnacheev <ilyak@office.uw.ru>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Kernel panic (reiserfs), some hangs - bad hardware?.
Date: Tue, 27 Jul 2004 10:42:30 +0400
User-Agent: KMail/1.6.2
References: <4104E587.1050606@office.uw.ru> <200407261733.53449.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200407261733.53449.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200407271042.30993.ilyak@office.uw.ru>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 1) (looks like )Applications such as oggenc or flac, who mmap() output
> > files and write into mapped memory area, produce corrupted files on my
> > system. ~1 error on 10-100M, resulting file just some bytes different
> > from what program wrote. Second attempts always removes error (while may
> > cause new one with same proportion) More errors on intensive IO/bad
> > interface cable, less errors on no other IO/good cable. Tried 2.6.7
> > vanilla kernel. Am i crazy?
> Partly :)
> Stop using unreliable equipment.
I do not understand, what do not work - drive, cables, or motherboard.
But is this a reason for handing - anyway?

> > 2) With bad interface cable, my system used to just hang. With
> > better?/40pin cable, it do this very rare. Memtest86 and burncpu do not
> > produce errors, and windows works fine on same box. Both 2.4.x and 2.6.7
> > kernels.
> Neither memtest nor burncpu test for flakey IDE cables.
SeaTools do not find any errors, so do windows.
Only linux cause errors on this box.

> > 3) Main. I have got a reiserfs partition with some errors (due to
> > 2)), and kernel panics on it when i do 'find /'. with these errors:
> Wow. this is something debuggable. Do this:
> objdump file_containing_scheduler_tick.o >file.objdump
Did objdump -d kernel/sched.o > kernel/sched.objdump

> make path/to/<file containing scheduler_tick>.s
Did this
So:
==
00000940 <scheduler_tick>:
...
     a28:       99                      cltd
     a29:       03 05 10 00 00 00       add    0x10,%eax
     a2f:       13 15 14 00 00 00       adc    0x14,%edx
     a35:       89 47 10                mov    %eax,0x10(%edi)
     a38:       89 57 14                mov    %edx,0x14(%edi)
     a3b:       a1 08 04 00 00          mov    0x408,%eax
     a40:       39 46 28                cmp    %eax,0x28(%esi)
     a43:       74 10                   je     a55 <scheduler_tick+0x115>
     a45:       8b 46 04                mov    0x4(%esi),%eax
     a48:       0f ba 68 08 03          btsl   $0x3,0x8(%eax)
     a4d:       83 c4 10                add    $0x10,%esp
     a50:       5b                      pop    %ebx
     a51:       5e                      pop    %esi
     a52:       5f                      pop    %edi
     a53:       c9                      leave
...
==
0x940+0x108 is 0xa48, right?
Which is:
==
        cltd
        addl    per_cpu__kstat+16, %eax
        adcl    per_cpu__kstat+20, %edx
        movl    %eax, 16(%edi)
        movl    %edx, 20(%edi)
        movl    per_cpu__runqueues+40, %eax
        cmpl    %eax, 40(%esi)
        je      .L395
        movl    4(%esi), %eax
#APP
        btsl $3,8(%eax)
.L391:
#NO_APP
.L367:
        addl    $16, %esp
        popl    %ebx
        popl    %esi
        popl    %edi
        leave
==
in .s-file.

> and find exact instruction corresponding to
> EIP=scheduler_tick+0x108/0x400. Then find relevant piece
> of C code.
I do not konw how to find relevant piece in C code, i don't know good both 
i386 assembler and debugging to do so.

But i am almost sure that problem is in reiserfs code, not here, 'cause it 
happened only with broken reiserfs partition when stat()ing files on it.

> > EFLAGS: 0010007 (2.6.7)
> > EIP is at scheduler_tick+0x108/0x400
> > eax: 00000000 ebx: 00000001 ecx: 0000023d edx: 00000000
> > esi: ca0a9750 edi: c0343520 ebp: ca0a7d4c esp: ca0a7d30
> > ds: 007b es: 007b ss: 0068
> > Process (pid: -1048345824, threadinfo = ca0a6000, task=ca0a9750)
> > Stack: c188a23c 00145ad7 00000000 3d108500 00000000 00000001 00000000
> >        ca0a7dd4 c0121606 00000000 00000001 00000001 00000000 ca0a6000
> >        ca0a7dd4 c0121834 00000000 ca0a6000 c010a2ce ca0a7dd4 c02d51c4
> >        20000001 00000000 c010632a
> > Trace:
> > c0121606	update_process_times+0x46/0x60
> > c0121834	do_timer+0x34/0xf0
> > c010a2ce	timer_interrupt+0x4e/0x120
> > c010632a	handle_IRQ_event+0x3a/0x70
> > c01066c1	do_IRQ+0x91/0x130
> > c0124a48	common_interrupt+0x18/0x20
> > c01ba80a	_mmx_memcpy+0x8a/0x170
> > d08c8630	reiserfs_readdir+0x4c0/0x560		[reiserfs]
> > c0127052	in_group_p+0x42/0x80
> > d08e5fa9	__reiserfs_permission+0x169/0x260	[reiserfs]
> > Code: 0f ba 68 08 03 83 c4 10 56 5e 5f c9 c3 b8 00 e0 ff ff 21 e0
> > Panic: Fatal exception in interrupt

> > fsck.xfs looks pretty like void main() {};, what should i do?
> Contact xfs people with this.
Ok, where can i find them?
