Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275250AbTHSAPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 20:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275252AbTHSAPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 20:15:47 -0400
Received: from aneto.able.es ([212.97.163.22]:45283 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S275250AbTHSAPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 20:15:10 -0400
Date: Tue, 19 Aug 2003 02:15:07 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: gcc -O3 and register usage
Message-ID: <20030819001507.GA2015@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I was playing looking at the code gcc gives for some simple operations,
and got this...

Simple C program (do you recognise it ;) ?):

struct list_head
{
	struct list_head *next, *prev;
};

static inline int list_empty(struct list_head *head)
{
	return head->next == head;
}

int use(struct list_head *l)
{
	return list_empty(l);
}

I use gcc 3.3.1.
Compile at -O2:

use:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	popl	%ebp
	cmpl	%eax, (%eax)
	sete	%al
	movzbl	%al, %eax
	ret

Compile at -O3:

use:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %edx
	popl	%ebp
	cmpl	%edx, (%edx)
	sete	%al
	andl	$255, %eax
	ret

Compile at -O3 and (at least) -march=pentiumpro:

use:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %edx
	popl	%ebp
	cmpl	%edx, (%edx)
	sete	%dl
	movzbl	%dl, %eax
	ret

Go back to -O2, but keep -march=pentiumpro:

use:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	popl	%ebp
	cmpl	%eax, (%eax)
	sete	%al
	movzbl	%al, %eax
	ret

Does this mean that since PentiumPro gcc has one other register (%dl)
available, and it uses it only at -O3 ?
This can be a _big_ advantage to reduce register spilling (stack
traffic...)

The above effect is due to the -frename-registers activated in -O3.
This option is used in arch/ia64/Makefile, but it is supposed to
benefit more to arches with few registers (I suppose ia64 has a ton more
that ia32...)

Would if be useful ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-rc2-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
