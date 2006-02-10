Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWBJHPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWBJHPO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 02:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWBJHPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 02:15:14 -0500
Received: from science.horizon.com ([192.35.100.1]:12086 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751169AbWBJHPM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 02:15:12 -0500
Date: 10 Feb 2006 02:15:04 -0500
Message-ID: <20060210071504.31345.qmail@science.horizon.com>
From: linux@horizon.com
To: akpm@osdl.org, nickpiggin@yahoo.com.au
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Cc: linux-kernel@vger.kernel.org, linux@horizon.com, sct@redhat.com
In-Reply-To: <20060209201333.62db0e24.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, no.  Consider a continuously-running application which modifies its
> data store via MAP_SHARED+msync(MS_ASYNC).  If the msync() immediately
> started I/O, the disk would be seeking all over the place all the time.  The
> queue merging and timer-based unplugging would help here, but it won't be
> as good as a big, infrequent ascending-file-offset pdflush pass.
>
> Secondly, consider the behaviour of the above application if it is modifying
> the same page relatively frequently (quite likely).  If MS_ASYNC starts I/O
> immediately, that page will get written 10, 100 or 1000 times per second. 
> If MS_ASYNC leaves it to pdflush, that page gets written once per 30
> seconds, so we do far much less I/O.

You're assuming a brain-dead application.  Which can already thrash the
disk very nicely with O_SYNC.  Yes, if you ask for control and then do
something stupid, you can send performance into the toilet.

That's not a reason to not do what the application asks unless it's
a serious DoS attack.

(For example, In my appliction, I'm using a raw device as a circular
buffer, so I'm already delivering perfectly sequential block numbers.
And it's a flash memory disk anyway.)

> We just don't know.  It's better to leave it up to the application designer
> rather than lumping too many operations into the one syscall.

I know the operating system doesn't know.  If it did, there wouldn't
be any need for the application to tell it by making a system call.
So do what the application asks for, which is what the SuS says
msync(MS_ASYNC) means, which is start the write immediately.
(I'd call it "I/O", but it's only "O".)

As I said, I'm actively looking for a way, on Linux 2.6.x, x <= 15,
to start disk writes on part of an mmapped file without either blocking
(yet) or writing other dirty pages that aren't complete yet.
