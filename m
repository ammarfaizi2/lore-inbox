Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263477AbTJLQOR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 12:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTJLQOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 12:14:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:41195 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263477AbTJLQOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 12:14:15 -0400
Date: Sun, 12 Oct 2003 09:13:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg Stark <gsstark@mit.edu>
cc: Joel Becker <Joel.Becker@oracle.com>, Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <87ekxi4gmk.fsf@stark.dyndns.tv>
Message-ID: <Pine.LNX.4.44.0310120909050.12190-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Oct 2003, Greg Stark wrote:
> 
> There are other reasons databases want to control their own cache. The
> application knows more about the usage and the future usage of the data than
> the kernel does.

But this again is not an argument for not using the page cache - it's only 
an argument for _telling_ the kernel about its use.

> However on busy servers whenever it's run it causes lots of pain because the
> kernel flushes all the cached data in favour of the data this job touches.

Yes. But this is actually pretty easy to avoid in-kernel, since all of the 
LRU logic is pretty localized.

It could be done on a per-process thing ("this process should not pollute 
the active list") or on a per-fd thing ("accesses through this particular 
open are not to pollute the active list"). 

>									 And
> worse, there's no way to indicate that the i/o it's doing is lower priority,
> so i/o bound servers get hit dramatically. 

IO priorities are pretty much worthless. It doesn't _matter_ if other 
processes get preferred treatment - what is costly is the latency cost of 
seeking. What you want is not priorities, but batching.

			Linus

