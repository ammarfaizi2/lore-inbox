Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWBPQcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWBPQcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWBPQcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:32:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35247 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932322AbWBPQcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:32:10 -0500
Date: Thu, 16 Feb 2006 08:28:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 singlestep is borken
In-Reply-To: <200602160601_MC3-1-B882-BFB6@compuserve.com>
Message-ID: <Pine.LNX.4.64.0602160825370.916@g5.osdl.org>
References: <200602160601_MC3-1-B882-BFB6@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Feb 2006, Chuck Ebbert wrote:
> 
> 2. Makes vsyscall; debug trap occurs in kernel mode and TF
>    is cleared.  TIF_SINGLESTEP gets set so kernel will remember
>    to re-enable TF on return to user.  But when user eflags
>    is saved on the stack, TF has already been cleared.

This is exactly correct. 

TF should be re-enabled by the "is there work to be done at system call 
return time?" logic, which should mean that we go through 
do_notify_resume() (which will set TF_MASK) and return with an "iret".

We can't return with a sysexit in the TF case, and setting TF on the stack 
is thus useless.

> 3. When user gets control back, TF is not re-enabled.

Sounds like something is broken, but I don't see what.

I did check single-step over sysenter at some point (a long time ago), so 
this has worked.

		Linus
