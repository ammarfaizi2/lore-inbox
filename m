Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSLZCok>; Wed, 25 Dec 2002 21:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSLZCok>; Wed, 25 Dec 2002 21:44:40 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:24081 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id <S261855AbSLZCoj>;
	Wed, 25 Dec 2002 21:44:39 -0500
Date: Thu, 26 Dec 2002 03:52:56 +0100
From: Felix von Leitner <felix-linux@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: problem with rt-sigio: lost events
Message-ID: <20021226025256.GA21711@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I am having trouble with sigio.  I tried to integrate it in a event
notification framework of mine that already speaks poll and epoll.
I want sigio for backwards compatibility with 2.4 kernels.

So I used the description from Dan's C10k web site and got it working.
My test application is a trivial web server for static web pages only.

My first problem is that sigio will not signal POLLOUT on freshly
connected connections.  It doesn't change when I read the HTTP header.
So I added a kludge that calls poll() when the application wants to
switch from reading to writing or vice versa.  That is quite ugly but it
works.

The second problem is that once I start hammering the server with
request (as opposed to running wget manually from the command line), the
server just stops serving requests.  strace shows this pattern:

  sigtimedwait signals an event on fd #3 (the listening socket)
  accept is called, returns #4
  fd 4 is set non-blocking
  F_SETOWN, F_SETSIG, SETFL O_ASYNC
  sigtimedwait times out.
  sigtimedwait is called again, times out again.

Why is that?  Googling seemed to indicate that there could be a race
condition here after the accept.  Should I be running poll on the socket
right away?  Or just blindly call the read handler?

Is anyone actually successfully using sigio for anything?  So far it
does not look very reliable to me.

Felix
