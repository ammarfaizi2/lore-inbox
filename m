Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264769AbTGGGvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 02:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264768AbTGGGvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 02:51:54 -0400
Received: from [212.209.10.215] ([212.209.10.215]:58569 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S264769AbTGGGvo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 02:51:44 -0400
From: Johan.Adolfsson@axis.com
Message-ID: <222e01c34456$2a054310$e2070d0a@pcjohana>
To: "Davide Libenzi" <davidel@xmailserver.org>,
       "Matthew Wilcox" <willy@debian.org>
Cc: "Patrick Mochel" <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
References: <20030706163353.GU23597@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.55.0307060935140.14675@bigblue.dev.mcafeelabs.com>
Subject: Re: kobjects, sysfs and the driver model make my head hurt
Date: Mon, 7 Jul 2003 09:05:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Davide Libenzi" <davidel@xmailserver.org>
To: "Matthew Wilcox" <willy@debian.org>
Cc: "Patrick Mochel" <mochel@osdl.org>; <linux-kernel@vger.kernel.org>
Sent: Sunday, July 06, 2003 6:42 PM
Subject: Re: kobjects, sysfs and the driver model make my head hurt


> On Sun, 6 Jul 2003, Matthew Wilcox wrote:
> 
> > Why on earth does it return the value of its argument?
> 
> Maybe for the same reason 'strcpy' returns 'dest'. It allows you to use
> the function in a function parameter :

Another possible benefit (although I'm not sure we should care)
is that if the return variable is the same as the first argument, 
the compiler can save an instruction or two on at least some archs.

Simple example:

char *tst(char *p, int i)
{
  return p;
}

void tst2(char *p, int i)
{
  *p = i;
  p = tst(p,i);
  p[1]=i;
}

void tst3(char *p, int i)
{
  *p = i;
  tst(p,i);
  p[1]=i;
}

i386 ts2 saves 3 instructions compared to tst3
tst2:
        pushl %ebp
        movl %esp,%ebp
        subl $20,%esp
        pushl %ebx
        movl 8(%ebp),%eax
        movl 12(%ebp),%ebx
        movb %bl,(%eax)
        addl $-8,%esp
        pushl %ebx
        pushl %eax
        call tst
        movb %bl,1(%eax)
        movl -24(%ebp),%ebx
        leave
        ret
.Lfe2:
        .size    tst2,.Lfe2-tst2
        .align 4
.globl tst3
        .type    tst3,@function
tst3:
        pushl %ebp
        movl %esp,%ebp
        subl $16,%esp
        pushl %esi
        pushl %ebx
        movl 8(%ebp),%esi
        movl 12(%ebp),%ebx
        movb %bl,(%esi)
        addl $-8,%esp
        pushl %ebx
        pushl %esi
        call tst
        movb %bl,1(%esi)
        leal -24(%ebp),%esp
        popl %ebx
        popl %esi
        leave
        ret
.Lfe3:


On CRIS you save one register on stack instead of two
tst2:
        Push $srp
        subq 4,$sp
        movem $r0,[$sp]
        move.d $r10,$r9
        move.d $r11,$r0
        move.b $r11,[$r9]
        Jsr tst
        move.b $r0,[$r10+1]
        movem [$sp+],$r0
        Jump [$sp+]
.Lfe2:
        .size   tst2,.Lfe2-tst2
        .align 1
        .global tst3
        .type   tst3,@function
tst3:
        Push $srp
        subq 8,$sp
        movem $r1,[$sp]
        move.d $r10,$r0
        move.d $r11,$r1
        move.b $r11,[$r0+]
        Jsr tst
        move.b $r1,[$r0]
        movem [$sp+],$r1
        Jump [$sp+]
.Lfe3:

/Johan

