Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316882AbSHATFy>; Thu, 1 Aug 2002 15:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316887AbSHATFy>; Thu, 1 Aug 2002 15:05:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27667 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316882AbSHATFy>; Thu, 1 Aug 2002 15:05:54 -0400
Date: Thu, 1 Aug 2002 12:09:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@redhat.com>
cc: <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: manipulating sigmask from filesystems and drivers
In-Reply-To: <15189.1028116363@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.33.0208011203010.3000-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Jul 2002, David Howells wrote:
> 
> Can you comment on whether a driver is allowed to block signals like this, and
> whether they should be waiting in TASK_UNINTERRUPTIBLE?

They should be waiting in TASK_UNINTERRUPTIBLE, and we should add a flag 
to distinguish between "increases load average" and "doesn't". So you 
could have

	TASK_WAKESIGNAL - wake on all signals
	TASK_WAKEKILL	- wake on signals that are deadly
	TASK_NOSIGNAL	- don't wake on signals
	TASK_LOADAVG	- counts toward loadaverage

	#define TASK_UNINTERRUPTIBLE	(TASK_NOSIGNAL | TASK_LOADAVG)
	#define TASK_INTERRUPTIBLE	TASK_WAKESIGNAL

and then people who wanted to could use other combinations. The
TASK_WAKEKILL thing is useful - there are many loops that cannot exit
until they have a result, simply because the calling conventions require 
that. Th emost common example is disk wait.

HOWEVER, if they are killed by a signal, the calling convention doesn't
matter, and the read() or whatever could just return 0 (knowing that the
process will never see it), and leave a locked page locked. Things like 
generic_file_read() could easily use this, and make processes killable 
even when they are waiting for a hung NFS mount - regardless of any soft 
mount issues, and without NFS having to have special code.

In the end, I'm too lazy, and I don't care. So I can only tell you how it 
_should_ be done, and maybe you can tell somebody else until the sucker to 
actually do it is found.

		Linus

