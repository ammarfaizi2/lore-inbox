Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWCaADw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWCaADw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWCaADw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:03:52 -0500
Received: from science.horizon.com ([192.35.100.1]:4905 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750771AbWCaADw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:03:52 -0500
Date: 30 Mar 2006 19:03:44 -0500
Message-ID: <20060331000344.12797.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice support #2
Cc: torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Lord High Penguin spake:
> In particular, what happens when you try to connect two streaming devices,
> but the destination stops accepting data? You cannot put the received
> data "back" into the streaming source any way - so if you actually want
> to be able to handle error recovery, you _have_ to get access to the
> source buffers.

Ding!  Ding!  Ding!  The light dawns.

Oh my, that *is* clever.  And I remember wrestling with the problem before.
If you're reading from a seekable fd (a la sendfile()), you can always
back up the read pointer, but if you're reading from a non-seekable
fd, what *do* you do if there's a write problem?  The pipe gives you
a solution.


However, that gets me thinking... what about a pipe lets it be used as
a splice() source?  The answer is that, like seekable files, it's peekable.
You can "peek at" an efficiently-sized chunk of data before deciding
to remove it from the source.  You don't have to read(buf)/write(buf),
you can buf=peek()/len=write(buf)/accept(len).

Network sockets have too many features (what with urgent data pointers
and crap) to make that easy, and some character devices have
side effects from read() that can't be hidden at all.  So you need
an explicit buffer.


Next, what about a pipe makes it an acceptable splice() destination?
The answer is that space is reservable.  You can know that a write()
won't fail before read()ing the source.  But a great many devices with
non-synchronous write semantics behave the same way.  Certainly it's
not hard to make a non-O_SYNC file system behave that way.


Give all that, it it necessary to use the fallback of a pipe all
the time?  It seems that doing without the pipe would be
feasible a large fraction of the time And would a

bytes_written = splice2(src, pipefd[1], pipefd[0], dst, &bytes_buffered);

system call be worth it to reduce overhead?  (I'm assuming that
bytes_read = bytes_written + bytes_buffered, but you can use any two
of the three in the interface.)  Note that it could bypass the pipe
entirely for those cases where it's possible.


Finally, has anyone thought about the semantics of tee(2)?
It seems that it could be used on block files to get a second
handle that does NOT share the file pointer.  But if used on
a pipe, does the write block if EITHER reader is behind?
So one reader could block the other?  I can't see any other way
to implement it, but I would like to be sure those semantics are
expected.
