Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131587AbRCSS6K>; Mon, 19 Mar 2001 13:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131586AbRCSS6B>; Mon, 19 Mar 2001 13:58:01 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:1543 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131572AbRCSS5t>;
	Mon, 19 Mar 2001 13:57:49 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200103191856.VAA01054@ms2.inr.ac.ru>
Subject: Re: rsync over ssh on 2.4.2 to 2.2.18
To: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 19 Mar 2001 21:56:50 +0300 (MSK)
Cc: crosser@average.ORG, linux-kernel@vger.kernel.org
In-Reply-To: <20010319073703.B16622@flint.arm.linux.org.uk> from "Russell King" at Mar 19, 1 07:37:03 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Well, since I moved the rsync to 5pm, and then back to 9pm, I haven't
> seen this problem - everything is again working as expected (touch wood)
> with 2.2.15pre13 and 2.4.0.
> 
> This is odd, since it wasn't a one-off problem, but something that happened
> each and every day of a particular week.  Anyway, if it starts happening
> again, I'll get a tcpdump of the session.

Well... I can reproduce this not depending of day of week now. :-(

If I understood Andrew's mail correctly, rsync freezes when 
large amount of errors happen. Particularly, here ssh always freezes
trying to write to stdout (pipe linked to rsync) some chunk of data (>64K), 
consisting of reports sort of "stat(usr/X11R6/bin/xmbind) : No such file"
(my /usr has huge amount of stray symlinks...). rsync does not read
this pipe, trying to write some more data to pipe, which is
pipe linked to rsync stdin. Dead lock.

Note, that doing strace you do not see this write()! write() is interrupted
by strace and you see succesful select(). You can see real place of lockup
via ps axl or starting strace before lockup happened.

Andrew said about one more common case, when large amount of errors happens:
wrong permission on some target directory.

I have impression that long ago I observed the same affect,
when disk space at target exhausted.

Why do I tall this? Well, probably, something changed at fs,
wich you rsync and rsync generates less errors.

Alexey
