Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUCBW4c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbUCBW4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:56:32 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:57147 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262316AbUCBW4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:56:23 -0500
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
References: <Pine.LNX.4.53.0403021318580.796@chaos>
	<527jy3qalg.fsf@topspin.com> <Pine.LNX.4.53.0403021510270.1856@chaos>
	<52vflnq807.fsf@topspin.com> <Pine.LNX.4.53.0403021624300.2296@chaos>
	<52n06zq67n.fsf@topspin.com> <Pine.LNX.4.53.0403021651010.9048@chaos>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 02 Mar 2004 14:56:22 -0800
In-Reply-To: <Pine.LNX.4.53.0403021651010.9048@chaos>
Message-ID: <52hdx6rh7t.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Mar 2004 22:56:22.0684 (UTC) FILETIME=[95424DC0:01C400A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Richard> You are playing games with semantics because you are
    Richard> wrong.  The code in fs/select.c about line 101, adds the
    Richard> current caller to the wait-queue.

I assume you mean the call to add_wait_queue() there.  That does not
sleep.  Look at the implementation.  add_wait_queue() is defined in
kernel/fork.c -- it just does some locking and calls
__add_wait_queue().  __add_wait_queue() is really nothing more than 
a list_add().  There's nothing more to it and nothing that goes to
sleep.  Where do you think add_wait_queue() goes to sleep?

    Richard> This wait-queue is the mechanism by which the current
    Richard> caller sleeps, i.e., gives the CPU up to somebody else.
    Richard> That caller's thread will not return past that line until
    Richard> a wake_up_interruptible() call has been made for/from the
    Richard> driver or interface handling that file descriptor. In
    Richard> this manner any number of file discriptors may be handled
    Richard> because the poll() routine for each of then makes its own
    Richard> entry into the wait-queue using the described mechanism.

But there's only one thread around: the user space process that called
into the kernel via poll().  If the first driver goes to sleep, which
thread do you think is going to wake up and call into the second
driver?

 - Roland
