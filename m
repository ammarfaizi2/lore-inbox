Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTKZSaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 13:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTKZSaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 13:30:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:211 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263172AbTKZSaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 13:30:08 -0500
Date: Wed, 26 Nov 2003 10:29:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG (non-kernel), can hurt developers.
In-Reply-To: <Pine.LNX.4.53.0311261153050.10929@chaos>
Message-ID: <Pine.LNX.4.58.0311261021400.1524@home.osdl.org>
References: <Pine.LNX.4.53.0311261153050.10929@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Nov 2003, Richard B. Johnson wrote:
>
> Note  to hackers. Even though this is a lib-c bug

It's not.

It's a bug in your program.

You can't just randomly use library functions in signal handlers. You can
only use a very specific "signal-safe" set.

POSIX lists that set in 3.3.1.3 (3f), and says

	"All POSIX.1 functions not in the preceding table and all
	 functions defined in the C standard {2} not stated to be callable
	 from a signal-catching function are considered to be /unsafe/
	 with respect to signals. .."

typos mine.

The thing is, they have internal state that makes then non-reentrant (and
note that even the re-entrant ones might not be signal-safe, since they
may have deadlock issues: being thread-safe is _not_ the same as being
signal-safe).

In other words, if you want to do complex things from signals, you should
really just set a flag (of type "sigatomic_t") and have your main loop do
them. Or you have to be very very careful and only use stuff that is
defined to be signal-safe (mainly core system calls - stuff like <stdio.h>
is right out).

		Linus
