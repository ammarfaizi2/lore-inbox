Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbUKCQxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbUKCQxJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUKCQxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:53:09 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:13456 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261725AbUKCQto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:49:44 -0500
Message-ID: <41890C0F.6080702@nortelnetworks.com>
Date: Wed, 03 Nov 2004 10:49:19 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Oliver Neukum <oliver@neukum.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on common error-handling idiom
References: <4187E920.1070302@nortelnetworks.com> <Pine.LNX.4.61.0411022208390.3285@dragon.hygekrogen.localhost> <Pine.LNX.4.53.0411022229070.6104@yvahk01.tjqt.qr> <Pine.LNX.4.61.0411022241160.3285@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0411022241160.3285@dragon.hygekrogen.localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

> Has anyone taken a look at what recent gcc's actually do with different 
> variations of the constructs mentioned in this thread?

I did, out of curiosity:

I used the following (admittedly simplistic) code, compiled with -O2.

int bbbb(int a)
{
	int err = -5;
	if (a == 1)
		goto out;
	err=0;
out:
	return err;
}

int cccc(int a)
{
	int err=0;
	if (a == 1) {
		err = -5;
		goto out;
	}
out:
	return err;
}


With gcc 3.2.2 for x86, both constructs generated the same code:

        pushl   %ebp
         movl    %esp, %ebp
         xorl    %eax, %eax
         cmpl    $1, 8(%ebp)
         setne   %al
         leal    -5(%eax,%eax,4), %eax
         leave
         ret

With gcc 2.96 (Mandrake) however, the standard construct generated this:


	pushl	%ebp
	movl	%esp, %ebp
	subl	$4, %esp
	movl	$-5, -4(%ebp)
	cmpl	$1, 8(%ebp)
	jne	.L3
	jmp	.L4
	.p2align 4,,7
.L3:
	movl	$0, -4(%ebp)
.L4:
	movl	-4(%ebp), %eax
	movl	%eax, %eax
	movl	%ebp, %esp
	popl	%ebp
	ret



While moving the err setting into the conditional generates the following:

	pushl	%ebp
	movl	%esp, %ebp
	subl	$4, %esp
	movl	$0, -4(%ebp)
	cmpl	$1, 8(%ebp)
	jne	.L6
	movl	$-5, -4(%ebp)
	jmp	.L7
	.p2align 4,,7
.L6:
	nop
.L7:
	movl	-4(%ebp), %eax
	movl	%eax, %eax
	movl	%ebp, %esp
	popl	%ebp
	ret


For PPC, gcc 3.3.3, the standard construct gave:

         xori 3,3,1
         addic 3,3,-1
         subfe 3,3,3
         rlwinm 3,3,0,30,28
         blr

While moving the err setting into the conditional generates the following:

         xori 3,3,1
         srawi 0,3,31
         xor 3,0,3
         subf 3,3,0
         srawi 3,3,31
         andi. 3,3,5
         addi 3,3,-5
         blr


So, it looks like the standard construct can actually generate better code in 
some cases, its almost never worse, and it's certainly nicer to read.

Chris
