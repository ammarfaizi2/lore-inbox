Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTKIUm6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 15:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbTKIUm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 15:42:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:22438 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262796AbTKIUm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 15:42:56 -0500
Date: Sun, 9 Nov 2003 12:42:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: crashme on ARM - unkillable processes
In-Reply-To: <20031109200430.A2278@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0311091230300.2158-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Nov 2003, Russell King wrote:
> 
> The code which crashme generated corrupted the user stack pointer.  We
> then tried to deliver a signal, found the user stack pointer invalid,
> and tried to deliver a SEGV to the process via force_sig().  Unfortunately,
> this signal never made it through for the reasons described previously.
> (We dequeued the ILL, found we couldn't setup the stack frame, force_sig,
> returned to userspace, generated another undefined instruction exception
> on the same instruction, etc.)

Ahh. I think I found why ARM has this problem, and others don't.

Your SA_NODEFER handling is broken.

The thing is, you only block a signal if its stack frame was successfully 
done _and_ SA_NODEFER is not set.

It should be the other way around. You should block a signal if it's stack 
frame was unsuccessful _or_ SA_NODEFER was not set.

(x86 gets this wrong too, in the sense that we don't even check to see if
the stack frame was successful - but since nobody sets SA_NODEFER anyway,
we don't really much care).

		Linus

