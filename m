Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUEKGOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUEKGOg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUEKGOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:14:36 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:35222 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262129AbUEKGOe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:14:34 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 May 2004 23:14:32 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
cc: Daniel Jacobowitz <dan@debian.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ptrace in 2.6.5
In-Reply-To: <1084236054.1763.25.camel@slack.domain.invalid>
Message-ID: <Pine.LNX.4.58.0405102253480.1156@bigblue.dev.mdolabs.com>
References: <1UlcA-6lq-9@gated-at.bofh.it>  <m365b4kth8.fsf@averell.firstfloor.org>
  <1084220684.1798.3.camel@slack.domain.invalid>  <877jvkx88r.fsf@devron.myhome.or.jp>
 <873c67yk5v.fsf@devron.myhome.or.jp>  <20040510225818.GA24796@nevyn.them.org>
 <1084236054.1763.25.camel@slack.domain.invalid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, Fabiano Ramos wrote:

> The question is: the int 0x80 can be seen as complex instructions that
> is only completed after the iret. This way, I do not see why a debug
> trap is not generated afer the int 0x80 and BEFORE the mov.
> 
> I reinvented the wheel and built a module that did the same thing as
> a singlestep ptrace, and a the trap WAS generated after the int 0x80
> completed, before the mov. 
> 
> So I think it has sth to do with the debug trap handler. 
> 
> I DO NOT BELIEVE THIS BEAVIOUR is right, since if it is not stopping
> after the int 0x80, ptrace is not TRULLY singlestepping.

If you look at the Intel manual 24319202 page 44 (TF bit), it clearly says 
that the trap is generated on the instruction that follows the IRET. In 
the same doc, at page 145, it also says that the return address seen by 
the trap handler is the one following the trapped instructuion (INT#1 is a 
trap). Ideally, I'm with you in expecting a full trace on all the 
instructions (out of INTs), but this doesn't seem to be what documented.
On the kernel side, this would be pretty much solved by issuing a ptrace 
op, with a modified EIP (+2) on return from a syscall (if in single-step 
mode).



- Davide

