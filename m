Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbTJZFtB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 01:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbTJZFtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 01:49:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:6355 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262834AbTJZFs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 01:48:58 -0400
Date: Sat, 25 Oct 2003 22:48:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test9
In-Reply-To: <UTC200310260116.h9Q1GdR00982.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0310252237510.6370-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 26 Oct 2003 Andries.Brouwer@cwi.nl wrote:
> 
> I have run 2.6.0-test6 without any problems. Switched
> to 2.6.0-test9 today. Something involving job control
> or so is broken. Several of my remote xterms hang.

Btw, this one sounds like a known bug in bash.

The bash bug does bad things when setting up pipelines of processes, and
it assigns the process groups in the wrong order. This causes the tty
layer to send SIGTTOU if the process touches the tty at just the right
time, which in turn causes processes to become stuck in STOPPED state.
It's very timing sensitive, and it apparently became easier to trigger
within the last month or so, probably because of the scheduler
interactivity changes.

You can trigger it under 2.4.x, and in fact it seems to be reasonably easy 
to see with

	while true ; do date | less -E ; done

which will cause processes to become stuck in stopped state after a while 
(but because of the timing issues it's not 100% repeatable - you may 
have to do this for a while).

You can work around it by building basb without the "PGRP_PIPE" config
option (which may cause other issues), but Ernie Petrides also had a
proper fix for it in the bash sources. Last I say (this was end of
September), Chet Ramey acknowledged the bug but hadn't yet put it in
standard bash sources.

It's definitely not a kernel bug. I chased it for a while myself, and 
Ernie proved it quite conclusively.

		Linus

