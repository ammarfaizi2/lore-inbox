Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVAGRLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVAGRLP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVAGRLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:11:15 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:33217 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261345AbVAGRLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:11:01 -0500
Subject: Re: Make pipe data structure be a circular list of pages, rather
	than
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
References: <41DE9D10.B33ED5E4@tv-sign.ru>
	 <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105113998.24187.361.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 07 Jan 2005 16:06:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-07 at 16:17, Linus Torvalds wrote:
> it a "don't do that then", and I'll wait to see if people do. I can't
> think of anything that cares about performance that does that anyway:  
> becuase system calls are reasonably expensive regardless, anybody who
> cares at all about performance will have buffered things up in user space.

Actually I found a load of apps that do this but they don't care about
performance. Lots of people have signal handlers that just do

	write(pipe_fd, &signr, sizeof(signr))

so they can drop signalled events into their event loops


> > May be it make sense to add data to the last allocated page
> > until buf->len > PAGE_SIZE ?
> 
> The reason I don't want to coalesce is that I don't ever want to modify a
> page that is on a pipe buffer (well, at least not through the pipe buffe

If I can't write 4096 bytes down it one at a time without blocking from
an empty pipe then its not a pipe in the eyes of the Unix world and the
standards.

> With this organization, a pipe ends up being able to act as a "conduit"  
> for pretty much any data, including some high-bandwidth things like video
> streams, where you really _really_ don't want to copy the data. So the 
> next stage is:

The data copying impact isn't very high even if it is just done for the
pipe() case for standards behaviour. You end up with one page that is
written too and then sent and then freed rather than many.

Possibly what should be done is to not use pipe() for this at all but to
create a more explicit object so we don't confuse existing code and code
that refuses buffers heavily (plenty of that around). Add "sewer()"[1]
or "conduit()" and we don't have to change the behaviour of the Unix
pipe world and risk screwing up apps, and you get to not to have to
write grungy corner cases to ruin the plan.

