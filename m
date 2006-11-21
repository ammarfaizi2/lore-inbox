Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030708AbWKUDtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030708AbWKUDtU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 22:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030709AbWKUDtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 22:49:20 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:58103 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030708AbWKUDtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 22:49:19 -0500
Message-Id: <200611210349.kAL3mxt3015702@dell2.home>
To: Folkert van Heusden <folkert@vanheusden.com>
cc: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>,
       linux@rochester.rr.com
Subject: Re: [PATCH] emit logging when a process receives a fatal signal 
In-reply-to: <20061118020200.GC31268@vanheusden.com> 
References: <20061118010946.GB31268@vanheusden.com> <slrnelsomr.dd3.olecom@flower.upol.cz> <20061118020200.GC31268@vanheusden.com>
Comments: In-reply-to Folkert van Heusden <folkert@vanheusden.com>
   message dated "Sat, 18 Nov 2006 03:02:00 +0100."
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15699.1164080939.1@dell2.home>
Date: Mon, 20 Nov 2006 22:48:59 -0500
From: "Marty Leisner" <linux@rochester.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden <folkert@vanheusden.com> writes  on Sat, 18 Nov 2006 03:02:
00 +0100
     > Hi,
     > 
     > > > I found that sometimes processes disappear on some heavily used system
     > > > of mine without any logging. So I've written a patch against 2.6.18.2
     > > > which emits logging when a process emits a fatal signal.
     > > Why not to patch default signal handlers in glibc, to have not only
     > > stderr, but syslog, or /dev/kmsg copy of fatal messages?
     > 
     > Afaik when a proces gets shot because of a segfault, also the libraries
     > it used are shot so to say. iirc some of the more fatal signals are
     > handled directly by the kernel.
     > 
     > 
     > Folkert van Heusden

This is a user-space issue, not kernel (carrying this forward, we can
say the "kernel should complain when programs have bugs").

Newer glibc has catchsegv (haven't found any documentation, but its
interesting) --

: leisner@gateway 10:28:16;catchsegv sleep 1d
*** Segmentation fault
Register dump:

 EAX: fffffffc   EBX: bfc302e4   ECX: 00000000   EDX: b7f0c690
 ESI: bfc302e4   EDI: 00003800   EBP: bfc302f8   ESP: bfc302b8

 EIP: 00c5a402   EFLAGS: 00200246

 CS: 0073   DS: 007b   ES: 007b   FS: 0000   GS: 0033   SS: 007b

 Trap: 00000000   Error: 00000000   OldMask: 00000000
 ESP/signal: bfc302b8   CR2: 00000000

 FPUCW: ffff037f   FPUSW: ffff4000   TAG: ffffffff
 IPOFF: 080492e9   CSSEL: 0073   DATAOFF: bfc302bc   DATASEL: 007b

 ST(0) 0000 0000000000000000   ST(1) 0000 0000000000000000
 ST(2) 0000 0000000000000000   ST(3) 0000 a8c0000000000000
 ST(4) 0000 0000000000000000   ST(5) 0000 0000000000000000
 ST(6) 0000 0000000000000000   ST(7) 0000 0000000000000000

Backtrace:
/lib/libSegFault.so[0x2e21ff]
??:0(??)[0xc5a420]
sleep[0x8048ddf]
/lib/libc.so.6(__libc_start_main+0xdc)[0xc8b7e4]
sleep[0x8048af1]

Memory map:

002e0000-002e3000 r-xp 00000000 08:15 91703 /lib/libSegFault.so
002e3000-002e4000 r-xp 00002000 08:15 91703 /lib/libSegFault.so
002e4000-002e5000 rwxp 00003000 08:15 91703 /lib/libSegFault.so
0036f000-0037a000 r-xp 00000000 08:15 244694 /lib/libgcc_s-4.1.0-20060304.so.1
0037a000-0037b000 rwxp 0000a000 08:15 244694 /lib/libgcc_s-4.1.0-20060304.so.1
003e9000-00402000 r-xp 00000000 08:15 183695 /lib/ld-2.4.so
00402000-00403000 r-xp 00018000 08:15 183695 /lib/ld-2.4.so
00403000-00404000 rwxp 00019000 08:15 183695 /lib/ld-2.4.so
00c5a000-00c5b000 r-xp 00c5a000 00:00 0 [vdso]
00c76000-00da2000 r-xp 00000000 08:15 244689 /lib/libc-2.4.so
00da2000-00da5000 r-xp 0012b000 08:15 244689 /lib/libc-2.4.so
00da5000-00da6000 rwxp 0012e000 08:15 244689 /lib/libc-2.4.so
00da6000-00da9000 rwxp 00da6000 00:00 0
08048000-0804b000 r-xp 00000000 08:18 1354883 /usr/local/gnu/coreutils-6.5/bin/sleep
0804b000-0804c000 rw-p 00003000 08:18 1354883 /usr/local/gnu/coreutils-6.5/bin/sleep
09c1b000-09c40000 rw-p 09c1b000 00:00 0 [heap]
b7f0c000-b7f0d000 rw-p b7f0c000 00:00 0
b7f31000-b7f32000 rw-p b7f31000 00:00 0
bfc1d000-bfc32000 rw-p bfc1d000 00:00 0 [stack]

Processes don't  "disappear" -- the parent can track this...

Also, do you have core dumps turned on?

marty
