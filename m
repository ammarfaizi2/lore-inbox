Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWI3MWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWI3MWb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 08:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWI3MWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 08:22:31 -0400
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:45259 "EHLO
	aa011msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750944AbWI3MWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 08:22:30 -0400
Date: Sat, 30 Sep 2006 14:14:55 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Arkadiusz =?UTF-8?B?SmHFgm93aWVj?= <ajalowiec@interia.pl>,
       <linux-kernel@vger.kernel.org>, <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] PROBLEM: Kernel 2.6.x freeze
Message-ID: <20060930141455.29fdadef@localhost>
In-Reply-To: <Pine.LNX.4.44L0.0609291717460.26116-100000@netrider.rowland.org>
References: <20060929143806.0d6a9162@localhost>
	<Pine.LNX.4.44L0.0609291717460.26116-100000@netrider.rowland.org>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 17:29:04 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> > But we have:
> > 
> >   500894:       74 3f                   je     5008d5 <_end+0x2d>
> >   500896:       0f b6 46 20             movzbl 0x20(%rsi),%eax
> >   50089a:       8b 4e 20                mov    0x20(%rsi),%ecx
> >   50089d:       ba                      .byte 0xba
> >   50089e:       fe                      (bad)
> >   50089f:       ff                      .byte 0xff
> > 
> > 
> > So "c7 04 24" turned into
> >    "ba fe ff"
> 
> What do you mean by "we have"?  Where did your two disassembly listings 
> come from?  The values in the oops message above don't match either of 
> your listings, at least not exactly.

Beacuse I'm an idiot :)


The first disassembed code comes from a 2.6.18 compiled with gcc 3.3.6
(but different config than Arkadiusz).


The second (and wrong one) comes from:

--- 1.c ---
char str[]={0x5c,0x89,0x57,0x2c,0x8b,0x40,0x44,0xc7,0x47,0x40,0x00,0x00,0x
00,0x00,0x89,0x47,0x3c,0x8b,0x45,0x00,0x8b,0x55,0x04,0x89,0x02,0x89,0x50,0
x04,0x89,0x6d,0x00,0x8d,0x47,0x18,0x89,0x6d,0x04,0x39,0x47,0x18,0x75,0x4b,
0x0f,0xb6,0x47,0x50,0xa8,0x02,0x88,0x44,0x24,0x08,0x74,0x3f,0x0f,0xb6,0x46
,0x20,0x8b,0x4e,0x20,0xba,0xfe,0xff};
void main(void){}
--------------

disassembled with "objdump -D".

The problem was that I'm on AMD64 and I've forgot to add "-m32" at gcc
options to produce a i386 executable ;)


This one should be correct:

00000000 <str>:
   0:   5c                      pop    %esp
   1:   89 57 2c                mov    %edx,0x2c(%edi)
   4:   8b 40 44                mov    0x44(%eax),%eax
   7:   c7 47 40 00 00 00 00    movl   $0x0,0x40(%edi)
   e:   89 47 3c                mov    %eax,0x3c(%edi)
  11:   8b 45 00                mov    0x0(%ebp),%eax
  14:   8b 55 04                mov    0x4(%ebp),%edx
  17:   89 02                   mov    %eax,(%edx)
  19:   89 50 04                mov    %edx,0x4(%eax)
  1c:   89 6d 00                mov    %ebp,0x0(%ebp)
  1f:   8d 47 18                lea    0x18(%edi),%eax
  22:   89 6d 04                mov    %ebp,0x4(%ebp)
  25:   39 47 18                cmp    %eax,0x18(%edi)
  28:   75 4b                   jne    75 <main+0x75>
  2a:   0f b6 47 50             movzbl 0x50(%edi),%eax
  2e:   a8 02                   test   $0x2,%al
  30:   88 44 24 08             mov    %al,0x8(%esp)
  34:   74 3f                   je     75 <main+0x75>
  36:   0f b6 46 20             movzbl 0x20(%esi),%eax   <----- crash!
  3a:   8b 4e 20                mov    0x20(%esi),%ecx
  3d:   ba                      .byte 0xba
  3e:   fe                      (bad)
  3f:   ff                      .byte 0xff


So now the problem is, as you pointed out, to discover why EIP is
pointing to "b6" intead of "0f".

-- 
	Paolo Ornati
	Linux 2.6.18 on x86_64
