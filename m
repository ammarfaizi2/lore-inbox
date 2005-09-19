Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbVISPAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVISPAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 11:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbVISPAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 11:00:10 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:4784 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932449AbVISPAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 11:00:09 -0400
Message-ID: <432ED53F.EE8DEC5E@tv-sign.ru>
Date: Mon, 19 Sep 2005 19:11:59 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce setup_timer() helper
References: <432D70C8.EF7B0438@tv-sign.ru>
		<1127056369.30256.4.camel@localhost.localdomain>
		<432D8CF8.C14C48A0@tv-sign.ru>
		<20050918154301.GA9088@devserv.devel.redhat.com>
		<432D9432.5C5B64D6@tv-sign.ru> <20050918130613.5bbe9344.akpm@osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Oleg Nesterov <oleg@tv-sign.ru> wrote:
> >
> > I think this can save a couple of cpu cycles. The init_timer()
> >  is not inline, gcc can't reorder exprx() and init_timer() calls.
> >
> >  Ok, I do not want to persist very much, I can resend this patch.
> >
> >  Andrew, should I?
> 
> Try both, see which one generates the shorter code?

The code:

	void *expr(void);

	void tst(struct timer_list *timer)
	{
		setup_timer(timer, expr(), 0);
	}

Asm output:

     1  tst:
     2          pushl   %ebp
     3          movl    %esp, %ebp
     4          pushl   %ebx
     5          movl    8(%ebp), %ebx
     6          call    expr
     7          movl    %eax, 16(%ebx)
     8          movl    %ebx, %eax
     9          movl    $0, 20(%ebx)
    10          call    init_timer
    11          popl    %ebx
    12          popl    %ebp
    13          ret

After the Arjan proposed change:

     1  tst:
     2          pushl   %ebp
     3          movl    %esp, %ebp
     4          subl    $8, %esp
     5          movl    %ebx, (%esp)
     6          movl    8(%ebp), %ebx
     7          movl    %esi, 4(%esp)
     8          call    expr
     9          movl    %eax, %esi
    10          movl    %ebx, %eax
    11          call    init_timer
    12          movl    %esi, 16(%ebx)
    13          movl    $0, 20(%ebx)
    14          movl    (%esp), %ebx
    15          movl    4(%esp), %esi
    16          movl    %ebp, %esp
    17          popl    %ebp
    18          ret

I don't think we'll see any difference in practice, but still...

Oleg.
