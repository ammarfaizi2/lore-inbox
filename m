Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUBRS6x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 13:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267455AbUBRS6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 13:58:53 -0500
Received: from user-12l28nl.cable.mindspring.com ([69.81.34.245]:12697 "EHLO
	mail.pelennor.net") by vger.kernel.org with ESMTP id S267452AbUBRS6t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 13:58:49 -0500
Date: Wed, 18 Feb 2004 12:58:40 -0600
From: Matthew Rench <lists@pelennor.net>
To: linux-kernel@vger.kernel.org
Cc: Keith Owens <kaos@ocs.com.au>
Subject: Re: problem rmmod'ing module
Message-ID: <20040218125840.A25346@pelennor.net>
References: <20040217153858.A11859@pelennor.net> <7711.1077077181@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <7711.1077077181@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Wed, Feb 18, 2004 at 03:06:21PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 03:06:21PM +1100, Keith Owens wrote:
> On Tue, 17 Feb 2004 15:38:58 -0600, 
> Matthew Rench <lists@pelennor.net> wrote:
> >When I strace rmmod, the last few lines are:
> >
> >  query_module(NULL, QM_MODULES, { /* 5 entries */ }, 5) = 0
> >  query_module("serial", QM_INFO, {address=0xd8816000, size=43620, flags=MOD_RUNNING, usecount=14}, 16) = 0
> >  query_module( <unfinished ...>
> >  +++ killed by SIGSEGV +++
> 
> Information about the second module in the chain (after "serial") is
> corrupt.  What does lsmod report?

lsmod reports:

Module                  Size  Used by
serial                 43620  16 (unused)
loop                    8600   6 (autoclean)
ide-scsi                8984   0
parport_pc             15604   0 (autoclean)
parport                13760   0 (autoclean) [parport_pc]

> You should have several oops reports in your syslog.  Run the first two
> through ksymoops and send in the ksymoops output.

The first several oops have identical reports from ksymoops, so I'm just
including the first one below. One unusual thing I noticed from running
ksymoops is that serial.o doesn't appear to have any symbols. Very odd. I
take it this isn't normal?

By the way, I don't suppose there's any way to clean this up without
rebooting, is there?

Thanks for the help,
mdr


mdr@aragorn: ksymoops -k 20040217120634.ksyms -l 20040217120634.modules oops.1
ksymoops 2.4.9 on i686 2.4.21.  Options used
     -V (default)
     -k 20040217120634.ksyms (specified)
     -l 20040217120634.modules (specified)
     -o /lib/modules/2.4.21/ (default)
     -m /usr/src/linux/System.map (default)

/usr/bin/nm: /lib/modules/2.4.21/kernel/drivers/char/serial.o: no symbols
Warning (read_object): no symbols in /lib/modules/2.4.21/kernel/drivers/char/serial.o
Warning (compare_maps): serial symbol <NULL> not found in /lib/modules/2.4.21/kernel/drivers/char/serial.o.  Ignoring /lib/modules/2.4.21/kernel/drivers/char/serial.o entry
Feb 17 13:56:35 aragorn kernel:  <1>Unable to handle kernel NULL pointer derefer
ence at virtual address 00000000
Feb 17 13:56:35 aragorn kernel: c0118b7e
Feb 17 13:56:35 aragorn kernel: *pde = 00000000
Feb 17 13:56:35 aragorn kernel: Oops: 0000
Feb 17 13:56:35 aragorn kernel: CPU:    0
Feb 17 13:56:35 aragorn kernel: EIP:    0010:[qm_symbols+194/500]    Not tainted
Feb 17 13:56:35 aragorn kernel: EFLAGS: 00010246
Feb 17 13:56:35 aragorn kernel: eax: 00000000   ebx: 00000000   ecx: ffffffff   
edx: 00000000
Feb 17 13:56:35 aragorn kernel: esi: 00000048   edi: 00000000   ebp: d881bc24   
esp: cb3dbf7c
Feb 17 13:56:35 aragorn kernel: ds: 0018   es: 0018   ss: 0018
Feb 17 13:56:35 aragorn kernel: Process depmod (pid: 10011, stackpage=cb3db000)
Feb 17 13:56:35 aragorn kernel: Stack: fffffffe d8816000 c46e1000 bfff4988 00000
009 08071780 080717c8 00000000 
Feb 17 13:56:35 aragorn kernel:        c0118ed7 d8816000 08071780 000003b8 bfff4
988 cb3da000 00000400 bfff4988 
Feb 17 13:56:35 aragorn kernel:        bfff492c c0106f9b 080711f8 00000004 08071
780 00000400 bfff4988 bfff492c 
Feb 17 13:56:35 aragorn kernel: Call Trace:    [sys_query_module+327/420] [trace
sys+31/35]
Feb 17 13:56:35 aragorn kernel: Code: f2 ae f7 d1 49 8d 59 01 3b 5c 24 2c 0f 87 
98 00 00 00 53 52 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebp; d881bc24 <[serial].rodata.end+253/2af>
>>esp; cb3dbf7c <_end+b0cb0f8/185051dc>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f2 ae                     repnz scas %es:(%edi),%al
Code;  00000002 Before first symbol
   2:   f7 d1                     not    %ecx
Code;  00000004 Before first symbol
   4:   49                        dec    %ecx
Code;  00000005 Before first symbol
   5:   8d 59 01                  lea    0x1(%ecx),%ebx
Code;  00000008 Before first symbol
   8:   3b 5c 24 2c               cmp    0x2c(%esp,1),%ebx
Code;  0000000c Before first symbol
   c:   0f 87 98 00 00 00         ja     aa <_EIP+0xaa> 000000aa Before first sy
mbol
Code;  00000012 Before first symbol
  12:   53                        push   %ebx
Code;  00000013 Before first symbol
  13:   52                        push   %edx


