Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVCODHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVCODHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVCODHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:07:53 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:18671 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S262212AbVCODH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:07:27 -0500
Date: Mon, 14 Mar 2005 22:07:25 -0500
From: Mark Studebaker <mds@mds.gotdns.com>
Subject: Re: ancient portmap segfault
In-reply-to: <m1d5u3yi1l.fsf@muc.de>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <4236516D.5030001@mds.gotdns.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4233B520.7010307@mds.gotdns.com> <m1d5u3yi1l.fsf@muc.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030420
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,
thanks for the response.

The code forks immediately and the new process segfaults immediately. 
>From an inspection of 'strace -f' on a working version, the next call
would have been setsid() . (The library call in the code is daemon(0,0)).
The original Makefile has an LDFLAG of -N (OMAGIC: make text secion writable, 
don't page-align the data section.... No idea why).

If I compile with ancient gcc/ld,
it works after compiling without -N and segfaults when compiling with -N.
If I compile with a recent gcc/ld, it works fine.

here's an objump of the segfaulting portmap
------------------------------------------------
>  objdump -x /usr/sbin/portmap

/usr/sbin/portmap:     file format a.out-i386-linux
/usr/sbin/portmap
architecture: i386, flags 0x00000002:
EXEC_P
start address 0x00000000

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00000f7c  00000000  00000000  00000020  2**2
                  CONTENTS, ALLOC, LOAD, CODE
  1 .data         00000110  00000f7c  00000f7c  00000f9c  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00000018  0000108c  0000108c  00000000  2**2
                  ALLOC
SYMBOL TABLE:
no symbols

-------------------
and here's the objdump of the test without -N

>  objdump -h a.out

a.out:     file format a.out-i386-linux

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00001fe0  00001020  00001020  00000020  2**3
                  CONTENTS, ALLOC, LOAD, CODE
  1 .data         00001000  00003000  00003000  00002000  2**3
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00000000  00004000  00004000  00000000  2**3
                  ALLOC



--------------------------------------------------
so maybe the alignment difference is the problem?

as I said before, I have things working, only reporting this on the possibility
that it's a bug worth  investigating.

thanks
mds


Andi Kleen wrote:
> Mark Studebaker <mds@mds.gotdns.com> writes:
> 
> 
>>I upgraded from 2.6.5 to 2.6.11.2 and my ancient (libc4 a.out) /sbin/portmap from 1994 that's been running without complaint
>>on kernels for 11 years now consistently segfaults.
>>
>>I upgraded to a version 4 RPM (circa 2002) and that fixed it.
>>
>>If some compatibility was broken on purpose, that's fine, although I couldn't find anything in the kernel docs.
>>I know, I should upgrade everything, but that can break a lot of things too...
>>Thought I'd mention it though in case it's a bug or somebody else has the same problem.
> 
> 
> It's probably a bug, but your bug report doesn't have enough details
> to track it down. Do you have a a.out strace and could send an strace log
> with the segfault and the last tens of system calls before it?
> 
> -Andi


