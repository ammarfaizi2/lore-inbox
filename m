Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUEDWbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUEDWbg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 18:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUEDWbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 18:31:36 -0400
Received: from sphinx.mythic-beasts.com ([212.69.37.6]:48911 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id S261236AbUEDWbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 18:31:05 -0400
Date: Tue, 4 May 2004 23:30:57 +0100 (BST)
From: chris@scary.beasts.org
X-X-Sender: cevans@sphinx.mythic-beasts.com
To: Steve Beaty <beaty@emess.mscd.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: sigaction, fork, malloc, and futex
In-Reply-To: <200405042015.i44KFb0R001900@emess.mscd.edu>
Message-ID: <Pine.LNX.4.58.0405042315001.24297@sphinx.mythic-beasts.com>
References: <200405042015.i44KFb0R001900@emess.mscd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

On Tue, 4 May 2004, Steve Beaty wrote:

>
> 	anyone have a clue on this one?  we set up a signal handler, create
> 	a child that sends that signal, and have the signal handler fork
> 	another child.  if there is a malloc(), the second child gets stuck
> 	in a futex(); without the malloc(), no problem.  2.4.20-30.9
> 	kernel.  straces at the end.  any help would be appreciated.
> 	thanks!

Your signal handler function is illegally calling non-reentrant functions.
The *printf() family of functions are going to need to call malloc() to
allocate buffers. malloc() cannot be re-entered.

So specifically your deadlock sequence is:

Parent:
fork()
fprintf()
-> malloc()
   -> take a malloc() lock
(Child schedules and sends SIGALRM at this point)
SIGALRM:
fprintf()
-> malloc()
   -> try to take a malloc() lock
      -> deadlock, lock is already taken and will never be released!

Modern glibc / kernel combinations which use futexes in the malloc code
really seem to expose this race.

Cheers
Chris
