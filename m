Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbVLWBKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVLWBKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 20:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVLWBKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 20:10:46 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:7068 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751224AbVLWBKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 20:10:46 -0500
Subject: Re: questions on wait_event ...
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexey Shinkin <alexshinkin@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY16-F8E0161EA0C4B79180F698AF330@phx.gbl>
References: <BAY16-F8E0161EA0C4B79180F698AF330@phx.gbl>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 20:10:40 -0500
Message-Id: <1135300240.12761.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 06:51 +0600, Alexey Shinkin wrote:

> 
> And what if the condition have changed after we have checked it in 
> wait_event() but
> before calling __wait_event() and before putting the process into the wait 
> queue ?
> The process could not be woken up "in advance" , right ?

Lets add the other part of this too (the __wait_event)

#define __wait_event(wq, condition) 					\
do {									\
	DEFINE_WAIT(__wait);						\
									\
	for (;;) {							\
		prepare_to_wait(&wq, &__wait, TASK_UNINTERRUPTIBLE);	\
		if (condition)						\
			break;						\
		schedule();						\
	}								\
	finish_wait(&wq, &__wait);					\
} while (0)


> 
> 
> #define wait_event(wq, condition)        \
> do {                                                   \
>         if (condition)                                \
>                 break;                                 \
>    /* and here we have condition changed  ???? */
>         __wait_event(wq, condition);        \
> } while (0)
> 

So if the condition happens there, it will be checked again up above in
__wait_event.

-- Steve


