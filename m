Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbTLORKP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTLORKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:10:15 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:37650 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S263795AbTLORKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:10:06 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI Express support for 2.4 kernel 
In-reply-to: Your message of "Mon, 15 Dec 2003 17:52:38 +0200."
             <3FDDD8C6.3080804@intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Dec 2003 04:09:55 +1100
Message-ID: <4921.1071508195@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003 17:52:38 +0200, 
Vladimir Kondratiev <vladimir.kondratiev@intel.com> wrote:
>OK, I almost convinced it may be removed.
>My point is, this initialization with 0 cost nothing. Readability and 
>clearness of code do matter, on my opinion. I think when one states 
>explicitly he expect variable to have 0 value, it is better then use 
>implicit rules.
>
>To illustrate zero cost, I did the following test:
>[tmp]$ cat t.c; gcc -S t.c; cat t.s
>static int a1=0;
>static int a2;
>/* EOF */
>
>    .file    "t.c"
>    .local    a1
>    .comm    a1,4,4
>    .local    a2
>    .comm    a2,4,4
>    .section    .note.GNU-stack,"",@progbits
>    .ident    "GCC: (GNU) 3.3.1 20030811 (Red Hat Linux 3.3.1-1)"
>
>As you can see, assembly code is identical, compiler did this trivial 
>optimization for me.

Try it with an older version of gcc, which most people are still using
to build the kernel.  With 3.2.2, you get

# gcc -S t.c

         .file   "t.c"
        .data
        .align 4
        .type   a1,@object
        .size   a1,4
a1:
        .long   0
        .local  a2
        .comm   a2,4,4
        .ident  "GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"

# gcc t.c -c -o t.o
# objdump -h t.o

t.o:     file format elf32-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00000000  00000000  00000000  00000034  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .data         00000004  00000000  00000000  00000034  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00000004  00000000  00000000  00000038  2**2
                  ALLOC
  3 .comment      00000033  00000000  00000000  00000038  2**0
                  CONTENTS, READONLY

a1 is in the data section, taking up space on disk.  a2 is in bss which
is allocated and zeroed at run time, no disk space is required.

