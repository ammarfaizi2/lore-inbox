Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316188AbSEKBeU>; Fri, 10 May 2002 21:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316189AbSEKBeT>; Fri, 10 May 2002 21:34:19 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:22022 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316188AbSEKBeS>;
	Fri, 10 May 2002 21:34:18 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG() disassembly tweak 
In-Reply-To: Your message of "Sat, 11 May 2002 02:04:02 +0100."
             <Pine.LNX.4.21.0205110122430.1215-100000@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 May 2002 11:34:07 +1000
Message-ID: <2764.1021080847@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2002 02:04:02 +0100 (BST), 
Hugh Dickins <hugh@veritas.com> wrote:
>I thought I was the only one dissatisfied (that a disassembler cannot
>make sense of this line number and filename pointer dumped into the
>instruction stream after the ud2: laugh at the ingenious instructions
>ksymoops shows after the ud2 these days).

IMNSHO the instructions _after_ the oops are almost useless.  I would
be much happier to see all architectures display the code line like
this (from alpha):

Code: 44220001  f4200003  46520400 <a77d9c38> 6b9b4a40  a44803a8  42425401  42c10403  40603401

Showing instructions either side of the oops and marking the
instruction pointer with <>.  Even that version displays too much data
after the oops, for debugging you need more instructions leading up to
the failure and fewer instructions afterwards.

The variable length i386 instructions are a problem, finding a decent
start point is tricky.  ksymoops handles up to 64 bytes of code so
dumping EIP-56:EIP+8 would increase the chance of the disassembler
syncing to the correct instructions.  To be absolutely sure, dump two
code lines on i386.

Code: EIP-56 ... <EIP> ... EIP+8
Code: EIP ... EIP+8

The second line starts with EIP and does not have <> around any values,
it guarantees that we get a clean decode of the failing instruction.
ksymoops will print both code lines, which makes the decoded trace look
a little strange, but it is worth it to get better debugging.  For
architectures with fixed length instructions this is not a problem.

Code: c6 05 00 00 00 00 00 <eb> e7 8d 76 00 b8 00 e0 ff ff 21 e0 ff 

>>EIP; c0113f8c No symbols available   <=====

...

Code;  c0113f85 No symbols available
00000000 <_EIP>:
Code;  c0113f85 No symbols available
   0:   c6 05 00 00 00 00 00      movb   $0x0,0x0
Code;  c0113f8c No symbols available   <=====
   7:   eb e7                     jmp    fffffff0 <_EIP+0xfffffff0> c0113f75 No symbols available   <=====
Code;  c0113f8e No symbols available
   9:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0113f91 No symbols available
   c:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
Code;  c0113f96 No symbols available
  11:   21 e0                     and    %esp,%eax
Code;  c0113f98 No symbols available
  13:   ff 00                     incl   (%eax)

Code: eb e7 8d 76 00 b8 00 e0 (second code line, no <>)


Code;  c0113f8c No symbols available
00000000 <_EIP>:
Code;  c0113f8c No symbols available
   0:   eb e7                     jmp    ffffffe9 <_EIP+0xffffffe9> c0113f75 No symbols available
Code;  c0113f8e No symbols available
   2:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0113f91 No symbols available
   5:   b8 00 e0 00 00            mov    $0xe000,%eax

