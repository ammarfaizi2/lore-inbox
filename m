Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbUCDNzY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbUCDNxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:53:54 -0500
Received: from mail.jambit.de ([212.18.21.206]:38159 "EHLO mail.jambit.de")
	by vger.kernel.org with ESMTP id S261903AbUCDNxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:53:25 -0500
Message-ID: <001b01c401f0$10d77130$c100a8c0@wakatipu>
From: "Michael Kerrisk" <mtk-lists@jambit.de>
To: <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <mjp@pilcrow.madison.wi.us>
Subject: open(O_ASYNC) is (still) broken in 2.6.3
Date: Thu, 4 Mar 2004 14:53:25 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

>From http://www.ussg.iu.edu/hypermail/linux/kernel/0111.1/1401.html and
http://www.ussg.iu.edu/hypermail/linux/kernel/0111.1/1636.html , I see that
this topic has been visited at least once before, but this behavior appears
still to be present in Linux 2.6.3.

The O_ASYNC flag has no affect (in terms of signal generation) when
specified in a call to open().  For example, if we make the following set of
calls:

    fd = open("/dev/tty2", O_RDONLY | O_ASYNC);
    fcntl(fd, F_SETOWN, getpid());

Then the call:

    flags = fcntl(fd, F_GETFL);

tells us that O_ASYNC is in 'flags', but no signal is delivered when input
becomes available on the terminal.  (We see the same behaviour if opening a
FIFO on 2.6.3.).  On the other hand, the following does result in the
generation of SIGIO signals when input is available:

    fd = open("/dev/tty2", O_RDONLY);
    flags = fcntl(fd, F_GETFL);
    fcntl(fd, F_SETFL, flags | O_ASYNC);
    fcntl(fd, F_SETOWN, getpid());

Furthermore, the following sequence also results in generation of SIGIO when
input is available, but only after the final fcntl() call:

    fd = open("/dev/tty2", O_RDONLY) | O_ASYNC;
    fcntl(fd, F_SETOWN, getpid());
    fcntl(fd, F_SETFL, 0);
    fcntl(fd, F_SETFL, O_ASYNC);

I assume the patch referred to at the second URL above fixes this problem,
but I haven't tested it.  The question is, why is this still broken?

Cheers,

Michael

