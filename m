Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266042AbUFUFNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266042AbUFUFNf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 01:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266055AbUFUFNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 01:13:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:49092 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266042AbUFUFMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 01:12:46 -0400
Date: Sun, 20 Jun 2004 22:11:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joris van Rantwijk <joris@eljakim.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7 Oops in signal handling with ptrace
Message-Id: <20040620221147.7c3086b7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406191611450.12748@eljakim.netsystem.nl>
References: <Pine.LNX.4.58.0406191611450.12748@eljakim.netsystem.nl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joris van Rantwijk <joris@eljakim.nl> wrote:
>
> Linux 2.6.7 (and 2.6.6) gives an Oops in specific situations
>  related to signal handling and ptracing. The Oops is triggered when
>  a process which is being ptraced with TRACESYSGOOD, receives signals
>  in a very specific pattern. This Oops is perfectly reproducable.

Joris, Linus has merged a patch similar to yours which should address this
problem.  Many thanks for tracking this down.



From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: bk-commits-head@vger.kernel.org
Subject: Follow 2.4.x semantics for in-kernel signal sending.
Date: Sun, 20 Jun 2004 16:56:58 +0000
Sender: bk-commits-head-owner@vger.kernel.org

 ChangeSet 1.1769, 2004/06/20 09:56:58-07:00, torvalds@ppc970.osdl.org

 	Follow 2.4.x semantics for in-kernel signal sending.



  signal.c |    7 +++++++
  1 files changed, 7 insertions(+)


 diff -Nru a/kernel/signal.c b/kernel/signal.c
 --- a/kernel/signal.c	2004-06-20 11:07:49 -07:00
 +++ b/kernel/signal.c	2004-06-20 11:07:49 -07:00
 @@ -1197,6 +1197,13 @@
  	unsigned long flags;
  
  	/*
 +	 * Make sure legacy kernel users don't send in bad values
 +	 * (normal paths check this in check_kill_permission).
 +	 */
 +	if (sig < 0 || sig > _NSIG)
 +		return -EINVAL;
 +
 +	/*
  	 * We need the tasklist lock even for the specific
  	 * thread case (when we don't need to follow the group
  	 * lists) in order to avoid races with "p->sighand"
 -
 To unsubscribe from this list: send the line "unsubscribe bk-commits-head" in
 the body of a message to majordomo@vger.kernel.org
 More majordomo info at  http://vger.kernel.org/majordomo-info.html
